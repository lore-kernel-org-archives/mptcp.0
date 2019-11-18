Content-Type: multipart/mixed; boundary="===============1153962393561318576=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 13/13] sendmsg: truncate source buffer if mptcp
 sndbuf size was set from userspace
Date: Mon, 18 Nov 2019 22:45:38 +0100
Message-ID: <20191118214538.21931-14-fw@strlen.de>
In-Reply-To: 20191118214538.21931-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2598

--===============1153962393561318576==
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
index b36d1b89cb34..e158b30f9cab 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -483,6 +483,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
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
 	while (msg_data_left(msg)) {
 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
-- =

2.23.0

--===============1153962393561318576==--
