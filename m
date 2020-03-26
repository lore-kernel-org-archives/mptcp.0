Content-Type: multipart/mixed; boundary="===============6384026362080888084=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/2] add support for mptcp netlink interface.
Date: Thu, 26 Mar 2020 16:03:04 +0100
Message-ID: <65a08c10aa83d4cc6861b1c2b9534fa8b9e1cae1.1585234717.git.pabeni@redhat.com>
In-Reply-To: cover.1585234717.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4080

--===============6384026362080888084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement basic commands to:
- manipulate MPTCP local addresses list
- manipulate MPTCP connection limits

Examples:
1. Allows multiple subflows per MPTCP connection
   $ ip mptcp limits subflows 2

2. Accept ADD_ADDR announcement from the peer (server):
   $ ip mptcp limits add_addr_accepted 2

3. Add a ipv4 address to be annunced for backup subflows:
   $ip mptcp address add 10.99.1.2 signal backup

4. Add an ipv6 address used as source for additional subflows:
   $ip mptcp address add 2001::2 subflow

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 ip/Makefile    |   2 +-
 ip/ip.c        |   3 +-
 ip/ip_common.h |   1 +
 ip/ipmptcp.c   | 446 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 450 insertions(+), 2 deletions(-)
 create mode 100644 ip/ipmptcp.c

diff --git a/ip/Makefile b/ip/Makefile
index 5ab78d7d..8735b8e4 100644
--- a/ip/Makefile
+++ b/ip/Makefile
@@ -11,7 +11,7 @@ IPOBJ=3Dip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o=
 ipnetns.o \
     iplink_bridge.o iplink_bridge_slave.o ipfou.o iplink_ipvlan.o \
     iplink_geneve.o iplink_vrf.o iproute_lwtunnel.o ipmacsec.o ipila.o \
     ipvrf.o iplink_xstats.o ipseg6.o iplink_netdevsim.o iplink_rmnet.o \
-    ipnexthop.o
+    ipnexthop.o ipmptcp.o
 =

 RTMONOBJ=3Drtmon.o
 =

diff --git a/ip/ip.c b/ip/ip.c
index 90392c2a..4249df03 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -51,7 +51,7 @@ static void usage(void)
 		"where  OBJECT :=3D { link | address | addrlabel | route | rule | neigh =
| ntable |\n"
 		"                   tunnel | tuntap | maddress | mroute | mrule | monito=
r | xfrm |\n"
 		"                   netns | l2tp | fou | macsec | tcp_metrics | token | =
netconf | ila |\n"
-		"                   vrf | sr | nexthop }\n"
+		"                   vrf | sr | nexthop | mptcp }\n"
 		"       OPTIONS :=3D { -V[ersion] | -s[tatistics] | -d[etails] | -r[esol=
ve] |\n"
 		"                    -h[uman-readable] | -iec | -j[son] | -p[retty] |\n"
 		"                    -f[amily] { inet | inet6 | mpls | bridge | link } |=
\n"
@@ -103,6 +103,7 @@ static const struct cmd {
 	{ "vrf",	do_ipvrf},
 	{ "sr",		do_seg6 },
 	{ "nexthop",	do_ipnh },
+	{ "mptcp",	do_mptcp },
 	{ "help",	do_help },
 	{ 0 }
 };
diff --git a/ip/ip_common.h b/ip/ip_common.h
index 879287e3..d604f755 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -83,6 +83,7 @@ void vrf_reset(void);
 int netns_identify_pid(const char *pidstr, char *name, int len);
 int do_seg6(int argc, char **argv);
 int do_ipnh(int argc, char **argv);
+int do_mptcp(int argc, char **argv);
 =

 int iplink_get(char *name, __u32 filt_mask);
 int iplink_ifla_xstats(int argc, char **argv);
diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
new file mode 100644
index 00000000..1ff66a7b
--- /dev/null
+++ b/ip/ipmptcp.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <string.h>
+#include <rt_names.h>
+#include <errno.h>
+
+#include <linux/genetlink.h>
+#include <linux/mptcp.h>
+
+#include "utils.h"
+#include "ip_common.h"
+#include "libgenl.h"
+#include "json_print.h"
+
+static void usage(void)
+{
+	fprintf(stderr,
+		"Usage:	ip mptcp address add <address> [dev <name>] [id <id>] [signal] [=
subflow] [backup]\n"
+		"	ip mptcp address del id <id>\n"
+		"	ip mptcp address list\n"
+		"	ip mptcp address get id <id>\n"
+		"	ip mptcp address flush\n"
+		"	ip mptcp limits [subflows <nr>] [add_addr_accepted <nr>]\n");
+
+	exit(-1);
+}
+
+/* netlink socket */
+static struct rtnl_handle genl_rth =3D { .fd =3D -1 };
+static int genl_family =3D -1;
+
+#define MPTCP_BUFLEN	4096
+#define MPTCP_REQUEST(_req,  _cmd, _flags)	\
+	GENL_REQUEST(_req, MPTCP_BUFLEN, genl_family, 0,	\
+		     MPTCP_PM_VER, _cmd, _flags)
+
+/* Mapping from argument to address flag mask */
+static const struct {
+	const char *name;
+	unsigned long value;
+} mptcp_addr_flag_names[] =3D {
+	{ "signal",		MPTCP_PM_ADDR_FLAG_SIGNAL },
+	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
+	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
+};
+
+static void print_mptcp_addr_flags(unsigned int flags)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(mptcp_addr_flag_names); i++) {
+		unsigned long mask =3D mptcp_addr_flag_names[i].value;
+
+		if (flags & mask) {
+			print_string(PRINT_FP, NULL, "%s ",
+				     mptcp_addr_flag_names[i].name);
+			print_bool(PRINT_JSON,
+				   mptcp_addr_flag_names[i].name, NULL, true);
+		}
+
+		flags &=3D ~mask;
+	}
+
+	if (flags) {
+		/* unknown flags */
+		SPRINT_BUF(b1);
+
+		snprintf(b1, sizeof(b1), "%02x", flags);
+		print_string(PRINT_ANY, "rawflags", "rawflags %s ", b1);
+	}
+}
+
+static int get_flags(const char *arg, __u32 *flags)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(mptcp_addr_flag_names); i++) {
+		if (strcmp(arg, mptcp_addr_flag_names[i].name))
+			continue;
+
+		*flags |=3D mptcp_addr_flag_names[i].value;
+		return 0;
+	}
+	return -1;
+}
+
+static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
+			 bool adding)
+{
+	struct rtattr *attr_addr;
+	bool addr_set =3D false;
+	inet_prefix address;
+	bool id_set =3D false;
+	__u32 index =3D 0;
+	__u32 flags =3D 0;
+	__u8 id =3D 0;
+
+	ll_init_map(&rth);
+	while (argc > 0) {
+		if (get_flags(*argv, &flags) =3D=3D 0) {
+		} else if (!matches(*argv, "id")) {
+			NEXT_ARG();
+
+			if (get_u8(&id, *argv, 0)) {
+				invarg("invalid TTL\n", *argv);
+				return -1;
+			}
+			id_set =3D true;
+		} else if (!matches(*argv, "dev")) {
+			const char *ifname;
+
+			NEXT_ARG();
+
+			ifname =3D *argv;
+
+			if (check_ifname(ifname)) {
+				invarg("name", ifname);
+				return -1;
+			}
+
+			index =3D ll_name_to_index(ifname);
+
+			if (!index) {
+				invarg("name", ifname);
+				return -1;
+			}
+		} else if (get_addr(&address, *argv, AF_UNSPEC) =3D=3D 0) {
+			addr_set =3D true;
+		} else {
+			invarg("unknown argument", *argv);
+			usage();
+		}
+		argc--, argv++;
+	}
+
+	if (!addr_set && adding) {
+		fprintf(stderr, "mptcp: must set 'address' on add\n");
+		return -1;
+	}
+
+	if (!id_set && !adding) {
+		fprintf(stderr, "mptcp: must set 'id'\n");
+		return -1;
+	}
+
+	attr_addr =3D addattr_nest(n, MPTCP_BUFLEN,
+				 MPTCP_PM_ATTR_ADDR | NLA_F_NESTED);
+	if (id_set)
+		addattr8(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_ID, id);
+	if (flags)
+		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_FLAGS, flags);
+	if (index)
+		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_IF_IDX, index);
+	if (addr_set) {
+		int type;
+
+		addattr16(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_FAMILY,
+			  address.family);
+		type =3D address.family =3D=3D AF_INET ? MPTCP_PM_ADDR_ATTR_ADDR4 :
+						   MPTCP_PM_ADDR_ATTR_ADDR6;
+		addattr_l(n, MPTCP_BUFLEN, type, &address.data,
+			  address.bytelen);
+	}
+
+	addattr_nest_end(n, attr_addr);
+	return 0;
+}
+
+static int mptcp_addr_modify(int argc, char **argv, int cmd)
+{
+	MPTCP_REQUEST(req, cmd, NLM_F_REQUEST);
+	int ret;
+
+	ret =3D mptcp_parse_opt(argc, argv, &req.n, cmd =3D=3D MPTCP_PM_CMD_ADD_A=
DDR);
+	if (ret)
+		return ret;
+
+	if (rtnl_talk(&genl_rth, &req.n, NULL) < 0)
+		return -2;
+
+	return 0;
+}
+
+static int print_mptcp_addrinfo(struct rtattr *addrinfo)
+{
+	struct rtattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+	__u8 family =3D AF_UNSPEC, addr_attr_type;
+	const char *ifname;
+	unsigned int flags;
+	int index;
+	__u16 id;
+
+	parse_rtattr_nested(tb, MPTCP_PM_ADDR_ATTR_MAX, addrinfo);
+
+	open_json_object(NULL);
+	if (tb[MPTCP_PM_ADDR_ATTR_FAMILY])
+		family =3D rta_getattr_u8(tb[MPTCP_PM_ADDR_ATTR_FAMILY]);
+
+	addr_attr_type =3D family =3D=3D AF_INET ? MPTCP_PM_ADDR_ATTR_ADDR4 :
+					     MPTCP_PM_ADDR_ATTR_ADDR6;
+	if (tb[addr_attr_type]) {
+		print_string(PRINT_ANY, "address", "%s ",
+			     format_host_rta(family, tb[addr_attr_type]));
+	}
+	if (tb[MPTCP_PM_ADDR_ATTR_ID]) {
+		id =3D rta_getattr_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
+		print_uint(PRINT_ANY, "id", "id %u ", id);
+	}
+	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS]) {
+		flags =3D rta_getattr_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		print_mptcp_addr_flags(flags);
+	}
+	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX]) {
+		index =3D rta_getattr_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
+		ifname =3D index ? ll_index_to_name(index) : NULL;
+
+		if (ifname)
+			print_string(PRINT_ANY, "dev", "dev %s ", ifname);
+	}
+
+	close_json_object();
+	print_string(PRINT_FP, NULL, "\n", NULL);
+	fflush(stdout);
+
+	return 0;
+}
+
+static int print_mptcp_addr(struct nlmsghdr *n, void *arg)
+{
+	struct rtattr *tb[MPTCP_PM_ATTR_MAX + 1];
+	struct genlmsghdr *ghdr;
+	struct rtattr *addrinfo;
+	int len =3D n->nlmsg_len;
+
+	if (n->nlmsg_type !=3D genl_family)
+		return 0;
+
+	len -=3D NLMSG_LENGTH(GENL_HDRLEN);
+	if (len < 0)
+		return -1;
+
+	ghdr =3D NLMSG_DATA(n);
+	parse_rtattr_flags(tb, MPTCP_PM_ATTR_MAX, (void *) ghdr + GENL_HDRLEN,
+			   len, NLA_F_NESTED);
+	addrinfo =3D tb[MPTCP_PM_ATTR_ADDR];
+	if (!addrinfo)
+		return -1;
+
+	ll_init_map(&rth);
+	return print_mptcp_addrinfo(addrinfo);
+}
+
+static int mptcp_addr_list(int argc, char **argv)
+{
+	MPTCP_REQUEST(req, MPTCP_PM_CMD_GET_ADDR, NLM_F_REQUEST | NLM_F_DUMP);
+
+	if (argc > 0) {
+		fprintf(stderr,
+			"\"ip mptcp addr show\" does not take any arguments.\n");
+		return -1;
+	}
+
+	if (rtnl_send(&genl_rth, &req.n, req.n.nlmsg_len) < 0) {
+		perror("Cannot send show request");
+		exit(1);
+	}
+
+	new_json_obj(json);
+
+	if (rtnl_dump_filter(&genl_rth, print_mptcp_addr, stdout) < 0) {
+		fprintf(stderr, "Dump terminated\n");
+		delete_json_obj();
+		fflush(stdout);
+		return -2;
+	}
+
+	close_json_object();
+	fflush(stdout);
+	return 0;
+}
+
+static int mptcp_addr_get(int argc, char **argv)
+{
+	MPTCP_REQUEST(req, MPTCP_PM_CMD_GET_ADDR, NLM_F_REQUEST);
+	struct nlmsghdr *answer;
+	int ret;
+
+	ret =3D mptcp_parse_opt(argc, argv, &req.n, false);
+	if (ret)
+		return ret;
+
+	if (rtnl_talk(&genl_rth, &req.n, &answer) < 0)
+		return -2;
+
+	return print_mptcp_addr(answer, stdout);
+}
+
+static int mptcp_addr_flush(int argc, char **argv)
+{
+	MPTCP_REQUEST(req, MPTCP_PM_CMD_FLUSH_ADDRS, NLM_F_REQUEST);
+
+	if (rtnl_talk(&genl_rth, &req.n, NULL) < 0)
+		return -2;
+
+	return 0;
+}
+
+static int mptcp_parse_limit(int argc, char **argv, struct nlmsghdr *n)
+{
+	bool set_rcv_add_addrs =3D false;
+	bool set_subflows =3D false;
+	__u32 rcv_add_addrs =3D 0;
+	__u32 subflows =3D 0;
+
+	while (argc > 0) {
+		if (!matches(*argv, "subflows")) {
+			NEXT_ARG();
+
+			if (get_u32(&subflows, *argv, 0)) {
+				invarg("invalid subflows\n", *argv);
+				return -1;
+			}
+			set_subflows =3D true;
+		} else if (!matches(*argv, "add_addr_accepted")) {
+			NEXT_ARG();
+
+			if (get_u32(&rcv_add_addrs, *argv, 0)) {
+				invarg("invalid add_addr_accepted\n", *argv);
+				return -1;
+			}
+			set_rcv_add_addrs =3D true;
+		} else {
+			invarg("unknown argument", *argv);
+			usage();
+		}
+		argc--, argv++;
+	}
+
+	if (set_rcv_add_addrs)
+		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ATTR_RCV_ADD_ADDRS,
+			  rcv_add_addrs);
+	if (set_subflows)
+		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ATTR_SUBFLOWS, subflows);
+	return set_rcv_add_addrs || set_subflows;
+}
+
+static int print_mptcp_limit(struct nlmsghdr *n, void *arg)
+{
+	struct rtattr *tb[MPTCP_PM_ATTR_MAX + 1];
+	struct genlmsghdr *ghdr;
+	int len =3D n->nlmsg_len;
+	__u32 val;
+
+	if (n->nlmsg_type !=3D genl_family)
+		return 0;
+
+	len -=3D NLMSG_LENGTH(GENL_HDRLEN);
+	if (len < 0)
+		return -1;
+
+	ghdr =3D NLMSG_DATA(n);
+	parse_rtattr(tb, MPTCP_PM_ATTR_MAX, (void *) ghdr + GENL_HDRLEN, len);
+
+	open_json_object(NULL);
+	if (tb[MPTCP_PM_ATTR_RCV_ADD_ADDRS]) {
+		val =3D rta_getattr_u32(tb[MPTCP_PM_ATTR_RCV_ADD_ADDRS]);
+
+		print_uint(PRINT_ANY, "add_addr_accepted",
+			   "add_addr_accepted %d ", val);
+	}
+
+	if (tb[MPTCP_PM_ATTR_SUBFLOWS]) {
+		val =3D rta_getattr_u32(tb[MPTCP_PM_ATTR_SUBFLOWS]);
+
+		print_uint(PRINT_ANY, "subflows", "subflows %d ", val);
+	}
+	print_string(PRINT_FP, NULL, "%s", "\n");
+	fflush(stdout);
+	close_json_object();
+	return 0;
+}
+
+static int mptcp_limit_get_set(int argc, char **argv)
+{
+	MPTCP_REQUEST(req, MPTCP_PM_CMD_SET_LIMITS, NLM_F_REQUEST);
+	struct nlmsghdr *answer;
+	bool do_get;
+	int ret;
+
+	ret =3D mptcp_parse_limit(argc, argv, &req.n);
+	if (ret < 0)
+		return -1;
+
+	do_get =3D ret =3D=3D 0;
+	if (do_get)
+		req.g.cmd =3D MPTCP_PM_CMD_GET_LIMITS;
+	if (rtnl_talk(&genl_rth, &req.n, do_get ? &answer : NULL) < 0)
+		return -2;
+
+	if (do_get)
+		return print_mptcp_limit(answer, stdout);
+	return 0;
+}
+
+int do_mptcp(int argc, char **argv)
+{
+	if (argc =3D=3D 0)
+		usage();
+
+	if (!matches(*argv, "help"))
+		usage();
+
+	if (genl_init_handle(&genl_rth, MPTCP_PM_NAME, &genl_family))
+		exit(1);
+
+	if (!matches(*argv, "address")) {
+		argc--, argv++;
+		if (argc =3D=3D 0)
+			return mptcp_addr_list(0, NULL);
+
+		if (!matches(*argv, "add"))
+			return mptcp_addr_modify(argc-1, argv+1,
+						 MPTCP_PM_CMD_ADD_ADDR);
+		if (!matches(*argv, "delete"))
+			return mptcp_addr_modify(argc-1, argv+1,
+						 MPTCP_PM_CMD_DEL_ADDR);
+		if (!matches(*argv, "list"))
+			return mptcp_addr_list(argc-1, argv+1);
+		if (!matches(*argv, "get"))
+			return mptcp_addr_get(argc-1, argv+1);
+		if (!matches(*argv, "flush"))
+			return mptcp_addr_flush(argc-1, argv+1);
+
+		goto unknown;
+	}
+
+	if (!matches(*argv, "limits"))
+		return mptcp_limit_get_set(argc-1, argv+1);
+
+unknown:
+	fprintf(stderr,
+		"Command \"%s\" is unknown, try \"ip mptcp help\".\n",
+		*argv);
+	exit(-1);
+}
-- =

2.21.1

--===============6384026362080888084==--
