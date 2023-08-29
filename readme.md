# 3D Platforma SDK для iOS. Пример интеграции режимов 3D-съемок и просмотра 3D-изображений.

3D Platforma SDK позволяет интегрировать в ваше приложение функционал 3D/360-визуализации и съемок объектов любого типа. SDK состоит из нескольких модулей. Некоторые модули могут быть вам недоступны, проверьте ограничения вашей лицензии.

Инструкция:

1. Скачайте Platforma SDK и запросите доступ к документации.
2. Копируйте Platforma.xcframework в папку "PLACE_XC_FRAMEWORK_HERE".
3. Настройте ваш Development Team в закладке "Signing and Capabilities".
4. Для инициализации SDK, вставьте SDK Access Token в свойство .token.

```swift

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        PlatformaSDK.shared.token = "YOUR TOKEN HERE"
        return true
    }
}
```

5. Запустите приложение. Выберите режим съемок (объекты, автомобили или панорама недвижимости) и следуйте инструкциям.
6. Когда съемка будет завершена, ID новой модели будет установлен в свойство lastCreatedModelID.
7. Выберите режим 'View model'.

# Свяжитесь с нами по вопросам получения доступа

Доступ к SDK: support@3dplatforma.ru

Copyright (c) 2023 ООО «3Д ПЛАТФОРМА», ИНН 7702437500 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


              
