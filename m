Content-Type: multipart/mixed; boundary="===============4239044807921193702=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 7/7] selftests: add PM netlink functional tests
Date: Mon, 17 Feb 2020 19:28:33 +0100
Message-ID: <6e6bf9803a683ffd84daee3ed8db3941831546a6.1581963739.git.pabeni@redhat.com>
In-Reply-To: cover.1581963738.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3684

--===============4239044807921193702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 tools/testing/selftests/net/mptcp/Makefile    |   4 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh | 149 +++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 556 ++++++++++++++++++
 3 files changed, 707 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/pm_netlink.sh
 create mode 100644 tools/testing/selftests/net/mptcp/pm_nl_ctl.c

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/sel=
ftests/net/mptcp/Makefile
index 93de52016dde..8bbb676e49b6 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -2,11 +2,11 @@
 =

 top_srcdir =3D ../../../../..
 =

-CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g
+CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g  -iquote../../../../../include=
/uapi/
 =

 TEST_PROGS :=3D mptcp_connect.sh
 =

-TEST_GEN_FILES =3D mptcp_connect
+TEST_GEN_FILES =3D mptcp_connect pm_nl_ctl
 =

 EXTRA_CLEAN :=3D *.pcap
 =

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
new file mode 100755
index 000000000000..817c4200e348
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -0,0 +1,149 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+capture=3Dfalse
+ksft_skip=3D4
+ret=3D0
+
+usage() {
+	echo "Usage: $0 [ -a ]"
+	echo -e "\t-c: capture packets for each test using tcpdump (default: no c=
apture)"
+}
+
+
+while getopts "$optstring" option;do
+	case "$option" in
+	"h")
+		usage $0
+		exit 0
+		;;
+	"c")
+		capture=3Dtrue
+		;;
+	"?")
+		usage $0
+		exit 1
+		;;
+	esac
+done
+
+sec=3D$(date +%s)
+rndh=3D$(printf %x $sec)-$(mktemp -u XXXXXX)
+ns1=3D"ns1-$rndh"
+ns2=3D"ns2-$rndh"
+err=3D$(mktemp)
+ret=3D0
+
+cleanup()
+{
+	rm -f $out
+	for netns in "$ns1" "$ns2";do
+		ip netns del $netns
+	done
+}
+
+ip -Version > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+trap cleanup EXIT
+
+for i in "$ns1" "$ns2";do
+	ip netns add $i || exit $ksft_skip
+	ip -net $i link set lo up
+	ip netns exec $i sysctl -q net.mptcp.enabled=3D1
+done
+
+#  "$ns1"              ns2
+#    ns1eth1    ns2eth1
+#    ns1eth2    ns2eth2
+#    ns1eth3    ns2eth3
+
+for i in `seq 1 3`; do
+	ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns=
2"
+	ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
+	ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
+	ip -net "$ns1" link set ns1eth$i up
+
+	ip -net "$ns2" addr add 10.0.$i.2/24 dev ns2eth$i
+	ip -net "$ns2" addr add dead:beef:$i::2/64 dev ns2eth$i nodad
+	ip -net "$ns2" link set ns2eth$i up
+done
+
+check()
+{
+	local cmd=3D"$1"
+	local expected=3D"$2"
+	local msg=3D"$3"
+	local out=3D`$cmd 2>$err`
+	local cmd_ret=3D$?
+
+	printf "%-50s %s" "$msg"
+	if [ $cmd_ret -ne 0 ]; then
+		echo "[FAIL] command execution '$cmd' stderr "
+		cat $err
+		ret=3D1
+	elif [ "$out" =3D "$expected" ]; then
+		echo "[ OK ]"
+	else
+		echo -n "[FAIL] "
+		echo "expected '$expected' got '$out'"
+		ret=3D1
+	fi
+}
+
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
+check "ip netns exec $ns1 ./pm_nl_ctl accept" "accept 0" "defaults accept =
add addr"
+
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal
+check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1 " "simp=
le add/get addr"
+
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+"id 1 flags  10.0.1.1 =

+id 2 flags subflow 10.0.1.2 =

