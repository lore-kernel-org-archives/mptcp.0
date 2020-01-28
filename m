Content-Type: multipart/mixed; boundary="===============0702176132669896527=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v1 1/4] mptcp: protocol: defer freeing of
 cached ext until last moment
Date: Tue, 28 Jan 2020 16:01:21 +0100
Message-ID: <20200128150125.26625-2-fw@strlen.de>
In-Reply-To: 20200128150125.26625-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3536

--===============0702176132669896527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

access to msk->cached_ext is only legal if the msk is locked or all
concurrent accesses are impossible.

Furthermore, once we start to tear down, we must make sure nothing else
can step in and allocate a new cached ext.

So place this code in the destroy callback where it belongs.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 patch is new in this round.

 net/mptcp/protocol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 39fdca79ce90..f1b1160dbbb4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -654,8 +654,6 @@ static void __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 	}
 =

-	if (msk->cached_ext)
-		__skb_ext_put(msk->cached_ext);
 	release_sock(sk);
 	sk_common_release(sk);
 }
@@ -776,6 +774,10 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 =

 static void mptcp_destroy(struct sock *sk)
 {
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (msk->cached_ext)
+		__skb_ext_put(msk->cached_ext);
 }
 =

 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
-- =

2.24.1

--===============0702176132669896527==--
