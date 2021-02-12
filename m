Content-Type: multipart/mixed; boundary="===============1530836414567641951=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/4] selftests: mptcp: display warnings on
 one line
Date: Fri, 12 Feb 2021 15:20:29 -0800
Message-ID: <20210212232030.377261-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210212232030.377261-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7781

--===============1530836414567641951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Before we had this in case of SYN retransmissions:

  (...)
  # ns4 MPTCP -> ns2 (10.0.1.2:10034      ) MPTCP	(duration  1201ms) [ OK ]
  # ns4 MPTCP -> ns2 (dead:beef:1::2:10035) MPTCP	(duration  1242ms) [ OK ]
  # ns4 MPTCP -> ns2 (10.0.2.1:10036      ) MPTCP	ns2-60143c00-cDZWo4 SYNRX=
: MPTCP -> MPTCP: expect 11, got
  # 13
  # (duration  6221ms) [ OK ]
  # ns4 MPTCP -> ns2 (dead:beef:2::1:10037) MPTCP	(duration  1427ms) [ OK ]
  # ns4 MPTCP -> ns3 (10.0.2.2:10038      ) MPTCP	(duration   881ms) [ OK ]
  (...)

Now we have:

  (...)
  # ns4 MPTCP -> ns2 (10.0.1.2:10034      ) MPTCP	(duration  1201ms) [ OK ]
  # ns4 MPTCP -> ns2 (dead:beef:1::2:10035) MPTCP	(duration  1242ms) [ OK ]
  # ns4 MPTCP -> ns2 (10.0.2.1:10036      ) MPTCP	(duration  6221ms) [ OK ]=
 WARN: SYNRX: expect 11, got 13
  # ns4 MPTCP -> ns2 (dead:beef:2::1:10037) MPTCP	(duration  1427ms) [ OK ]
  # ns4 MPTCP -> ns3 (10.0.2.2:10038      ) MPTCP	(duration   881ms) [ OK ]
  (...)

So we put everything on one line, keep the durations and "OK" aligned
and removed duplicated info to short the warning.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 63 ++++++++++++-------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 9ab35ae41628..362e891f89cf 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -334,6 +334,21 @@ do_ping()
 	return 0
 }
 =

+# $1: ns, $2: MIB counter
+get_mib_counter()
+{
+	local listener_ns=3D"${1}"
+	local mib=3D"${2}"
+
+	# strip the header
+	ip netns exec "${listener_ns}" \
+		nstat -z -a "${mib}" | \
+			tail -n+2 | \
+			while read a count c rest; do
+				echo $count
+			done
+}
+
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -410,10 +425,10 @@ do_transfer()
 		sleep 1
 	fi
 =

