Content-Type: multipart/mixed; boundary="===============0560029095642738721=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/3] mptcp: properly detect skb collapsing
Date: Thu, 21 Nov 2019 11:31:40 +0100
Message-ID: <a44066180cf6cc548de8ad76c51be116dee1073e.1574331014.git.pabeni@redhat.com>
In-Reply-To: cover.1574331014.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2639

--===============0560029095642738721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we can misdetect skb collapsing, which will lead
to a kernel warning and crash.

Changing a bit the detection logic for skb collapsing we
can address the issue.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 38259a8a5df3..6a59ca249f59 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -321,15 +321,24 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		sk->sk_forward_alloc -=3D frag_truesize;
 	}
 =

-	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
+	skb =3D tcp_write_queue_tail(ssk);
+	if (WARN_ON_ONCE(!skb)) {
+		ret =3D -EBADFD;
+		goto out;
+	}
+
+	/* if the tail skb extension is still the cached one, collapsing
+	 * really happened. Note: we can't check for 'same skb' as the sk_buff
+	 * hdr on tail can be transmitted, freed and re-allocated by the
+	 * do_tcp_sendpages() call
+	 */
+	collapsed =3D mpext && mpext =3D=3D skb_ext_find(skb, SKB_EXT_MPTCP);
 	if (collapsed) {
 		WARN_ON_ONCE(!can_collapse);
-		/* when collapsing mpext always exists */
 		mpext->data_len +=3D ret;
 		goto out;
 	}
 =

-	skb =3D tcp_write_queue_tail(ssk);
 	mpext =3D __skb_ext_add(skb, SKB_EXT_MPTCP, msk->cached_ext);
 	msk->cached_ext =3D NULL;
 =

-- =

2.21.0

--===============0560029095642738721==--
