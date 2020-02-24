Content-Type: multipart/mixed; boundary="===============6717712257093583300=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 9/9] selftests: add test-cases for MPTCP MP_JOIN
Date: Mon, 24 Feb 2020 16:51:12 +0100
Message-ID: <d179aac677c69a2b2794a6741fcb36bcf3cc398e.1582558805.git.pabeni@redhat.com>
In-Reply-To: cover.1582558805.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3759

--===============6717712257093583300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the pm netlink to configure the creation of several
subflows, and verify that via MIB counters.

Update the mptcp_connect program to allow reliable MP_JOIN
handshake even on small data file

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v2 -> v3:
 - update self-tests Makefile, too
 - really return an error code on error

Notes:
- all the tests trying to establish subflows using multiple
local addresses currently fail because we currently don'
t send the 4th ack for subflows, so we don't trigger the
mptcp_pm_subflow_established() function (subflows are in
PREESTABLISHED status)

- need more MIB for more reliable checks,
  e.g. MPTcpExtMPJoinSynTx, MPTcpExtMPJoinSynAckRx, AddAddrRx,
	AddAddrTx
---
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../selftests/net/mptcp/mptcp_connect.c       |  19 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 296 ++++++++++++++++++
 3 files changed, 314 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_join.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/sel=
ftests/net/mptcp/Makefile
index 2985cc2f6168..c84589a5c646 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,7 @@ KSFT_KHDR_INSTALL :=3D 1
 =

 CFLAGS =3D  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
 =

-TEST_PROGS :=3D mptcp_connect.sh pm_netlink.sh
+TEST_PROGS :=3D mptcp_connect.sh pm_netlink.sh mptcp_join.sh
 =

 TEST_GEN_FILES =3D mptcp_connect pm_nl_ctl
 =

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 99579c0223c1..1c8696a1417a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -50,6 +50,7 @@ static int cfg_sock_proto	=3D IPPROTO_MPTCP;
 static bool tcpulp_audit;
 static int pf =3D AF_INET;
 static int cfg_sndbuf;
