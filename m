Content-Type: multipart/mixed; boundary="===============1344300527675021961=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 7/9] selftests: mptcp: add port
 argument for pm_nl_ctl
Date: Wed, 25 Nov 2020 11:01:14 +0800
Message-ID: <9c43a4c55fc629f6879a5e98353b9d4b2173a3f2.1606272852.git.geliangtang@gmail.com>
In-Reply-To: d3da793954959ea2745e3fe886427736ffb63616.1606272852.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6914

--===============1344300527675021961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new argument for pm_nl_ctl tool. We can use it like
this:

 # pm_nl_ctl add 10.0.2.1 flags signal port 10100
 # pm_nl_ctl dump
 id 1 flags signal 10.0.2.1 10100

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index b24a2f17d415..cf654a57552b 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -176,8 +176,8 @@ int add_addr(int fd, int pm_family, int argc, char *arg=
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
@@ -223,7 +223,6 @@ int add_addr(int fd, int pm_family, int argc, char *arg=
v[])
 			char *tok, *str;
 =

 			/* flags */
-			flags =3D 0;
 			if (++arg >=3D argc)
 				error(1, 0, " missing flags value");
 =

@@ -271,6 +270,20 @@ int add_addr(int fd, int pm_family, int argc, char *ar=
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
@@ -323,6 +336,7 @@ int del_addr(int fd, int pm_family, int argc, char *arg=
v[])
 static void print_addr(struct rtattr *attrs, int len)
 {
 	uint16_t family =3D 0;
+	uint16_t port =3D 0;
 	char str[1024];
 	uint32_t flags;
 	uint8_t id;
@@ -330,12 +344,16 @@ static void print_addr(struct rtattr *attrs, int len)
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
@@ -343,6 +361,8 @@ static void print_addr(struct rtattr *attrs, int len)
 				      family);
 			inet_ntop(AF_INET6, RTA_DATA(attrs), str, sizeof(str));
 			printf("%s", str);
+			if (port)
+				printf(" %d", port);
 		}
 		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_ID) {
 			memcpy(&id, RTA_DATA(attrs), 1);
-- =

2.26.2

--===============1344300527675021961==--
