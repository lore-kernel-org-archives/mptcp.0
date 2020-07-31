Content-Type: multipart/mixed; boundary="===============4598578958676565665=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 12/12] mptcp: simult flow self-tests
Date: Fri, 31 Jul 2020 19:39:27 +0200
Message-ID: <67f4e00895aed1a4678891c0838623df3db2e44e.1596216310.git.pabeni@redhat.com>
In-Reply-To: cover.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5419

--===============4598578958676565665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a bunch of test-cases for multiple subflow xmit:
create multiple subflows simulating different links
condition via netem and verify that the msk is able
to use completely the aggregated bandwidth.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 .../selftests/net/mptcp/simult_flows.sh       | 290 ++++++++++++++++++
 1 file changed, 290 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/simult_flows.sh

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/test=
ing/selftests/net/mptcp/simult_flows.sh
new file mode 100755
index 000000000000..0d91a3f87e3f
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -0,0 +1,290 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+rndh=3D$(printf %x $sec)-$(mktemp -u XXXXXX)
+ns1=3D"ns1-$rndh"
+ns2=3D"ns2-$rndh"
+ns3=3D"ns3-$rndh"
+capture=3Dfalse
+ksft_skip=3D4
+timeout=3D30
+test_cnt=3D1
+ret=3D0
+bail=3D0
+
+usage() {
+	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
+	echo -e "\t-b: bail out after first error, otherwise runs al testcases"
+	echo -e "\t-c: capture packets for each test using tcpdump (default: no c=
apture)"
+	echo -e "\t-d: debug this script"
+}
+
+cleanup()
+{
+	rm -f "$cin" "$cout"
+	rm -f "$sin" "$sout"
+	rm -f "$capout"
+
+	local netns
+	for netns in "$ns1" "$ns2" "$ns3";do
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
+#  "$ns1"              ns2                    ns3
+#     ns1eth1    ns2eth1   ns2eth3      ns3eth1
+#            netem
+#     ns1eth2    ns2eth2
+#            netem
+
+setup()
+{
+	large=3D$(mktemp)
+	small=3D$(mktemp)
+	sout=3D$(mktemp)
+	cout=3D$(mktemp)
+	capout=3D$(mktemp)
+	size=3D$((2048 * 4096))
+	dd if=3D/dev/zero of=3D$small bs=3D4096 count=3D20 >/dev/null 2>&1
+	dd if=3D/dev/zero of=3D$large bs=3D4096 count=3D$((size / 4096)) >/dev/nu=
ll 2>&1
+
+	trap cleanup EXIT
+
+	for i in "$ns1" "$ns2" "$ns3";do
+		ip netns add $i || exit $ksft_skip
+		ip -net $i link set lo up
+	done
+
+	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
+	ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth2 netns "$ns2"
+	ip link add ns2eth3 netns "$ns2" type veth peer name ns3eth1 netns "$ns3"
+
+	ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth1
+	ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth1 nodad
+	ip -net "$ns1" link set ns1eth1 up mtu 1500
+	ip -net "$ns1" route add default via 10.0.1.2
+	ip -net "$ns1" route add default via dead:beef:1::2
+
+	ip -net "$ns1" addr add 10.0.2.1/24 dev ns1eth2
+	ip -net "$ns1" addr add dead:beef:2::1/64 dev ns1eth2 nodad
+	ip -net "$ns1" link set ns1eth2 up mtu 1500
+	ip -net "$ns1" route add default via 10.0.2.2 metric 101
+	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
+
+	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
+	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
+	ip netns exec "$ns1" sysctl -q net.ipv4.conf.all.rp_filter=3D0
+
+	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
+	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
+	ip -net "$ns2" link set ns2eth1 up mtu 1500
+
+	ip -net "$ns2" addr add 10.0.2.2/24 dev ns2eth2
+	ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth2 nodad
+	ip -net "$ns2" link set ns2eth2 up mtu 1500
+
+	ip -net "$ns2" addr add 10.0.3.2/24 dev ns2eth3
+	ip -net "$ns2" addr add dead:beef:3::2/64 dev ns2eth3 nodad
+	ip -net "$ns2" link set ns2eth3 up mtu 1500
+	ip netns exec "$ns2" sysctl -q net.ipv4.ip_forward=3D1
+	ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=3D1
+
+	ip -net "$ns3" addr add 10.0.3.3/24 dev ns3eth1
+	ip -net "$ns3" addr add dead:beef:3::3/64 dev ns3eth1 nodad
+	ip -net "$ns3" link set ns3eth1 up mtu 1500
+	ip -net "$ns3" route add default via 10.0.3.2
+	ip -net "$ns3" route add default via dead:beef:3::2
+
+	ip netns exec "$ns3" ./pm_nl_ctl limits 1 1
+}
+
+# $1: ns, $2: port
+wait_local_port_listen()
+{
+	local listener_ns=3D"${1}"
+	local port=3D"${2}"
+
+	local port_hex i
+
+	port_hex=3D"$(printf "%04X" "${port}")"
+	for i in $(seq 10); do
+		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
+			awk "BEGIN {rc=3D1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=3D0;=
 exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
+
+do_transfer()
+{
+	local cin=3D$1
+	local sin=3D$2
+	local max_time=3D$3
+	local port
+	port=3D$((10000+$test_cnt))
+	test_cnt=3D$((test_cnt+1))
+
+	:> "$cout"
+	:> "$sout"
+	:> "$capout"
+
+	local addr_port
+	addr_port=3D$(printf "%s:%d" ${connect_addr} ${port})
+
+	if $capture; then
+		local capuser
+		if [ -z $SUDO_USER ] ; then
+			capuser=3D""
+		else
+			capuser=3D"-Z $SUDO_USER"
+		fi
+
+		local capfile=3D"${rndh}-${port}"
+		local capopt=3D"-i any -s 65535 -B 32768 ${capuser}"
+
+		ip netns exec ${ns3}  tcpdump ${capopt} -w "${capfile}-listener.pcap"  >=
> "${capout}" 2>&1 &
+		local cappid_listener=3D$!
+
+		ip netns exec ${ns1} tcpdump ${capopt} -w "${capfile}-connector.pcap" >>=
 "${capout}" 2>&1 &
+		local cappid_connector=3D$!
+
+		sleep 1
+	fi
+
+	ip netns exec ${ns3} ./mptcp_connect -jt $timeout -l -p $port 0.0.0.0 < "=
$sin" > "$sout" &
+	local spid=3D$!
+
+	wait_local_port_listen "${ns3}" "${port}"
+
+	local start
+	start=3D$(date +%s%3N)
+	ip netns exec ${ns1} ./mptcp_connect -jt $timeout -p $port 10.0.3.3 < "$c=
in" > "$cout" &
+	local cpid=3D$!
+
+	wait $cpid
+	local retc=3D$?
+	wait $spid
+	local rets=3D$?
+
+	local stop
+	stop=3D$(date +%s%3N)
+
+	if $capture; then
+		sleep 1
+		kill ${cappid_listener}
+		kill ${cappid_connector}
+	fi
+
+	local duration
+	duration=3D$((stop-start))
+
+	cmp $sin $cout > /dev/null 2>&1
+	local cmps=3D$?
+	cmp $cin $sout > /dev/null 2>&1
+	local cmpc=3D$?
+
+	printf "%16s" "$duration max $max_time "
+	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
+	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ] && \
+	   [ $duration -lt $max_time ]; then
+		echo "[ OK ]"
+		cat "$capout"
+		return 0
+	fi
+
+	echo " [ fail ]"
+	echo "client exit code $retc, server $rets" 1>&2
+	echo "\nnetns ${ns3} socket stat for $port:" 1>&2
+	ip netns exec ${ns3} ss -nita 1>&2 -o "sport =3D :$port"
+	echo "\nnetns ${ns1} socket stat for $port:" 1>&2
+	ip netns exec ${ns1} ss -nita 1>&2 -o "dport =3D :$port"
+	ls -l $sin $cout
+	ls -l $cin $sout
+
+	cat "$capout"
+	return 1
+}
+
+run_test()
+{
+	local rate1=3D$1
+	local rate2=3D$2
+	local delay1=3D$3
+	local delay2=3D$4
+	local lret
+	local dev
+	shift 4
+	local msg=3D$*
+
+	[ $delay1 -gt 0 ] && delay1=3D"delay $delay1" || delay1=3D""
+	[ $delay2 -gt 0 ] && delay2=3D"delay $delay2" || delay2=3D""
+
+	for dev in ns1eth1 ns1eth2; do
+		tc -n $ns1 qdisc del dev $dev root >/dev/null 2>&1
+	done
+	for dev in ns2eth1 ns2eth2; do
+		tc -n $ns2 qdisc del dev $dev root >/dev/null 2>&1
+	done
+	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1
+	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2
+	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1
+	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2
+
+	# time is measure in ms
+	local time=3D$((size * 8 * 1000 / (( $rate1 + $rate2) * 1024 *1024) ))
+
+	# mptcp_connect will sleep a bit to allow for mp_join completion
+	time=3D$((time + 1000))
+
+	printf "%-50s" "$msg"
+	do_transfer $small $large $((time * 11 / 10))
+	lret=3D$?
+	if [ $lret -ne 0 ]; then
+		ret=3D$lret
+		[ $bail -eq 0 ] || exit $ret
+	fi
+
+	printf "%-50s" "$msg - reverse direction"
+	do_transfer $large $small $((time * 11 / 10))
+	lret=3D$?
+	if [ $lret -ne 0 ]; then
+		ret=3D$lret
+		[ $bail -eq 0 ] || exit $ret
+	fi
+}
+
+while getopts "bcdh" option;do
+	case "$option" in
+	"h")
+		usage $0
+		exit 0
+		;;
+	"b")
+		bail=3D1
+		;;
+	"c")
+		capture=3Dtrue
+		;;
+	"d")
+		set -x
+		;;
+	"?")
+		usage $0
+		exit 1
+		;;
+	esac
+done
+
+setup
+run_test 10 10 0 0 "balanced bwidth"
+run_test 10 10 1 50 "balanced bwidth with unbalanced delay"
+run_test 30 10 0 0 "unbalanced bwidth"
+run_test 30 10 1 50 "unbalanced bwidth with unbalanced delay"
+run_test 30 10 50 1 "unbalanced bwidth with opposed, unbalanced delay"
+exit $ret
\ No newline at end of file
-- =

2.26.2

--===============4598578958676565665==--
