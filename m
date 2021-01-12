Content-Type: multipart/mixed; boundary="===============6928512694889823118=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 mptcp-next 4/4] mptcp: schedule work for better snd
 subflow selection
Date: Tue, 12 Jan 2021 12:10:00 +0100
Message-ID: <3ebdff5515856d055652fe3ad45e5c22a0dd26b8.1610449705.git.pabeni@redhat.com>
In-Reply-To: cover.1610449705.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7326

--===============6928512694889823118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise the packet scheduler policy will not be
enforced when pushing pending data at MPTCP-level
ack reception time.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
I'm very sad to re-introduce the worker usage for the
datapath, but I could not find an easy way to avoid it.

I'm thinking of some weird schema involving a dummy percpu
napi instance serving/processing a queue of mptcp sockets
instead of actual packets. Any BH user can enqueue an MPTCP
subflow there to delegate some action to the latter.

The above will require also overriding the tcp_release_cb()
with something able to process this delegated events.

Yep, crazy, but possibly doable without any core change and
possibly could be used to avoid the worker usage even for
data fin processing/sending.
---
 net/mptcp/protocol.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2e440d40fbd..d538f5a6810c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2243,6 +2243,7 @@ static void mptcp_worker(struct work_struct *work)
 	if (unlikely(state =3D=3D TCP_CLOSE))
 		goto unlock;
 =

+	mptcp_push_pending(sk, 0);
 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
 =

@@ -2901,10 +2902,14 @@ void __mptcp_check_push(struct sock *sk, struct soc=
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

--===============6928512694889823118==--
