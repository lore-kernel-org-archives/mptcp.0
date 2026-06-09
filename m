Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D12EA480
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971567; cv=none; b=sMoKKvVnDyZvpq4uiYKst0UEhlxSXwHXvdNnpg2/HI1UFWz2xFxgItf5A3JjeURdenErv5+4GY/1+/cjbVt902/SiJJHcEIjySocmJ/9UXUuLyn+xBSY7HiwJ/kph3gKM4RRDywcWgosQaIS1sRsyUAUUNcfAp+udubiIDUF8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971567; c=relaxed/simple;
	bh=VHTysyCT+QHPcWheBGQ7vWkBA+p9OB64Q+D1pAXfcPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sE3OOrYzRaVsqWn7ZkWIvgiA7IcOHe5/J+ox03OTbV/gbml6+2556SxEgiNR4GVg/vqSJAnsqjCBN8BmyIHJjNGmHPgWI6HOUi/tWIVzk6jmeA1/ttLckPcix2gQ6qoej0569W/lt2MWjCJeTaTnMuzlt5qIbY7gpZ9axtx06xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS7Z1Heb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS7Z1Heb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A50F1F00893;
	Tue,  9 Jun 2026 02:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971566;
	bh=UqwTny8lm73e/bg9bgWS1ZWlJFjYzPr3AJUZtW4HQ4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JS7Z1HebSiEbNq53eLawmPe8oNtiOrCX6MGkf68sIPlzvXaptI7L6eJSR7jUz64Pz
	 0eyZa6soPh5c0Dj5DsOLcguxvdKsXcelclelOG6gEAYXfOi3mcu4MbX0+jOtaEG1uH
	 rty/ZCSIsfYV6foUw06DZG9mWHSD8eB1S4BQ3JzNPUb7mII/lenovs28mYUGm/nSWD
	 XxUKA+gY/+9aea0D4gcDV+85PI5dPPD9ulWFzTKWAN5WLaclOCVTtQ4+cxz5cVE/nI
	 JCWioqstezOMX8k07KmK1WJ9HMKq05G7levLLeHngF3eFgSjIMc5c6nxbI1Eb/+dJK
	 HdXtA169Sq5+A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v25 04/22] tls: replace tcp_inq with socket peek_len
Date: Tue,  9 Jun 2026 10:18:30 +0800
Message-ID: <f6cb04f09158dbd072e6f35ae21ff6662b1cf622.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
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
index c72e88317627..c14dab13edf3 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -485,12 +485,14 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
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
 			memset(&strp->stm, 0, sizeof(strp->stm));
 			return false;
@@ -513,7 +515,7 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 {
 	int sz, inq;
 
-	inq = tcp_inq(strp->sk);
+	inq = strp->sk->sk_socket->ops->peek_len(strp->sk->sk_socket);
 	if (inq < 1)
 		return 0;
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee4..d833ee14d62e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1982,12 +1982,14 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
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
2.43.0

