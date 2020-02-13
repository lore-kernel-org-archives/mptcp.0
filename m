Content-Type: multipart/mixed; boundary="===============7947508724590507084=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 2/5] tcp: permit skb stealing in recv actor
Date: Thu, 13 Feb 2020 11:27:39 +0100
Message-ID: <20200213102742.18937-3-fw@strlen.de>
In-Reply-To: 20200213102742.18937-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3645

--===============7947508724590507084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Normal actor callbacks will copy skb data to some buffer, tcp_read_sock
then frees those skbs.

For MPTCP, it makes sense to move skbs from the subflow socket receive
queue to the mptcp socket receive queue.
It would be good to do so without the need for skb_clone or any other
dynamic memory allocation.

This allows the mptcp actor to dequeue the skb from the ssk rx queue
and add it to the tail of the msk rx queue.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/ipv4/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index eb2d80519f8e..bb374424a07c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1581,6 +1581,9 @@ static struct sk_buff *tcp_recv_skb(struct sock *sk, =
u32 seq, u32 *off)
 	u32 offset;
 =

 	while ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NULL) {
+		/* This can happen when sk_read_actor_t stole the skb */
+		if (unlikely(after(TCP_SKB_CB(skb)->seq, seq)))
+			break;
 		offset =3D seq - TCP_SKB_CB(skb)->seq;
 		if (unlikely(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
 			pr_err_once("%s: found a SYN, please report !\n", __func__);
-- =

2.24.1

--===============7947508724590507084==--
