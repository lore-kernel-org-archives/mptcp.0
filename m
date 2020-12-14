Content-Type: multipart/mixed; boundary="===============5308761773278242285=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net] mptcp: properly annotate nested lock
Date: Mon, 14 Dec 2020 18:49:21 +0100
Message-ID: <50af234d94b3b4cd596782e094222837702b7641.1607965491.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7166

--===============5308761773278242285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MPTCP closes the subflows while holding the msk-level lock.
While acquiring the subflow socket lock we need to use the
correct nested annotation, or we can hit a lockdep splat
at runtime.

Reported-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>
Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b372e4b18092..089f084d0ba8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2118,7 +2118,7 @@ void __mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
 =

 	list_del(&subflow->node);
 =

-	lock_sock(ssk);
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 =

 	/* if we are invoked by the msk cleanup code, the subflow is
 	 * already orphaned
-- =

2.26.2

--===============5308761773278242285==--
