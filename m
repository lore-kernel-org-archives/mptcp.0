Content-Type: multipart/mixed; boundary="===============8372181073619965239=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] subflow: process pending data on state changes, too
Date: Tue, 10 Dec 2019 16:48:23 +0100
Message-ID: <62b2f929fdf3c17a05a5dd6ec632aba00e69c5d7.1575992767.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2859

--===============8372181073619965239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise we can miss the data carried by the data fin.
An alternative solution would calling __subflow_state_change
on the parent socket only when we process the data fin in
mptcp_subflow_data_available.

Currently, on the squashed tree, we have sporadic data stream
corrution near EoS, triggered by the lossy self-tests every a
few iteration.

This change addresses them.

Squash-to: "mptcp: Implement MPTCP receive path"
Suggested-by: Florian Festphal <fwestpha(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
this is on top of Florians's rebase tree
---
 net/mptcp/subflow.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d6540f0a5be9..26cf2e435af4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -645,6 +645,18 @@ static void subflow_state_change(struct sock *sk)
 =

 	__subflow_state_change(sk);
 =

+	/* as recvmsg() does not acquire the subflow socket for ssk selection
+	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
+	 * the data available machinery here.
+	 */
+	if (parent && subflow->mp_capable && mptcp_subflow_data_available(sk)) {
+		smp_mb__before_atomic();
+		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
+		smp_mb__after_atomic();
+
+		parent->sk_data_ready(parent);
+	}
+
 	if (parent && !(parent->sk_shutdown & RCV_SHUTDOWN) &&
 	    !subflow->rx_eof && subflow_is_done(sk)) {
 		subflow->rx_eof =3D 1;
-- =

2.21.0

--===============8372181073619965239==--
