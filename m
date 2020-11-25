Content-Type: multipart/mixed; boundary="===============5863926841837300601=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: be careful on subflows shutdown
Date: Wed, 25 Nov 2020 19:41:33 +0100
Message-ID: <0e80f1282034868082de4b9a76c8f5fde867f840.1606329599.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6936

--===============5863926841837300601==
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
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
this could possibly fix issues#115, @Christoph could
you please have a spin on syzkaller?
---
 net/mptcp/protocol.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dd912697ffdd..2a8174a7e630 100644
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
@@ -2118,6 +2125,8 @@ void __mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
 		sock_orphan(ssk);
 	}
 =

+	subflow->disposable =3D 1;
+
 	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
 	 * the ssk has been already destroyed, we just need to release the
 	 * reference owned by msk;
@@ -2125,8 +2134,7 @@ void __mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
 	if (!inet_csk(ssk)->icsk_ulp_ops) {
 		kfree_rcu(subflow, rcu);
 	} else {
-		/* otherwise ask tcp do dispose of ssk and subflow ctx */
-		subflow->disposable =3D 1;
+		/* otherwise ask tcp will dispose of ssk and subflow ctx */
 		__tcp_close(ssk, 0);
 =

 		/* close acquired an extra ref */
-- =

2.26.2

--===============5863926841837300601==--
