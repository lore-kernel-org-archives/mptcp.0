Content-Type: multipart/mixed; boundary="===============5933898748579610755=="
MIME-Version: 1.0
From: Dan Carpenter <dan.carpenter at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix bit MPTCP_PUSH_PENDING tests
Date: Fri, 12 Mar 2021 10:41:12 +0300
Message-ID: <YEsbGCmx4Jh3fApi@mwanda>
X-Status: 
X-Keywords:                  
X-UID: 8106

--===============5933898748579610755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MPTCP_PUSH_PENDING define is 6 and these tests should be testing if
BIT(6) is set.

Fixes: c2e6048fa1cf ("mptcp: fix race in release_cb")
Signed-off-by: Dan Carpenter <dan.carpenter(a)oracle.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 76958570ae7f..1590b9d4cde2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2968,7 +2968,7 @@ static void mptcp_release_cb(struct sock *sk)
 	for (;;) {
 		flags =3D 0;
 		if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->flags))
-			flags |=3D MPTCP_PUSH_PENDING;
+			flags |=3D BIT(MPTCP_PUSH_PENDING);
 		if (!flags)
 			break;
 =

@@ -2981,7 +2981,7 @@ static void mptcp_release_cb(struct sock *sk)
 		 */
 =

 		spin_unlock_bh(&sk->sk_lock.slock);
-		if (flags & MPTCP_PUSH_PENDING)
+		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
 =

 		cond_resched();
-- =

2.30.1

--===============5933898748579610755==--
