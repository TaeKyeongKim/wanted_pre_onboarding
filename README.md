# wanted_pre_onboarding
![iOS 13.0+](https://img.shields.io/badge/iOS-13.0%2B-lightgrey) ![Xcode 13.3](https://img.shields.io/badge/Xcode-13.3-blue) ![SwiftLint](https://img.shields.io/badge/Pod-swiftLint-brightgreen)

> ## Wanted 선별과제 : 날씨 APP 만들기 
>
> 프로젝트 기간 : 2022.06.13 ~ 2022.06.17 (6일) 
>
> [프로젝트 요구사항 링크](https://yagomacademy.notion.site/4eb46f9eb3a442efb9d0856b72f15b74)

## 프로젝트 다운로드및 API Key 설정 방법 


## 프로젝트 OverView 
### 설계: 
![image](https://user-images.githubusercontent.com/36659877/174433882-fda9c759-3e88-4b70-b274-6633da7420f6.png)
- Massavie View Controller 를 방지하기 위해 MVVM 패턴을 사용하여 프로젝트를 진행하였습니다. 
- View 이외의 모듈들은 `UIKit` 으로 부터 독립적인 모듈로 작성하였습니다. (유닛 테스트에 용이하도록 설계했지만 테스트는 진행하지 못했습니다.)

## 진행 Steps 
<details>
  <summary> 1.프로젝트 Setup </summary>
  
  - Pod 으로 SwiftLint 적용 
  
  - [WeatherAPI](https://openweathermap.org/) Key 생성 
  
  - API key 를 저장시킬 weather_API.plist 생성 및 gitignore 추가  
  
  - main StoryBoard 삭제 (코드로 화면구현) 
   
</details>
  <details>
  <summary> 2. 네트워크 Layer 구현  </summary>
  
  > 관련 오브젝트: `EndPoint`, `URLInformation`, `URLComponent` , `NetworkManager`
  
  ### 목표
  
  서버에 `request` 를 보내는 함수를 범용적으로 사용할수 있도록 구현.
  
  ### 요구사항 분석 
  
  - 서버에 보내는 요청은 `GET` 방식의 요청밖에 존재하지 않는다. (날씨 데이터 및 이미지 주소 URL)

  ### 고민과 해결 
  
  > 고민 1.0
  - Image 와 weatherData 를 받아오는 `EndPoint` 가 각각 다르고, URL 에 담겨지는 `queryItem`, `path` 도 각각 상이함. 
  
  > 해결
  - `URLInformation` 열거형 에 원하는 `image`,`weather` 정보를 받아올수 있도록 associate type 을 정해주고, `URLComponent` 타입의 변수를 할당시켜줌.
  
  > 고민 2.0
  - `NetWork Manager` 의 `request` 함수의 completionHandler 로 돌아올 서버의 응답 데이터를 decoding 하는 작업중, 이미지일때는 서버에서부터 response 로 받아온 `Data` 타입을 decoding 하지 않고 리턴 해주어야함. 

  > 해결
  - 아래와 같이 request 함수의 T 타입이 Data 타입 일시, (이미지 request 를 보낼때 명시가능) 디코딩 작업을 건너 뛰고 data 를 CompletionHandler 로 전달하도록 구현 했습니다.  
  
  ```swift 
  if T.self == Data.self {
                completion(.success(data as! T))
            } else {
                do {
                    let decoder = JSONDecoder()

                    let value = try decoder.decode(T.self, from: data)

                    completion(.success(value))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
  ```

</details>

<details>
  <summary> 3. Home 화면 구현  </summary>
  
  > 관련 오브젝트: `HomeViewController`, `HomeViewModel`, `CityWeatherCell` , `WeatherSummary`, `WeatherDetail`

  ### 목표
  
  - `HomeViewModel` 의 데이터가 변경될시 `HomeViewController` 의 `collectionView` 를 자동으로 reload 해줌. 
  
  ### 요구사항 분석 
  
  - 홈 화면에 보여줄 정보들 (도시이름, 날씨 아이콘, 현재기온, 현재습도) 을 담을 `entity` 필요
  - 각각의 도시 정보가 서버에서로부터 응답이 오면 화면에 정보 업데이트 

  ### 고민과 해결 
  
  > 고민 1.0
  - 주어진 API 는 Detail 화면에 필요한 정보들과 Home 화면에 필요한정보들이 하나의 API 호출로 전부 받올수 있게 설계 되어있었습니다. 앱을 켰을때 필요한 정보를 전부 가져와야할까? 그렇다면 detailViewController 에 정보를 어떻게 전달해야할까? 라는 고민 을 했습니다.
  
  > 해결 
  - `Detail View` 에 사용자가 접근했을때 따로 서버 호출을 할 필요가 없지 않을까? 라는 생각으로 entity 를 설계 했습니다. 
  - 사용자가 도시를 선택했을때 `UICollectionViewDelegate` 에서 childViewController 로 detailViewController 를 생성하고, 필요한 정보를 viewModel 에서 전달해줍니다.
  
  > 고민 2.0
  - HomeViewController 에 언제 날씨 정보가 업데이트 되었다고 알려 주어야할까? 주어진 도시의 정보가 전부 fetching 완료 될 시에 주어야할까? 하나의 도시의 날씨 정보가 fetching 완료될때마다 알려주어야할까? 
  
  > 해결
  - 주어진 모든 도시의 날씨 정보가 완료될시에 VC 에게 알려주는 방법은 안전하지 않다고 생각했습니다. (도시 리스트중 하나의 호출만이라도 실패할시 ViewController 에 정보전달 불가)
  - 따라서 `HomeViewModel` 에 딕셔너리 형태로 `cityWeather: [도시이름: Observable<날씨데이터?>]` 를 선언해주고, 각각의 key 마다 API 호출을 할수 있도록 진행하였습니다. 
 
  
  > 고민 3.0
  
  - 각각의 도시 정보들의 값이 업데이트 될때마다 `HomeViewController` 의 전체의 `collectionView` 를 reload() 해주었습니다. 하지만 한개의 도시 정보만 바뀌어도 전체를 reload 해주는 방식은 아래와 같은 버그를 발생 시켰습니다. 
  
![datareloadproblem](https://user-images.githubusercontent.com/36659877/174436153-b6ab5315-dd2e-436a-bb8f-7cd9ffddddd0.gif)

  > 해결
  - dataBinding 하는 부분에서 어떤 도시의 정보가 바뀌었는지 확인하고 해당 인덱스의 cell 만 업데이트 해주도록 수정하여 버그를 고칠수 있었습니다. 
  
</details>
<details>
  <summary> 4. image caching 작업 </summary>
  
   > 관련 오브젝트: `ImageCacheManager`

  ### 목표
  
  - 이미 캐시에 저장되있는 이미지들은 따로 API 호출하지 않고 저장된 데이터를 사용하여 이미지를 화면에 보여준다.
  
  ### 고민과 해결 
  
  > 고민 1.0
  - Memmory caching, 과 file caching 을 둘다 사용해야 할지 고민했습니다. 
  
  > 해결 
  - 해당 어플에선 file caching 까지 해야되는 데이터를 요구하지 않다고 판단하여 memory caching 작업만 진행하였습니다. 
  
  > 고민 2.0
  - ATS 에러 
  
  > 해결
  [여기서 확인 할수 있습니다](https://github.com/TaeKyeongKim/wanted_pre_onboarding/issues/8)

</details>
<details>
  <summary> 5. Detail 화면 구현  </summary>
  
   > 관련 오브젝트: `DetailViewModel`, `DetailViewController`, `DetailViewModel`

  ### 목표
  
  - `HomeViewController` 에서 특정 도시 날씨를 사용자가 선택할시, detail 정보를 보여주는 `DeatailView` 를 화면에 띄운다. 
  
  ### 고민과 해결 
  
  > 고민 1.0
  - 어떻게 해당 도시의 날씨 정보를 `HomeViewController` 에서 부터 전달받을까 고민하였습니다.  
  
  > 해결 
  - `HomeViewController` 에서 `DetailViewController` 를 생성할때 initializer 의 매개변수로 해당 `weatherSummary` 데이터를 넘겨주는 방식으로 구현하였습니다.

</details>


## 결과 화면 
![wanted](https://user-images.githubusercontent.com/36659877/174434076-bbdb146a-62f2-41e0-bd2c-f9947cfe36ec.gif)
