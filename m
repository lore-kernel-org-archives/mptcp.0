Content-Type: multipart/mixed; boundary="===============7133026999304548624=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] Squash to "selftests: mptcp: add addr
 argument for del_addr"
Date: Fri, 12 Mar 2021 13:54:25 +0100
Message-ID: <20210312125425.3199991-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 8124

--===============7133026999304548624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Avoid calling pm_nl_ctl with id > 255.

Without this patch, we can see this when running the selftests:

  selftests: net/mptcp: pm_netlink.sh
  (...)
  above hard addr limit                              [ OK ]
  ./pm_nl_ctl add|get|set|del|flush|dump|accept
   add [flags signal|subflow|backup] [id <nr>] [dev <name>] <ip>
  del <id>
   get <id>
   set <ip> [flags backup|nobackup]
   flush
   dump
  limits [<rcv addr max> <subflow max>]

  id limit                                           [ OK ]
  (...)

That's because we were calling:

  $ pm_nl_ctl del 256

In the code, the parsed ID is written in a u_int8_t. Then the value
"256" is stored as "0" which is now a special case and requires an IP.

We could modify pm_nl_ctl but stop if the ID is negative or higher than
255 but not sure we need this for a tool only used in selftests.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "selftests: mptcp: add addr argument for del_addr"

 tools/testing/selftests/net/mptcp/pm_netlink.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testin=
g/selftests/net/mptcp/pm_netlink.sh
index a617e293734c..365ba4611ae7 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -100,9 +100,10 @@ done
 check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" =
"hard addr limit"
 check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
 =

-for i in `seq 9 256`; do
+ip netns exec $ns1 ./pm_nl_ctl del 9
+for i in `seq 10 255`; do
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
 	ip netns exec $ns1 ./pm_nl_ctl del $i
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $((i+1))
 done
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
 id 2 flags  10.0.0.9
-- =

2.30.2

--===============7133026999304548624==--
