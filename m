Content-Type: multipart/mixed; boundary="===============8089965102765749422=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 8/8] mptcp: try to push pending data on snd una
 updates
Date: Thu, 24 Sep 2020 15:59:30 +0200
Message-ID: <b9ff8d190f04263976edd53f3253cfcfa679679f.1600955407.git.pabeni@redhat.com>
In-Reply-To: cover.1600955407.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6022

--===============8089965102765749422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the previous patch we may end-up with unsent data
in the write buffer. If such buffer is full, the writer
will block for unlimited time.

We need to trigger the MPTCP xmit path even for the
subflow rx path, on MPTCP snd_una updates.

Keep things simple and just schedule the work queue if
needed.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index def627d249c8..cda5802b880e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -718,6 +718,7 @@ void mptcp_data_acked(struct sock *sk)
 	mptcp_reset_timer(sk);
 =

 	if ((!test_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags) ||
+	     mptcp_send_head(sk) ||
 	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)))
 		mptcp_schedule_work(sk);
 }
@@ -1787,6 +1788,8 @@ static void mptcp_worker(struct work_struct *work)
 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
 	__mptcp_move_skbs(msk);
+	if (mptcp_send_head(sk))
+		mptcp_push_pending(sk, 0);
 =

 	if (msk->pm.status)
 		pm_work(msk);
-- =

2.26.2

--===============8089965102765749422==--
