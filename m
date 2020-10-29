Content-Type: multipart/mixed; boundary="===============0364728571557910015=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 7/8] selftests: mptcp: add ADD_ADDR
 port support for pm_nl_ctl
Date: Thu, 29 Oct 2020 14:39:27 +0800
Message-ID: <74a7932cdf68d481379e0910f511b4ef017661ce.1603952836.git.geliangtang@gmail.com>
In-Reply-To: 1c2111f713f72610a59400b5c821f09e53485134.1603952836.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6470

--===============0364728571557910015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added ADD_ADDR port support for pm_nl_ctl.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index b24a2f17d415..9e6f30d34d9a 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -178,6 +178,7 @@ int add_addr(int fd, int pm_family, int argc, char *arg=
v[])
 	struct nlmsghdr *nh;
 	u_int16_t family;
 	u_int32_t flags;
+	u_int16_t port;
 	int nest_start;
 	u_int8_t id;
 	int off =3D 0;
@@ -271,6 +272,16 @@ int add_addr(int fd, int pm_family, int argc, char *ar=
gv[])
 			rta->rta_len =3D RTA_LENGTH(4);
 			memcpy(RTA_DATA(rta), &ifindex, 4);
 			off +=3D NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "port")) {
+			if (++arg >=3D argc)
+				error(1, 0, " missing port value");
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
@@ -323,6 +334,7 @@ int del_addr(int fd, int pm_family, int argc, char *arg=
v[])
 static void print_addr(struct rtattr *attrs, int len)
 {
 	uint16_t family =3D 0;
+	uint16_t port =3D 0;
 	char str[1024];
 	uint32_t flags;
 	uint8_t id;
@@ -330,12 +342,16 @@ static void print_addr(struct rtattr *attrs, int len)
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
@@ -343,6 +359,8 @@ static void print_addr(struct rtattr *attrs, int len)
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

--===============0364728571557910015==--
