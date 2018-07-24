Content-Type: multipart/mixed; boundary="===============6969711035158893354=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: Fix: Correct version-negotiation when
 SYN-cookies are set
Date: Tue, 24 Jul 2018 16:49:39 -0700
Message-ID: <20180724234940.62909-2-cpaasch@apple.com>
In-Reply-To: 20180724234940.62909-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 686

--===============6969711035158893354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to check for the negotiated version when SYN-cookies are set.

Fixes: c9b4b66a0e54 ("mptcp: Add MPTCP version control")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 8b053971270731059387a5f3cefb502800871d9b)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_ctrl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 8c807c7681b6..7f7b4a0f2ee1 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -297,6 +297,7 @@ static void mptcp_reqsk_new_mptcp(struct request_sock *=
req,
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 =

 	inet_rsk(req)->saw_mpc =3D 1;
+
 	/* MPTCP version agreement */
 	if (mopt->mptcp_ver >=3D tp->mptcp_ver)
 		mtreq->mptcp_ver =3D tp->mptcp_ver;
@@ -316,11 +317,18 @@ static void mptcp_reqsk_new_mptcp(struct request_sock=
 *req,
 }
 =

 static int mptcp_reqsk_new_cookie(struct request_sock *req,
+				  const struct sock *sk,
 				  const struct mptcp_options_received *mopt,
 				  const struct sk_buff *skb)
 {
 	struct mptcp_request_sock *mtreq =3D mptcp_rsk(req);
 =

+	/* MPTCP version agreement */
+	if (mopt->mptcp_ver >=3D tcp_sk(sk)->mptcp_ver)
+		mtreq->mptcp_ver =3D tcp_sk(sk)->mptcp_ver;
+	else
+		mtreq->mptcp_ver =3D mopt->mptcp_ver;
+
 	rcu_read_lock_bh();
 	spin_lock(&mptcp_tk_hashlock);
 =

@@ -2397,7 +2405,7 @@ void mptcp_reqsk_init(struct request_sock *req, const=
 struct sock *sk,
 	mtreq->dss_csum =3D mopt.dss_csum;
 =

 	if (want_cookie) {
-		if (!mptcp_reqsk_new_cookie(req, &mopt, skb))
+		if (!mptcp_reqsk_new_cookie(req, sk, &mopt, skb))
 			/* No key available - back to regular TCP */
 			inet_rsk(req)->mptcp_rqsk =3D 0;
 		return;
-- =

2.16.2


--===============6969711035158893354==--
