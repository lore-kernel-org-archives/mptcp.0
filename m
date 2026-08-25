Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEFE3016FB
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644694; cv=none; b=hk7hWCkjqfSIoszfEUF8Wkfjaxlc+7jc6XcA8gMr06RXsL2KE7f6/LxVBX8+CSAjUrW0nPIs0ZVUCM41ygoHw+VMozqslY/9DLdprwUVKeGiJoY9SZlBaZtehvMcYnwBAGFfsxgomr6chOk0ufk9jEu7me3IJuw55tF35Bzsn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644694; c=relaxed/simple;
	bh=ts7JGyNV77YkRgmFotzMKGv2PpdAb1Fb35yCQpPvEiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgOOuniWBRXjo4YFAI/zSHUvRZ1AWF5Ax4k6cmz8KKuSXbcYbCo2myvttRhiDlT/JqnKExb8ELr5LgplX2FqK69Ra8ZiZNlUkei34wfchVSgjiqpg60wJNN6/71sQArEvdQMqI0KSpJXKf3Vd2I7eMplvkrwujSrjb7CcICPk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrBbnqH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrBbnqH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646371F00A3D;
	Tue, 25 Aug 2026 07:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787644692;
	bh=HsKNPbquQsRniToYOkYdRShrji1SMMXDHZfGwPOqpXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JrBbnqH/cNwv9XxbvxDONdrACxcOz7HjlcO61vO6mq/wOxxzDKCAN4GawWORUSlO1
	 5DGYK1TAh3xAQYatKiukXuUIzlGAQHJ0KYSCMjwAMI/Xo4UDjmc1kIFsTUTRE1c+Ac
	 lelZwilLJ02lEROOk9slUjOxkZo8QAQiX53hCWaBOKTHZpZKqWUFTwj8Lj5C5EOoV9
	 3eOFQtPQ3uxngP1ejsTqC9sVj2RWQuJWcFHK2X/2q0T7a0hQZgBDrpvYFQJT4V8lJq
	 wkLewCcurWuqqY2cmn4H+7yUwnmmDt+pqs7BInDpfImJTH3+usNpctJEi6fEj393vn
	 SJJcPQEbe4Eng==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v8 6/8] mptcp: defer read_sock cleanup to mptcp_worker
Date: Tue, 25 Aug 2026 15:57:34 +0800
Message-ID: <bf15214a576effacece5f5f905c1e2226c45d35f.1787644449.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787644449.git.tanggeliang@kylinos.cn>
References: <cover.1787644449.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

When MPTCP carries TLS, the data path runs under mptcp_data_lock().
Reaching sk->sk_data_ready(sk) synchronously ends up at
tls_strp_check_rcv() -> mptcp_recv_skb() -> mptcp_move_skbs(), which
calls mptcp_data_lock() on the same sk and recurses on sk_lock.slock.

The TLS path is not the only constraint: before the mptcp_recv_skb()
calls, the TLS code would also reach __mptcp_read_sock(), which calls
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf(). Both require holding
the msk socket lock in process context, while the mptcp/TLS caller is
in BH scope.

Fix this by deferring sk->sk_data_ready(sk) to mptcp_worker() via a new
MPTCP_WORK_READ_COMPLETE bit, reusing the existing mptcp_schedule_work()/
mptcp_cancel_work() infrastructure. The wakeup bit is consumed after the
SOCK_DEAD && TCP_CLOSE destroy branch, so a socket that reaches the destroy
path drops the pending wakeup rather than running it post-free.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 25 +++++++++++++++++++------
 net/mptcp/protocol.h |  2 ++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d0425ba96ad5..623edce84b8b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3141,6 +3141,15 @@ static void mptcp_backlog_purge(struct sock *sk)
 	sk_mem_reclaim(sk);
 }
 
+static void mptcp_read_complete(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_rcv_space_adjust(msk, msk->read_copied);
+	mptcp_cleanup_rbuf(msk, msk->read_copied);
+	msk->read_copied = 0;
+}
+
 static void mptcp_do_fastclose(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3217,6 +3226,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -4595,9 +4607,6 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
-		mptcp_move_skbs(sk);
-
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
 		if (offset < skb->len) {
@@ -4612,6 +4621,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4653,11 +4663,14 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	if (noack)
 		goto out;
 
-	mptcp_rcv_space_adjust(msk, copied);
-
+	/* The backlog flushing is only needed when some data is actually
+	 * moved and will take place in the workers's release callback.
+	 */
 	if (copied > 0) {
 		mptcp_recv_skb(sk, &offset);
-		mptcp_cleanup_rbuf(msk, copied);
+		msk->read_copied += copied;
+		set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
+		mptcp_schedule_work(sk);
 	}
 out:
 	return copied;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 13cbc14870d2..2b3a32166d8b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_DISABLED	4
+#define MPTCP_WORK_READ_COMPLETE 5
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -312,6 +313,7 @@ struct mptcp_sock {
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
+	int		read_copied;
 	unsigned long	timer_ival;
 	u32		token;
 	u32		tfo_skb_len;
-- 
2.53.0

