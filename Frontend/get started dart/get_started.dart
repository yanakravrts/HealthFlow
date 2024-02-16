ROW(
  child: Positioned(
    child: Container(
        child: Text(
              "Hello World",
              style: TextStyle(
                fontSize: 40.0,
                color: Color(0xFFFFFF00),
              ),
            ),
        width: _parent_ * 0.8 
        height: 600.0,
        padding: const EdgeInsets.all(0.0),
        margin: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Color(0x459A9E00),
          borderRadius: BorderRadius.all(const Radius.circular(45.0)),
          border: Border.all(
            color: Color(0xFFFFFF00),
            width: 0.0,
            style: BorderStyle.solid
          ),
        )
      ),
    bottom: _parent_ * 0.1 // percentage of parent width. like 'MediaQuery.of(context).size.width * 0.2',
    left: _parent_ * 0.09 // percentage of parent width. like 'MediaQuery.of(context).size.width * 0.2',
    top: _parent_ * -0.02 // percentage of parent width. like 'MediaQuery.of(context).size.width * 0.2',
    right: _parent_ * -0.02 // percentage of parent width. like 'MediaQuery.of(context).size.width * 0.2',
  ),
),