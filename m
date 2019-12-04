Content-Type: multipart/mixed; boundary="===============8104242173623143833=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 3/3] mptcp: properly detect skb collapsing
Date: Wed, 04 Dec 2019 15:18:12 +0100
Message-ID: <c09213bf8ffefcba01907f6d13b1a970d95be7fc.1575468532.git.pabeni@redhat.com>
In-Reply-To: cover.1575468474.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2781

--===============8104242173623143833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we can misdetect skb collapsing, which will lead
to a kernel warning and crash.

Changing a bit the detection logic for skb collapsing we
can address the issue.

Squash-to: mptcp: allow collapsing consecutive sendpages on the same substr=
eam
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
v1 -> v3:
 - cleanup the 'collapsed' check (Mat)
---
 net/mptcp/protocol.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d83569672129..8fb93cc3d43f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -105,10 +105,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 {
 	int mss_now, avail_size, size_goal, ret;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	bool collapsed, can_collapse =3D false;
 	struct mptcp_ext *mpext =3D NULL;
+	struct sk_buff *skb, *tail;
+	bool can_collapse =3D false;
 	struct page_frag *pfrag;
-	struct sk_buff *skb;
 	size_t psize;
 =

 	/* use the mptcp page cache so that we can easily move the data
@@ -165,10 +165,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	if (unlikely(ret < psize))
 		iov_iter_revert(&msg->msg_iter, psize - ret);
 =

-	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
-	if (collapsed) {
+	/* if the tail skb extension is still the cached one, collapsing
+	 * really happened. Note: we can't check for 'same skb' as the sk_buff
+	 * hdr on tail can be transmitted, freed and re-allocated by the
+	 * do_tcp_sendpages() call
+	 */
+	tail =3D tcp_write_queue_tail(ssk);
+	if (mpext && tail && mpext =3D=3D skb_ext_find(tail, SKB_EXT_MPTCP)) {
 		WARN_ON_ONCE(!can_collapse);
-		/* when collapsing mpext always exists */
 		mpext->data_len +=3D ret;
 		goto out;
 	}
-- =

2.21.0

--===============8104242173623143833==--
