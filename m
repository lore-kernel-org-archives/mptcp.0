Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A93E44ED
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825474; cv=none; b=JZnjC5zjxFLt1xu4+YPXvw5ImuYcOQl2D33sh/Ci9nenDph4xGkgKw7qZn2aIKRKoqJfEHoZ7gX+ujioRw2d9pAy9ACnT9Qw8f+OYX8ajmZ5Tko6jGofXGxXvVRRX071Y3jam1RP15Gif1MiNlnlAQRfeuqlsscCWCKry4GLOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825474; c=relaxed/simple;
	bh=oMEugjnCeKQdbA789sG8VYFKjJhjGibxH8Z9r1/UtoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFx1adeJ/wGxNjMRp28Q4eB2B5x4HRa6fnL/BLTNS/prl/UWyTPPmQfjp/Pldmuzglrw9bNi87XJPiYs69yN3xktqWaXszCymFZQKJ6G7BTQ/uUOeXNOhoOyhu+cBoN9EuRMkGpDGB8uN13BRBYuDYb5PhOF0sMf0UJ3UTD6DCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/7z4gOi; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/7z4gOi"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-141395927feso3787584c88.0
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791825471; x=1792430271; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q9uphTUzKlJIO8ykom0EuQluYfwCoBGzPXgWkonl8YM=;
        b=s/7z4gOioDHIDSSEhwbuKe+M3MkvJXej5aVLgYDzTu6FJn8CUzEssBr7aLggb08TGA
         uKb1xTPQAzYR8gv9meWGmghBM/G/37UpQm3jyPIt+kaLB7C7AEyRPwFIO6TUJYJFYYL0
         eUe7URUgnSDyKELDIZxURCCW8ZxA0kWnabNq71AvrnPxTuhOWiOPHw4Y67yZW1d6F7Zt
         GzP+yFyNj1zMygUphTr+M3fY32FP7fzTkDP8KeXeBh+UepSDbuLTsX/M561/wzCv0O9M
         5ca+gd7f7FTdky/l5FCb6VbuJoauggK1n6WGp7/Ena+gJ4V/+kPLD+lLE33xbfVIoC0n
         rlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791825471; x=1792430271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q9uphTUzKlJIO8ykom0EuQluYfwCoBGzPXgWkonl8YM=;
        b=zQ6MQDJObzAXbml0qjC7zZooC6XG+3ZURFo9R2+nfx0AzCs/cJpZVoulCZQUckOh0V
         2znKMGmQa/mMhv9GcD7Zrj0QMjQPrC0pvmQ27WaCwAVJ/PKpowQ+f+bHa9MQzlzpGN7f
         zLv+EiIXpM+9iv3DTRxnmjp5JQkPwoHN+Br7yUE8G4LFEuiMdpVYJIJ9xA0WekSjkQ8u
         zsafB9U24zZjIInpwGgTVFo5MhzJuf/CuSiWg1W5BowliT08hqPflSCEzIU1vjgJSdzR
         D/+AXgQ1/tzxnd23bvmVyGjwVFHj80f15hVMts+WCUrWuRVcGJDdBrmdlfsdqz5mzGis
         FCUA==
X-Gm-Message-State: AFq9FYK1cQtFPauUnUX9DxUrbDU7fbClycX26JdBRnVa2n9ChAfuNee+
	CEzyECamRQENFikjiJapGNEr6mAY4qU3xgzNKOWdupxYR6ahZ7SiY+IrXhDCEg==
