Content-Type: multipart/mixed; boundary="===============8292447905276104115=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: reset 'first' and ack_hint on subflow close
Date: Thu, 18 Feb 2021 16:59:46 +0100
Message-ID: <20210218155946.18540-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 7847

--===============8292447905276104115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just like with last_snd, we have to NULL 'first' on subflow close.

ack_hint isn't strictly required (its never dereferenced), but better to
clear this as well.

msk->first is dereferenced unconditionally at accept time, but
at that point the ssk is not on the conn_list yet -- this means
worker can't see it when iterating the conn_list.

Reported-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d811f60a867b..acbd2e554ede 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2161,6 +2161,12 @@ static void __mptcp_close_ssk(struct sock *sk, struc=
t sock *ssk,
 	if (ssk =3D=3D msk->last_snd)
 		msk->last_snd =3D NULL;
 =

+	if (ssk =3D=3D msk->ack_hint)
+		msk->ack_hint =3D NULL;
+
+	if (ssk =3D=3D msk->first)
+		msk->first =3D NULL;
+
 	if (msk->subflow && ssk =3D=3D msk->subflow->sk)
 		mptcp_dispose_initial_subflow(msk);
 }
-- =

2.26.2

--===============8292447905276104115==--
