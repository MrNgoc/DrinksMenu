//
//  DrinksMenuService.swift
//  DrinksMenu
//
//  Created by NGOCDT16 on 03/08/2022.
//

import RxSwift
import RxCocoa
import RealmSwift
import RxRealm

protocol DrinksMenuServiceType {
    func getDrinksMenu() -> Observable<[Drink]>
    func observableDrinkMenu() -> Observable<[Drink]>
}

final class DrinksMenuService: DrinksMenuServiceType {
    static let shared = DrinksMenuService()
    
    func observableDrinkMenu() -> Observable<[Drink]> {
      
        let realm = workerRealm()
        let collecion = realm.objects(DrinkModel.self)
        return Observable.collection(from: collecion).map { Array($0) }.map { model in
            model.map { $0.toDrink() }
        }
    }
    
    func getDrinksMenu() -> Observable<[Drink]> {
        let observable = Observable<String>.of("https://thecocktaildb.com/api/json/v1/1/search.php?s=margarita")
            .map { URL(string: $0)!}
            .map { URLRequest(url: $0) }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .filter { response, _ -> Bool in
                return 200..<300 ~= response.statusCode
            }
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { _, data -> [Drink]  in
                let decoder = JSONDecoder()
                let drink = try? decoder.decode(Drinks.self, from: data)
                return drink?.model ?? []
            }
            .do { [weak self] models in
                self?.saveDrinkMenu(models: models.map { $0.toRealm() })
            }
        return observable
    }
    
    private func saveDrinkMenu(models: [DrinkModel]) {
        let realm = workerRealm()
        try! realm.write {
            realm.add(models, update: .all)
        }
    }
    
    private func workerRealm() -> Realm {
        do {
            return try Realm()
        } catch {
            fatalError(String(describing: error))
        }
    }
}
