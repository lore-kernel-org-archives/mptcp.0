Content-Type: multipart/mixed; boundary="===============6059534318049878139=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 04/10] selftests:mptcp: reduce wait time for the listen
Date: Sat, 16 Nov 2019 13:59:30 +0100
Message-ID: <20191116125936.3563275-5-matthieu.baerts@tessares.net>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2565

--===============6059534318049878139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I noticed that we were spending a lot of time waiting with the sleep
command. Now we poll the socket status and we reduce the exec time by
maybe ~30 seconds.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 .../selftests/net/mptcp/mptcp_connect.sh      | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 74d62a69b6e9..3274cc1fd145 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -286,6 +286,23 @@ do_ping()
 	return 0
 }
 =

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
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -323,7 +340,7 @@ do_transfer()
 	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} $local_addr < "$sin" > "$sout" &
 	spid=3D$!
 =

-	sleep 1
+	wait_local_port_listen "${listener_ns}" "${port}"
 =

 	start=3D$(date +%s%3N)
 	ip netns exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $connect_addr < "$cin" > "$cout" &
-- =

2.24.0

--===============6059534318049878139==--
