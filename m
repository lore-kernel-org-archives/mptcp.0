Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E56423A79
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297091; cv=none; b=I+YMfYb9KsyhDLUffcJPsNW3klNmmwynvOnIxCOxvRTIadZ9+ymeX8Ekj4Ur4Mfywg+nB34RQtU6P4SREX1jbBT9pZOnERCEE7DcBsC0bt9T+dTf+S2DIVILzBF30GIsBqG6ugn8c5tT8z5jYb/T3Vj2h6ndXAb22ERuRHAfneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297091; c=relaxed/simple;
	bh=z1EGHRoL2+l8w/pXEl0WtTrPzKuwyrVcN0CJvQTR+24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGvmADKzjCoZMZ2SLxk2tF6LoVyIDyhrCfvVQsOzwlf3ffBwgVfxSypSMBWVuVlV8efksS6W/X628xR0BYfMOcPHoIbz8f4lf7jqFPtUMl3tN9veg/EjieJpPD73pQrJ0PLqO47fdSrE/2pGx04b/8Wk0JlPaaHblPqHtN3i+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls8eanRP; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls8eanRP"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2232375eec.0
        for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 21:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297081; x=1792901881; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1fR27jZsvFiCA94aCBJQ8L314nFGlM3MWJ349fYKEk=;
        b=ls8eanRPcNXoZgRHqsfP8mbyt+gmH8tJ32nro8nir/kVZVWwkaCuXROLfWcKoP4e6g
         cEsUuZjRl7IsXEB52QsHoyQhqVyMfqgL/j/60AZggxEFadJ1xjheOC7xG4U3GYgS42Ef
         tQOxv8usc5qdmACBpzkFrT0QFC5ljNUKwa9BcWYa4YMY8EK44rthO78ts5Z3X2RjaSDJ
         dp75l6GnQFKUNAT+cRV5nwVetxQp9IkPCmy9RERwCp45BeMQXUd973kGFBT0bSppg6yM
         v2JP9QSfYCjyZ9yu2UwKZCc5oFvVYCuZZTrEkWnOvnVLeHy660qvaqZeQyx5gVAYRR4U
         qKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297081; x=1792901881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W1fR27jZsvFiCA94aCBJQ8L314nFGlM3MWJ349fYKEk=;
        b=baNW3ErSsGwuSYc9ULO092+hz++e9ceYmBlmO372MsLivACauw5IKz5FjR5OOqZ+V5
         JEhjKrzbE8GgJ8QvDmijwvdiKdnvOF/nDT1v69vb1mXDg/hGQ5/rH8+EconHAXPgmWwm
         kimyB4Ti+eBp2HoVD1PWIuM7ZCNW9799zgLVp06u5cjha4B4B4CY5EJc8PW/q3YbMaVH
         9f0OGyVKcvHuxG2NGPCNxLCoMXATmk9Rm3/8VY6k11vJjtLmmhrcBG2Hu5ldbm/yEMK5
         oXa3eRrKMHHsXIAxSa7Otr/y33cj+NIvefXrONsRLALrV/D6whvGIITcSy6WEXN7PHQF
         kk9A==
X-Gm-Message-State: AFq9FYIHy9iT2m+rCfTM8qdAu5GoAppryXRRvU1pFyAsz6g1WUoQhzP9
	b4iASiR8WfZ7nAlJ/hcY4F652B4NmSpsxe1AUC2JwfJJjwPWcwKwVw/d5Udgzw==
