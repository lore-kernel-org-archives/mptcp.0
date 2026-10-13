Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDF3A6B66
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860225; cv=none; b=ad2hO77i450WrSQkPTMJcsePiiwgZU4i8dEkIPPvBK3/eZoBKIu+6HzlbPyy4/a3l9YTWoK+sKbOrwv2wmqeWmVy/1ypWKDHD0x+QP/LO6ze+rGF+ETmg5B+mh6hf2VqRWvvqWMWt9eR7POE1S4nLNn4zEQkLmuzY4xO436/zEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860225; c=relaxed/simple;
	bh=3R/PEtJof5wwXH+7+xPtWh52slNIutpzDKwa/6eEo8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzsrD6Ov1TsDiseJz0TenVjTWprlav4KpxBsgzGNcr81UtPdbj2MtwD32okZ7wOjQJeM0B291XiyyQVo0b2yM5Ex/76Y3H9fZJb7kDmxRYnufIvSup3qR9CXZJ0Ja8qY0spqV/e/s4WHGMwuPro/3abifBVupqjH2SlVal+YYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsEEetcn; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsEEetcn"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3535a54bed9so3444646eec.1
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 19:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791860222; x=1792465022; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9ur/WO6VcmMZ07b7ZWh5OIqL4vN340yJoS+Z+wYuuE=;
        b=CsEEetcnlBY9YXnAcTM+y4S7MWGYUWxIzb3b3IeMJOe57qtSkr61u2g5iiWc961FYg
         EvYzTPqC3Hxe/AlXf6Snm2ewwLeuPF7j2w8D9UGEabA5xTAuq88exDtrnln+8REwhT3r
         rJ5kkPBzK9gVmShloOiWP8Fud1SbbUpElXUI2V1m8N8o/vyg93fO7sNO2M2edgBQ8jij
         wcxJNm2C2S/z1XwP+/NStFeERIX8iHeXbP/nIjUsy1HL9H3I5mMmtfAe0xOl9BUvVes3
         yI22j4sSeWti7smTizpl1EVhz8sVcXOenyJcp+1O9OsDREiFGiy3wIwfi/0LRnHwqiaH
         ntrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860222; x=1792465022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g9ur/WO6VcmMZ07b7ZWh5OIqL4vN340yJoS+Z+wYuuE=;
        b=rlFlJESAFClDpY7mRozrN5vwMvunISqTbKGctgMgux+yN0Uic98Sn7XOoNt8e5ul89
         j682sPbjm3evc92J+0xcmYFO8D1Au3aqpgtU7HCJ9IlQhhV3iRrA7XhZwZ1mLPTE+LYY
         ItuB19L57pd6WNpkRYjurHGkCAXMzEZU7YutY+WJ1IcNuvey7I729EdnGTV6jUfOPVD6
         7DVZN6OaFfdvNggXUW/GSDvn3iXINk2oSzEWDNttcUxGUqPWSAz5hMkSLP1yxP0nE1lg
         ko+JvTSZkrQckASGIFuHT4VglgvPhBqfKhLjPAytbck2/Z05sgD3JRorBg2drPiwGSIZ
         5uiw==
X-Gm-Message-State: AFq9FYIJermYVL1sAWYMhdiZAaplQViOd/CAy/Fns40Lq7Ar0KrustTa
	YLGr8/DCgO5qutFpQT5n8z2CmoTvG16w7iP22h0gpRHVxA4WkUhXpYVYnptdmQ==
X-Gm-Gg: AYBFou16aW78BVQOj7G5D2Na6nXxj8fvVMbcdJ/cBFaMLtRON6wMMSFTKXVrKSFyB9U
	SoWaOwO90jzS3w1kzZh9QV91ra2X7AkF0sQa5xOcvu34a8BRtrtYRXLxyWbC5H3Aanj/XpaKnqZ
	AyezZV5voC2y9bteziazUZfkzH4QZaepdSQ2u78qOIpiEgE+26YbcfMcKuQyxGbxOy5dGumbxEO
	LXELnLeNSYs+aO7Xas/JKdnF+/wzQ0u8HIJCDM/agb3VvbhkIpR3oxLIBQlPdJ1KgB0BJ2QdEkP
	0z9XU8kzBl33f4Iv0RhDS657sZy9lF2BognPIMz04WoJ99X2knsQCoEndUGwbk8PIcHUMV5PEhH
	inr82FwZ7Ug/Jq4swofzuYoO74qlOaDSd31Owy4eHIFYfRO2z/pX+JvCsdnr18yzzoPK3+kzpGz
	4Jn9FarSDAmidolruiRt/Yt5V7wWpA7LrKPQ4yXNrQa0iJgfR4FpT862YqrdzG/h7tIj5fZT2gt
	1ND9cgALM29qM/qzn9hTcPKTUWV0mPqt6uB/C4o6YWvBiJXGnorUw873Urmh2yHJ7euCGyUgSmg
	IG+yvdVAIgc/5646Sxw89uGXa8ajjraQT9Nak6PyigG+
