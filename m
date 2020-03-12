Content-Type: multipart/mixed; boundary="===============3506891295948756997=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: propagate sendbuf setting to subflow on
 fallback
Date: Thu, 12 Mar 2020 16:44:08 +0100
Message-ID: <20200312154408.597-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3935

--===============3506891295948756997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For normal mptcp subflows we do not need to propagate the sndbuf size
because all skbs to be transmitted via mptcp get charged to the mptcp
send buffer, i.e. mptcp sndbuf will limit the amount of data handed to
the subflow sockets.

However, when we enter fallback mode, the mptcp xmit function is cut
short and no mptcp-level socket accouting takes place.
Therefore for the sndbuf limit to have any effect we need to set it
on the fallback socket.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 I'll pass this to netdev@ unless there are objections.

 net/mptcp/protocol.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8d6ab825bdab..ddfd02ab6e31 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -57,15 +57,27 @@ static bool __mptcp_needs_tcp_fallback(const struct mpt=
cp_sock *msk)
 	return msk->first && !sk_is_mptcp(msk->first);
 }
 =

+static void sync_sndbuf(const struct sock *msk, struct sock *ssk)
+{
+	if (unlikely((msk->sk_userlocks & SOCK_SNDBUF_LOCK) &&
+	     ssk->sk_sndbuf !=3D msk->sk_sndbuf)) {
+		ssk->sk_userlocks |=3D SOCK_SNDBUF_LOCK;
+		WRITE_ONCE(ssk->sk_sndbuf, msk->sk_sndbuf);
+	}
+}
+
 static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
-	sock_owned_by_me((const struct sock *)msk);
+	struct sock *sk =3D (struct sock *)msk;
+
+	sock_owned_by_me(sk);
 =

 	if (likely(!__mptcp_needs_tcp_fallback(msk)))
 		return NULL;
 =

 	if (msk->subflow) {
-		release_sock((struct sock *)msk);
+		sync_sndbuf(sk, msk->subflow->sk);
+		release_sock(sk);
 		return msk->subflow;
 	}
 =

-- =

2.24.1

--===============3506891295948756997==--