X-Gm-Gg: AYBFou0/n1tfMF26B5421aAOpnhi+OlhLDNk6xda4UxBOrXiDWBHm8NdyPqac/cjLND
	GW9Ght9XrRkQE+4HgXE/mAIdN1B1MyTo1cuHY+YmkL/RMItPGVY/hH+VYhC0oTbfmZMyjdmVKIE
	FkDDOfDjmg7i0O4wekLd41PeNi0nhFRWYR13MKJyWkTlBILxJyRbyMxOQ/w45D5hbRMVWtZP/bN
	Mt2GL17IQX26VnnQP0uNkjfO5xytnDu4aQf1kyd1VgsZ/aDHDRyNaCPGIa+SpWWZqgI2UiBYS2W
	x1jhtdGtfnxecH7NPIb4/mr7RCLw2h+M9RxjtzfsmgL1K07TeFtfFZXqYnpzh+/6guDt4lrI8PL
	W4TLcNCjVals4UoeCftIxJM22HFov/1Ijy9YK1evsJJEXAYRyNhwDre+lSrorR3CNThm0MQ9+eL
	emE88wnKj0ZcUbif2pPFXBYKX0m9kCEWgt0m2PXoCi1ivrEsQUAs9YNEvJumTcaAL+iG/JEYEqx
	uq7nQkrEAwnZ+QzDdMmOi4zFQR0hKrMG3zwwuInpqzL5Hm9dPCvyFqdZte0lRQr4FA4umz6WzQL
	kRK2dzL5Mf2XjIsOda4cbntGhdDvIpHftgYiSsrw59g=
X-Received: by 2002:a05:701b:2902:b0:143:271a:3df2 with SMTP id a92af1059eb24-1851481eb23mr5750274c88.44.1792297081216;
        Sat, 17 Oct 2026 21:18:01 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fdfesm17867932c88.7.2026.10.17.21.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:18:00 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v6 4/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Sun, 18 Oct 2026 04:17:46 +0000
Message-Id: <20261018041748.1655711-5-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the in-kernel PM, a subflow closed after an error, e.g. a timeout
when a path silently drops packets, is never re-created, even once the
path works again. For example, with a main link and a backup link,
connections move to the backup after an outage but never come back.

When TCP closes an established subflow created by this side after an
error, the PM now creates a new one with the same addresses. Its SYN
retries, set like TCP_SYNCNT by the subflow-retries limit, space out the
attempts. If this new subflow cannot connect, it is not retried again,
and it is closed if the MPTCP socket is closed in the meantime. Once it
is established, it is handled like any other subflow. Re-creating the
initial subflow uses one of the additional subflows allowed by the
limits.

A subflow that never got established is not re-created: the PM keeps
trying the next endpoints, as before. Subflows reset by the peer with an
MP_RST without the transient flag (RFC 8684 section 3.6), aborted
locally, or using an address that has been removed are not retried
either.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440
Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v6 (netdev Sashiko):
     - only re-create subflows that were established: the PM still tries the
       next endpoints when one never gets established
     - only once TCP closed the subflow, to read its reset flags safely
     - removed addresses, also the remote ones and the local ID 0: the dead
       subflows are marked in mptcp_pm_rm_addr_or_subflow(), instead of
       looking up the endpoint
    v5 (Matthieu):
     - split in 4 patches
     - reverse xmas tree in mptcp_pm_kernel_retry_check()
     - "in-kernel" in the subject, like the other in-kernel PM patches
     - close the re-created subflows still connecting when the socket is
       closed (Matthieu: closing the socket during a retry)
    v4 (Matthieu):
     - netlink limit, on by default, instead of the sysctl
     - one new subflow per failure, its SYN retries set from the limit: no
       socket reuse, no attempts counter, no 60s check
     - no MIB counter
     - not retried if the endpoint was removed, instead of the pm.c change
     - called through pm.c
     - new bit in the subflow context, no new hole
     - commit message: MP_RST, not any RST (Sashiko)
    v3 (Sashiko):
     - no retry after MP_RST without the T flag, local abort or EBADMSG
     - no retry on a removed endpoint or address
     - use only request_bkup for the backup flag
    v2:
     - use the subflow sockets, no list or timer
     - code moved to pm_kernel.c

 net/mptcp/pm.c        |  39 ++++++++++++++++
 net/mptcp/pm_kernel.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c  |  23 ++++++++++
 net/mptcp/protocol.h  |  19 ++++++++
 4 files changed, 181 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d7c5b50b34cc..54d94bc72963 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -694,6 +694,26 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
