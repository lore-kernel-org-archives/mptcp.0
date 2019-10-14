Content-Type: multipart/mixed; boundary="===============6779871105881414214=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 5/6] mptcp: add and use mptcp_subflow_get_retrans
Date: Tue, 15 Oct 2019 01:19:18 +0200
Message-ID: <20191014231919.2454-6-fw@strlen.de>
In-Reply-To: 20191014231919.2454-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2127

--===============6779871105881414214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of having retransmit worker grab first subflow on the list,
make it pick the first subflow that has empty tcp write queue.

Rationale is that it makes no sense to attempt to retransmit
at mptcp level if there is still unsent data in its write queue.

Backup flows are skipped, unless all other sockets have been
removed and a backup flow is the only remaining type.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 259a2743db91..e003608af237 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -781,6 +781,35 @@ static void mptcp_retransmit_timer(struct timer_list *=
t)
 	sock_put(sk);
 }
 =

+/* return first subflow that has no data outstanding at tcp level.
+ *
+ * Never return a backup subflow unless thats the only kind left.
+ */
+static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *backup =3D NULL;
+	bool use_backup =3D true;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_socket(subflow)->sk;
+
+		if (!subflow->backup)
+			use_backup =3D false;
+
+		if (tcp_write_queue_empty(ssk)) {
+			if (!subflow->backup)
+				return ssk;
+
+			backup =3D ssk;
+		}
+	}
+
+	return use_backup ? backup : NULL;
+}
+
 static void mptcp_retransmit(struct work_struct *work)
 {
 	int orig_len, orig_offset, ret, mss_now =3D 0, size_goal =3D 0;
@@ -801,7 +830,7 @@ static void mptcp_retransmit(struct work_struct *work)
 	if (!dfrag)
 		goto unlock;
 =

-	ssk =3D mptcp_subflow_get(msk);
+	ssk =3D mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		goto reset_unlock;
 =

-- =

2.21.0

--===============6779871105881414214==--
