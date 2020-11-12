Content-Type: multipart/mixed; boundary="===============7178152406893599817=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 10/13] mptcp: try to push pending data on
 snd una updates
Date: Thu, 12 Nov 2020 18:45:30 +0100
Message-ID: <fddd06ca7375d53a9294efa195856a2439fb106c.1605199807.git.pabeni@redhat.com>
In-Reply-To: cover.1605199807.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6700

--===============7178152406893599817==
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
index eae457dc7061..86b4b6e2afbc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -731,6 +731,7 @@ void mptcp_data_acked(struct sock *sk)
 	mptcp_reset_timer(sk);
 =

 	if ((!test_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags) ||
+	     mptcp_send_head(sk) ||
 	     (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)))
 		mptcp_schedule_work(sk);
 }
@@ -1835,6 +1836,8 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_close_subflow(msk);
 =

 	__mptcp_move_skbs(msk);
+	if (mptcp_send_head(sk))
+		mptcp_push_pending(sk, 0);
 =

 	if (msk->pm.status)
 		pm_work(msk);
-- =

2.26.2

--===============7178152406893599817==--