X-Gm-Gg: AYBFou14tqem/zBV+c5mJBVRVt1e23HHPl5p4KVIpYiuOYe7NWFWog8RkhOKG98nNSi
	9PjH1jmrw9g4D7szLziSj6MEiwkUheLx95hLZNx26bl1GliUs/5Gncav4afhisriq4bfAgKOvUn
	QVrEQev0kJe2ncxLUgIu3Jq7MX4E/3aS/7q8XFgqrHJG9UrThn7AyMhbebtQrkMub3EkIzqBLg9
	ktVOxHU+pAG2CW2p2sWb+jI722jwZMXYHZ4Ko88aLY0YcQFWVcSSyaM59Jqvu+HzPayUPTeTiCd
	Zqfkzo602SXuhbsRFYJRBnu5EouRM9KeWiGz8ET6dV4a5QT7TPzlFmm3uD2xONP8xpgWQAHoOVn
	R45akbaEABbBEf2/EGDHtqJMNK4v01uptq2k9Yf1YfBxFuuH8lwR03HZuNIg5TRP/vWWRV83Mo8
	9rrCJSDJpwh0Ac246v6PbaYy4BoULRkC2IZT7cnyzOmjtuPdII9MPBHrDGY2qv7IQTWjLWfdxBI
	GcHKtWKIZ/tr7YotOLbkApF/IvKJ4bw3Y0WsNTY0zwo5yIoGPLgKn2jNRE5hXUUN5fwh73YGn66
	X0b6FvQsZU0tL6slXI2Vwo9jx3EsqXVongg7fkxaAKQ=
X-Received: by 2002:a05:701b:454b:20b0:144:f096:4dda with SMTP id a92af1059eb24-16a6203de6dmr13456367c88.43.1791825470801;
        Mon, 12 Oct 2026 10:17:50 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm34978099eec.30.2026.10.12.10.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:17:49 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next 2/3] mptcp: pm: kernel: retry subflows closed after an error
Date: Mon, 12 Oct 2026 17:17:39 +0000
Message-Id: <20261012171740.464517-3-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
References: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
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

Add an opt-in sysctl, net.mptcp.subflow_retry_timeout (0 by default).
When set, the PM tries to re-create such subflows with the same
addresses: first after 1 second, then doubling the wait after each
failure, up to the sysctl value. Only subflows created by this side are
retried. Retries stop when the endpoint or the peer's address is
removed. A subflow the peer refused is not retried.

A new counter, SubflowRetry, counts the attempts.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/440
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst |  15 ++
 net/mptcp/ctrl.c                          |  13 ++
 net/mptcp/mib.c                           |   1 +
 net/mptcp/mib.h                           |   1 +
 net/mptcp/pm.c                            | 272 ++++++++++++++++++++++
 net/mptcp/pm_kernel.c                     |   3 +
 net/mptcp/protocol.h                      |   5 +
 7 files changed, 310 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index b9b5f58e0625..5144319923f5 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -149,6 +149,21 @@ stale_loss_cnt - INTEGER
 
 	Default: 4
 
+subflow_retry_timeout - INTEGER (seconds)
+	Maximum interval between two attempts to re-create a subflow closed
+	after an error, e.g. a timeout or an unreachable path, while the MPTCP
+	connection is still established. When set, the in-kernel path manager
+	tries again to create such subflows, using the same local and remote
+	addresses, one second after the closure, then doubling the interval
+	after each failed attempt, up to this value. Only subflows initiated
+	by this side are re-created, within the limits set for the path
+	manager. Attempts stop when the corresponding endpoint is removed, or
+	when the peer removes the corresponding address.
+
+	0 disables the retries. This is a per-namespace sysctl.
+
+	Default: 0
+
 syn_retrans_before_tcp_fallback - INTEGER
 	The number of SYN + MP_CAPABLE retransmissions before falling back to
 	TCP, i.e. dropping the MPTCP options. In other words, if all the packets
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 63c5747f0f63..f90850f06794 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -31,6 +31,7 @@ struct mptcp_pernet {
 	unsigned int blackhole_timeout;
 	unsigned int close_timeout;
 	unsigned int stale_loss_cnt;
+	unsigned int subflow_retry_timeout;
 	atomic_t active_disable_times;
 	unsigned long active_disable_stamp;
 	u8 syn_retrans_before_tcp_fallback;
@@ -73,6 +74,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
 	return mptcp_get_pernet(net)->stale_loss_cnt;
 }
 