+/* Called with the msk socket lock held, before closing a subflow: true if
+ * it has to be re-created once closed, see mptcp_pm_subflow_retry().
+ */
+bool mptcp_pm_subflow_retry_check(struct mptcp_sock *msk,
+				  const struct mptcp_subflow_context *subflow,
+				  struct mptcp_pm_retry *retry)
+{
+	if (!mptcp_pm_is_kernel(msk))
+		return false;
+
+	return mptcp_pm_kernel_retry_check(msk, subflow, retry);
+}
+
+void mptcp_pm_subflow_retry(struct mptcp_sock *msk,
+			    const struct mptcp_pm_retry *retry)
+{
+	if (mptcp_pm_is_kernel(msk))
+		mptcp_pm_kernel_retry(msk, retry);
+}
+
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr)
 {
@@ -762,6 +782,24 @@ static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
 }
 
+/* A subflow closed by TCP but not collected yet must not be re-created with
+ * a removed address, see mptcp_pm_kernel_retry_check().
+ */
+static void mptcp_pm_rm_no_retry(struct mptcp_subflow_context *subflow,
+				 enum linux_mptcp_mib_field rm_type, u8 rm_id)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	u8 id;
+
+	if (rm_type == MPTCP_MIB_RMADDR)
+		id = READ_ONCE(subflow->remote_id);
+	else
+		id = subflow_get_local_id(subflow);
+
+	if (id == rm_id && inet_sk_state_load(ssk) == TCP_CLOSE)
+		subflow->no_retry = 1;
+}
+
 static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 					const struct mptcp_rm_list *rm_list,
 					enum linux_mptcp_mib_field rm_type)
@@ -794,6 +832,7 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
+			mptcp_pm_rm_no_retry(subflow, rm_type, rm_id);
 			if ((1 << inet_sk_state_load(ssk)) &
 			    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING | TCPF_CLOSE))
 				continue;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 0379e1495cf4..e88c236b62e9 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1610,6 +1610,106 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
+/* Called with the msk socket lock held, before the subflow is closed */
+bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow,
+				 struct mptcp_pm_retry *retry)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	struct sock *sk = (struct sock *)msk;
+	int err;
+
+	/* Only once TCP closed it: the acquire in inet_sk_state_load() makes
+	 * sure the reset flags checked below are the ones of this close.
+	 */
+	if (inet_sk_state_load(ssk) != TCP_CLOSE)
+		return false;
+
+	err = READ_ONCE(ssk->sk_err);
+	retry->syn_retries = mptcp_pm_get_limit_subflow_retries(msk);
+	if (!retry->syn_retries || !err || sk->sk_state != TCP_ESTABLISHED ||
+	    __mptcp_check_fallback(msk))
+		return false;
+
+	/* mptcp_close_ssk() will not handle it again, e.g. the initial
+	 * subflow, kept in the list once closed
+	 */
+	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
+		return false;
+
+	/* Only a path that worked is tried again. If a subflow never got
+	 * established, the PM moves on to the next endpoints instead, and a
+	 * re-created subflow that cannot connect is not retried again: its SYN
+	 * retransmissions already spaced out the tries.
+	 */
+	if (!READ_ONCE(subflow->fully_established))
+		return false;
+
+	/* its address has been removed, see mptcp_pm_rm_addr_or_subflow() */
+	if (subflow->no_retry)
+		return false;
+
+	/* The peer asked not to use this path again (MP_RST without the T
+	 * flag), the subflow has been aborted locally, or it hit an MPTCP
+	 * protocol error.
+	 */
+	if ((subflow->reset_seen && !subflow->reset_transient) ||
+	    err == ECONNABORTED || err == EBADMSG)
+		return false;
+
+	/* Only re-create subflows initiated by this side: MP_JOIN ones, or the
+	 * initial one on the client side.
+	 */
+	if (!subflow->request_join &&
+	    (subflow->mp_join || READ_ONCE(msk->pm.server_side)))
+		return false;
+
+	mptcp_remote_address((struct sock_common *)ssk, &retry->remote);
+	retry->remote.id = READ_ONCE(subflow->remote_id);
+	if (!retry->remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
+		return false;
+
+	mptcp_local_address((struct sock_common *)ssk, &retry->local.addr);
+	retry->local.addr.port = 0;
+	retry->local.addr.id = subflow_get_local_id(subflow);
+	retry->local.flags = subflow->request_bkup ?
+			     MPTCP_PM_ADDR_FLAG_BACKUP : 0;
+	retry->local.ifindex = ssk->sk_bound_dev_if;
+
+	return true;
+}
+
+/* Called with the msk socket lock held, after the subflow has been closed */
+void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	struct sock *ssk;
+	bool allowed;
+
+	spin_lock_bh(&msk->pm.lock);
+	allowed = msk->pm.extra_subflows <
+		  mptcp_pm_get_limit_extra_subflows(msk);
+	if (allowed)
+		msk->pm.extra_subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
+	if (!allowed ||
+	    __mptcp_subflow_connect(sk, &retry->local, &retry->remote))
+		return;
+
+	/* the new subflow is the last one */
+	subflow = list_last_entry(&msk->conn_list, struct mptcp_subflow_context,
+				  node);
+	ssk = mptcp_subflow_tcp_sock(subflow);
+
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	WRITE_ONCE(inet_csk(ssk)->icsk_syn_retries, retry->syn_retries);
+	subflow->retry = 1;
+	release_sock(ssk);
+}
+
 /* Called under PM lock */
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60cbd91be632..354b80156bce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2816,6 +2816,8 @@ static void __mptcp_close_subflow(struct sock *sk)
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int ssk_state = inet_sk_state_load(ssk);
+		struct mptcp_pm_retry retry;
+		bool do_retry;
 
 		if (ssk_state != TCP_CLOSE &&
 		    (ssk_state != TCP_CLOSE_WAIT ||
@@ -2827,7 +2829,10 @@ static void __mptcp_close_subflow(struct sock *sk)
 		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
 			continue;
 
+		do_retry = mptcp_pm_subflow_retry_check(msk, subflow, &retry);
 		mptcp_close_ssk(sk, ssk, subflow);
+		if (do_retry)
+			mptcp_pm_subflow_retry(msk, &retry);
 	}
 
 }
