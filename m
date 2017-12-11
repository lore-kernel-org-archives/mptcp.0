Content-Type: multipart/mixed; boundary="===============0246002534164112975=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC v3 01/15] tcp md5sig: Use skb's saddr when replying to
 an incoming segment
Date: Mon, 11 Dec 2017 13:42:04 -0800
Message-ID: <20171211214218.35868-2-cpaasch@apple.com>
In-Reply-To: 20171211214218.35868-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 234

--===============0246002534164112975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MD5-key that belongs to a connection is identified by the peer's
IP-address. When we are in tcp_v4(6)_reqsk_send_ack(), we are replying
to an incoming segment from tcp_check_req() that failed the seq-number
checks.

Thus, to find the correct key, we need to use the skb's saddr and not
the daddr.

This bug seems to have been there since quite a while, but probably got
unnoticed because the consequences are not catastrophic. We will call
tcp_v4_reqsk_send_ack only to send a challenge-ACK back to the peer,
thus the connection doesn't really fail.

Fixes: 9501f9722922 ("tcp md5sig: Let the caller pass appropriate key for t=
cp_v{4,6}_do_calc_md5_hash().")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_ipv4.c | 2 +-
 net/ipv6/tcp_ipv6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 77ea45da0fe9..94e28350f420 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -848,7 +848,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk=
, struct sk_buff *skb,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
 			req->ts_recent,
 			0,
-			tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->daddr,
+			tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->saddr,
 					  AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			ip_hdr(skb)->tos);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 1f04ec0e4a7a..7178476b3d2f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -994,7 +994,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk=
, struct sk_buff *skb,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
 			req->ts_recent, sk->sk_bound_dev_if,
-			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->daddr),
+			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr),
 			0, 0);
 }
 =

-- =

2.15.0


--===============0246002534164112975==--
