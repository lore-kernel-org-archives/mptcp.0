Content-Type: multipart/mixed; boundary="===============7379134018341201522=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/3] imptcp: properly detect skb collapsing
Date: Mon, 02 Dec 2019 11:24:23 +0100
Message-ID: <0848ecdf13d13ee6614d98095a573d5e87543334.1575281351.git.pabeni@redhat.com>
In-Reply-To: cover.1575281285.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2731

--===============7379134018341201522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we can misdetect skb collapsing, which will lead
to a kernel warning and crash.

Changing a bit the detection logic for skb collapsing we
can address the issue.

Squash-to: "mptcp: allow collapsing consecutive sendpages on the same subst=
ream"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1c489eccdb58..ba918c4fdcc8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -107,8 +107,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	bool collapsed, can_collapse =3D false;
 	struct mptcp_ext *mpext =3D NULL;
+	struct sk_buff *skb, *tail;
 	struct page_frag *pfrag;
-	struct sk_buff *skb;
 	size_t psize;
 =

 	/* use the mptcp page cache so that we can easily move the data
@@ -165,10 +165,16 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	if (unlikely(ret < psize))
 		iov_iter_revert(&msg->msg_iter, psize - ret);
 =

-	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
+	/* if the tail skb extension is still the cached one, collapsing
+	 * really happened. Note: we can't check for 'same skb' as the sk_buff
+	 * hdr on tail can be transmitted, freed and re-allocated by the
+	 * do_tcp_sendpages() call
+	 */
+	tail =3D tcp_write_queue_tail(ssk);
+	collapsed =3D mpext &&
+		    mpext =3D=3D (tail ? skb_ext_find(tail, SKB_EXT_MPTCP) : NULL);
 	if (collapsed) {
 		WARN_ON_ONCE(!can_collapse);
-		/* when collapsing mpext always exists */
 		mpext->data_len +=3D ret;
 		goto out;
 	}
-- =

2.21.0

--===============7379134018341201522==--