@@ -3494,6 +3499,22 @@ static void mptcp_check_listen_stop(struct sock *sk)
 	release_sock(ssk);
 }
 
+/* Re-created subflows still connecting are useless once the msk is closed,
+ * and their SYN retransmissions could keep them around for a long time.
+ */
+static void mptcp_close_retry_subflows(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (subflow->retry && inet_sk_state_load(ssk) == TCP_SYN_SENT)
+			mptcp_close_ssk(sk, ssk, subflow);
+	}
+}
+
 bool __mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
@@ -3520,6 +3541,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_wr_shutdown(sk);
 	}
 
+	mptcp_close_retry_subflows(sk);
+
 	sk_stream_wait_close(sk, timeout);
 
 cleanup:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6d571328aca9..0dc591d92fdc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -621,6 +621,8 @@ struct mptcp_subflow_context {
 	u8	reset_seen:1;
 	u8	reset_transient:1;
 	u8	reset_reason:4;
+	u8	retry:1;	    /* re-created after an error */
+	u8	no_retry:1;	    /* closed, with a removed address */
 	u8	stale_count;	    /* Protected by the msk socket lock */
 	u8	stale;		    /* Protected by the msk socket lock,
 				     * if set the subflow is unable to snd/rcv
@@ -1137,6 +1139,18 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 				 const struct mptcp_subflow_context *subflow);
+
+struct mptcp_pm_retry {
+	struct mptcp_pm_local	local;
+	struct mptcp_addr_info	remote;
+	u8			syn_retries;
+};
+
+bool mptcp_pm_subflow_retry_check(struct mptcp_sock *msk,
+				  const struct mptcp_subflow_context *subflow,
+				  struct mptcp_pm_retry *retry);
+void mptcp_pm_subflow_retry(struct mptcp_sock *msk,
+			    const struct mptcp_pm_retry *retry);
 void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
@@ -1258,6 +1272,11 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
+bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow,
+				 struct mptcp_pm_retry *retry);
+void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
-- 
2.25.1

