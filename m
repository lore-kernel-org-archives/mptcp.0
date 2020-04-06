Content-Type: multipart/mixed; boundary="===============4616488401779338502=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp:pm netlink: fix variable scope
Date: Mon, 06 Apr 2020 16:19:31 +0200
Message-ID: <20200406141931.134339-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4141

--===============4616488401779338502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kbuild reported this warning from CPPCheck:

    net/mptcp/pm_netlink.c:98:22: warning: The scope of the variable 'skc' =
can be reduced. [variableScope]

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    I tried to reproduce this warning with CPPCheck (1.90) but without succ=
ess.
    Should I send this patch to netdev? In this function, it will not change
    anything, no?
    =

    CPPCheck could also complain that 'cur' variable scope could be reduced.
    =

    With CPPCheck, I only got false positive warnings in net/mptcp/protocol=
.c:
    =

        Possible null pointer dereference: dfrag
    =

        net/mptcp/protocol.c:776:42: note: Calling function 'mptcp_sendmsg_=
frag', 4th argument 'NULL' value is 0
          ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
    =

    It seems it doesn't understand "retransmision =3D !!dfrag". I don't kno=
w if I
    should add cppcheck support in the CI. For the moment, I would only hav=
e to
    suppress false positives :)

 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a0ce7f324499..3ad952affdcf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -95,9 +95,10 @@ static bool lookup_subflow_by_saddr(const struct list_he=
ad *list,
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
-	struct sock_common *skc;
 =

 	list_for_each_entry(subflow, list, node) {
+		struct sock_common *skc;
+
 		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 =

 		local_address(skc, &cur);
-- =

2.25.1

--===============4616488401779338502==--
