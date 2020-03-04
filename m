Content-Type: multipart/mixed; boundary="===============2336146024602960321=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 11/0011] Squash-to: "selftests: add PM netlink
 functional tests"
Date: Wed, 04 Mar 2020 16:02:10 +0100
Message-ID: <abb68ea1a2921527e0bd71d66c8c9660ae0d2c3a.1583334096.git.pabeni@redhat.com>
In-Reply-To: cover.1583334095.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3859

--===============2336146024602960321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

update to new NL APIs

add checks for subflows limits

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 17 +++++--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 46 ++++++++++++-------
 2 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index a6552eb8acbe..cfc743c47cb2 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -69,7 +69,8 @@ check()
 }
 =

 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
-check "ip netns exec $ns1 ./pm_nl_ctl accept" "accept 0" "defaults accept =
add addr"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
+subflows 0" "defaults limits"
 =

 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
@@ -114,10 +115,16 @@ id 8 flags signal 10.0.1.8 " "id limit"
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 =

-ip netns exec $ns1 ./pm_nl_ctl accept 9
-check "ip netns exec $ns1 ./pm_nl_ctl accept" "accept 0" "above accept add=
_addr hard limit"
+ip netns exec $ns1 ./pm_nl_ctl limits 9 1
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
+subflows 0" "rcv addrs above hard limit"
 =

-ip netns exec $ns1 ./pm_nl_ctl accept 8
-check "ip netns exec $ns1 ./pm_nl_ctl accept" "accept 8" "set accept add_a=
ddr"
+ip netns exec $ns1 ./pm_nl_ctl limits 1 9
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
+subflows 0" "subflows above hard limit"
+
+ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
+subflows 8" "set limits"
 =

 exit $ret
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 66ce85a0ff98..cc3b9c5a3cff 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -30,7 +30,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tget <id>\n");
 	fprintf(stderr, "\tflush\n");
 	fprintf(stderr, "\tdump\n");
-	fprintf(stderr, "\taccept [<max>]\n");
+	fprintf(stderr, "\tlimits [<rcv addr max> <subflow max>]\n");
 	exit(0);
 }
 =

@@ -501,7 +501,7 @@ int flush_addrs(int fd, int pm_family, int argc, char *=
argv[])
 	return 0;
 }
 =

-static void print_accept(struct nlmsghdr *nh, int pm_family, int total_len)
+static void print_limits(struct nlmsghdr *nh, int pm_family, int total_len)
 {
 	struct rtattr *attrs;
 	uint32_t max;
@@ -520,11 +520,15 @@ static void print_accept(struct nlmsghdr *nh, int pm_=
family, int total_len)
 		attrs =3D (struct rtattr *) ((char *) NLMSG_DATA(nh) +
 					   GENL_HDRLEN);
 		while (RTA_OK(attrs, len)) {
-			if (attrs->rta_type !=3D MPTCP_PM_ATTR_RCV_ADD_ADDRS)
+			int type =3D attrs->rta_type;
+
+			if (type !=3D MPTCP_PM_ATTR_RCV_ADD_ADDRS &&
+			    type !=3D MPTCP_PM_ATTR_SUBFLOWS)
 				goto next;
 =

 			memcpy(&max, RTA_DATA(attrs), 4);
-			printf("accept %u\n", max);
+			printf("%s %u\n", type =3D=3D MPTCP_PM_ATTR_SUBFLOWS ?
+					  "subflows": "accept", max);
 =

 next:
 			attrs =3D RTA_NEXT(attrs, len);
@@ -532,22 +536,23 @@ static void print_accept(struct nlmsghdr *nh, int pm_=
family, int total_len)
 	}
 }
 =

-int get_set_accept(int fd, int pm_family, int argc, char *argv[])
+int get_set_limits(int fd, int pm_family, int argc, char *argv[])
 {
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
 		  1024];
+	uint32_t rcv_addr =3D 0, subflows =3D 0;
 	int cmd, len =3D sizeof(data);
 	struct nlmsghdr *nh;
-	uint32_t max =3D 0;
 	int off =3D 0;
 =

 	/* limit */
-	if (argc =3D=3D 3) {
-		max =3D atoi(argv[2]);
-		cmd =3D MPTCP_PM_CMD_SET_RCV_ADD_ADDRS;
+	if (argc =3D=3D 4) {
+		rcv_addr =3D atoi(argv[2]);
+		subflows =3D atoi(argv[3]);
+		cmd =3D MPTCP_PM_CMD_SET_LIMITS;
 	} else {
-		cmd =3D MPTCP_PM_CMD_GET_RCV_ADD_ADDRS;
+		cmd =3D MPTCP_PM_CMD_GET_LIMITS;
 	}
 =

 	memset(data, 0, sizeof(data));
@@ -555,20 +560,27 @@ int get_set_accept(int fd, int pm_family, int argc, c=
har *argv[])
 	off =3D init_genl_req(data, pm_family, cmd, MPTCP_PM_VER);
 =

 	/* limit */
-	if (cmd =3D=3D MPTCP_PM_CMD_SET_RCV_ADD_ADDRS) {
+	if (cmd =3D=3D MPTCP_PM_CMD_SET_LIMITS) {
 		struct rtattr *rta =3D (void *)(data + off);
 =

 		rta->rta_type =3D MPTCP_PM_ATTR_RCV_ADD_ADDRS;
 		rta->rta_len =3D RTA_LENGTH(4);
-		memcpy(RTA_DATA(rta), &max, 4);
+		memcpy(RTA_DATA(rta), &rcv_addr, 4);
 		off +=3D NLMSG_ALIGN(rta->rta_len);
-		cmd =3D MPTCP_PM_CMD_SET_RCV_ADD_ADDRS;
+
+		rta =3D (void *)(data + off);
+		rta->rta_type =3D MPTCP_PM_ATTR_SUBFLOWS;
+		rta->rta_len =3D RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &subflows, 4);
+		off +=3D NLMSG_ALIGN(rta->rta_len);
+
+		/* do not expect a reply */
 		len =3D 0;
 	}
 =

 	len =3D do_nl_req(fd, nh, off, len);
-	if (cmd =3D=3D MPTCP_PM_CMD_GET_RCV_ADD_ADDRS)
-		print_accept(nh, pm_family, len);
+	if (cmd =3D=3D MPTCP_PM_CMD_GET_LIMITS)
+		print_limits(nh, pm_family, len);
 	return 0;
 }
 =

@@ -595,8 +607,8 @@ int main(int argc, char *argv[])
 		return get_addr(fd, pm_family, argc, argv);
 	else if (!strcmp(argv[1], "dump"))
 		return dump_addrs(fd, pm_family, argc, argv);
-	else if (!strcmp(argv[1], "accept"))
-		return get_set_accept(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "limits"))
+		return get_set_limits(fd, pm_family, argc, argv);
 =

 	fprintf(stderr, "unknown sub-command: %s", argv[1]);
 	syntax(argv);
-- =

2.21.1

--===============2336146024602960321==--
