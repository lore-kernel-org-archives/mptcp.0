Content-Type: multipart/mixed; boundary="===============5340280737708892197=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 mptcp-net-next 05/12] mptcp: Remove support for
 sendpage()
Date: Fri, 21 Dec 2018 08:13:31 -0800
Message-ID: <20181221161338.72325-6-cpaasch@apple.com>
In-Reply-To: 20181221161338.72325-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 957

--===============5340280737708892197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h | 18 ------------------
 net/ipv4/tcp.c      | 21 ++-------------------
 2 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index e01a642466c0..9e7dd681fb71 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -868,20 +868,6 @@ struct request_sock *rev_mptcp_rsk(const struct mptcp_=
request_sock *req)
 	return (struct request_sock *)req;
 }
 =

-static inline bool mptcp_can_sendpage(struct sock *sk)
-{
-	struct mptcp_tcp_sock *mptcp;
-
-	mptcp_for_each_sub(tcp_sk(sk)->mpcb, mptcp) {
-		struct sock *sk_it =3D mptcp_to_sock(mptcp);
-
-		if (!(sk_it->sk_route_caps & NETIF_F_SG))
-			return false;
-	}
-
-	return true;
-}
-
 static inline void mptcp_push_pending_frames(struct sock *meta_sk)
 {
 	/* We check packets out and send-head here. TCP only checks the
@@ -1366,10 +1352,6 @@ static inline int mptcp_rcv_synsent_state_process(st=
ruct sock *sk,
 {
 	return 0;
 }
-static inline bool mptcp_can_sendpage(struct sock *sk)
-{
-	return false;
-}
 static inline int mptcp_init_tw_sock(struct sock *sk,
 				     struct tcp_timewait_sock *tw)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 213be064adde..87f7616aaf93 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -977,28 +977,12 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page=
 *page, int offset,
 	 * is fully established.
 	 */
 	if (((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) &&
-	    !tcp_passive_fastopen(mptcp(tp) && tp->mpcb->master_sk ?
-				  tp->mpcb->master_sk : sk)) {
+	    !tcp_passive_fastopen(sk)) {
 		err =3D sk_stream_wait_connect(sk, &timeo);
 		if (err !=3D 0)
 			goto out_err;
 	}
 =

-	if (mptcp(tp)) {
-		/* We must check this with socket-lock hold because we iterate
-		 * over the subflows.
-		 */
-		if (!mptcp_can_sendpage(sk)) {
-			ssize_t ret;
-
-			release_sock(sk);
-			ret =3D sock_no_sendpage(sk->sk_socket, page, offset,
-					       size, flags);
-			lock_sock(sk);
-			return ret;
-		}
-	}
-
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 =

 	mss_now =3D tcp_send_mss(sk, &size_goal, flags);
@@ -1117,8 +1101,7 @@ EXPORT_SYMBOL_GPL(do_tcp_sendpages);
 int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
 			size_t size, int flags)
 {
-	/* If MPTCP is enabled, we check it later after establishment */
-	if (!mptcp(tcp_sk(sk)) && !(sk->sk_route_caps & NETIF_F_SG))
+	if (!(sk->sk_route_caps & NETIF_F_SG) || mptcp(tcp_sk(sk)))
 		return sock_no_sendpage_locked(sk, page, offset, size, flags);
 =

 	tcp_rate_check_app_limited(sk);  /* is sending application-limited? */
-- =

2.16.2


--===============5340280737708892197==--
