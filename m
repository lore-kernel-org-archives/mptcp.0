Content-Type: multipart/mixed; boundary="===============5343739388073931002=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 13/14] sendmsg: don't restart mptcp_sendmsg_frag
Date: Thu, 14 Nov 2019 18:32:24 +0100
Message-ID: <20191114173225.21199-14-fw@strlen.de>
In-Reply-To: 20191114173225.21199-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2541

--===============5343739388073931002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This function calls do_tcp_sendpages which already has such a loop.

When tcp sendbuffer runs out of space and non-blocking io is used,
do_tcp_sendpages will return early because it can't sleep.
No -EAGAIN is returned, as some data was sent.

When mptcp_sendmsg_frag is called again, next call will either return
-EAGAIN immediately or it will only send a few more bytes.

Simplify this and leave all 'allocate another skb?' logic to tcp.

This would need to be spread over multiple changes, I'd propose
I do the squash myself and send a pull request for the updated branch
if thats fine with you.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d3bf189b407..fbbff667e07a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -499,14 +499,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	pr_debug("conn_list->subflow=3D%p", ssk);
 =

 	lock_sock(ssk);
-	while (msg_data_left(msg)) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
-					 &size_goal);
-		if (ret < 0)
-			break;
-
-		copied +=3D ret;
-	}
+	ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
+				 &size_goal);
+	if (ret > 0)
+		copied =3D ret;
 =

 	mptcp_set_timeout(sk, ssk);
 	if (copied) {
@@ -789,7 +785,6 @@ static void mptcp_worker(struct work_struct *work)
 	struct sock *ssk, *sk;
 	struct mptcp_sock *msk;
 	u64 orig_write_seq;
-	size_t copied =3D 0;
 	struct msghdr msg;
 	long timeo =3D 0;
 =

@@ -816,20 +811,16 @@ static void mptcp_worker(struct work_struct *work)
 	orig_len =3D dfrag->data_len;
 	orig_offset =3D dfrag->offset;
 	orig_write_seq =3D dfrag->data_seq;
-	while (dfrag->data_len > 0) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &timeo, &mss_now,
-					 &size_goal);
-		if (ret < 0)
-			break;
 =

+	ret =3D mptcp_sendmsg_frag(sk, ssk, &msg, dfrag, &timeo, &mss_now,
+				 &size_goal);
+	if (ret > 0) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied +=3D ret;
 		dfrag->data_len -=3D ret;
 		dfrag->offset +=3D ret;
-	}
-	if (copied)
 		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
+	}
 =

 	dfrag->data_seq =3D orig_write_seq;
 	dfrag->offset =3D orig_offset;
-- =

2.23.0

--===============5343739388073931002==--
