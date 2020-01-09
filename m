Content-Type: multipart/mixed; boundary="===============1499014098337498440=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] protocol: pm callback must be done after msk
 state is set up
Date: Thu, 09 Jan 2020 15:31:13 +0100
Message-ID: <20200109143114.7716-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3309

--===============1499014098337498440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Squashto: mptcp: Add path manager interface

current location calls this when msk->token is still 0, so pm worker
will never find the mptcp socket it should be using.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 475ef4c90460..a33c4c58de78 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1371,8 +1371,6 @@ void mptcp_finish_connect(struct sock *ssk)
 =

 	pr_debug("msk=3D%p, token=3D%u", sk, subflow->token);
 =

-	mptcp_pm_new_connection(msk, 0);
-
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
 	ack_seq++;
 	subflow->map_seq =3D ack_seq;
@@ -1389,6 +1387,8 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->ack_seq, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	atomic64_set(&msk->snd_una, msk->write_seq);
+
+	mptcp_pm_new_connection(msk, 0);
 }
 =

 static void mptcp_sock_graft(struct sock *sk, struct socket *parent)
-- =

2.24.1

--===============1499014098337498440==--
