Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE9185B6A
	for <mptcp@lists.linux.dev>; Mon,  2 Sep 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268163; cv=none; b=Bwbj/9lEc/zX3LQulkL0WTKQwxRQLn61ln599BVmf//ML3ueGk2T1IEd72QOdL6EZ9TCkqDDvt8PgZcuJtEObCud4dX+FfS3avjtih8Vr2riuBoG1ZjcrySqWV9dPMOAJIPZjpV/EivPRcT2y02ymVEhpKD4CzOqCSL4+SZvBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268163; c=relaxed/simple;
	bh=75M/B2Raljs92TuJB4xKJ3XI2BTsyB/PvjkYM8Zo728=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gktHja17WG5Bph0ek5HgdAAZN1H5UEEfpJeLbFZJyavopLmJGifW7NAkN6cxHlHveMh0gYQglKDJFqXMKJaHoeJvHJkxJHmVzlLmLzJW/G2908EUcziEoxI3nVe6DERr176+EvRzXNfMnpcceyvNch7AZ43h0watUsdqXpLQ/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKU1cEie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKU1cEie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB3BC4CEC8;
	Mon,  2 Sep 2024 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725268162;
	bh=75M/B2Raljs92TuJB4xKJ3XI2BTsyB/PvjkYM8Zo728=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FKU1cEieF0qR7lOttx5ngyjZikGWyaYauT0rWTPozb31Nh5dKvoFY2nms81KejFmP
	 ZMgcsVrPUrB29ce1SJOXj+0E/ZVFtr+PNZhmaDKu23CwTu8c9OGfF6h9TpUJkrX6NS
	 Ekp0LGDzrcrCFF1fMrkN0bQ3gX+dz+QQpIlo96+a2Cv084f0WOorjmVntfdASbR2BB
	 hPzP1fHcf8BXDME5jEjPxL9Li55q5Q7K53SUTtQy0cOU4NoMmiFkVXYrpgYFy1BgM4
	 1a6yIDMp4CJ5KKcRzcLV0KE5heLz4L55SlW3VyQIg+wC48DBky4RTy+zSietH9cTfL
	 kO7ZOuZdlYrnQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 11:09:10 +0200
Subject: [PATCH mptcp-next 3/3] mptcp: disable active MPTCP in case of
 blackhole
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-mptcp-fallback-x-mpc-v1-3-86d9170ddff7@kernel.org>
References: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
In-Reply-To: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=13632; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=75M/B2Raljs92TuJB4xKJ3XI2BTsyB/PvjkYM8Zo728=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1YC+KBwwUfiLfckb0fA65yJ/lydm9iV1bAATz
 7h8dMTBpdyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWAvgAKCRD2t4JPQmmg
 c5ynD/9gnXscMDAzia9AlwnbcfqiMrjy93fDEdo8zLfJ05CncbblCcl/NCURP89fFdTXJkcRT6f
 OjMd8MRNqM3QJhpz2KzRAEcgcJx8r38Rc427kI1SaNNMo0mPFmwAEXgP26JylqqutlVOYl1fKU3
 bcd19ffkQ1YJTqn6ciUHx5E8/H3AhTc/Y4w5Wf6GYbKYLOcAMtrdf6LKt5eREl027nxcnydiQUC
 J3w5cPheOaYZJ2rMA/JVp4B5Q17UFi4xIKpqL8a/k49HSBXzytXbQaWOTS0d7hK6O6xSrb/FSDS
 JPQAyoX8pRvTryp1nUTWQdl10dx2LP4LjvaSL78lWqKpLQHn7cYWbQsf7oMo9MwU3Jks9lew0Br
 1LjF8n1W5+zkfZBHHwkq4IOG2WKjcPicwCnXAsaMFNbqkFF0BsBhleczFlC5MbSwdOm/0VyGHdk
 CJQMXEQM7mzidg1635E6CODVuMzVYT5xOvrRe9ev+k5FssFGXWHDXH3upLxmEI73yAv3pZsdKfz
 x/weWympdQcpKGP6z77XrcJwTp4i+QNTZZ+XOWPvkngfQUxY77unlLRmEQVOJWOILcCDHE06tQ4
 EYnh5ceIDu4gZqbfrUDRFgb76Mxcr9TB6WZ9p/iXk49/h9se6PY2Nw5Ojiac9UhV7pK029JQcrt
 v0KqKxkLqEbDvEA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

An MPTCP firewall blackhole can be detected if the following SYN
retransmission after a fallback to "plain" TCP is accepted.

In case of blackhole, a similar technique to the one used by TFO is
used: MPTCP can be disabled for a certain period of time, 1h by default.
This time period will grow exponentially when more blackhole issues get
detected right after MPTCP is re-enabled and will reset to the initial
value when the blackhole issue goes away.

The blackhole period can be modified thanks to a new sysctl knob:
blackhole_timeout. Two new MIB counters help understanding what's
happening:

