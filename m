Content-Type: multipart/mixed; boundary="===============0561446108826606769=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net 5/5] selftests: mptcp: dump more info on
 errors
Date: Fri, 05 Feb 2021 17:55:14 +0100
Message-ID: <1eda5017066883f1bd0f59598477b817313458c1.1612543972.git.pabeni@redhat.com>
In-Reply-To: cover.1612543972.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7655

--===============0561446108826606769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Even if that may sound completely unlikely, the mptcp implementation
is not perfect, yet.

When the self-tests report an error we usually need more information
of what the scripts currently report. iproute allow provides
some additional goodies since a few releases, let's dump them.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 2cfd87d94db89..9dae77f3aa2a9 100755
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

@@ -438,16 +439,20 @@ do_transfer()
 		kill ${cappid_connector}
 	fi
 =

+	NSTAT_HISTORY=3D/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} ns=
tat |grep Tcp > /tmp/${listener_ns}.out
+	[ ${listener_ns} !=3D ${connector_ns} ] && NSTAT_HISTORY=3D/tmp/${connect=
or_ns}.nstat ip netns exec ${connector_ns} nstat -s |grep Tcp > /tmp/${conn=
ector_ns}.out
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

2.26.2

--===============0561446108826606769==--
