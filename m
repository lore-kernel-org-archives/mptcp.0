Content-Type: multipart/mixed; boundary="===============1779573969563904525=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 2/3] mptcp: skip MPTCP_EVENT_SUB_CLOSED event
 when mptcp socket isn't established
Date: Tue, 02 Feb 2021 18:47:53 +0100
Message-ID: <20210202174754.6861-3-fw@strlen.de>
In-Reply-To: 20210202174754.6861-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7596

--===============1779573969563904525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A CLOSE event will be sent when the logical mptcp socket is closing.
Thus there is no need to generate individual subflow close events
if the mptcp socket isn't established anymore.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b5ba832ca58b..24eb42a60844 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2150,7 +2150,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct=
 sock *ssk,
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
-	mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
+	if (sk->sk_state =3D=3D TCP_ESTABLISHED)
+		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 	__mptcp_close_ssk(sk, ssk, subflow);
 }
 =

-- =

2.26.2

--===============1779573969563904525==--
