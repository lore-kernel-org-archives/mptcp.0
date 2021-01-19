Content-Type: multipart/mixed; boundary="===============0340046023950899092=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: implement
 delegated actions"
Date: Tue, 19 Jan 2021 09:26:35 +0800
Message-ID: <99135405274e3d94b4eafe6e92eaffc99f436b76.1611019539.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7418

--===============0340046023950899092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since a new listening socket in kernel for the new port is added, there's
a lockdep warning in mptcp_subflow_process_delegated. This patch added the
_nested annotation for the sock lock to fix it.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/138
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 442ad81d4abc..c750767be898 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2978,13 +2978,14 @@ void mptcp_subflow_process_delegated(struct sock *s=
sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct sock *sk =3D subflow->conn;
+	unsigned long flags;
 =

-	mptcp_data_lock(sk);
+	spin_lock_irqsave_nested(&sk->sk_lock.slock, flags, SINGLE_DEPTH_NESTING);
 	if (!sock_owned_by_user(sk))
 		__mptcp_subflow_push_pending(sk, ssk);
 	else
 		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
-	mptcp_data_unlock(sk);
+	spin_unlock_irqrestore(&sk->sk_lock.slock, flags);
 	mptcp_subflow_delegated_done(subflow);
 }
 =

-- =

2.29.2

--===============0340046023950899092==--
