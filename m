Content-Type: multipart/mixed; boundary="===============1478412910675740027=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-net-next 09/12] mptcp: Remove MPTCP-code out
 of do_ip_setsockopt
Date: Mon, 17 Dec 2018 17:38:05 -0800
Message-ID: <20181218013808.4819-10-cpaasch@apple.com>
In-Reply-To: 20181218013808.4819-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 931

--===============1478412910675740027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/ip_sockglue.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 4760ebe590e1..7c864ad41e6d 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -753,20 +753,6 @@ static int do_ip_setsockopt(struct sock *sk, int level,
 			inet->tos =3D val;
 			sk->sk_priority =3D rt_tos2priority(val);
 			sk_dst_reset(sk);
-			/* Update TOS on mptcp subflow */
-			if (is_meta_sk(sk)) {
-				struct mptcp_tcp_sock *mptcp;
-
-				mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
-					struct sock *sk_it =3D mptcp_to_sock(mptcp);
-
-					if (inet_sk(sk_it)->tos !=3D inet_sk(sk)->tos) {
-						inet_sk(sk_it)->tos =3D inet_sk(sk)->tos;
-						sk_it->sk_priority =3D sk->sk_priority;
-						sk_dst_reset(sk_it);
-					}
-				}
-			}
 		}
 		break;
 	case IP_TTL:
-- =

2.16.2


--===============1478412910675740027==--