+id 3 flags signal 10.0.1.3 " "dump addrs"
+
+ip netns exec $ns1 ./pm_nl_ctl del 2
+check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+"id 1 flags  10.0.1.1 =

+id 3 flags signal 10.0.1.3 " "dump addrs after del"
+
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3
+check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
+
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 id 10 flags signal
+check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4 "=
 "id addr increment"
+
+for i in `seq 5 9`; do
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
+done
+check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9 "=
 "hard addr limit"
+check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
+
+for i in `seq 9 256`; do
+	ip netns exec $ns1 ./pm_nl_ctl del $i
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9
+done
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1 =

+id 3 flags signal 10.0.1.3 =

+id 4 flags signal 10.0.1.4 =

+id 5 flags signal 10.0.1.5 =

+id 6 flags signal 10.0.1.6 =

+id 7 flags signal 10.0.1.7 =

+id 8 flags signal 10.0.1.8 " "id limit"
+
+ip netns exec $ns1 ./pm_nl_ctl flush
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
+
+ip netns exec $ns1 ./pm_nl_ctl accept 9
+check "ip netns exec $ns1 ./pm_nl_ctl accept" "accept 0" "above accept add=
_addr hard limit"
+
+ip netns exec $ns1 ./pm_nl_ctl accept 8
+check "ip netns exec $ns1 ./pm_nl_ctl accept" "accept 8" "set accept add_a=
ddr"
+
+exit $ret
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
new file mode 100644
index 000000000000..a2512f7c3d70
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <error.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/socket.h>
+#include <sys/types.h>
+
+#include <arpa/inet.h>
+
+#include <linux/rtnetlink.h>
+#include <linux/genetlink.h>
+
+#include "linux/mptcp.h"
+
+#ifndef MPTCP_PM_NAME
+#define MPTCP_PM_NAME		"mptcp_pm"
+#endif
+
+static void syntax(char *argv[])
+{
+	fprintf(stderr, "%s add|get|del|flush|dump|accept [<args>]\n", argv[0]);
+	fprintf(stderr, "\tadd [flags signal|subflow] <ip>\n");
+	fprintf(stderr, "\tdel <id>\n");
+	fprintf(stderr, "\tget <id>\n");
+	fprintf(stderr, "\tflush\n");
+	fprintf(stderr, "\tdump\n");
+	fprintf(stderr, "\taccept [<max>]\n");
+	exit(0);
+}
+
+static int init_genl_req(char *data, int family, int cmd, int version)
+{
+	struct nlmsghdr *nh =3D (void *)data;
+	struct genlmsghdr *gh;
+	int off =3D 0;
+
+	nh->nlmsg_type =3D family;
+	nh->nlmsg_flags =3D NLM_F_REQUEST;
+	nh->nlmsg_len =3D NLMSG_LENGTH(GENL_HDRLEN);
+	off +=3D NLMSG_ALIGN(sizeof(*nh));
+
+	gh =3D (void *)(data + off);
+	gh->cmd =3D cmd;
+	gh->version =3D version;
+	off +=3D NLMSG_ALIGN(sizeof(*gh));
+	return off;
+}
+
+static void nl_error(struct nlmsghdr *nh)
+{
+	struct nlmsgerr *err =3D (struct nlmsgerr *)NLMSG_DATA(nh);
+	int len =3D nh->nlmsg_len - sizeof(*nh);
+	uint32_t off;
+
+	if (len < sizeof(struct nlmsgerr))
+		error(1, 0, "netlink error message truncated %d min %ld", len,
+		      sizeof(struct nlmsgerr));
+
+	if (!err->error) {
+		/* check messages from kernel */
+		struct rtattr *attrs =3D (struct rtattr *)NLMSG_DATA(nh);
+		while (RTA_OK(attrs, len)) {
+			if (attrs->rta_type =3D=3D NLMSGERR_ATTR_MSG)
+				fprintf(stderr, "netlink ext ack msg: %s\n",
+				        (char *)RTA_DATA(attrs));
+			if (attrs->rta_type =3D=3D NLMSGERR_ATTR_OFFS) {
+				memcpy(&off, RTA_DATA(attrs), 4);
+				fprintf(stderr, "netlink err off %d\n",
+				        (int)off);
+			}
+			attrs =3D RTA_NEXT(attrs, len);
+		}
+	} else {
+		fprintf(stderr, "netlink error %d", err->error);
+	}
+}
+
+/* do a netlink command and, if max > 0, fetch the reply  */
+static int do_nl_req(int fd, struct nlmsghdr *nh, int len, int max)
+{
+	struct sockaddr_nl nladdr =3D { .nl_family =3D AF_NETLINK };
+	socklen_t addr_len;
+	void *data =3D nh;
+	int rem, ret;
+	int err =3D 0;
+
+	nh->nlmsg_len =3D len;
+	ret =3D sendto(fd, data, len, 0, (void *)&nladdr, sizeof(nladdr));
+	if (ret !=3D len)
+		error(1, errno, "send netlink: %uB !=3D %uB\n", ret, len);
+	if (max =3D=3D 0)
+		return 0;
+
+	addr_len =3D sizeof(nladdr);
+	rem =3D ret =3D recvfrom(fd, data, max, 0, (void *)&nladdr, &addr_len);
+	if (ret < 0)
+		error(1, errno, "recv netlink: %uB\n", ret);
+
+	/* Beware: the NLMSG_NEXT macro updates the 'rem' argument */
+	for (;NLMSG_OK(nh, rem); nh =3D NLMSG_NEXT(nh, rem)) {
+		if (nh->nlmsg_type =3D=3D NLMSG_ERROR) {
+			nl_error(nh);
+			err =3D 1;
+		}
+	}
+	if (err)
+		error(1, 0, "bailing out due to netlink error[s]");
+	return ret;
+}
+
+static int genl_parse_getfamily(struct nlmsghdr *nlh)
+{
+	struct genlmsghdr *ghdr =3D NLMSG_DATA(nlh);
+	int len =3D nlh->nlmsg_len;
+	struct rtattr *attrs;
+
+	if (nlh->nlmsg_type !=3D GENL_ID_CTRL)
+		error(1, errno, "Not a controller message, nlmsg_len=3D%d "
+			"nlmsg_type=3D0x%x\n", nlh->nlmsg_len, nlh->nlmsg_type);
+
+	len -=3D NLMSG_LENGTH(GENL_HDRLEN);
+
+	if (len < 0)
+		error(1, errno, "wrong controller message len %d\n", len);
+
+	if (ghdr->cmd !=3D CTRL_CMD_NEWFAMILY)
+		error(1, errno, "Unknown controller command %d\n", ghdr->cmd);
+
+	attrs =3D (struct rtattr *) ((char *) ghdr + GENL_HDRLEN);
+	while (RTA_OK(attrs, len)) {
+		if (attrs->rta_type =3D=3D CTRL_ATTR_FAMILY_ID)
+			return *(__u16 *)RTA_DATA(attrs);
+		attrs =3D RTA_NEXT(attrs, len);
+	}
+
+	error(1, errno, "can't find CTRL_ATTR_FAMILY_ID attr");
+	return -1;
+}
+
+static int resolve_mptcp_pm_netlink(int fd)
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	struct nlmsghdr *nh;
+	struct rtattr *rta;
+	int namelen;
+	int off =3D 0;
+
+	memset(data, 0, sizeof(data));
+	nh =3D (void *)data;
+	off =3D init_genl_req(data, GENL_ID_CTRL, CTRL_CMD_GETFAMILY, 0);
+
+	rta =3D (void *)(data + off);
+	namelen =3D strlen(MPTCP_PM_NAME) + 1;
+	rta->rta_type =3D CTRL_ATTR_FAMILY_NAME;
+	rta->rta_len =3D RTA_LENGTH(namelen);
+	memcpy(RTA_DATA(rta), MPTCP_PM_NAME, namelen);
+	off +=3D NLMSG_ALIGN(rta->rta_len);
+
+	do_nl_req(fd, nh, off, sizeof(data));
+	return genl_parse_getfamily((void *)data);
+}
+
+int add_addr(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	struct rtattr *rta, *nest;
+	struct nlmsghdr *nh;
+	u_int16_t family;
+	u_int32_t flags;
+	int nest_start;
+	u_int8_t id;
+	int off =3D 0;
+	int arg;
+
+	memset(data, 0, sizeof(data));
+	nh =3D (void *)data;
+	off =3D init_genl_req(data, pm_family, MPTCP_CMD_ADD_ADDR, MPTCP_PM_VER);
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
+	} else
+		error(1, errno, "can't parse ip %s", argv[2]);
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
+			/* flags */
+			flags =3D 0;
+			if (++arg >=3D argc)
+				error(1, 0, " missing flags value");
+
+			/* do not support flag list yet */
+			if (!strcmp(argv[arg], "subflow"))
+				flags |=3D MPTCP_PM_ADDR_FLAG_SUBFLOW;
+			else if (!strcmp(argv[arg], "signal"))
+				flags |=3D MPTCP_PM_ADDR_FLAG_SIGNAL;
+			else
+				error(1, errno, "unknown flag %s", argv[arg]);
+
+			rta =3D (void *)(data + off);
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_FLAGS;
+			rta->rta_len =3D RTA_LENGTH(4);
+			memcpy(RTA_DATA(rta), &flags, 4);
+			off +=3D NLMSG_ALIGN(rta->rta_len);
+		} else if (!strcmp(argv[arg], "id")) {
+			if (++arg >=3D argc)
+				error(1, 0, " missing id value");
+
+			id =3D atoi(argv[arg]);
+			rta =3D (void *)(data + off);
+			rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ID;
+			rta->rta_len =3D RTA_LENGTH(1);
+			memcpy(RTA_DATA(rta), &id, 1);
+			off +=3D NLMSG_ALIGN(rta->rta_len);
+		} else
+			error(1, 0, "unknown keyword %s", argv[arg]);
+	}
+	nest->rta_len =3D off - nest_start;
+
+	do_nl_req(fd, nh, off, 0);
+	return 0;
+}
+
+int del_addr(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	struct rtattr *rta, *nest;
+	struct nlmsghdr *nh;
+	int nest_start;
+	u_int8_t id;
+	int off =3D 0;
+
+	memset(data, 0, sizeof(data));
+	nh =3D (void *)data;
+	off =3D init_genl_req(data, pm_family, MPTCP_CMD_DEL_ADDR, MPTCP_PM_VER);
+
+	/* the only argument is the address id */
+	if (argc !=3D 3)
+		syntax(argv);
+
+	id =3D atoi(argv[2]);
+
+	nest_start =3D off;
+	nest =3D (void *)(data + off);
+	nest->rta_type =3D NLA_F_NESTED | MPTCP_PM_ATTR_ADDR;
+	nest->rta_len =3D  RTA_LENGTH(0);
+	off +=3D NLMSG_ALIGN(nest->rta_len);
+
+	/* build a dummy addr with only the ID set */
+	rta =3D (void *)(data + off);
+	rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ID;
+	rta->rta_len =3D RTA_LENGTH(1);
+	memcpy(RTA_DATA(rta), &id, 1);
+	off +=3D NLMSG_ALIGN(rta->rta_len);
+	nest->rta_len =3D off - nest_start;
+
+	do_nl_req(fd, nh, off, 0);
+	return 0;
+}
+
+static void print_addr(struct rtattr *attrs, int len)
+{
+	uint16_t family =3D 0;
+	char str[1024];
+	uint32_t flags;
+	uint8_t id;
+
+	while (RTA_OK(attrs, len)) {
+		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_FAMILY)
+			memcpy(&family, RTA_DATA(attrs), 2);
+		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_ADDR4) {
+			if (family !=3D AF_INET)
+				error(1, errno, "wrong IP (v4) for family %d",
+				      family);
+			inet_ntop(AF_INET, RTA_DATA(attrs), str, sizeof(str));
+			printf("%s ", str);
+		}
+		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_ADDR6) {
+			if (family !=3D AF_INET6)
+				error(1, errno, "wrong IP (v6) for family %d",
+				      family);
+			inet_ntop(AF_INET6, RTA_DATA(attrs), str, sizeof(str));
+			printf("%s ", str);
+		}
+		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_ID) {
+			memcpy(&id, RTA_DATA(attrs), 1);
+			printf("id %d ", id);
+		}
+		if (attrs->rta_type =3D=3D MPTCP_PM_ADDR_ATTR_FLAGS) {
+			memcpy(&flags, RTA_DATA(attrs), 4);
+
+			printf("flags ");
+			if (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+				printf("signal");
+				flags &=3D ~MPTCP_PM_ADDR_FLAG_SIGNAL;
+				if (flags)
+					printf(",");
+			}
+
+			if (flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+				printf("subflow");
+				flags &=3D ~MPTCP_PM_ADDR_FLAG_SUBFLOW;
+				if (flags)
+					printf(",");
+			}
+
+			/* bump unkown flags, if any */
+			if (flags)
+				printf("0x%x", flags);
+			printf(" ");
+		}
+
+		attrs =3D RTA_NEXT(attrs, len);
+	}
+	printf("\n");
+}
+
+static void print_addrs(struct nlmsghdr *nh, int pm_family, int total_len)
+{
+	struct rtattr *attrs;
+
+	for (;NLMSG_OK(nh, total_len); nh =3D NLMSG_NEXT(nh, total_len)) {
+		int len =3D nh->nlmsg_len;
+
+		if (nh->nlmsg_type =3D=3D NLMSG_DONE)
+			break;
+		if (nh->nlmsg_type =3D=3D NLMSG_ERROR)
+			nl_error(nh);
+		if (nh->nlmsg_type !=3D pm_family)
+			continue;
+
+		len -=3D NLMSG_LENGTH(GENL_HDRLEN);
+		attrs =3D (struct rtattr *) ((char *) NLMSG_DATA(nh) +
+					   GENL_HDRLEN);
+		while (RTA_OK(attrs, len)) {
+			if (attrs->rta_type =3D=3D
+			    (MPTCP_PM_ATTR_ADDR | NLA_F_NESTED))
+				print_addr((void *)RTA_DATA(attrs),
+					   attrs->rta_len);
+			attrs =3D RTA_NEXT(attrs, len);
+		}
+	}
+}
+
+int get_addr(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	struct rtattr *rta, *nest;
+	struct nlmsghdr *nh;
+	int nest_start;
+	u_int8_t id;
+	int off =3D 0;
+
+	memset(data, 0, sizeof(data));
+	nh =3D (void *)data;
+	off =3D init_genl_req(data, pm_family, MPTCP_CMD_GET_ADDR, MPTCP_PM_VER);
+
+	/* the only argument is the address id */
+	if (argc !=3D 3)
+		syntax(argv);
+
+	id =3D atoi(argv[2]);
+
+	nest_start =3D off;
+	nest =3D (void *)(data + off);
+	nest->rta_type =3D NLA_F_NESTED | MPTCP_PM_ATTR_ADDR;
+	nest->rta_len =3D  RTA_LENGTH(0);
+	off +=3D NLMSG_ALIGN(nest->rta_len);
+
+	/* build a dummy addr with only the ID set */
+	rta =3D (void *)(data + off);
+	rta->rta_type =3D MPTCP_PM_ADDR_ATTR_ID;
+	rta->rta_len =3D RTA_LENGTH(1);
+	memcpy(RTA_DATA(rta), &id, 1);
+	off +=3D NLMSG_ALIGN(rta->rta_len);
+	nest->rta_len =3D off - nest_start;
+
+	print_addrs(nh, pm_family, do_nl_req(fd, nh, off, sizeof(data)));
+	return 0;
+}
+
+int dump_addrs(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	pid_t pid =3D getpid();
+	struct nlmsghdr *nh;
+	int off =3D 0;
+
+	memset(data, 0, sizeof(data));
+	nh =3D (void *)data;
+	off =3D init_genl_req(data, pm_family, MPTCP_CMD_GET_ADDR, MPTCP_PM_VER);
+	nh->nlmsg_flags |=3D NLM_F_DUMP;
+	nh->nlmsg_seq =3D 1;
+	nh->nlmsg_pid =3D pid;
+	nh->nlmsg_len =3D off;
+
+	print_addrs(nh, pm_family, do_nl_req(fd, nh, off, sizeof(data)));
+	return 0;
+}
+
+int flush_addrs(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	struct nlmsghdr *nh;
+	int off =3D 0;
+
+	memset(data, 0, sizeof(data));
+	nh =3D (void *)data;
+	off =3D init_genl_req(data, pm_family, MPTCP_CMD_FLUSH_ADDRS, MPTCP_PM_VE=
R);
+
+	do_nl_req(fd, nh, off, 0);
+	return 0;
+}
+
+static void print_accept(struct nlmsghdr *nh, int pm_family, int total_len)
+{
+	struct rtattr *attrs;
+	uint32_t max;
+
+	for (;NLMSG_OK(nh, total_len); nh =3D NLMSG_NEXT(nh, total_len)) {
+		int len =3D nh->nlmsg_len;
+
+		if (nh->nlmsg_type =3D=3D NLMSG_DONE)
+			break;
+		if (nh->nlmsg_type =3D=3D NLMSG_ERROR)
+			nl_error(nh);
+		if (nh->nlmsg_type !=3D pm_family)
+			continue;
+
+		len -=3D NLMSG_LENGTH(GENL_HDRLEN);
+		attrs =3D (struct rtattr *) ((char *) NLMSG_DATA(nh) +
+					   GENL_HDRLEN);
+		while (RTA_OK(attrs, len)) {
+			if (attrs->rta_type !=3D MPTCP_PM_ATTR_RCV_ADD_ADDRS)
+				goto next;
+
+			memcpy(&max, RTA_DATA(attrs), 4);
+			printf("accept %u\n", max);
+
+next:
+			attrs =3D RTA_NEXT(attrs, len);
+		}
+	}
+}
+
+int get_set_accept(int fd, int pm_family, int argc, char *argv[])
+{
+	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
+		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
+		  1024];
+	int cmd, len =3D sizeof(data);
+	struct nlmsghdr *nh;
+	uint32_t max =3D 0;
+	int off =3D 0;
+
+	/* limit */
+	if (argc =3D=3D 3) {
+		max =3D atoi(argv[2]);
+		cmd =3D MPTCP_CMD_SET_RCV_ADD_ADDRS;
+	} else {
+		cmd =3D MPTCP_CMD_GET_RCV_ADD_ADDRS;
+	}
+
+	memset(data, 0, sizeof(data));
+	nh =3D (void *)data;
+	off =3D init_genl_req(data, pm_family, cmd, MPTCP_PM_VER);
+
+	/* limit */
+	if (cmd =3D=3D MPTCP_CMD_SET_RCV_ADD_ADDRS) {
+		struct rtattr *rta =3D (void *)(data + off);
+
+		rta->rta_type =3D MPTCP_PM_ATTR_RCV_ADD_ADDRS;
+		rta->rta_len =3D RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &max, 4);
+		off +=3D NLMSG_ALIGN(rta->rta_len);
+		cmd =3D MPTCP_CMD_SET_RCV_ADD_ADDRS;
+		len =3D 0;
+	}
+
+	len =3D do_nl_req(fd, nh, off, len);
+	if (cmd =3D=3D MPTCP_CMD_GET_RCV_ADD_ADDRS)
+		print_accept(nh, pm_family, len);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int fd, pm_family;
+
+	if (argc < 2)
+		syntax(argv);
+
+	fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	if (fd =3D=3D -1)
+		error(1, errno, "socket netlink");
+
+	pm_family =3D resolve_mptcp_pm_netlink(fd);
+
+	if (!strcmp(argv[1], "add"))
+		return add_addr(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "del"))
+		return del_addr(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "flush"))
+		return flush_addrs(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "get"))
+		return get_addr(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "dump"))
+		return dump_addrs(fd, pm_family, argc, argv);
+	else if (!strcmp(argv[1], "accept"))
+		return get_set_accept(fd, pm_family, argc, argv);
+
+	fprintf(stderr, "unknown sub-command: %s", argv[1]);
+	syntax(argv);
+	return 0;
+}
-- =

2.21.1

--===============4239044807921193702==--
