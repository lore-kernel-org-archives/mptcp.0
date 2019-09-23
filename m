Content-Type: multipart/mixed; boundary="===============9164801300304841371=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix retransmit timer update
Date: Mon, 23 Sep 2019 13:49:23 +0200
Message-ID: <21b1af7b421981a219b64ae92da798e489010118.1569239317.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1905

--===============9164801300304841371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat noted the current code access ssk data outside the relevant
socket lock. Fix that moving the update in such scope

Fixes: 28d2e02041c9 ("mptcp: implement and use MPTCP-level retransmission")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
I'm ok with squashing this into the fixed commit
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 439d6744c8e2..a26b74a706c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -830,11 +830,11 @@ static void mptcp_retransmit(struct work_struct *work)
 	dfrag->offset =3D orig_offset;
 	dfrag->data_len =3D orig_len;
 =

+	mptcp_set_timeout(sk, ssk);
 	release_sock(ssk);
 	sock_put(ssk);
 =

 reset_unlock:
-	mptcp_set_timeout(sk, ssk);
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
 =

-- =

2.21.0


--===============9164801300304841371==--
