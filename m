Content-Type: multipart/mixed; boundary="===============6507196487808563993=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: replace mptcp_disconnect with a stub
Date: Wed, 29 Apr 2020 16:22:23 +0200
Message-ID: <20200429142223.18894-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4274

--===============6507196487808563993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo points out that mptcp_disconnect is bogus:
"lock_sock(sk);
looks suspicious (lock should be already held by the caller)
And call to: tcp_disconnect(sk, flags); too, sk is not a tcp
socket".

->disconnect() gets called from e.g. inet_stream_connect when
one tries to disassociate a connected socket again (to re-connect
without closing the socket first).
MPTCP however uses mptcp_stream_connect, not inet_stream_connect,
for the mptcp-socket connect call.

inet_stream_connect only gets called indirectly, for the tcp socket,
so any ->disconnect() calls end up calling tcp_disconnect for that
tcp subflow sk.

This also explains why syzkaller has not yet reported a problem
here.  So for now replace this with a stub that doesn't do anything.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/14
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b22a63ba2348..6e0188f5d3f3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1316,11 +1316,12 @@ static void mptcp_copy_inaddrs(struct sock *msk, co=
nst struct sock *ssk)
 =

 static int mptcp_disconnect(struct sock *sk, int flags)
 {
-	lock_sock(sk);
-	__mptcp_clear_xmit(sk);
-	release_sock(sk);
-	mptcp_cancel_work(sk);
-	return tcp_disconnect(sk, flags);
+	/* Should never be called.
+	 * inet_stream_connect() calls ->disconnect, but that
+	 * refers to the subflow socket, not the mptcp one.
+	 */
+	WARN_ON_ONCE(1);
+	return 0;
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-- =

2.26.2

--===============6507196487808563993==--
