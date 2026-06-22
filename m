Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C44D396B79;
	Mon, 22 Jun 2026 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125091; cv=none; b=cdl+RoSmZwkQ38eWTRHwJoj6nQDXyPqL3DN6V96yqsBt+BkyZ2/fwWVg0v34+7wBrT4x8XebdJWfrL6cZfBrEpJYm7k80blaIznPVqUUcwWVpwnp44n7pAg2i0pI1rEzQOGw31TbQ49m9NJ/PWXYpZXz9i9gS16K3gxVXMfvQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125091; c=relaxed/simple;
	bh=uUAz00WkmvKE4Pw3KMgKRpIyOHXUaewfiwq3ELCxz6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXi5RSTHz17kh4WJfRiVg5+3CyFEE4JwhHXmdVlbl3MLgRb9j5K01X5qVdeEYanpagecX7mblakale9KcUL3/tJ1jrrAM3rw4XlDmusAQhVnQrGrjfo8Q6Ye0iQSyWKNhzAWwys0V9XW6/0tohJY+EHwLm8+iECpuh8f37Yiaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jplHGzm+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jplHGzm+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0851F000E9;
	Mon, 22 Jun 2026 10:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125090;
	bh=5U39BmXz5gXJhw1YQj428YGYFBW5iG5GsyNCDasB+xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jplHGzm+Ngni6xtBTDItq7x30P7LqXB+nL20Thk4rnreYKLYZSytvca2QPwUnB0Lq
	 /wdP5BaArDkf0ZlZi3Fup10+6Ig/vhTeZYTv4EzKUMFTPv0ORF6q77ueTw+ZYpRvga
	 wLMq/kBeFuMDpJxHqUKP+gWxyMysygFx16zZ3FPJsPl6pTU+f4B9duUM7+eNV8KSd9
	 By3XjHnxRgH2bJQSPbsn91Ey1F4j5fYYRvjVf9UyJov7YiQFPzfto0NbnkHJa/qvx8
	 7RWIwdbHmXV82nj3OUHmpYgVykibvC74wcOeoSKE62OL8sgVYetxp3YRiwTbZcP8/y
	 MgM0E869VLYMg==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 07/17] tls: replace tcp_inq with socket peek_len
Date: Mon, 22 Jun 2026 18:43:27 +0800
Message-ID: <2c96084e62a7b48733443b70ca2e540bd095bf51.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

TLS (device, strparser, and software) calls tcp_inq() directly to
determine how much data is still pending in the socket receive queue.
This breaks when the underlying socket is not TCP (e.g., MPTCP).

Switch all occurrences of tcp_inq(sk) to sk->sk_socket->ops->
peek_len(sk->sk_socket). This operation is implemented for both TCP
and MPTCP (after the previous commits), making TLS transparently
usable over MPTCP connections.

The change is straightforward: every place where TLS needed the
available in-queue bytes now uses the protocol-specific peek_len
method instead of assuming a TCP socket.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_device.c | 4 ++--
 net/tls/tls_strp.c   | 6 ++++--
 net/tls/tls_sw.c     | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 741aef09bfd3..c44a59d9d715 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -805,7 +805,7 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		/* head of next rec is already in, note that the sock_inq will
 		 * include the currently parsed message when called from parser
 		 */
-		sock_data = tcp_inq(sk);
+		sock_data = sk->sk_socket->ops->peek_len(sk->sk_socket);
 		if (sock_data > rcd_len) {
 			trace_tls_device_rx_resync_nh_delay(sk, sock_data,
 							    rcd_len);
@@ -864,7 +864,7 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 	rxm = strp_msg(skb);
 
 	/* head of next rec is already in, parser will sync for us */
-	if (tcp_inq(sk) > rxm->full_len) {
+	if (sk->sk_socket->ops->peek_len(sk->sk_socket) > rxm->full_len) {
 		trace_tls_device_rx_resync_nh_schedule(sk);
 		ctx->resync_nh_do_now = 1;
 	} else {
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 61b10c697ecc..82a5b64b5f48 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -484,12 +484,14 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 {
 	struct strp_msg *rxm;
 	struct tls_msg *tlm;
+	int inq;
 
 	DEBUG_NET_WARN_ON_ONCE(!strp->msg_ready);
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+		inq = strp->sk->sk_socket->ops->peek_len(strp->sk->sk_socket);
+		if (unlikely(inq < strp->stm.full_len)) {
 			WRITE_ONCE(strp->msg_ready, 0);
 			strp->msg_announced = 0;
 			memset(&strp->stm, 0, sizeof(strp->stm));
@@ -513,7 +515,7 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 {
 	int sz, inq;
 
-	inq = tcp_inq(strp->sk);
+	inq = strp->sk->sk_socket->ops->peek_len(strp->sk->sk_socket);
 	if (inq < 1)
 		return 0;
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9324e4ed20a3..35fb0c3c965a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1706,12 +1706,14 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 		       size_t *flushed_at)
 {
 	size_t max_rec;
+	int inq;
 
 	if (len_left <= decrypted)
 		return false;
 
+	inq = sk->sk_socket->ops->peek_len(sk->sk_socket);
 	max_rec = prot->overhead_size - prot->tail_size + TLS_MAX_PAYLOAD_SIZE;
-	if (done - *flushed_at < SZ_128K && tcp_inq(sk) > max_rec)
+	if (done - *flushed_at < SZ_128K && inq > max_rec)
 		return false;
 
 	*flushed_at = done;
-- 
2.53.0