+unsigned int mptcp_subflow_retry_timeout(const struct net *net)
+{
+	return READ_ONCE(mptcp_get_pernet(net)->subflow_retry_timeout);
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
+		.procname = "subflow_retry_timeout",
+		.maxlen = sizeof(unsigned int),
+		.mode = 0644,
+		.proc_handler = proc_dointvec_jiffies,
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -405,6 +417,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[11].data = &pernet->path_manager;
 	/* table[12] is for available_path_managers which is read-only info */
 	table[13].data = &pernet->add_addr_v6_port_drop_ts;
+	table[14].data = &pernet->subflow_retry_timeout;
 
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
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d7c5b50b34cc..2683e359695c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -22,6 +22,20 @@ struct mptcp_pm_add_addr {
 	struct rcu_head		rcu;
 };
 
+struct mptcp_pm_retry {
+	struct list_head	list;
+	struct mptcp_pm_local	local;
+	struct mptcp_addr_info	remote;
+	u8			attempts;
+	bool			pending;	/* timer fired, worker not run yet */
+	bool			disabled;	/* local or remote address removed */
+	bool			timer_done;
+	struct timer_list	timer;
+	struct mptcp_sock	*sock;
+};
+
+#define MPTCP_PM_RETRY_MAX	8
+
 static DEFINE_SPINLOCK(mptcp_pm_list_lock);
 static LIST_HEAD(mptcp_pm_list);
 
@@ -261,6 +275,8 @@ static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
 }
 
 static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
+static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
+				   enum mptcp_pm_status new_status);
 static void
 mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
 				  const struct mptcp_rm_list *rm_list)
@@ -493,6 +509,250 @@ static void mptcp_pm_free_announced_list(struct mptcp_sock *msk)
 	}
 }
 
