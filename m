Content-Type: multipart/mixed; boundary="===============0121514748088897854=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 08/13] mptcp: add and use mptcp_subflow_get_retrans
Date: Mon, 18 Nov 2019 22:45:33 +0100
Message-ID: <20191118214538.21931-9-fw@strlen.de>
In-Reply-To: 20191118214538.21931-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2593

--===============0121514748088897854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of having retransmit worker grab first subflow on the list,
make it always return NULL, unless either the first non-backup subflow
on the list is idle or all normal subflows have already been removed.

In the latter case, the first idle backup subflow is used.

Rationale is that it makes no sense to attempt to retransmit
at mptcp level if there is still unsent data in its write queue.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1515c3bad751..d0b050f6611e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -661,6 +661,37 @@ static void mptcp_retransmit_timer(struct timer_list *=
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
@@ -685,7 +716,7 @@ static void mptcp_worker(struct work_struct *work)
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

--===============0121514748088897854==--
