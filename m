Content-Type: multipart/mixed; boundary="===============1399725929163936413=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] selftests: mptcp: interpret \n as a new line
Date: Tue, 06 Oct 2020 16:56:36 +0200
Message-ID: <20201006145636.3863539-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6223

--===============1399725929163936413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of errors, this message was printed:

  (...)
  balanced bwidth with unbalanced delay       5233 max 5005  [ fail ]
  client exit code 0, server 0
  \nnetns ns3-0-EwnkPH socket stat for 10003:
  (...)

Obviously, the idea was to add a new line before the socket stat and not
print "\nnetns".

The commit 8b974778f998 ("selftests: mptcp: interpret \n as a new line")
is very similar to this one. But the modification in simult_flows.sh was
missed because this commit above was done in parallel to one here below.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/test=
ing/selftests/net/mptcp/simult_flows.sh
index 0d88225daa02..2f649b431456 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -200,9 +200,9 @@ do_transfer()
 =

 	echo " [ fail ]"
 	echo "client exit code $retc, server $rets" 1>&2
-	echo "\nnetns ${ns3} socket stat for $port:" 1>&2
+	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
 	ip netns exec ${ns3} ss -nita 1>&2 -o "sport =3D :$port"
-	echo "\nnetns ${ns1} socket stat for $port:" 1>&2
+	echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
 	ip netns exec ${ns1} ss -nita 1>&2 -o "dport =3D :$port"
 	ls -l $sin $cout
 	ls -l $cin $sout
-- =

2.27.0

--===============1399725929163936413==--
