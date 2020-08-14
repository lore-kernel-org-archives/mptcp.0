Content-Type: multipart/mixed; boundary="===============5160289455896885463=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: sendmsg: reset iter on error
Date: Fri, 14 Aug 2020 15:56:34 +0200
Message-ID: <20200814135634.12996-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 5556

--===============5160289455896885463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Once we've copied data from the iterator we need to revert in case we
end up not sending any data.

This bug doesn't trigger with normal 'poll' based tests, because
we only feed a small chunk of data to kernel after poll indicated
POLLOUT.  With blocking IO and large writes this triggers. Receiver
ends up with less data than it should get.

Fixes: 72511aab95c94d ("mptcp: avoid blocking in tcp_sendpages")
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d5aaa98b9136..2e7e87304930 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -725,8 +725,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 		if (!psize)
 			return -EINVAL;
 =

-		if (!sk_wmem_schedule(sk, psize + dfrag->overhead))
+		if (!sk_wmem_schedule(sk, psize + dfrag->overhead)) {
+			iov_iter_revert(&msg->msg_iter, psize);
 			return -ENOMEM;
+		}
 	} else {
 		offset =3D dfrag->offset;
 		psize =3D min_t(size_t, dfrag->data_len, avail_size);
@@ -737,8 +739,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct =
sock *ssk,
 	 */
 	ret =3D do_tcp_sendpages(ssk, page, offset, psize,
 			       msg->msg_flags | MSG_SENDPAGE_NOTLAST | MSG_DONTWAIT);
-	if (ret <=3D 0)
+	if (ret <=3D 0) {
+		iov_iter_revert(&msg->msg_iter, psize);
 		return ret;
+	}
 =

 	frag_truesize +=3D ret;
 	if (!retransmission) {
-- =

2.26.2

--===============5160289455896885463==--
