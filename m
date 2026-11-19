Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065057;
	b=HQez8Ws8+u/ExRO/v2OLbl/A+0R68kSZkuhcoQCaSIBUhlEDI+/N58bGpxFmZsmlHICC
	 jOo1sLqpEQ+uucW0i4lX3q70o1AjyS3JqgCLG8n0wdQgQ258midha/jGqtiAayAJZNQRf
	 uQ8R4TUn8nJeVmZM4iyfVWXIVSXUaXrF7XMs9z9n+7D7e1HNKouF/sX/K84iFWV04pHDd
	 iE18OIhy53sTyblHgP7QWixNTu278kvBQAeODrbd1IEoBvUZmvfpGwC0eigS7x9oc4Abw
	 hBHvF7z3SF210TITe+Py81MNMje2w11SKCFRRjLUA+LE+0TM/LXQLNY0H2LUWK89ZBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065057;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gwsc9B524aVmAhGPAFsItZn6jO07GdsOMilZ1YOiO2E=;
	b=csgVAGHkvLFQGsmKA+r3Uks73cIYbJ8WYg57Tn1e6GTF2e1Kujk1GqV4b7UWAeS5KPGJ
	 zxgQnoRnaTV77j87K1hxqLBsW+Tj6jZWgpXwK9FghIG5lh1GdJlmjHWaxd9JDLRBFo0at
	 5gjZbLdENujAeNPAK7vWjmHdKfXDs95V1Uhjz7tCMJyq1xSpZ9sncvLGz663hZd4SuBLo
	 cfLXNT1ytJj4fXDb5ebUcZLDNQuskzlfXhI8PFEOaAs5se0za4YShfEbM3dH38CXNrgB3
	 Tyr3b04KdxXJpxyLytsMhXP4PusvkaKNmYjPndPFX4NTTjbS5R1J1qOpbnfH8xDYG2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3I9K81A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B2606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3I9K81A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BED1F000C8
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065057;
	bh=gwsc9B524aVmAhGPAFsItZn6jO07GdsOMilZ1YOiO2E=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=f3I9K81AuRpEl3TvrZlhDR1+vjEoybqmKTIdZzWXCOQM8FvNKbzQ8QVYckqxcevP8
	 5bI79M13OxaJ+vc2i6kdOIWbbtcWdgmeJFsCw6a3pWZHrIowNwcqbJrv0WPdrGoO0F
	 PqqMHhP7R7zFB9q0Z5l6dkPtVNkgJjeVyx1WYRPoOZMQx428nIRXU+ICKN719MctmL
	 GAwPBvwaESk+Moou/ap649uWOAK9iyIBg8IlhCJyzGqrevI0CpGn+nW3oEDNfhFKBf
	 Te88NZ1accx0wN8s906zCUGqmi5z0ETB2Aj1vnNiTnTgKfazFvR3mDyP25QbS+BVCW
	 8znBMYAnUI3vw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v29 8/8] mptcp: defer read_sock cleanup to mptcp_worker
Date: Thu, 19 Nov 2026 13:10:34 +0800
Message-ID: <94e060e3ad7a179da7d77eb8f6495d83ac1381ba.1795063943.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795063943.git.tanggeliang@kylinos.cn>
References: <cover.1795063943.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch prepares __mptcp_read_sock() for future MPTCP TLS support,
where it may be reached from BH context. In that case, calling
mptcp_rcv_space_adjust() and mptcp_cleanup_rbuf() is not safe as both
expect process context.

Conditionally defer cleanup to mptcp_worker(): when the caller doesn't
own the socket lock (BH context), accumulate consumed bytes in
msk->read_copied and signal the worker through MPTCP_WORK_READ_COMPLETE.
When the caller owns the lock (process context), perform inline cleanup
to avoid delaying window updates and autotuning.

The existing backlog flush in mptcp_recv_skb() is now gated on
sock_owned_by_user(). This ensures process context callers flush the
backlog before processing skbs, while future BH context callers skip it.
The reason is that BH callers would already hold the msk spinlock, so
mptcp_data_lock() inside mptcp_move_skbs() would self-deadlock.

Initialize msk->read_copied in __mptcp_init_sock() and reset it in
mptcp_disconnect().

Note: The BH call path does not exist in the current tree. This is
groundwork for the upcoming MPTCP TLS series. Currently, the only
in-tree caller is mptcp_splice_read(), which holds lock_sock() and runs
in process context.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 38 +++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h |  2 ++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 707a40850ada..a4d82841a0ff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3157,6 +3157,21 @@ static void mptcp_backlog_purge(struct sock *sk)
 	sk_mem_reclaim(sk);
 }
 
+static void mptcp_read_complete(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	u32 read_copied;
+
+	mptcp_data_lock(sk);
+	read_copied = msk->read_copied;
+	msk->read_copied = 0;
+	mptcp_data_unlock(sk);
+
+	mptcp_rcv_space_adjust(msk, read_copied);
+	if (read_copied > 0)
+		mptcp_cleanup_rbuf(msk, read_copied);
+}
+
 static void mptcp_do_fastclose(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3232,6 +3247,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags))
+		mptcp_read_complete(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
@@ -3275,6 +3293,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_data_sent = tcp_jiffies32;
 	msk->last_data_recv = tcp_jiffies32;
 	msk->last_ack_recv = tcp_jiffies32;
+	msk->read_copied = 0;
 
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
@@ -3723,6 +3742,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->fastclosing = 0;
 	msk->tfo_iasn = 0;
 	msk->rcvd_dummy_seq = false;
+	msk->read_copied = 0;
 	mptcp_init_rtt_est(msk);
 
 	/* for fallback's sake */
@@ -4645,7 +4665,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 	struct sk_buff *skb;
 	u32 offset;
 
-	if (!list_empty(&msk->backlog_list))
+	if (sock_owned_by_user(sk) && !list_empty(&msk->backlog_list))
 		mptcp_move_skbs(sk);
 
 	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
@@ -4670,6 +4690,7 @@ static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 /*
  * Note:
  *	- It is assumed that the socket was locked by the caller.
+ *	- Can be invoked in BH scope.
  */
 static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 			     sk_read_actor_t recv_actor, bool noack)
@@ -4711,11 +4732,18 @@ static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	if (noack)
 		goto out;
 
-	mptcp_rcv_space_adjust(msk, copied);
-
 	if (copied > 0) {
-		mptcp_recv_skb(sk, &offset);
-		mptcp_cleanup_rbuf(msk, copied);
+		if (sock_owned_by_user(sk)) {
+			/* Process context: inline cleanup */
+			mptcp_rcv_space_adjust(msk, copied);
+			mptcp_recv_skb(sk, &offset);
+			mptcp_cleanup_rbuf(msk, copied);
+		} else {
+			/* BH context: defer to worker */
+			msk->read_copied += copied;
+			set_bit(MPTCP_WORK_READ_COMPLETE, &msk->flags);
+			mptcp_schedule_work(sk);
+		}
 	}
 out:
 	return copied;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1dbd84270b45..febec1269d2c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_ENABLED	4
+#define MPTCP_WORK_READ_COMPLETE 5
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -328,6 +329,7 @@ struct mptcp_sock {
 	u32		last_data_sent;
 	u32		last_data_recv;
 	u32		last_ack_recv;
+	u32		read_copied;
 	unsigned long	timer_ival;
 	u32		token;
 	u64		tfo_iasn;
-- 
2.55.0

