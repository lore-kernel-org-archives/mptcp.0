Content-Type: multipart/mixed; boundary="===============8901915959690584139=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: timout delta must be signed
Date: Wed, 09 Oct 2019 15:34:48 +0200
Message-ID: <938ec02702e513154846b2dc9ea9fd9377e26de1.1570628019.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2070

--===============8901915959690584139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

otherwise later 'tout <=3D 0' check will give unexpected results

Squash-to "mptcp: introduce MPTCP retransmission timer"

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 12a9051f3922..b5287bc40c59 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -24,12 +24,12 @@ static struct percpu_counter mptcp_sockets_allocated;
 =

 static void mptcp_set_timeout(const struct sock *sk, const struct sock *ss=
k)
 {
-	unsigned long tout =3D ssk && inet_csk(ssk)->icsk_pending ?
-			     inet_csk(ssk)->icsk_timeout - jiffies : 0;
+	long tout =3D ssk && inet_csk(ssk)->icsk_pending ?
+				      inet_csk(ssk)->icsk_timeout - jiffies : 0;
 =

 	if (tout <=3D 0)
 		tout =3D mptcp_sk(sk)->timer_ival;
-	mptcp_sk(sk)->timer_ival =3D  tout > 0 ? tout : TCP_RTO_MIN;
+	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
 }
 =

 bool mptcp_timer_pending(struct sock *sk)
-- =

2.21.0

--===============8901915959690584139==--
