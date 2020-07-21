Content-Type: multipart/mixed; boundary="===============1832011546503177452=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v2 mptcp-next 12/12] selftests: mptcp: make 2nd net
 namespace use tcp syn cookies unconditionally
Date: Tue, 21 Jul 2020 22:36:42 +0200
Message-ID: <20200721203642.32753-13-fw@strlen.de>
In-Reply-To: 20200721203642.32753-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5158

--===============1832011546503177452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

check we can establish connections even in syncookie mode.
Also check following MIB counters:
MPTcpExtMPCapableSYNRX (should increase for each MPTCP test)
MPTcpExtMPCapableACKRX (should increase for each MPTCP test)
TcpExtSyncookiesSent (should increase for listener in ns2)
TcpExtSyncookiesRecv (same)

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index c0589e071f20..6260520674d0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -196,6 +196,9 @@ ip -net "$ns4" link set ns4eth3 up
 ip -net "$ns4" route add default via 10.0.3.2
 ip -net "$ns4" route add default via dead:beef:3::2
 =

+# use TCP syn cookies, even if no flooding was detected.
+ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=3D2
+
 set_ethtool_flags() {
 	local ns=3D"$1"
 	local dev=3D"$2"
@@ -407,6 +410,11 @@ do_transfer()
 		sleep 1
 	fi
 =

+	local stat_synrx_last_l=3D$(ip netns exec ${listener_ns} nstat -z -a MPTc=
pExtMPCapableSYNRX | while read a count c rest ;do  echo $count;done)
+	local stat_ackrx_last_l=3D$(ip netns exec ${listener_ns} nstat -z -a MPTc=
pExtMPCapableACKRX | while read a count c rest ;do  echo $count;done)
+	local stat_cookietx_last=3D$(ip netns exec ${listener_ns} nstat -z -a Tcp=
ExtSyncookiesSent | while read a count c rest ;do  echo $count;done)
+	local stat_cookierx_last=3D$(ip netns exec ${listener_ns} nstat -z -a Tcp=
ExtSyncookiesRecv | while read a count c rest ;do  echo $count;done)
+
 	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} $extra_args $local_addr < "$sin" > "$sout" &
 	local spid=3D$!
 =

@@ -450,6 +458,48 @@ do_transfer()
 	check_transfer $cin $sout "file received by server"
 	rets=3D$?
 =

+	local stat_synrx_now_l=3D$(ip netns exec ${listener_ns} nstat -z -a MPTcp=
ExtMPCapableSYNRX  | while read a count c rest ;do  echo $count;done)
+	local stat_ackrx_now_l=3D$(ip netns exec ${listener_ns} nstat -z -a MPTcp=
ExtMPCapableACKRX  | while read a count c rest ;do  echo $count;done)
+
+	local stat_cookietx_now=3D$(ip netns exec ${listener_ns} nstat -z -a TcpE=
xtSyncookiesSent | while read a count c rest ;do  echo $count;done)
+	local stat_cookierx_now=3D$(ip netns exec ${listener_ns} nstat -z -a TcpE=
xtSyncookiesRecv | while read a count c rest ;do  echo $count;done)
+
+	expect_synrx=3D$((stat_synrx_last_l))
+	expect_ackrx=3D$((stat_ackrx_last_l))
+
+	cookies=3D$(ip netns exec ${listener_ns} sysctl net.ipv4.tcp_syncookies)
+	cookies=3D${cookies##*=3D}
+
+	if [ ${cl_proto} =3D "MPTCP" ] && [ ${srv_proto} =3D "MPTCP" ]; then
+		expect_synrx=3D$((stat_synrx_last_l+1))
+		expect_ackrx=3D$((stat_ackrx_last_l+1))
+		if [ $cookies -eq 2 ];then
+			expect_synrx=3D$((stat_synrx_last_l+2))
+		fi
+	fi
+	if [ $cookies -eq 2 ];then
+		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
+			echo "${listener_ns} CookieSent: ${cl_proto} -> ${srv_proto}: did not a=
dvance"
+		fi
+		if [ $stat_cookierx_last -ge $stat_cookierx_now ] ;then
+			echo "${listener_ns} CookieRecv: ${cl_proto} -> ${srv_proto}: did not a=
dvance"
+		fi
+	else
+		if [ $stat_cookietx_last -ne $stat_cookietx_now ] ;then
+			echo "${listener_ns} CookieSent: ${cl_proto} -> ${srv_proto}: changed"
+		fi
+		if [ $stat_cookierx_last -ne $stat_cookierx_now ] ;then
+			echo "${listener_ns} CookieRecv: ${cl_proto} -> ${srv_proto}: changed"
+		fi
+	fi
+
+	if [ $expect_synrx -ne $stat_synrx_now_l ] ;then
+		echo "${listener_ns} SYNRX: ${cl_proto} -> ${srv_proto}: expect ${expect=
_synrx}, got ${stat_synrx_now_l}"
+	fi
+	if [ $expect_ackrx -ne $stat_ackrx_now_l ] ;then
+		echo "${listener_ns} ACKRX: ${cl_proto} -> ${srv_proto}: expect ${expect=
_synrx}, got ${stat_synrx_now_l}"
+	fi
+
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
 		echo "$duration [ OK ]"
 		cat "$capout"
-- =

2.26.2

--===============1832011546503177452==--