- 'Blackhole', incremented when a blackhole has been detected.
- 'MPCapableSYNTXDisabled', incremented when an MPTCP connection
  directly falls back to TCP during the blackhole period.

Because the technique is similar to the one used by TFO, an important
part of the new code is similar to what was can find in tcp_fastopen.c,
with some adaptations to the MPTCP case.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/57
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst |  11 +++
 net/mptcp/ctrl.c                          | 121 +++++++++++++++++++++++++++++-
 net/mptcp/mib.c                           |   2 +
 net/mptcp/mib.h                           |   2 +
 net/mptcp/protocol.c                      |  11 ++-
 net/mptcp/protocol.h                      |   8 +-
 net/mptcp/subflow.c                       |   4 +
 7 files changed, 151 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index fd514bba8c43..95598c21fc8e 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -34,6 +34,17 @@ available_schedulers - STRING
 	Shows the available schedulers choices that are registered. More packet
 	schedulers may be available, but not loaded.
 
+blackhole_timeout - INTEGER (seconds)
+	Initial time period in second to disable MPTCP on active MPTCP sockets
+	when a MPTCP firewall blackhole issue happens. This time period will
+	grow exponentially when more blackhole issues get detected right after
+	MPTCP is re-enabled and will reset to the initial value when the
+	blackhole issue goes away.
+
+	0 to disable the blackhole detection.
+
+	Default: 3600
+
 checksum_enabled - BOOLEAN
 	Control whether DSS checksum can be enabled.
 
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 0b23e3c5e8ff..38d8121331d4 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -28,8 +28,11 @@ struct mptcp_pernet {
 #endif
 
 	unsigned int add_addr_timeout;
+	unsigned int blackhole_timeout;
 	unsigned int close_timeout;
 	unsigned int stale_loss_cnt;
+	atomic_t active_disable_times;
+	unsigned long active_disable_stamp;
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
@@ -88,6 +91,8 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->blackhole_timeout = 3600;
+	atomic_set(&pernet->active_disable_times, 0);
 	pernet->close_timeout = TCP_TIMEWAIT_LEN;
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
@@ -152,6 +157,20 @@ static int proc_available_schedulers(const struct ctl_table *ctl,
 	return ret;
 }
 
+static int proc_blackhole_detect_timeout(const struct ctl_table *table,
+					 int write, void *buffer, size_t *lenp,
+					 loff_t *ppos)
+{
+	struct mptcp_pernet *pernet = mptcp_get_pernet(current->nsproxy->net_ns);
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (write && ret == 0)
+		atomic_set(&pernet->active_disable_times, 0);
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -218,6 +237,13 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dointvec_jiffies,
 	},
+	{
+		.procname = "blackhole_timeout",
+		.maxlen = sizeof(unsigned int),
+		.mode = 0644,
+		.proc_handler = proc_blackhole_detect_timeout,
+		.extra1 = SYSCTL_ZERO,
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -241,6 +267,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[6].data = &pernet->scheduler;
 	/* table[7] is for available_schedulers which is read-only info */
 	table[8].data = &pernet->close_timeout;
+	table[9].data = &pernet->blackhole_timeout;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
@@ -278,6 +305,88 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
 
 #endif /* CONFIG_SYSCTL */
 
+/* The following code block is to deal with middle box issues with MPTCP,
+ * similar to what is done with TFO.
+ * The proposed solution is to disable active MPTCP globally when SYN+MPC are
+ * dropped, while SYN without MPC aren't. In this case, active side MPTCP is
+ * disabled globally for 1hr at first. Then if it happens again, it is disabled
+ * for 2h, then 4h, 8h, ...
+ * The timeout is reset back to 1hr when a successful active MPTCP connection is
+ * fully established.
+ */
+
+/* Disable active MPTCP and record current jiffies and active_disable_times */
+void mptcp_active_disable(struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+	struct mptcp_pernet *pernet;
+
+	pernet = mptcp_get_pernet(net);
+
+	if (!READ_ONCE(pernet->blackhole_timeout))
+		return;
+
+	/* Paired with READ_ONCE() in mptcp_active_should_disable() */
+	WRITE_ONCE(pernet->active_disable_stamp, jiffies);
+
+	/* Paired with smp_rmb() in mptcp_active_should_disable().
+	 * We want pernet->active_disable_stamp to be updated first.
+	 */
+	smp_mb__before_atomic();
+	atomic_inc(&pernet->active_disable_times);
+
+	MPTCP_INC_STATS(net, MPTCP_MIB_BLACKHOLE);
+}
+
+/* Calculate timeout for MPTCP active disable
+ * Return true if we are still in the active MPTCP disable period
+ * Return false if timeout already expired and we should use active MPTCP
+ */
+bool mptcp_active_should_disable(struct sock *ssk)
+{
+	struct net *net = sock_net(ssk);
+	unsigned int blackhole_timeout;
+	struct mptcp_pernet *pernet;
+	unsigned long timeout;
+	int disable_times;
+	int multiplier;
+
+	pernet = mptcp_get_pernet(net);
+	blackhole_timeout = READ_ONCE(pernet->blackhole_timeout);
+
+	if (!blackhole_timeout)
+		return false;
+
+	disable_times = atomic_read(&pernet->active_disable_times);
+	if (!disable_times)
+		return false;
+
+	/* Paired with smp_mb__before_atomic() in mptcp_active_disable() */
+	smp_rmb();
+
+	/* Limit timeout to max: 2^6 * initial timeout */
+	multiplier = 1 << min(disable_times - 1, 6);
+
+	/* Paired with the WRITE_ONCE() in mptcp_active_disable(). */
+	timeout = READ_ONCE(pernet->active_disable_stamp) +
+		  multiplier * blackhole_timeout * HZ;
+
+	return time_before(jiffies, timeout);
+}
+
+/* Enable active MPTCP and reset active_disable_times if needed */
+void mptcp_active_enable(struct sock *sk)
+{
+	struct mptcp_pernet *pernet = mptcp_get_pernet(sock_net(sk));
+
+	if (atomic_read(&pernet->active_disable_times)) {
+		struct dst_entry *dst = sk_dst_get(sk);
+
+		if (dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK))
+			atomic_set(&pernet->active_disable_times, 0);
+	}
+}
+
 /* Check the number of retransmissions, and fallback to TCP if needed */
 void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 {
@@ -290,10 +399,14 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 	timeouts = inet_csk(ssk)->icsk_retransmits;
 	subflow = mptcp_subflow_ctx(ssk);
 
-	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT &&
-	    (timeouts == 2 || (timeouts < 2 && expired))) {
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDROP);
-		mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
+	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT) {
+		if (timeouts == 2 || (timeouts < 2 && expired)) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDROP);
+			subflow->mpc_drop = 1;
+			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
+		} else {
+			subflow->mpc_drop = 0;
+		}
 	}
 }
 
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index d70a3e2bfad6..38c2efc82b94 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -16,6 +16,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableSYNTXDrop", MPTCP_MIB_MPCAPABLEACTIVEDROP),
+	SNMP_MIB_ITEM("MPCapableSYNTXDisabled", MPTCP_MIB_MPCAPABLEACTIVEDISABLED),
 	SNMP_MIB_ITEM("MPFallbackTokenInit", MPTCP_MIB_TOKENFALLBACKINIT),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
