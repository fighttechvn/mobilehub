## Dependency library
- [x] https://github.com/octomato/preload_page_view


# Feature

## Sliders action

```
HightlightActionSliderWidget(
    items: state.highlightButton
        .map((e) => HightLightAction(
              title: e.title,
              subTitle: e.subTitle,
              image: e.image,
              backgroundColor: e.backgroundColor,
              deeplink: e.deeplink,
            ))
        .toList(),
    onTap: (e) {
      final url = e.deeplink;
      if (url?.isNotEmpty ?? false) {
        context
            .read<DeeplinkBloc>()
            .add(OpenLinkEvent(e.deeplink!));
      }
    },
    widgetItem: widgetItem,
    styleTitle: Theme.of(context).themeText.styleByFontFamily(
          fontFamily: FontConstants.albra,
          fontWeight: FontWeight.w400,
          fontSize: 10.0,
        ),
    styletitleLog: styletitleLog,
  ),
```


## ScrollWrapper

Just wrap the scrollable widget you want to show the scroll to top prompt over with a `ScrollWrapper`, and supply the `ScrollController` of the scrollable widget to the wrapper.

```dart
ScrollWrapper(
        scrollController: scrollController,
        child: ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Tile $index'),
              tileColor: Colors.grey.shade200,
            ),
          ),
        ),
      ),
```