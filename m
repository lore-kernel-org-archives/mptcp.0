Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A47239567
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361422; cv=none; b=bZX/Yl7vq3V4l4DKQpPypO950QbAftZ0UQjEpPlzAwqjI3BnnAtT/tLFBqvX1Qqje/bQx53enUWveAlVrIH13vJ7YOmBx0wm2lFXCbrzYiOuO8D2J0APyvE/nfrlbUdYmMD9iqwxy2Od+R1MYGSRDQf4yEN3bdDNzqIF/2Y7uME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361422; c=relaxed/simple;
	bh=RbFVPj4U5mRWz/DTX94xA8FaAzlhmwcWMgMW/PQXMg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuRLqAi3pQfP6XuvhZkCt+6U50RbB67m+jo3U+LiFo294bzcfj4xVLB42ytxhxd8ANKr1zOVHZJcei6GTGg0m4y9XN8d8EWtk0cXhU+uiRWj2B7XeWb8bHVZtW9MIQfpjyPLXoL41AhU3W4be3WP2x+CfOWtm6JdPoh0DPHN8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmC94/+M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmC94/+M"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48d102471a4so30499825e9.2
        for <mptcp@lists.linux.dev>; Sat, 09 May 2026 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778361419; x=1778966219; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9cFyvegcIIfQGaI2bqMmk5HjxopCH8Nip+wOVOpZcw=;
        b=mmC94/+MuykOkO1EOLf5TOaCf2mPww4wFrouXPHD6MPIw1jEZuudM95qqcPDti73+F
         cZQpdvXyA+33+rAJG3eDKo09071l726tTNRVUuUq45YGt5xgmjchcI5O3TWARRXq/MiY
         K1M5E0PDcjUT23kLTTvmHAU+4EJa0oXjmYqL+r08DZwP/kn5QYAwdXqsqx22yzfGnJ/q
         7bLFbx0rKbh5Jjyabny8JdWnAZVaKAtNFL8SpP2uNIPvoylH/bkcoshWeT3J7VBOjvB9
         Y92yjMpuD6b4piKhFHZkZObqdROvJgPVa6rpjPw2b1oiwKGwRL6JR3AcXOzpSXPEw5fu
         BBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778361419; x=1778966219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z9cFyvegcIIfQGaI2bqMmk5HjxopCH8Nip+wOVOpZcw=;
        b=ZJME6ITdAMGOhekRnoU2PuYfsPTmm6Toe7+8cMdrgeTFstomZVH4/sKX8xFwhGoYMT
         f/7k0zH82B/cQ1ZDlzAe2nPl5Voj7ZANWx5puNVNYkosXgc7d0fTdX2vSZETcPWPGqkE
         6c5ymsPYW7XLWBg26qhZb+VagMeQbXdyJ6zHAX7wyvV0Urr1fuGR629UAktpz4XBTIW7
         t5v3E5QE2kx6I6/NvphEW9aKPB7HUye6qAMlclZmpKnvxwGHmbgCRoLUTBGDxwxxY1AC
         uV1EpxQTBle/Kpb380+oq+zX0k8P+gcv15PVM3UQY+NBDk+fhrFUOGqNNNrmq4BT0XaW
         +iiw==
X-Gm-Message-State: AOJu0YylvQAc6Ew/rnZqepOBVICKSZYeS4OtNNwUR5SWhcTNgoAKU4BO
	1Q+S6symrd4uLpo/5S9PXb7UlOoXWVtkoa3qGOa3XrMor/Z7YTBM0+t1hTShpgEbj/I=
X-Gm-Gg: Acq92OH76xT7Z6MuZZDkxjDEH3EKC2zFjDqSYF53+JEsGOKm9G1nDDmGke48mzBg6TE
	3uFxff1q14PXwFU1T6siVzeqOxJ95QJgw5Tj+B28m1thZqZYDQ58DSq1r4IDChZQ+ZW7+61VTq7
	yzmEyJi9aWUWNtpOqz1xKqVe24Kuy4se4+uQspMUMcFz/ypkkn2XuzjtDtjYXuV95u/WCp55vwL
	HGP41r/pQ2Olngn+zjzHwKvF50NFjKVEl5dO9BndoX47cAlokoqf7yGXcPsiiwOdmVMFkhNaS0D
	8XPXpgOR0ytxziZkShCGcwOTXHHn5oO6NTy1luvHnRycZLWdR3uUpnlV9e4qzP91fGIk2+3/9dE
	wdIIUPRNwffYtCIAPcYM2N1OU6Ry05WcZIk6c1z7OEkqJXOekQyiSXEOOmV8EFuXtsSoBAzB0Q4
	oBEoKR8J4rHuBhg2dZ57Rui+iz5ptJv059eeUU8IOrT1NyGKXZgwerx0s9wTUYmeJXb0WkuEC3P
	KRRBWwN+AE=
