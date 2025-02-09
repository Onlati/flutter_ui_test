import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 250,
      color: theme.canvasColor,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Image.asset('assets/images/logo.png', height: 40),
                    ),
                  ),
                  SideMenuItem(
                    icon: Icons.article,
                    title: "News",
                    active: true,
                    iconColor: Colors.blue,
                    onTap: () {},
                  ),
                  SideMenuItem(
                    icon: Icons.dashboard,
                    title: "Dashboard",
                    iconColor: Colors.green,
                    onTap: () {},
                  ),
                  SideMenuItem(
                    icon: Icons.insert_chart,
                    title: "Reports",
                    iconColor: Colors.orange,
                    onTap: () {},
                  ),
                  Theme(
                    data: theme.copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.timeline, color: Colors.orange),
                      title: Text(
                        "Analytics",
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      childrenPadding:
                          const EdgeInsets.only(left: 16.0, bottom: 8.0),
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 16.0),
                          leading:
                              const Icon(Icons.show_chart, color: Colors.red),
                          title: Text("Real-Time Analytics",
                              style: theme.textTheme.bodyMedium),
                          onTap: () {},
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 16.0),
                          leading:
                              const Icon(Icons.bar_chart, color: Colors.purple),
                          title: Text("Performance",
                              style: theme.textTheme.bodyMedium),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SideMenuItem(
                    icon: Icons.people,
                    title: "User Insights",
                    iconColor: Colors.purple,
                    onTap: () {},
                  ),
                  Theme(
                    data: theme.copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Icon(Icons.settings, color: Colors.grey),
                      title: Text(
                        "Settings",
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      childrenPadding:
                          const EdgeInsets.only(left: 16.0, bottom: 8.0),
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 16.0),
                          leading: const Icon(Icons.security,
                              color: Colors.redAccent),
                          title: Text("Security",
                              style: theme.textTheme.bodyMedium),
                          onTap: () {},
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 16.0),
                          leading:
                              const Icon(Icons.build, color: Colors.blueGrey),
                          title: Text("System Settings",
                              style: theme.textTheme.bodyMedium),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SideMenuItem(
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    iconColor: Colors.teal,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text("Log Out", style: theme.textTheme.titleMedium),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SideMenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool active;
  final Color? iconColor;
  const SideMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.active = false,
    this.iconColor,
  }) : super(key: key);

  @override
  _SideMenuItemState createState() => _SideMenuItemState();
}

class _SideMenuItemState extends State<SideMenuItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color activeBg = theme.primaryColor.withOpacity(0.3);
    final Color hoverBg = theme.primaryColor.withOpacity(0.15);
    final Color bgColor =
        widget.active ? activeBg : (_hovering ? hoverBg : Colors.transparent);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(
              widget.icon,
              color: widget.iconColor ?? (widget.active ? Colors.blue : null),
            ),
            title: Text(
              widget.title,
              style: widget.active
                  ? theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)
                  : theme.textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
