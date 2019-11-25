Content-Type: multipart/mixed; boundary="===============5633538318808020298=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] subflow: don't increment msk refcount on join connect
 completion
Date: Mon, 25 Nov 2019 16:01:33 +0100
Message-ID: <20191125150133.13185-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2686

--===============5633538318808020298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: Add handling of outgoing MP_JOIN requests

The connecting socket already has a refcount, this additional
increase is never decremented, resulting in the mptcp socket to never get f=
reed.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e6a512bf6230..ba46c0b3a6d7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -38,7 +38,6 @@ static int subflow_rebuild_header(struct sock *sk)
 		err =3D mptcp_token_new_connect(sk);
 	} else if (subflow->request_join && !subflow->local_nonce) {
 		pr_debug("subflow=3D%p", sk);
-		mptcp_token_get_sock(subflow->token);
 =

 		do {
 			get_random_bytes(&subflow->local_nonce, sizeof(u32));
-- =

2.23.0

--===============5633538318808020298==--
