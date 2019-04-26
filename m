Content-Type: multipart/mixed; boundary="===============2751895892367552387=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: honor net namespace when creating subflow sk
Date: Fri, 26 Apr 2019 15:53:18 +0200
Message-ID: <20190426135318.8015-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1090

--===============2751895892367552387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise, even loopback communication doesn't work
when program is run from non-init_netns.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 Could be squashed with
 'mptcp: Make connection_list a real list of subflows'.

 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1e73e307a6d2..1fbddbcb1164 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -703,12 +703,12 @@ static struct proto mptcp_prot =3D {
 static int mptcp_subflow_create(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct net *net =3D sock_net(sk);
 	struct socket *sf;
 	int err;
 =

 	pr_debug("msk=3D%p", msk);
-	err =3D sock_create_kern(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
-			       &sf);
+	err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sf);
 	if (!err) {
 		lock_sock(sf->sk);
 		err =3D tcp_set_ulp(sf->sk, "mptcp");
-- =

2.21.0


--===============2751895892367552387==--