X-Received: by 2002:a05:600c:45c5:b0:48e:526e:1040 with SMTP id 5b1f17b1804b1-48e676b45eamr127681835e9.23.1778361419142;
        Sat, 09 May 2026 14:16:59 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d89af2esm30110455e9.0.2026.05.09.14.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 14:16:57 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v7 3/4] mptcp: support MSG_ERRQUEUE on the parent socket
Date: Sat,  9 May 2026 22:16:46 +0100
Message-ID: <20260509211651.104934-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509211651.104934-1-devnexen@gmail.com>
References: <20260509211651.104934-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Splice pending err skbs from each subflow's error queue onto the parent
msk's error queue at error-report time, so poll() and recvmsg(MSG_ERRQUEUE)
on the parent socket observe TX timestamps and MSG_ZEROCOPY completion
notifications through the standard inet ABI.

The splice filters by SO_EE_ORIGIN: TIMESTAMPING / ZEROCOPY / LOCAL
events forward to the parent because they are tied to user-handed data,
not to a specific path; subflow-level ICMP errors are dropped because
the legacy RECVERR ABI cannot meaningfully convey their per-subflow peer
identity to single-path-aware userspace. Such events will be carried by
a future MPTCP_RECERR channel.

mptcp_recv_error() retries the splice on the pull side: if
sock_queue_err_skb() previously failed under rmem pressure, the skb
stays on the subflow queue, and the next recvmsg(MSG_ERRQUEUE) splices
it once the parent's queue has been drained.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/protocol.c | 92 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 93e7a42fc65c..53abb8dc2c0f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
+#include <linux/errqueue.h>
 #include <net/aligned_data.h>
 #include <net/rps.h>
 #include <net/sock.h>
@@ -815,21 +816,52 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool mptcp_errqueue_skb_forwardable(const struct sk_buff *skb)
+{
+	u8 origin = SKB_EXT_ERR(skb)->ee.ee_origin;
+
+	return origin == SO_EE_ORIGIN_TIMESTAMPING ||
+		origin == SO_EE_ORIGIN_ZEROCOPY ||
+		origin == SO_EE_ORIGIN_LOCAL;
+}
+
+static bool __mptcp_subflow_splice_errqueue(struct sock *sk, struct sock *ssk)
+{
+	struct sk_buff *skb;
+	bool moved = false;
+
+	while ((skb = skb_dequeue(&ssk->sk_error_queue))) {
+		if (!mptcp_errqueue_skb_forwardable(skb)) {
+			kfree_skb(skb);  /* path-specific (ICMP) — belongs in MPTCP_RECERR */
+			continue;
+		}
+		if (sock_queue_err_skb(sk, skb)) {
+			skb_queue_head(&ssk->sk_error_queue, skb);
+			break;
+		}
+		moved = true;
+	}
+
+	return moved;
+}
+
 static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
 	int ssk_state;
+	bool report;
 	int err;
 
+	report = __mptcp_subflow_splice_errqueue(sk, ssk);
+
 	/* only propagate errors on fallen-back sockets or
 	 * on MPC connect
 	 */
 	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
-		return false;
+		goto out;
 
 	err = sock_error(ssk);
 	if (!err)
-		return false;
-
+		goto out;
 	/* We need to propagate only transition to CLOSE state.
 	 * Orphaned socket will see such state change via
 	 * subflow_sched_work_if_closed() and that path will properly
@@ -839,6 +871,11 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
 		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
+	report = true;
+
+out:
+	if (!report)
+		return false;
 
 	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
 	smp_wmb();
@@ -2286,6 +2323,35 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 	return 0;
 }
 
+static int mptcp_recv_error(struct sock *sk, struct msghdr *msg, int len)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	bool moved = false;
+	int ret;
+
+	/* Drain the parent first: a previous splice may have failed under
+	 * rmem pressure and the skb stayed on a subflow. Freeing space here
+	 * lets the splice below succeed; sock_queue_err_skb() then re-asserts
+	 * EPOLLERR so userspace knows to drain again on the next poll.
+	 */
+	ret = inet_recv_error(sk, msg, len);
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (!skb_queue_empty_lockless(&ssk->sk_error_queue))
+			moved |= __mptcp_subflow_splice_errqueue(sk, ssk);
+	}
+	release_sock(sk);
+
+	if (ret == -EAGAIN && moved)
+		ret = inet_recv_error(sk, msg, len);
+
+	return ret;
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int flags)
 {
@@ -2295,9 +2361,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len);
+		return mptcp_recv_error(sk, msg, len);
 
 	lock_sock(sk);
 	if (unlikely(sk->sk_state == TCP_LISTEN)) {
@@ -4298,6 +4363,19 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 	return 0;
 }
 
+static bool mptcp_subflow_errqueue_pending(const struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (!skb_queue_empty_lockless(&ssk->sk_error_queue))
+			return true;
+	}
+	return false;
+}
+
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
@@ -4341,7 +4419,9 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue) ||
+	    mptcp_subflow_errqueue_pending(msk))
 		mask |= EPOLLERR;
 
 	return mask;
-- 
2.53.0