@@ -74,6 +75,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndConflictUpdate", MPTCP_MIB_RCVWNDCONFLICTUPDATE),
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
 	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
+	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 062775700b63..c8ffe18a8722 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -11,6 +11,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way handshake */
 	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way handshake */
 	MPTCP_MIB_MPCAPABLEACTIVEDROP,	/* Client-side fallback due to a MPC drop */
+	MPTCP_MIB_MPCAPABLEACTIVEDISABLED, /* Client-side disabled due to past issues */
 	MPTCP_MIB_TOKENFALLBACKINIT,	/* Could not init/allocate token */
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
@@ -75,6 +76,7 @@ enum linux_mptcp_mib_field {
 					 */
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
 	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
+	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a32f79db235a..d401cbe9412b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3737,9 +3737,14 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
 		mptcp_subflow_early_fallback(msk, subflow);
 #endif
-	if (subflow->request_mptcp && mptcp_token_new_connect(ssk)) {
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
-		mptcp_subflow_early_fallback(msk, subflow);
+	if (subflow->request_mptcp) {
+		if (mptcp_active_should_disable(sk)) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDISABLED);
+			mptcp_subflow_early_fallback(msk, subflow);
+		} else if (mptcp_token_new_connect(ssk) < 0) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
+			mptcp_subflow_early_fallback(msk, subflow);
+		}
 	}
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 633a9bc7a0e7..02e51a469321 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -531,7 +531,8 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
-		__unused : 9;
+		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;
@@ -697,6 +698,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
+
+void mptcp_active_disable(struct sock *sk);
+bool mptcp_active_should_disable(struct sock *ssk);
+void mptcp_active_enable(struct sock *sk);
+
 void mptcp_get_available_schedulers(char *buf, size_t maxlen);
 void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 				       struct mptcp_subflow_context *subflow,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b9b14e75e8c2..1040b3b9696b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -546,6 +546,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_capable = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
+		mptcp_active_enable(parent);
 		mptcp_propagate_state(parent, sk, subflow, &mp_opt);
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
@@ -591,6 +592,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINPORTSYNACKRX);
 		}
 	} else if (mptcp_check_fallback(sk)) {
+		/* It looks like MPTCP is blocked, while TCP is not */
+		if (subflow->mpc_drop)
+			mptcp_active_disable(parent);
 fallback:
 		mptcp_propagate_state(parent, sk, subflow, NULL);
 	}

-- 
2.45.2

