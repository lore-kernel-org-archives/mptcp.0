Content-Type: multipart/mixed; boundary="===============2908582566804235854=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 4/5] selftests: mptcp: add addr
 argument for del_addr
Date: Thu, 04 Mar 2021 17:33:35 +0800
Message-ID: <481b4472959ca412d8cc77b7ac46ab56253ec464.1614849685.git.geliangtang@gmail.com>
In-Reply-To: fc3f30d0aaf04464e764a2802e457b50fef0fb98.1614849685.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8020

--===============2908582566804235854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For the id 0 address, different MPTCP connections could be using
different IP addresses for id 0.

This patch added an extra argument IP address for del_addr when
using id 0.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 7b4167f3f9a2..3a627895e03d 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -26,7 +26,7 @@ static void syntax(char *argv[])
 {
 	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0=
]);
 	fprintf(stderr, "\tadd [flags signal|subflow|backup] [id <nr>] [dev <name=
>] <ip>\n");
-	fprintf(stderr, "\tdel <id>\n");
+	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
 	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
 	fprintf(stderr, "\tflush\n");
@@ -301,6 +301,7 @@ int del_addr(int fd, int pm_family, int argc, char *arg=
v[])
 		  1024];
 	struct rtattr *rta, *nest;
 	struct nlmsghdr *nh;
+	u_int16_t family;
 	int nest_start;
 	u_int8_t id;
 	int off =3D 0;
@@ -310,11 +311,14 @@ int del_addr(int fd, int pm_family, int argc, char *a=
rgv[])
 	off =3D init_genl_req(data, pm_family, MPTCP_PM_CMD_DEL_ADDR,
 			    MPTCP_PM_VER);
 =

-	/* the only argument is the address id */
-	if (argc !=3D 3)
+	/* the only argument is the address id (nonzero) */
+	if (argc !=3D 3 && argc !=3D 4)
 		syntax(argv);
 =

 	id =3D atoi(argv[2]);
+	/* zero id with the IP address */
+	if (!id && argc !=3D 4)
+		syntax(argv);
 =

 	nest_start =3D off;
 	nest =3D (void *)(data + off);
@@ -328,6 +332,29 @@ int del_addr(int fd, int pm_family, int argc, char *ar=
gv[])
 	rta->rta_len =3D RTA_LENGTH(1);
 	memcpy(RTA_DATA(rta), &id, 1);
 	off +=3D NLMSG_ALIGN(rta->rta_len);
+
+	if (!id) {
+		/* addr data */
+		rta =3D (void *)(data + off);
+		if (inet_pton(AF_INET, argv[3], RTA_DATA(rta))) {
+			family =3D AF_INET;
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR4;
+			rta->rta_len =3D RTA_LENGTH(4);
+		} else if (inet_pton(AF_INET6, argv[3], RTA_DATA(rta))) {
+			family =3D AF_INET6;
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR6;
+			rta->rta_len =3D RTA_LENGTH(16);
+		} else
+			error(1, errno, "can't parse ip %s", argv[3]);
+		off +=3D NLMSG_ALIGN(rta->rta_len);
+
+		/* family */
+		rta =3D (void *)(data + off);
+		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_FAMILY;
+		rta->rta_len =3D RTA_LENGTH(2);
+		memcpy(RTA_DATA(rta), &family, 2);
+		off +=3D NLMSG_ALIGN(rta->rta_len);
+	}
 	nest->rta_len =3D off - nest_start;
 =

 	do_nl_req(fd, nh, off, 0);
-- =

2.29.2

--===============2908582566804235854==--
