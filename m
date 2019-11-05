Content-Type: multipart/mixed; boundary="===============5169397848342095532=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 3/4] protocol: use sk_wait_event helper
Date: Tue, 05 Nov 2019 18:05:30 +0100
Message-ID: <20191105170531.30407-4-fw@strlen.de>
In-Reply-To: 20191105170531.30407-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2396

--===============5169397848342095532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Avoids a bit of copy&paste code.
squashto:  mptcp: recvmsg() can drain data from multiple subflows

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3af5f121af9e..8cc9cc5675c2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -443,22 +443,12 @@ static void mptcp_wait_data(struct sock *sk, long *ti=
meo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	int data_ready;
 =

 	add_wait_queue(sk_sleep(sk), &wait);
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 =

-	release_sock(sk);
-
-	smp_mb__before_atomic();
-	data_ready =3D test_and_clear_bit(MPTCP_DATA_READY, &msk->flags);
-	smp_mb__after_atomic();
-
-	if (!data_ready)
-		*timeo =3D wait_woken(&wait, TASK_INTERRUPTIBLE, *timeo);
-
-	sched_annotate_sleep();
-	lock_sock(sk);
+	sk_wait_event(sk, timeo,
+		      test_and_clear_bit(MPTCP_DATA_READY, &msk->flags), &wait);
 =

 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
-- =

2.23.0

--===============5169397848342095532==--
