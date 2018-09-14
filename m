Content-Type: multipart/mixed; boundary="===============8007928259146535070=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 14/20] mptcp: Pick correct sk when iterating in
 mptcp_set_rto
Date: Fri, 14 Sep 2018 10:25:18 -0700
Message-ID: <20180914172524.67961-17-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 739

--===============8007928259146535070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We are iterating with sk_it as the iterator, so pick this one!

Fixes: 57192ffda92b ("mptcp: Correct initial meta-RTO estimation after 3-wa=
y handshake")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 92a6e05825aa069d409d188f42ab62aa9f83c167)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index bf902a884212..864796b2395c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -1183,7 +1183,7 @@ static inline void mptcp_set_rto(struct sock *sk)
 	mptcp_for_each_sub(tp->mpcb, mptcp) {
 		struct sock *sk_it =3D mptcp_to_sock(mptcp);
 =

-		if ((mptcp_sk_can_send(sk_it) || sk->sk_state =3D=3D TCP_SYN_RECV) &&
+		if ((mptcp_sk_can_send(sk_it) || sk_it->sk_state =3D=3D TCP_SYN_RECV) &&
 		    inet_csk(sk_it)->icsk_rto > max_rto)
 			max_rto =3D inet_csk(sk_it)->icsk_rto;
 	}
-- =

2.16.2


--===============8007928259146535070==--
