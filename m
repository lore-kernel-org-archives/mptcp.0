Content-Type: multipart/mixed; boundary="===============5686719206441227578=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/3] mptcp: be careful on subflows shutdown
Date: Wed, 09 Dec 2020 12:03:31 +0100
Message-ID: <e270b6f2ab71aa7ce8bf8f7836636332062d78cd.1607508810.git.pabeni@redhat.com>
In-Reply-To: cover.1607508810.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7099

--===============5686719206441227578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the workqueue disposes of the msk, the subflows can still
receive some data from the peer after __mptcp_close_ssk()
completes.

The above could trigger a race between the msk receive path and the
msk destruction. Acquiring the mptcp_data_lock() in __mptcp_destroy_sock()
will not save the day: the rx path could be reached even after msk
destruction completes.

Instead use the subflow 'disposable' flag to prevent entering
the msk receive path after __mptcp_close_ssk().

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4e29dcf17ecd..2540d82742ac 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -701,6 +701,13 @@ void mptcp_data_ready(struct sock *sk, struct sock *ss=
k)
 	int sk_rbuf, ssk_rbuf;
 	bool wake;
 =

+	/* The peer can send data while we are shutting down this
+	 * subflow at msk destruction time, but we must avoid enqueuing
+	 * more data to the msk receive queue
+	 */
+	if (unlikely(subflow->disposable))
+		return;
+
 	/* move_skbs_to_msk below can legitly clear the data_avail flag,
 	 * but we will need later to properly woke the reader, cache its
 	 * value
@@ -2119,6 +2126,8 @@ void __mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
 		sock_orphan(ssk);
 	}
 =

+	subflow->disposable =3D 1;
+
 	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
 	 * the ssk has been already destroyed, we just need to release the
 	 * reference owned by msk;
@@ -2126,8 +2135,7 @@ void __mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
 	if (!inet_csk(ssk)->icsk_ulp_ops) {
 		kfree_rcu(subflow, rcu);
 	} else {
-		/* otherwise ask tcp do dispose of ssk and subflow ctx */
-		subflow->disposable =3D 1;
+		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		__tcp_close(ssk, 0);
 =

 		/* close acquired an extra ref */
-- =

2.26.2

--===============5686719206441227578==--
