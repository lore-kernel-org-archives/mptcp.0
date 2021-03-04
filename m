Content-Type: multipart/mixed; boundary="===============5616388744904016935=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 1/9] mptcp: reset last_snd on subflow close
Date: Thu, 04 Mar 2021 13:32:08 -0800
Message-ID: <20210304213216.205472-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210304213216.205472-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8027

--===============5616388744904016935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

Send logic caches last active subflow in the msk, so it needs to be
cleared when the cached subflow is closed.

Fixes: d5f49190def61c ("mptcp: allow picking different xmit subflows")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/155
Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c5d5e68940ea..7362a536cbc0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2126,6 +2126,8 @@ static struct sock *mptcp_subflow_get_retrans(const s=
truct mptcp_sock *msk)
 static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			      struct mptcp_subflow_context *subflow)
 {
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
 	list_del(&subflow->node);
 =

 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
@@ -2154,6 +2156,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct=
 sock *ssk,
 	release_sock(ssk);
 =

 	sock_put(ssk);
+
+	if (ssk =3D=3D msk->last_snd)
+		msk->last_snd =3D NULL;
 }
 =

 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
-- =

2.30.1

--===============5616388744904016935==--