-	local stat_synrx_last_l=3D$(ip netns exec ${listener_ns} nstat -z -a MPTc=
pExtMPCapableSYNRX | while read a count c rest ;do  echo $count;done)
-	local stat_ackrx_last_l=3D$(ip netns exec ${listener_ns} nstat -z -a MPTc=
pExtMPCapableACKRX | while read a count c rest ;do  echo $count;done)
-	local stat_cookietx_last=3D$(ip netns exec ${listener_ns} nstat -z -a Tcp=
ExtSyncookiesSent | while read a count c rest ;do  echo $count;done)
-	local stat_cookierx_last=3D$(ip netns exec ${listener_ns} nstat -z -a Tcp=
ExtSyncookiesRecv | while read a count c rest ;do  echo $count;done)
+	local stat_synrx_last_l=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPC=
apableSYNRX")
+	local stat_ackrx_last_l=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPC=
apableACKRX")
+	local stat_cookietx_last=3D$(get_mib_counter "${listener_ns}" "TcpExtSync=
ookiesSent")
+	local stat_cookierx_last=3D$(get_mib_counter "${listener_ns}" "TcpExtSync=
ookiesRecv")
 =

 	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} $extra_args $local_addr < "$sin" > "$sout" &
 	local spid=3D$!
@@ -448,15 +463,17 @@ do_transfer()
 =

 	local duration
 	duration=3D$((stop-start))
-	duration=3D$(printf "(duration %05sms)" $duration)
+	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo "$duration [ FAIL ] client exit code $retc, server $rets" 1>&2
+		echo "[ FAIL ] client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport =3D :$port"
 		cat /tmp/${listener_ns}.out
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport =3D :$port"
 		[ ${listener_ns} !=3D ${connector_ns} ] && cat /tmp/${connector_ns}.out
+
+		echo
 		cat "$capout"
 		return 1
 	fi
@@ -466,11 +483,14 @@ do_transfer()
 	check_transfer $cin $sout "file received by server"
 	rets=3D$?
 =

-	local stat_synrx_now_l=3D$(ip netns exec ${listener_ns} nstat -z -a MPTcp=
ExtMPCapableSYNRX  | while read a count c rest ;do  echo $count;done)
-	local stat_ackrx_now_l=3D$(ip netns exec ${listener_ns} nstat -z -a MPTcp=
ExtMPCapableACKRX  | while read a count c rest ;do  echo $count;done)
+	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
+		printf "[ OK ]"
+	fi
 =

-	local stat_cookietx_now=3D$(ip netns exec ${listener_ns} nstat -z -a TcpE=
xtSyncookiesSent | while read a count c rest ;do  echo $count;done)
-	local stat_cookierx_now=3D$(ip netns exec ${listener_ns} nstat -z -a TcpE=
xtSyncookiesRecv | while read a count c rest ;do  echo $count;done)
+	local stat_synrx_now_l=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPCa=
pableSYNRX")
+	local stat_ackrx_now_l=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPCa=
pableACKRX")
+	local stat_cookietx_now=3D$(get_mib_counter "${listener_ns}" "TcpExtSynco=
okiesSent")
+	local stat_cookierx_now=3D$(get_mib_counter "${listener_ns}" "TcpExtSynco=
okiesRecv")
 =

 	expect_synrx=3D$((stat_synrx_last_l))
 	expect_ackrx=3D$((stat_ackrx_last_l))
@@ -484,35 +504,32 @@ do_transfer()
 	fi
 	if [ $cookies -eq 2 ];then
 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
-			echo "${listener_ns} CookieSent: ${cl_proto} -> ${srv_proto}: did not a=
dvance"
+			printf " WARN: CookieSent: did not advance"
 		fi
 		if [ $stat_cookierx_last -ge $stat_cookierx_now ] ;then
-			echo "${listener_ns} CookieRecv: ${cl_proto} -> ${srv_proto}: did not a=
dvance"
+			printf " WARN: CookieRecv: did not advance"
 		fi
 	else
 		if [ $stat_cookietx_last -ne $stat_cookietx_now ] ;then
-			echo "${listener_ns} CookieSent: ${cl_proto} -> ${srv_proto}: changed"
+			printf " WARN: CookieSent: changed"
 		fi
 		if [ $stat_cookierx_last -ne $stat_cookierx_now ] ;then
-			echo "${listener_ns} CookieRecv: ${cl_proto} -> ${srv_proto}: changed"
+			printf " WARN: CookieRecv: changed"
 		fi
 	fi
 =

 	if [ $expect_synrx -ne $stat_synrx_now_l ] ;then
-		echo "${listener_ns} SYNRX: ${cl_proto} -> ${srv_proto}: expect ${expect=
_synrx}, got ${stat_synrx_now_l}"
+		printf " WARN: SYNRX: expect %d, got %d" \
+			"${expect_synrx}" "${stat_synrx_now_l}"
 	fi
 	if [ $expect_ackrx -ne $stat_ackrx_now_l ] ;then
-		echo "${listener_ns} ACKRX: ${cl_proto} -> ${srv_proto}: expect ${expect=
_ackrx}, got ${stat_ackrx_now_l} "
-	fi
-
-	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
-		echo "$duration [ OK ]"
-		cat "$capout"
-		return 0
+		printf " WARN: ACKRX: expect %d, got %d" \
+			"${expect_ackrx}" "${stat_ackrx_now_l}"
 	fi
 =

+	echo
 	cat "$capout"
-	return 1
+	[ $retc -eq 0 ] && [ $rets -eq 0 ]
 }
 =

 make_file()
-- =

2.30.1

--===============1530836414567641951==--
