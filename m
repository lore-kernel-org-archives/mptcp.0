Content-Type: multipart/mixed; boundary="===============5632088481623665936=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: fix 'assignment from incompatible
 pointer type' warning
Date: Thu, 10 Oct 2019 17:27:07 +0200
Message-ID: <88e6d785c72e7d5591ae29dc8395162b306140ac.1570721199.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2091

--===============5632088481623665936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

when building vs 32 bits arches pfrag->offset is 16bits , otherwise 32.
Instead of using conditional definitions in multiple places, let's
drop 'poffset' variable altogether.

sendmsg_frag() updates only the pfrag offset, if pfrag is available,
while dfrag offset update is up to the caller.

Squash-to: "mptcp: rework mptcp_sendmsg_frag to accept optional dfrag"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b5287bc40c59..46a67f9da9c3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -179,7 +179,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	struct page *page;
 	u64 *write_seq;
 	size_t psize;
-	int *poffset;
 =

 	/* use the mptcp page cache so that we can easily move the data
 	 * from one substream to another, but do per subflow memory accounting
@@ -240,7 +239,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 			offset =3D dfrag->offset;
 			frag_truesize =3D dfrag->overhead;
 		}
-		poffset =3D &pfrag->offset;
 		psize =3D min_t(size_t, pfrag->size - offset, avail_size);
 =

 		/* Copy to page */
@@ -257,7 +255,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 			return -ENOMEM;
 	} else {
 		offset =3D dfrag->offset;
-		poffset =3D &dfrag->offset;
 		psize =3D min_t(size_t, dfrag->data_len, avail_size);
 	}
 =

@@ -316,7 +313,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 	 */
 =

 out:
-	*poffset +=3D frag_truesize;
+	if (!retransmission)
+		pfrag->offset +=3D frag_truesize;
 	*write_seq +=3D ret;
 	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;
 =

@@ -820,6 +818,7 @@ static void mptcp_retransmit(struct work_struct *work)
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
 		copied +=3D ret;
 		dfrag->data_len -=3D ret;
+		dfrag->offset +=3D ret;
 	}
 	if (copied)
 		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
-- =

2.21.0

--===============5632088481623665936==--
