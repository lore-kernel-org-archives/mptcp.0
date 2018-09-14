Content-Type: multipart/mixed; boundary="===============6396535492247266044=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 18/20] mptcp: Restart subflow-selection when we force
 a re-evaluation
Date: Fri, 14 Sep 2018 10:25:22 -0700
Message-ID: <20180914172524.67961-21-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 742

--===============6396535492247266044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After setting the path-mask to 0, all subflows become eligible again.
At that point, we should re-evaluate the subflow selection.

Fixes: f9ca33df8007 ("mptcp: sched: Improve active/backup subflow selection=
")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 156956479ee100ef77bfc74f4caa1e8cbcc7a9ee)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_sched.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
index b440df7aae71..3662bdf97c0d 100644
--- a/net/mptcp/mptcp_sched.c
+++ b/net/mptcp/mptcp_sched.c
@@ -215,7 +215,7 @@ static struct sock *get_available_subflow(struct sock *=
meta_sk,
 {
 	struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
 	struct sock *sk;
-	bool force;
+	bool looping =3D false, force;
 =

 	/* Answer data_fin on same subflow!!! */
 	if (meta_sk->sk_shutdown & RCV_SHUTDOWN &&
@@ -232,6 +232,7 @@ static struct sock *get_available_subflow(struct sock *=
meta_sk,
 	}
 =

 	/* Find the best subflow */
+restart:
 	sk =3D get_subflow_from_selectors(mpcb, skb, &subflow_is_active,
 					zero_wnd_test, &force);
 	if (force)
@@ -242,7 +243,7 @@ static struct sock *get_available_subflow(struct sock *=
meta_sk,
 =

 	sk =3D get_subflow_from_selectors(mpcb, skb, &subflow_is_backup,
 					zero_wnd_test, &force);
-	if (!force && skb)
+	if (!force && skb) {
 		/* one used backup sk or one NULL sk where there is no one
 		 * temporally unavailable unused backup sk
 		 *
@@ -250,6 +251,12 @@ static struct sock *get_available_subflow(struct sock =
*meta_sk,
 		 * sks, so clean the path mask
 		 */
 		TCP_SKB_CB(skb)->path_mask =3D 0;
+
+		if (!looping) {
+			looping =3D true;
+			goto restart;
+		}
+	}
 	return sk;
 }
 =

-- =

2.16.2


--===============6396535492247266044==--
