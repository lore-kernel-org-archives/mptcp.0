Content-Type: multipart/mixed; boundary="===============8148284187607306480=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 1/4] selftests: mptcp: dump more info on
 errors
Date: Fri, 12 Feb 2021 15:20:27 -0800
Message-ID: <20210212232030.377261-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210212232030.377261-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7779

--===============8148284187607306480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Even if that may sound completely unlikely, the mptcp implementation
is not perfect, yet.

When the self-tests report an error we usually need more information
of what the scripts currently report. iproute allow provides
some additional goodies since a few releases, let's dump them.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_connect.sh  | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 2cfd87d94db8..0c6b9d3c03c0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -128,6 +128,7 @@ cleanup()
 	local netns
 	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
 		ip netns del $netns
+		rm -f /tmp/$netns.{nstat,out}
 	done
 }
 =

@@ -438,16 +439,24 @@ do_transfer()
 		kill ${cappid_connector}
 	fi
 =

+	NSTAT_HISTORY=3D/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat | grep Tcp > /tmp/${listener_ns}.out
+	if [ ${listener_ns} !=3D ${connector_ns} ]; then
+		NSTAT_HISTORY=3D/tmp/${connector_ns}.nstat ip netns exec ${connector_ns}=
 \
+			nstat | grep Tcp > /tmp/${connector_ns}.out
+	fi
+
 	local duration
 	duration=3D$((stop-start))
 	duration=3D$(printf "(duration %05sms)" $duration)
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "$duration [ FAIL ] client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport =3D :$port"
+		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport =3D :$port"
+		cat /tmp/${listener_ns}.out
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
-		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport =3D :$port"
-
+		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport =3D :$port"
+		[ ${listener_ns} !=3D ${connector_ns} ] && cat /tmp/${connector_ns}.out
 		cat "$capout"
 		return 1
 	fi
-- =

2.30.1

--===============8148284187607306480==--