X-Received: by 2002:a05:7301:4d0b:b0:351:18a6:c337 with SMTP id 5a478bee46e88-3537ddf9247mr15891180eec.2.1791860222125;
        Mon, 12 Oct 2026 19:57:02 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2954bsm39890217eec.26.2026.10.12.19.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:57:01 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next v2 2/3] mptcp: pm: kernel: retry subflows closed after an error
Date: Tue, 13 Oct 2026 02:56:52 +0000
Message-Id: <20261013025653.523755-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013025653.523755-1-anilkaushikwireless@gmail.com>
References: <20261013025653.523755-1-anilkaushikwireless@gmail.com>
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

Add an opt-in sysctl, net.mptcp.subflow_retries (0 by default): the
maximum number of attempts to re-create such a subflow. When TCP closes
a subflow created by this side after an error, the PM creates a new one
with the same addresses right away. Its SYN retransmissions space out
the attempts, so no extra state or timer is needed. If it cannot
connect, the same socket is used for the next attempt. The number of
attempts is kept in the subflow context, and counted from scratch once
a re-created subflow is established. A subflow the peer refused is not
retried.

A new counter, SubflowRetry, counts the attempts.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440
Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst |  15 +++
 net/mptcp/ctrl.c                          |  13 +++
 net/mptcp/mib.c                           |   1 +
 net/mptcp/mib.h                           |   1 +
 net/mptcp/pm_kernel.c                     | 116 ++++++++++++++++++++++
 net/mptcp/protocol.c                      |   9 ++
 net/mptcp/protocol.h                      |  20 ++++
 net/mptcp/subflow.c                       |  53 ++++++++++
 8 files changed, 228 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index b9b5f58e0625..490ed4a20ce7 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -149,6 +149,21 @@ stale_loss_cnt - INTEGER
 
 	Default: 4
 
+subflow_retries - INTEGER
+	Maximum number of attempts to re-create a subflow closed by TCP after
+	an error, e.g. a timeout or an unreachable path, while the MPTCP
+	connection is still established. The in-kernel path manager creates a
+	new subflow with the same local and remote addresses: its SYN
+	retransmissions, see tcp_syn_retries, space out the attempts. If it
+	cannot connect, the same socket is used for the next attempt. The
+	count starts again once a re-created subflow is established. Only
+	subflows initiated by this side are re-created, within the limits set
+	for the path manager. A subflow refused by the peer is not retried.
+
+	0 disables the retries. This is a per-namespace sysctl.
+
+	Default: 0
+
 syn_retrans_before_tcp_fallback - INTEGER
 	The number of SYN + MP_CAPABLE retransmissions before falling back to
 	TCP, i.e. dropping the MPTCP options. In other words, if all the packets
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 63c5747f0f63..37d96f89c4b1 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -34,6 +34,7 @@ struct mptcp_pernet {
 	atomic_t active_disable_times;
 	unsigned long active_disable_stamp;
 	u8 syn_retrans_before_tcp_fallback;
+	u8 subflow_retries;
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
@@ -73,6 +74,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
 	return mptcp_get_pernet(net)->stale_loss_cnt;
 }
 
+u8 mptcp_subflow_retries(const struct net *net)
+{
+	return READ_ONCE(mptcp_get_pernet(net)->subflow_retries);
+}
+
 unsigned int mptcp_close_timeout(const struct sock *sk)
 {
 	if (sock_flag(sk, SOCK_DEAD))
@@ -377,6 +383,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.extra1       = SYSCTL_ZERO,
 		.extra2       = SYSCTL_ONE
 	},
