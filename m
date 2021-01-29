Content-Type: multipart/mixed; boundary="===============2414771132343830633=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 13/16] selftests: mptcp: add port argument
 for pm_nl_ctl
Date: Thu, 28 Jan 2021 17:11:12 -0800
Message-ID: <20210129011115.133953-14-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210129011115.133953-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7518

--===============2414771132343830633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch adds a new argument for pm_nl_ctl tool. We can use it like
this:

 # pm_nl_ctl add 10.0.2.1 flags signal port 10100
 # pm_nl_ctl dump
 id 1 flags signal 10.0.2.1 10100

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index abc269e96a07..7b4167f3f9a2 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -177,8 +177,8 @@ int add_addr(int fd, int pm_family, int argc, char *arg=
v[])
 		  1024];
 	struct rtattr *rta, *nest;
 	struct nlmsghdr *nh;
+	u_int32_t flags =3D 0;
 	u_int16_t family;
-	u_int32_t flags;
 	int nest_start;
 	u_int8_t id;
 	int off =3D 0;
@@ -224,7 +224,6 @@ int add_addr(int fd, int pm_family, int argc, char *arg=
v[])
 			char *tok, *str;
 =

 			/* flags */
-			flags =3D 0;
 			if (++arg >=3D argc)
 				error(1, 0, " missing flags value");
 =

@@ -272,6 +271,20 @@ int add_addr(int fd, int pm_family, int argc, char *ar=
gv[])
 			rta->rta_len =3D RTA_LENGTH(4);
 			memcpy(RTA_DATA(rta), &ifindex, 4);
 			off +=3D NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "port")) {
+			u_int16_t port;
+
+			if (++arg >=3D argc)
+				error(1, 0, " missing port value");
+			if (!(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+				error(1, 0, " flags must be signal when using port");
+
+			port =3D atoi(argv[arg]);
+			rta =3D (void *)(data + off);
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_PORT;
+			rta->rta_len =3D RTA_LENGTH(2);
+			memcpy(RTA_DATA(rta), &port, 2);
+			off +=3D NLMSG_ALIGN(rta->rta_len);
 		} else
 			error(1, 0, "unknown keyword %s", argv[arg]);
 	}
@@ -324,6 +337,7 @@ int del_addr(int fd, int pm_family, int argc, char *arg=
v[])
 static void print_addr(struct rtattr *attrs, int len)
 {
 	uint16_t family =3D 0;
+	uint16_t port =3D 0;
 	char str[1024];
 	uint32_t flags;
 	uint8_t id;
@@ -331,12 +345,16 @@ static void print_addr(struct rtattr *attrs, int len)
 	while (RTA_OK(attrs, len)) {
 		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_FAMILY)
 			memcpy(&family, RTA_DATA(attrs), 2);
+		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_PORT)
+			memcpy(&port, RTA_DATA(attrs), 2);
 		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_ADDR4) {
 			if (family !=3D AF_INET)
 				error(1, errno, "wrong IP (v4) for family %d",
 				      family);
 			inet_ntop(AF_INET, RTA_DATA(attrs), str, sizeof(str));
 			printf("%s", str);
+			if (port)
+				printf(" %d", port);
 		}
 		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_ADDR6) {
 			if (family !=3D AF_INET6)
@@ -344,6 +362,8 @@ static void print_addr(struct rtattr *attrs, int len)
 				      family);
 			inet_ntop(AF_INET6, RTA_DATA(attrs), str, sizeof(str));
 			printf("%s", str);
+			if (port)
+				printf(" %d", port);
 		}
 		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_ID) {
 			memcpy(&id, RTA_DATA(attrs), 1);
-- =

2.30.0

--===============2414771132343830633==--
