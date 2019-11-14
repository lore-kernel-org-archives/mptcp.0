Content-Type: multipart/mixed; boundary="===============8023843276954461294=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 08/14] mptcp: add and use mptcp_subflow_get_retrans
Date: Thu, 14 Nov 2019 18:32:19 +0100
Message-ID: <20191114173225.21199-9-fw@strlen.de>
In-Reply-To: 20191114173225.21199-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2536

--===============8023843276954461294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of having retransmit worker grab first subflow on the list,
make it always return NULL, unless either the first non-backup subflow
on the list is idle or all normal subflows have already been removed.

In the latter case, the first idle backup subflow is used.

Rationale is that it makes no sense to attempt to retransmit
at mptcp level if there is still unsent data in its write queue.

V2: always return NULL when first non-idle ssk is seen.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 83be407e1dd6..c5cf19a4b9f0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -667,6 +667,37 @@ static void mptcp_retransmit_timer(struct timer_list *=
t)
 	sock_put(sk);
 }
 =

+/* Find an idle subflow.  Return NULL if there is unacked data at tcp
+ * level.
+ *
+ * A backup subflow is returned only if thats the only kind available.
+ */
+static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *backup =3D NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_socket(subflow)->sk;
+
+		/* still data outstanding at TCP level?  Don't retransmit. */
+		if (!tcp_write_queue_empty(ssk))
+			return NULL;
+
+		if (subflow->backup) {
+			if (!backup)
+				backup =3D ssk;
+			continue;
+		}
+
+		return ssk;
+	}
+
+	return backup;
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	int orig_len, orig_offset, ret, mss_now =3D 0, size_goal =3D 0;
@@ -691,7 +722,7 @@ static void mptcp_worker(struct work_struct *work)
 	if (!dfrag)
 		goto unlock;
 =

-	ssk =3D mptcp_subflow_get(msk);
+	ssk =3D mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		goto reset_unlock;
 =

-- =

2.23.0

--===============8023843276954461294==--