+	{
+		.procname = "subflow_retries",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -405,6 +417,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[11].data = &pernet->path_manager;
 	/* table[12] is for available_path_managers which is read-only info */
 	table[13].data = &pernet->add_addr_v6_port_drop_ts;
+	table[14].data = &pernet->subflow_retries;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb568897c..5263ac6f2c43 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -95,6 +95,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
+	SNMP_MIB_ITEM("SubflowRetry", MPTCP_MIB_SUBFLOWRETRY),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9534..1359839f4bbe 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -98,6 +98,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
 	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
+	MPTCP_MIB_SUBFLOWRETRY,		/* Retried a subflow closed on error */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..c9199727c88c 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1591,6 +1591,122 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	return true;
 }
 
+static bool mptcp_pm_retry_path_error(int err)
+{
+	switch (err) {
+	case ETIMEDOUT:
+	case EHOSTUNREACH:
+	case ENETUNREACH:
+	case EHOSTDOWN:
+	case ENETDOWN:
+		return true;
+	}
+
+	return false;
+}
+
+/* A subflow initiated by this side and closed by TCP after an error can be
+ * re-created with the same addresses, see the 'subflow_retries' sysctl. The
+ * SYN retransmissions of the new subflow space out the attempts. Called with
+ * the msk socket lock held, before the subflow is closed.
+ */
+bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow,
+				 struct mptcp_pm_retry *retry)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	bool established = READ_ONCE(subflow->fully_established);
+	struct sock *sk = (struct sock *)msk;
+	int err = READ_ONCE(ssk->sk_err);
+
+	if (!mptcp_pm_is_kernel(msk) || !err ||
+	    sk->sk_state != TCP_ESTABLISHED || __mptcp_check_fallback(msk))
+		return false;
+
+	/* mptcp_close_ssk() will not handle it again, e.g. the initial
+	 * subflow, kept in the list once closed
+	 */
+	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
+		return false;
+
+	/* A subflow that never got established is retried only after network
+	 * errors: if the peer rejected it, trying again will not help.
+	 */
+	if (!established && !mptcp_pm_retry_path_error(err))
+		return false;
+
+	/* Only re-create subflows initiated by this side: MP_JOIN ones, or the
+	 * initial one on the client side.
+	 */
+	if (!subflow->request_join &&
+	    (subflow->mp_join || READ_ONCE(msk->pm.server_side)))
+		return false;
+
+	/* the path worked for a while: count the attempts from scratch */
+	retry->retries = established ? 0 : subflow->retries;
+	/* a failed attempt is retried with the same socket */
+	retry->reuse = !established && subflow->retries;
+	if (retry->retries >= mptcp_subflow_retries(sock_net(sk)))
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
+	retry->local.flags = subflow->request_bkup || subflow->backup ?
+			     MPTCP_PM_ADDR_FLAG_BACKUP : 0;
+	retry->local.ifindex = ssk->sk_bound_dev_if;
+
+	return true;
+}
+
+/* Called with the msk socket lock held, instead of closing the subflow */
+bool mptcp_pm_kernel_retry_reconnect(struct mptcp_sock *msk, struct sock *ssk,
+				     const struct mptcp_pm_retry *retry)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = (struct sock *)msk;
+
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
+	if (mptcp_subflow_reconnect(sk, ssk, &retry->local, &retry->remote))
+		return false;
+
+	/* the reset cleared it */
+	subflow->retries = retry->retries + 1;
+	return true;
+}
+
+/* Called with the msk socket lock held, after the subflow has been closed */
+void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool allowed;
+
+	spin_lock_bh(&msk->pm.lock);
+	allowed = msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk);
+	if (allowed)
+		msk->pm.extra_subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
+	if (!allowed)
+		return;
+
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
+	if (__mptcp_subflow_connect(sk, &retry->local, &retry->remote))
+		return;
+
+	/* the new subflow is the last one: it carries the number of attempts */
+	subflow = list_last_entry(&msk->conn_list, struct mptcp_subflow_context,
+				  node);
+	subflow->retries = retry->retries + 1;
+}
+
 /* Called under PM lock */
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60cbd91be632..f29cfd2ad69b 100644
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
@@ -2827,7 +2829,14 @@ static void __mptcp_close_subflow(struct sock *sk)
 		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
 			continue;
 
