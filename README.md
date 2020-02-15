# 加速器

## 安装

```shell script
eeui plugin install https://github.com/aipaw/eeui-plugin-accelerometer
```

## 卸载

```shell script
eeui plugin uninstall https://github.com/aipaw/eeui-plugin-accelerometer
```

## 引用

```js
const accelerometer = app.requireModule("eeui/accelerometer");
```

### get(callback) 获取当前加速度

#### 参数

1.  [`callback`] (Function)

#### 返回

1.  `result` (Object)
    *   `x` (Float) (m/s^2)

    *   `y` (Float) (m/s^2)

    *   `z` (Float) (m/s^2)

#### 示例

```
accelerometer.get((ret) => {
    console.log(ret)
})
```

* * *

### watch(options, callback) 实时监听加速度

#### 参数

1.  [`options`] (Object)
    *   `interval` (Int) (ms, default: `32`)

2.  [`callback`] (Function)

#### 返回

1.  `result` (Object)
    *   `x` (Float) (m/s^2)

    *   `y` (Float) (m/s^2)

    *   `z` (Float) (m/s^2)

#### 示例

```
accelerometer.watch((ret) => {
    console.log(ret)
})
```

* * *

### clearWatch(callback) 取消监听加速度

#### 参数

1.  [`callback`] (Function)

#### 示例

```
accelerometer.clearWatch(() => {
    console.log('cleared')
})
```

* * *

> **Error**<br/>
> ACCELEROMETER_PERMISSION_DENIED<br/>
> ACCELEROMETER_NOT_SUPPORTED<br/>
> ACCELEROMETER_INTERNAL_ERROR<br/>
> GET_ACCELERATION_INVALID_ARGUMENT<br/>
> WATCH_ACCELERATION_INVALID_ARGUMENT
