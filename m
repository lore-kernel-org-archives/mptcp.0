Content-Type: multipart/mixed; boundary="===============3261602226523002005=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 6/8] selftests: mptcp: add set_flags command
 in pm_nl_ctl
Date: Fri, 08 Jan 2021 16:48:00 -0800
Message-ID: <20210109004802.341602-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210109004802.341602-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7294

--===============3261602226523002005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added the set_flags command in pm_nl_ctl, currently we can only
set two flags: backup and nobackup. The set_flags command can be used like
this:

 # pm_nl_ctl set 10.0.0.1 flags backup
 # pm_nl_ctl set 10.0.0.1 flags nobackup

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 87 ++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index b24a2f17d415..abc269e96a07 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -24,10 +24,11 @@
 =

 static void syntax(char *argv[])
 {
-	fprintf(stderr, "%s add|get|del|flush|dump|accept [<args>]\n", argv[0]);
+	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0=
]);
 	fprintf(stderr, "\tadd [flags signal|subflow|backup] [id <nr>] [dev <name=
>] <ip>\n");
 	fprintf(stderr, "\tdel <id>\n");
 	fprintf(stderr, "\tget <id>\n");
+	fprintf(stderr, "\tset <ip> [flags backup|nobackup]\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
 	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
@@ -584,6 +585,88 @@ int get_set_limits(int fd, int pm_family, int argc, ch=
ar *argv[])
 	return 0;
 }
 =

+int set_flags(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	struct rtattr *rta, *nest;
+	struct nlmsghdr *nh;
+	u_int32_t flags =3D 0;
+	u_int16_t family;
+	int nest_start;
+	int off =3D 0;
+	int arg;
+
+	memset(data, 0, sizeof(data));
+	nh =3D (void *)data;
+	off =3D init_genl_req(data, pm_family, MPTCP_PM_CMD_SET_FLAGS,
+			    MPTCP_PM_VER);
+
+	if (argc < 3)
+		syntax(argv);
+
+	nest_start =3D off;
+	nest =3D (void *)(data + off);
+	nest->rta_type =3D NLA_F_NESTED | MPTCP_PM_ATTR_ADDR;
+	nest->rta_len =3D RTA_LENGTH(0);
+	off +=3D NLMSG_ALIGN(nest->rta_len);
+
+	/* addr data */
+	rta =3D (void *)(data + off);
+	if (inet_pton(AF_INET, argv[2], RTA_DATA(rta))) {
+		family =3D AF_INET;
+		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR4;
+		rta->rta_len =3D RTA_LENGTH(4);
+	} else if (inet_pton(AF_INET6, argv[2], RTA_DATA(rta))) {
+		family =3D AF_INET6;
+		rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ADDR6;
+		rta->rta_len =3D RTA_LENGTH(16);
+	} else {
+		error(1, errno, "can't parse ip %s", argv[2]);
+	}
+	off +=3D NLMSG_ALIGN(rta->rta_len);
+
+	/* family */
+	rta =3D (void *)(data + off);
+	rta->rta_type =3D MPTCP_PM_ADDR_ATTR_FAMILY;
+	rta->rta_len =3D RTA_LENGTH(2);
+	memcpy(RTA_DATA(rta), &family, 2);
+	off +=3D NLMSG_ALIGN(rta->rta_len);
+
+	for (arg =3D 3; arg < argc; arg++) {
+		if (!strcmp(argv[arg], "flags")) {
+			char *tok, *str;
+
+			/* flags */
+			if (++arg >=3D argc)
+				error(1, 0, " missing flags value");
+
+			/* do not support flag list yet */
+			for (str =3D argv[arg]; (tok =3D strtok(str, ","));
+			     str =3D NULL) {
+				if (!strcmp(tok, "backup"))
+					flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
+				else if (strcmp(tok, "nobackup"))
+					error(1, errno,
+					      "unknown flag %s", argv[arg]);
+			}
+
+			rta =3D (void *)(data + off);
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_FLAGS;
+			rta->rta_len =3D RTA_LENGTH(4);
+			memcpy(RTA_DATA(rta), &flags, 4);
+			off +=3D NLMSG_ALIGN(rta->rta_len);
+		} else {
+			error(1, 0, "unknown keyword %s", argv[arg]);
+		}
+	}
+	nest->rta_len =3D off - nest_start;
+
+	do_nl_req(fd, nh, off, 0);
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	int fd, pm_family;
@@ -609,6 +692,8 @@ int main(int argc, char *argv[])
 		return dump_addrs(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "limits"))
 		return get_set_limits(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "set"))
+		return set_flags(fd, pm_family, argc, argv);
 =

 	fprintf(stderr, "unknown sub-command: %s", argv[1]);
 	syntax(argv);
-- =

2.30.0

--===============3261602226523002005==--