+/* Subflows closed after an error can be re-created later on, see the
+ * 'subflow_retry_timeout' sysctl. Entries are kept until the msk is destroyed
+ * to track the exponential backoff, and are disabled when the corresponding
+ * local endpoint or remote address is removed.
+ */
+static void mptcp_pm_retry_timer(struct timer_list *timer)
+{
+	struct mptcp_pm_retry *entry = timer_container_of(entry, timer, timer);
+	struct mptcp_sock *msk = entry->sock;
+	struct sock *sk = (struct sock *)msk;
+
+	pr_debug("msk=%p\n", msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	/* the timer might have been re-armed while this callback was waiting
+	 * for the PM lock: let the next expiration handle the entry.
+	 */
+	if (!timer_pending(&entry->timer)) {
+		if (!entry->disabled &&
+		    !(msk->pm.status & BIT(MPTCP_PM_DESTROYING))) {
+			entry->pending = true;
+			mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_RETRY);
+		}
+
+		/* if sock_put calls sk_free: avoid waiting for this timer */
+		entry->timer_done = true;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	sock_put(sk);
+}
+
+/* To be called while pm->lock is held */
+static void mptcp_pm_retry_arm(struct mptcp_sock *msk,
+			       struct mptcp_pm_retry *entry)
+{
+	unsigned long max = mptcp_subflow_retry_timeout(sock_net((struct sock *)msk));
+	unsigned long timeout = TCP_TIMEOUT_INIT << min_t(u8, entry->attempts, 16);
+
+	entry->pending = false;
+	entry->timer_done = false;
+	if (entry->attempts < U8_MAX)
+		entry->attempts++;
+
+	sk_reset_timer((struct sock *)msk, &entry->timer,
+		       jiffies + min(timeout, max));
+}
+
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
+static void mptcp_pm_retry_add(struct mptcp_sock *msk,
+			       const struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	bool established = READ_ONCE(subflow->fully_established);
+	struct mptcp_addr_info local, remote;
+	int err = READ_ONCE(ssk->sk_err);
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_retry *entry;
+	int nr = 0;
+
+	if (!err || !mptcp_subflow_retry_timeout(sock_net(sk)))
+		return;
+
+	/* A subflow that never got established is retried only after network
+	 * errors: if the peer rejected it, trying again will not help.
+	 */
+	if (!established && !mptcp_pm_retry_path_error(err))
+		return;
+
+	/* Only re-create subflows initiated by this side: MP_JOIN ones, or the
+	 * initial one on the client side.
+	 */
+	if (!subflow->request_join &&
+	    (subflow->mp_join || READ_ONCE(msk->pm.server_side)))
+		return;
+
+	if (sk->sk_state != TCP_ESTABLISHED || __mptcp_check_fallback(msk))
+		return;
+
+	mptcp_local_address((struct sock_common *)ssk, &local);
+	local.port = 0;
+	local.id = subflow_get_local_id(subflow);
+	mptcp_remote_address((struct sock_common *)ssk, &remote);
+	remote.id = READ_ONCE(subflow->remote_id);
+
+	if (!remote.id && READ_ONCE(msk->pm.remote_deny_join_id0))
+		return;
+
+	spin_lock_bh(&msk->pm.lock);
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING))
+		goto unlock;
+
+	list_for_each_entry(entry, &msk->pm.retry_list, list) {
+		if (mptcp_addresses_equal(&entry->local.addr, &local, false) &&
+		    mptcp_addresses_equal(&entry->remote, &remote, true))
+			goto found;
+		nr++;
+	}
+
+	if (nr >= MPTCP_PM_RETRY_MAX)
+		goto unlock;
+
+	entry = kzalloc_obj(*entry, GFP_ATOMIC);
+	if (!entry)
+		goto unlock;
+
+	entry->sock = msk;
+	timer_setup(&entry->timer, mptcp_pm_retry_timer, 0);
+	list_add_tail(&entry->list, &msk->pm.retry_list);
+
+found:
+	/* the path worked for a while: restart the backoff */
+	if (established)
+		entry->attempts = 0;
+
+	entry->local.addr = local;
+	entry->local.flags = subflow->request_bkup || subflow->backup ?
+			     MPTCP_PM_ADDR_FLAG_BACKUP : 0;
+	entry->local.ifindex = ssk->sk_bound_dev_if;
+	entry->remote = remote;
+	entry->disabled = false;
+
+	pr_debug("msk=%p local_id=%d remote_id=%d err=%d attempts=%u\n", msk,
+		 local.id, remote.id, err, entry->attempts);
+	mptcp_pm_retry_arm(msk, entry);
+
+unlock:
+	spin_unlock_bh(&msk->pm.lock);
+}
+
+static bool mptcp_pm_retry_has_subflow(const struct mptcp_sock *msk,
+				       const struct mptcp_pm_retry *entry)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_addr_info local, remote;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (!((1 << inet_sk_state_load(ssk)) &
+		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
+			continue;
+
+		mptcp_local_address((struct sock_common *)ssk, &local);
+		mptcp_remote_address((struct sock_common *)ssk, &remote);
+		if (mptcp_addresses_equal(&entry->local.addr, &local, false) &&
+		    mptcp_addresses_equal(&entry->remote, &remote, true))
+			return true;
+	}
+
+	return false;
+}
+
+/* Called under PM lock */
+static void mptcp_pm_retry_subflows(struct mptcp_sock *msk)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_retry *entry;
+
+	/* Entries are only freed at destroy time, and new ones are added at
+	 * the tail: it is safe to release the PM lock while iterating.
+	 */
+	list_for_each_entry(entry, &msk->pm.retry_list, list) {
+		struct mptcp_addr_info remote;
+		struct mptcp_pm_local local;
+
+		if (!entry->pending || entry->disabled)
+			continue;
+
+		entry->pending = false;
+		if (sk->sk_state != TCP_ESTABLISHED ||
+		    mptcp_pm_retry_has_subflow(msk, entry))
+			continue;
+
+		if (msk->pm.extra_subflows >= mptcp_pm_get_limit_extra_subflows(msk)) {
+			mptcp_pm_retry_arm(msk, entry);
+			continue;
+		}
+
+		msk->pm.extra_subflows++;
+		local = entry->local;
+		remote = entry->remote;
+
+		spin_unlock_bh(&msk->pm.lock);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWRETRY);
+		if (__mptcp_subflow_connect(sk, &local, &remote)) {
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_retry_arm(msk, entry);
+			continue;
+		}
+		spin_lock_bh(&msk->pm.lock);
+	}
+}
+
+/* To be called while pm->lock is held. A NULL local address and a negative
+ * remote ID disable all entries.
+ */
+void mptcp_pm_retry_disable(struct mptcp_sock *msk,
+			    const struct mptcp_addr_info *local, int remote_id)
+{
+	struct mptcp_pm_retry *entry;
+
+	list_for_each_entry(entry, &msk->pm.retry_list, list) {
+		if (local && !mptcp_addresses_equal(&entry->local.addr, local, false))
+			continue;
+		if (remote_id >= 0 && entry->remote.id != remote_id)
+			continue;
+
+		entry->disabled = true;
+		entry->pending = false;
+		sk_stop_timer((struct sock *)msk, &entry->timer);
+	}
+}
+
+static void mptcp_pm_free_retry_list(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_retry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
+	LIST_HEAD(free_list);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_splice_init(&msk->pm.retry_list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	list_for_each_entry_safe(entry, tmp, &free_list, list) {
+		if (!entry->timer_done)
+			sk_stop_timer_sync(sk, &entry->timer);
+		kfree(entry);
+	}
+}
+
 /* path manager command handlers */
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -667,6 +927,9 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	bool update_subflows;
 
 	update_subflows = subflow->request_join || subflow->mp_join;
+	if (mptcp_pm_is_kernel(msk))
+		mptcp_pm_retry_add(msk, subflow);
+
 	if (mptcp_pm_is_userspace(msk)) {
 		if (update_subflows) {
 			spin_lock_bh(&pm->lock);
@@ -788,6 +1051,9 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 		u8 rm_id = rm_list->ids[i];
 		bool removed = false;
 
+		if (rm_type == MPTCP_MIB_RMADDR)
+			mptcp_pm_retry_disable(msk, NULL, rm_id);
+
 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			u8 remote_id = READ_ONCE(subflow->remote_id);
@@ -1150,6 +1416,10 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_rm_addr_recv(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_SUBFLOW_RETRY)) {
+		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_RETRY);
+		mptcp_pm_retry_subflows(msk);
+	}
 	__mptcp_pm_kernel_worker(msk);
 
 	spin_unlock_bh(&msk->pm.lock);
@@ -1192,6 +1462,7 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_free_announced_list(msk);
+	mptcp_pm_free_retry_list(msk);
 
 	/* Free the userspace local address list unconditionally: the socket
 	 * can be reused (mptcp_disconnect()) and re-selected to a different PM
@@ -1222,6 +1493,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
 	spin_lock_init(&msk->pm.lock);
 	INIT_LIST_HEAD(&msk->pm.anno_list);
+	INIT_LIST_HEAD(&msk->pm.retry_list);
 	INIT_LIST_HEAD(&msk->pm.userspace_pm_local_addr_list);
 	mptcp_pm_data_reset(msk);
 }
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..e3dce702fad2 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1106,6 +1106,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 
 		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_retry_disable(msk, addr, -1);
 		if (remove_subflow)
 			mptcp_pm_rm_subflow(msk, &list);
 		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
@@ -1156,6 +1157,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		spin_lock_bh(&msk->pm.lock);
 		if (announced)
 			msk->pm.add_addr_signaled--;
+		mptcp_pm_retry_disable(msk, &msk_local, -1);
 		mptcp_pm_remove_addr(msk, &list);
 		mptcp_pm_rm_subflow(msk, &list);
 		__mark_subflow_endp_available(msk, 0);
@@ -1267,6 +1269,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_rm_subflow(msk, &slist);
 	/* Reset counters: maybe some subflows have been removed before */
 	if (!more) {
+		mptcp_pm_retry_disable(msk, NULL, -1);
 		bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 		msk->pm.local_addr_used = 0;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ed2f363bb915..d1ff62d1f943 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -204,6 +204,7 @@ enum mptcp_pm_status {
 	MPTCP_PM_RM_ADDR_RECEIVED,
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
+	MPTCP_PM_SUBFLOW_RETRY,
 	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED event */
 	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED, /* persistent status, set after MPC local address is
 					  * accounted int id_avail_bitmap
@@ -235,6 +236,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
+	struct list_head retry_list;
 	struct list_head userspace_pm_local_addr_list;
 	struct mptcp_pm_ops *ops;
 
@@ -818,6 +820,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
+unsigned int mptcp_subflow_retry_timeout(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_path_manager(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
@@ -853,6 +856,8 @@ void mptcp_set_state(struct sock *sk, int state);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
+void mptcp_pm_retry_disable(struct mptcp_sock *msk,
+			    const struct mptcp_addr_info *local, int remote_id);
 void mptcp_local_address(const struct sock_common *skc,
 			 struct mptcp_addr_info *addr);
 void mptcp_remote_address(const struct sock_common *skc,
-- 
2.25.1

