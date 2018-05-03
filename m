Content-Type: multipart/mixed; boundary="===============2308500737413896090=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 05/14] mptcp: Render
 mptcp_sub_inherit_sockopts lockless
Date: Thu, 03 May 2018 14:04:49 -0700
Message-ID: <20180503210458.21524-6-cpaasch@apple.com>
In-Reply-To: 20180503210458.21524-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 605

--===============2308500737413896090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We are accessing the meta-socket's TOS field twice. It could change
in-between as we do this in a lockless manner.

Thus, let's make sure we read it only once.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 343a132cbc92989d311c09ae5976a354eec3c9fd)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_ctrl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 001ba216db7f..1e67d5d6c87d 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -945,11 +945,15 @@ static void mptcp_mpcb_inherit_sockopts(struct sock *=
meta_sk, struct sock *maste
 	inet_sk(master_sk)->recverr =3D 0;
 }
 =

+/* Called without holding lock on meta_sk */
 static void mptcp_sub_inherit_sockopts(const struct sock *meta_sk, struct =
sock *sub_sk)
 {
+	__u8 meta_tos;
+
 	/* IP_TOS also goes to the subflow. */
-	if (inet_sk(sub_sk)->tos !=3D inet_sk(meta_sk)->tos) {
-		inet_sk(sub_sk)->tos =3D inet_sk(meta_sk)->tos;
+	meta_tos =3D READ_ONCE(inet_sk(meta_sk)->tos);
+	if (inet_sk(sub_sk)->tos !=3D meta_tos) {
+		inet_sk(sub_sk)->tos =3D meta_tos;
 		sub_sk->sk_priority =3D meta_sk->sk_priority;
 		sk_dst_reset(sub_sk);
 	}
-- =

2.16.2


--===============2308500737413896090==--
