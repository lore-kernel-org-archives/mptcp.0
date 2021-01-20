Content-Type: multipart/mixed; boundary="===============2660943094036894906=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 net-next 4/5] mptcp: schedule work for better snd
 subflow selection
Date: Wed, 20 Jan 2021 15:39:13 +0100
Message-ID: <6c4828f44064aaf7e957e5a2419f25e3e6e0f3b1.1611153172.git.pabeni@redhat.com>
In-Reply-To: cover.1611153172.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7451

--===============2660943094036894906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise the packet scheduler policy will not be
enforced when pushing pending data at MPTCP-level
ack reception time.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e741201acc98f..8cb582eee2862 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2242,6 +2242,7 @@ static void mptcp_worker(struct work_struct *work)
 	if (unlikely(state =3D=3D TCP_CLOSE))
 		goto unlock;
 =

+	mptcp_push_pending(sk, 0);
 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
 =

@@ -2899,10 +2900,14 @@ void __mptcp_check_push(struct sock *sk, struct soc=
k *ssk)
 	if (!mptcp_send_head(sk))
 		return;
 =

-	if (!sock_owned_by_user(sk))
-		__mptcp_subflow_push_pending(sk, ssk);
-	else
+	if (!sock_owned_by_user(sk)) {
+		if (mptcp_subflow_get_send(mptcp_sk(sk)) =3D=3D ssk)
+			__mptcp_subflow_push_pending(sk, ssk);
+		else
+			mptcp_schedule_work(sk);
+	} else {
 		set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags);
+	}
 }
 =

 #define MPTCP_DEFERRED_ALL (TCPF_WRITE_TIMER_DEFERRED)
-- =

2.26.2

--===============2660943094036894906==--
