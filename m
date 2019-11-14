Content-Type: multipart/mixed; boundary="===============0841365692106833147=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 14/14] sendmsg: truncate source buffer if mptcp sndbuf
 size was set from userspace
Date: Thu, 14 Nov 2019 18:32:25 +0100
Message-ID: <20191114173225.21199-15-fw@strlen.de>
In-Reply-To: 20191114173225.21199-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2542

--===============0841365692106833147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If userspace uses SO_SNDBUF to set a value, then truncate the buffer
according to remaining wmem.

Otherwise, running selftest script with "-m mmap -b 4096" shows very
large sucessful write() calls, as we're only limited by how much data
the underlying tcp flow is willing to accept.

NB: It might make sense to carry SO_SNDBUF down to the subflows,
but thats left out for now.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbbff667e07a..eb3499ca4f36 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -498,6 +498,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 =

 	pr_debug("conn_list->subflow=3D%p", ssk);
 =

+	if (unlikely(sk->sk_userlocks & SOCK_SNDBUF_LOCK)) {
+		int limit =3D sk_stream_wspace(sk);
+
+		if (WARN_ON_ONCE(limit <=3D 0))
+			limit =3D 1;
+
+		iov_iter_truncate(&msg->msg_iter, limit);
+	}
+
 	lock_sock(ssk);
 	ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
 				 &size_goal);
-- =

2.23.0

--===============0841365692106833147==--
