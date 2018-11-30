Content-Type: multipart/mixed; boundary="===============0421657642345281121=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/5] mptcp: Always call sk_data_ready
Date: Thu, 29 Nov 2018 17:05:13 -0800
Message-ID: <20181130010514.18251-5-cpaasch@apple.com>
In-Reply-To: 20181130010514.18251-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 849

--===============0421657642345281121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit 03f45c883c6f ("tcp: avoid extra wakeups for SO_RCVLOWAT users"=
),
tcp_data_queue checks for available bytes in the subflow's receive-queue
before waking up the "app". However, with MPTCP we might have
zero-length data-fins in the queue. Thus, we still need to wakeup the
MPTCP-layer in case of a subflow.

Fixes: dd64d1c40b48 ("Merge tag 'v4.18' into mptcp_trunk")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 8562bd5e62968e4bbdbf897decf933e90210a139)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c0efc3de8683..0f1ac709f15d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4741,7 +4741,7 @@ void tcp_data_ready(struct sock *sk)
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 	int avail =3D tp->rcv_nxt - tp->copied_seq;
 =

-	if (avail < sk->sk_rcvlowat && !sock_flag(sk, SOCK_DONE))
+	if (avail < sk->sk_rcvlowat && !sock_flag(sk, SOCK_DONE) && !mptcp(tp))
 		return;
 =

 	sk->sk_data_ready(sk);
-- =

2.16.2


--===============0421657642345281121==--