+		do_retry = mptcp_pm_kernel_retry_check(msk, subflow, &retry);
+		if (do_retry && retry.reuse &&
+		    mptcp_pm_kernel_retry_reconnect(msk, ssk, &retry))
+			continue;
+
 		mptcp_close_ssk(sk, ssk, subflow);
+		if (do_retry && !retry.reuse)
+			mptcp_pm_kernel_retry(msk, &retry);
 	}
 
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ed2f363bb915..5a7a33e4ade8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -622,6 +622,7 @@ struct mptcp_subflow_context {
 	u8	reset_transient:1;
 	u8	reset_reason:4;
 	u8	stale_count;	    /* Protected by the msk socket lock */
+	u8	retries;	    /* re-creation attempts, msk socket lock */
 	u8	stale;		    /* Protected by the msk socket lock,
 				     * if set the subflow is unable to snd/rcv
 				     * data, the schedule should skip it
@@ -818,6 +819,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
+u8 mptcp_subflow_retries(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_path_manager(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
@@ -859,6 +861,9 @@ void mptcp_remote_address(const struct sock_common *skc,
 			  struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
+int mptcp_subflow_reconnect(struct sock *sk, struct sock *ssk,
+			    const struct mptcp_pm_local *local,
+			    const struct mptcp_addr_info *remote);
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
@@ -1258,6 +1263,21 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
+
+struct mptcp_pm_retry {
+	struct mptcp_pm_local	local;
+	struct mptcp_addr_info	remote;
+	u8			retries;
+	bool			reuse;	/* failed attempt: same socket */
+};
+
+bool mptcp_pm_kernel_retry_check(struct mptcp_sock *msk,
+				 const struct mptcp_subflow_context *subflow,
+				 struct mptcp_pm_retry *retry);
+void mptcp_pm_kernel_retry(struct mptcp_sock *msk,
+			   const struct mptcp_pm_retry *retry);
+bool mptcp_pm_kernel_retry_reconnect(struct mptcp_sock *msk, struct sock *ssk,
+				     const struct mptcp_pm_retry *retry);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b20258..0f1d3fae446e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1766,6 +1766,59 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	return err;
 }
 
+/* Connect again an MPJ subflow that failed to connect, with the same socket.
+ * The subflow never carried data: like for the initial subflow in
+ * __mptcp_subflow_disconnect(), resetting the TCP and the subflow states is
+ * enough. Called with the msk socket lock held.
+ */
+int mptcp_subflow_reconnect(struct sock *sk, struct sock *ssk,
+			    const struct mptcp_pm_local *local,
+			    const struct mptcp_addr_info *remote)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sockaddr_storage addr;
+	u32 remote_token;
+	int addrlen;
+	int err;
+
+	lock_sock(ssk);
+	err = tcp_disconnect(ssk, 0);
+	if (err)
+		goto out;
+
+	mptcp_subflow_ctx_reset(subflow);
+	subflow->request_mptcp = 0;
+	do {
+		subflow->local_nonce = get_random_u32();
+	} while (!subflow->local_nonce);
+	subflow_set_local_id(subflow, local->addr.id);
+	subflow->remote_key_valid = 1;
+	subflow->remote_key = READ_ONCE(msk->remote_key);
+	subflow->local_key = READ_ONCE(msk->local_key);
+	subflow->token = msk->token;
+	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
+	subflow->remote_token = remote_token;
+	WRITE_ONCE(subflow->remote_id, remote->id);
+	subflow->request_join = 1;
+	subflow->request_bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	subflow->subflow_id = msk->subflow_id++;
+
+	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
+	addrlen = sizeof(struct sockaddr_in);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (addr.ss_family == AF_INET6)
+		addrlen = sizeof(struct sockaddr_in6);
+#endif
+	err = ssk->sk_prot->connect(ssk, (struct sockaddr_unsized *)&addr, addrlen);
+
+out:
+	release_sock(ssk);
+	if (!err)
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTX);
+	return err;
+}
+
 void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t gfp)
 {
 	/* Only if the msk has been accepted already (and not orphaned).*/
-- 
2.25.1

