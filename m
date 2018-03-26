Content-Type: multipart/mixed; boundary="===============3456781026666552124=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 05/12] mptcp: Render mptcp_sub_inherit_sockopts
 lockless
Date: Mon, 26 Mar 2018 09:32:08 +0200
Message-ID: <20180326073215.83607-6-cpaasch@apple.com>
In-Reply-To: 20180326073215.83607-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 412

--===============3456781026666552124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We are accessing the meta-socket's TOS field twice. It could change
in-between as we do this in a lockless manner.

Thus, let's make sure we read it only once.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_ctrl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 29fe6485d69a..fb37053dd127 100644
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


--===============3456781026666552124==--
