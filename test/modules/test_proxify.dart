// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
//
//

/*

get_top_k_recommended_friends(user_id: int, cutoff_k: int) -> List[int] {

  // initialize a empty array of recommendations
  var recommendedFriends = []

  // get a list of friends of CURRENT USER
  var currentFriendsList = get_friends(user_id)

  // loop in CURRENT USER friends list
  for(var currentFriendId in currentFriendsList) {

    // get a list of friends of USER FRIEND
    var myFriendList = get_friends(currentFriendId)

    // loop in USER FRIEND list
    for(var friendId in myFriendList) {

      // check if recommendedFriends contains the friendId
      // check the size of recommendedFriends
      if(!currentFriendsList.contains(friendId) && recommendedFriends.count <  cutoff_k) {
        recommendedFriends.add(friendId)
      }
    }
  }

  return recommendedFriends

}



class User {
  id: int
  email: String
  password: String
  repeatPassword: String

  public func validatePassword() -> bool {
    # validate if password has the a minimum of characters
    # validate if the password and repeatPassword are equal
    # return true or false
  }

  public func validateEmail() -> bool {
    # validate if email is valid
    # return true or false
  }
}

class Restaurant {
  id: int
  name: String
}

class Position {
  latitude: Double
  longitude: Double
}

class Reservation {
  id: int
  user: User
  restaurant: Restaurant
  date: Datetime
}

class UserService {

  public func signUp(user: User) -> bool {
    # check the required fields
    # register a user if not exists
    # return true or false
  }

  public func signIn(user: User) -> bool {
    # check if user exists
    # return true or false
  }
}

class RestaurantService {

  public func getRestaurantsNearby(position: Position) -> [Restaurant] {
    # search the restaurants nearby the user position
    # return a empty array in case that didn't find any restaurant
    # return a array of restaurants if exists in the location
  }

  public func getRestaurantByName(name: String) -> Restaurant? {
    # search the restaurants with this name
    # return null if don't exists
    # return a restaurants if exists
  }
}

class ReservationService {

  public func reserve(user: User, restaurant: Restaurant, datetime: Datetime) -> bool {
    # check if the user is available
    # check if the date and time are available
    # return true or false
  }

  private func checkUserAvailable(user: User, datetime: Datetime) -> bool {
    # check if the user is available
    # return true or false
  }

  private func checkReservationAvailable(restaurant: Restaurant, datetime: Datetime) -> bool {
    # check if the date and time are available
    # return true or false
  }
}

* */

void main() {

  group('Character DTO test', () {
    test('proxify', () {
//
//       var date = '2021-06-04';
//       var datesArray = <String>[];
//       datesArray.add(date);
//
//       var dateTime = DateTime.parse(date);
//       for (var i = 0; i < 7; i++) {
//         dateTime = dateTime.add(Duration(days: 7));
//         datesArray.add(dateTime.toString().split(' ')[0]);
//       }
//
//       Iterable<String> dates = datesArray;
//
//       dates.takeWhile((value) => false);
//
//       final it = dates;
//       final Iterator iterator = it.iterator;
//
//       iterator.moveNext();
//
//       var retorno = iterator.current;
//
//       expect(retorno, '2021-06-04');
//
//       iterator.moveNext();
//       retorno = iterator.current;
//
//       expect(retorno, '2021-06-11');
//     });
//
//     test('toptal', () {
//
    });
  });
}