+static bool cfg_join;
 =

 static void die_usage(void)
 {
@@ -230,6 +231,7 @@ static int sock_connect_mptcp(const char * const remote=
addr,
 =

 static size_t do_rnd_write(const int fd, char *buf, const size_t len)
 {
+	static bool first =3D true;
 	unsigned int do_w;
 	ssize_t bw;
 =

@@ -237,10 +239,19 @@ static size_t do_rnd_write(const int fd, char *buf, c=
onst size_t len)
 	if (do_w =3D=3D 0 || do_w > len)
 		do_w =3D len;
 =

+	if (cfg_join && first && do_w > 100)
+		do_w =3D 100;
+
 	bw =3D write(fd, buf, do_w);
 	if (bw < 0)
 		perror("write");
 =

+	/* let the join handshake complete, before going on */
+	if (cfg_join && first) {
+		sleep(1);
+		first =3D false;
+	}
+
 	return bw;
 }
 =

@@ -638,7 +649,7 @@ static void maybe_close(int fd)
 {
 	unsigned int r =3D rand();
 =

-	if (r & 1)
+	if (!cfg_join && (r & 1))
 		close(fd);
 }
 =

@@ -774,8 +785,12 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 =

-	while ((c =3D getopt(argc, argv, "6lp:s:hut:m:b:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "6jlp:s:hut:m:b:")) !=3D -1) {
 		switch (c) {
+		case 'j':
+			cfg_join =3D true;
+			cfg_mode =3D CFG_MODE_POLL;
+			break;
 		case 'l':
 			listen_mode =3D true;
 			break;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
new file mode 100755
index 000000000000..799914cd973a
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -0,0 +1,296 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ret=3D0
+sin=3D""
+sout=3D""
+cin=3D""
+cout=3D""
+ksft_skip=3D4
+timeout=3D30
+capture=3D0
+
+TEST_COUNT=3D0
+
+init()
+{
+	capout=3D$(mktemp)
+
+	rndh=3D$(printf %x $sec)-$(mktemp -u XXXXXX)
+	nstat=3D"/tmp/.nstat.$rndh"
+
+	ns1=3D"ns1-$rndh"
+	ns2=3D"ns2-$rndh"
+
+	for netns in "$ns1" "$ns2";do
+		ip netns add $netns || exit $ksft_skip
+		ip -net $netns link set lo up
+		ip netns exec $netns sysctl -q net.mptcp.enabled=3D1
+		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=3D0
+		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=3D0
+	done
+
+	#  ns1              ns2
+	# ns1eth1    ns2eth1
+	# ns1eth2    ns2eth2
+	# ns1eth3    ns2eth3
+
+	for i in `seq 1 3`; do
+		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$n=
s2"
+		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
+		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
+		ip -net "$ns1" link set ns1eth$i up
+
+		ip -net "$ns2" addr add 10.0.$i.2/24 dev ns2eth$i
+		ip -net "$ns2" addr add dead:beef:$i::2/64 dev ns2eth$i nodad
+		ip -net "$ns2" link set ns2eth$i up
+
+		# let $ns2 reach any $ns1 address from any interface
+		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
+	done
+}
+
+cleanup_partial()
+{
+	rm -f "$capout"
+	rm -f "$nstat"
+
+	for netns in "$ns1" "$ns2"; do
+		ip netns del $netns
+	done
+}
+
+cleanup()
+{
+	rm -f "$cin" "$cout"
+	rm -f "$sin" "$sout"
+	cleanup_partial
+}
+
+reset()
+{
+	cleanup_partial
+	init
+}
+
+for arg in "$@"; do
+	if [ "$arg" =3D "-c" ]; then
+		capture=3D1
+	fi
+done
+
+ip -Version > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+
+check_transfer()
+{
+	in=3D$1
+	out=3D$2
+	what=3D$3
+
+	cmp "$in" "$out" > /dev/null 2>&1
+	if [ $? -ne 0 ] ;then
+		echo "[ FAIL ] $what does not match (in, out):"
+		print_file_err "$in"
+		print_file_err "$out"
+
+		return 1
+	fi
+
+	return 0
+}
+
+do_ping()
+{
+	listener_ns=3D"$1"
+	connector_ns=3D"$2"
+	connect_addr=3D"$3"
+
+	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
+	if [ $? -ne 0 ] ; then
+		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
+		ret=3D1
+	fi
+}
+
+do_transfer()
+{
+	listener_ns=3D"$1"
+	connector_ns=3D"$2"
+	cl_proto=3D"$3"
+	srv_proto=3D"$4"
+	connect_addr=3D"$5"
+
+	port=3D$((10000+$TEST_COUNT))
+	TEST_COUNT=3D$((TEST_COUNT+1))
+
+	:> "$cout"
+	:> "$sout"
+	:> "$capout"
+
+	if [ $capture -eq 1 ]; then
+		if [ -z $SUDO_USER ] ; then
+			capuser=3D""
+		else
+			capuser=3D"-Z $SUDO_USER"
+		fi
+
+		capfile=3D"mp_join-${listener_ns}.pcap"
+
+		echo "Capturing traffic for test $TEST_COUNT into $capfile"
+		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -=
w $capfile > "$capout" 2>&1 &
+		cappid=3D$!
+
+		sleep 1
+	fi
+
+	ip netns exec ${listener_ns} ./mptcp_connect -j -t $timeout -l -p $port -=
s ${srv_proto} 0.0.0.0 < "$sin" > "$sout" &
+	spid=3D$!
+
+	sleep 1
+
+	ip netns exec ${connector_ns} ./mptcp_connect -j -t $timeout -p $port -s =
${cl_proto} $connect_addr < "$cin" > "$cout" &
+	cpid=3D$!
+
+	wait $cpid
+	retc=3D$?
+	wait $spid
+	rets=3D$?
+
+	if [ $capture -eq 1 ]; then
+	    sleep 1
+	    kill $cappid
+	fi
+
+	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
+		echo " client exit code $retc, server $rets" 1>&2
+		echo "\nnetns ${listener_ns} socket stat for $port:" 1>&2
+		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport =3D :$port"
+		echo "\nnetns ${connector_ns} socket stat for $port:" 1>&2
+		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport =3D :$port"
+
+		cat "$capout"
+		return 1
+	fi
+
+	check_transfer $sin $cout "file received by client"
+	retc=3D$?
+	check_transfer $cin $sout "file received by server"
+	rets=3D$?
+
+	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
+		cat "$capout"
+		return 0
+	fi
+
+	cat "$capout"
+	return 1
+}
+
+make_file()
+{
+	name=3D$1
+	who=3D$2
+
+	SIZE=3D1
+
+	dd if=3D/dev/urandom of=3D"$name" bs=3D1024 count=3D$SIZE 2> /dev/null
+	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
+
+	echo "Created $name (size $SIZE KB) containing data sent by $who"
+}
+
+run_tests()
+{
+	listener_ns=3D"$1"
+	connector_ns=3D"$2"
+	connect_addr=3D"$3"
+	lret=3D0
+
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
+	lret=3D$?
+	if [ $lret -ne 0 ]; then
+		ret=3D$lret
+		return
+	fi
+}
+
+chk_join_nr()
+{
+	local msg=3D"$1"
+	local ns=3D$2
+	local nr=3D$3
+	local count
+
+	count=3D`NSTAT_HISTORY=3D$nstat ip netns exec $ns nstat |grep MPTcpExtMPJ=
oinSynRx | awk '{print $2}'`
+	[ -z "$count" ] && count=3D0
+	printf "%-50s %s" "$msg"
+	if [ "$count" !=3D "$nr" ]; then
+		echo "[fail] got $count JOIN[s] expected $nr"
+		ret=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+}
+
+sin=3D$(mktemp)
+sout=3D$(mktemp)
+cin=3D$(mktemp)
+cout=3D$(mktemp)
+init
+make_file "$cin" "client"
+make_file "$sin" "server"
+trap cleanup EXIT
+
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "no JOIN" $ns1 "0"
+
+# subflow
+reset
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "single subflow" $ns1 1
+
+# multiple subflows
+reset
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "multiple subflows" $ns1 2
+
+# add_address, unused
+reset
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "unused signal address" $ns1 0
+
+# accept and use add_addr
+reset
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl accept 1
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "signal address" $ns1 1
+
+# accept and use add_addr with an additional subflow
+reset
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl accept 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "subflow and signal" $ns1 2
+
+# accept and use add_addr with an additional subflows
+reset
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl accept 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.2 flags signal
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "multiple subflows and signal" $ns1 3
+
+exit $ret
\ No newline at end of file
-- =

2.21.1

--===============6717712257093583300==--
