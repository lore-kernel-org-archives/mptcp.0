Content-Type: multipart/mixed; boundary="===============4069915220308572296=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 05/20] mptcp: Render mptcp_sub_inherit_sockopts
 lockless
Date: Fri, 14 Sep 2018 10:25:09 -0700
Message-ID: <20180914172524.67961-8-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 730

--===============4069915220308572296==
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
index f178eb9db66c..b867612ec845 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -953,11 +953,15 @@ static void mptcp_mpcb_inherit_sockopts(struct sock *=
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


--===============4069915220308572296==--
