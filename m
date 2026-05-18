Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C34779BE
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109160; cv=none; b=kxy06k8l4juzlWuWOJN3/jRrdS51nwEBFNw7LkfPHko9aCrimNwOCVyu7fqO9m8NHOSUs8czjp2dY64A8fCog61c2xAh3R1RukljZ5rtTRRGGSSaIteB/qUbBbtPsxhsKBIUHSmOqD1CygDrtBD66yrmTxY3/mcaO6KlEofhe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109160; c=relaxed/simple;
	bh=3sS5izyKtMm7nMUr8VcP3jBPu8TGpIWqlZGN4BduJls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snRRLNMA9a7XevuL8dT06/Z0v0i5f3/NHRHZv5IACS/MM4ZXdhyl/dtaj++y5/UQfYfhRd7+nBkr/46W4pziVu+qAoV4151HwSZzZ/msGnnzG1Wm/4bILkrscfmNo4dqdJFexJ2tE4tmTXbDDOGh+7Fn26+MuyF6ELX6gl/VOFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtLoDXZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtLoDXZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6430CC2BCC7;
	Mon, 18 May 2026 12:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109159;
	bh=3sS5izyKtMm7nMUr8VcP3jBPu8TGpIWqlZGN4BduJls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UtLoDXZARE1EiV1mUhhEc9LSSiiJ+KoCZtApOGJ52Xo3P5Kd76synncHIZhqgs6Fn
	 458rWeLUThsFObF+5NV2bxm123tVWByON85sXnOD2pEHnyyQyz8DisbwYDv13vqnsX
	 7aMEvUb7pPxNJ4cWpJQBC1uqPJf7eDef2nI5RmCdipoWoO6uLtkSrog9C8t1Dtfo0U
	 xFNnK40TDAtpHoVNLzZU7dxo+ZYMwtR+ud0SFYlDsMlCcc1IX9gtihTYTqDLlIpcCT
	 mWo4QH8hYhJfnItaEDUA+KY5oCd918GMT25dNrmFjT7lo463C+NiSsk/oClnvbxTOu
	 bHAxNlxKzrVTQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:07 +1000
Subject: [PATCH mptcp-next 03/12] mptcp: pm: drop TCP TS with ADD_ADDRv6 +
 port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-3-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12888; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3sS5izyKtMm7nMUr8VcP3jBPu8TGpIWqlZGN4BduJls=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0hdvi0Y4MLd02m+8XCIOFLrXqn2SSWZShrr
 HewEIiwVL+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 cyblEACYKjJ654ImsQKJ0rYds24dVPYqxnlW0V/UqeLSzJYcwFki0ySNjiW2nDn/5/CqyQsZH9w
 /d/mZQJR+6NcvHe9ViWRjIIbmshHnbB4UYYmAO1s31bLHd0J8BlulGIjEWyIgacZojS9sCb9Ere
 Syjbm52KFCodkcC/ZphgIwYm6u3gjovHE5OSBsfKg9ReL8u1quohKb6pcpLl/aUJ0D1Q0v7+H2K
 6zhUFYrgfjV7ujol07w74F1KbkHuJWjk7lmdCs7ISo4P6tA2sVClE1NbvxOu5fd8jZjaoiLDA8c
 noVT6wJR1hUnVth6/qtLdt8rdUXJXvyX25DV6rkjjsw4Drtno9C6Qf69RSnXWg2u7GmEyF2M+pl
 tx3/ZJBlY1oYhqAFTO6t58AT97qI8OwcwO0h56oKZk0baKTKQcpjZM3FYn6LgChna1h2YP9UEfB
 B+cE/f2EANes55iBmPYDEvtq71ru5xEB9ZfE2d/HHk3xkCzVpqgwhkdLHyx/8Q26SQ46gf7+Zx1
 d3wwTeN4DJVBQeLY/8625yLQyPHMKYSWplfU/ugjYp9+hzoDbGNGktWQFJvkdbMgzfCI8qsw8M0
 cvpVyefQHFzREfZ0Jd7IDznVJ1nK9vA/aaGkNUWLl3QOdn2+Vla9rKlx1GFidDVSGV0EfM+bvxL
 /V5nvaNKXMBKqeg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
taking 30 bytes, the 40-byte limit for the TCP options is reached. In
this case, it is then not possible to send the signal.

To be able to send this ADD_ADDR, the TCP timestamps option can now be
dropped. This is controlled by a new net.mptcp.add_addr_v6_port_drop_ts
sysctl knob, enabled by default. This option is disabled in the MPTCP
Join selftest, with the "signal addr list progresses after tx drop"
subtest, to continue verifying the previous behaviour where the ADD_ADDR
is not sent due to a lack of space.

It is important to keep in mind that dropping the TCP timestamps option
for one packet of the connection could eventually disrupt some
middleboxes: even if it should be unlikely, they could drop the packet
or even block the connection. That's why this new feature can be
controlled by a sysctl knob.

Note that it would be technically possible to squeeze both options into
the header if the ADD_ADDR is first written, and then the TCP timestamps
without the NOPs preceding it. But this means more modifications on TCP
side, plus some middleboxes could still be disrupted by that.

A new parameter is passed from tcp_established_options to the MPTCP side
to indicate if the TCP TS option is used, and if it should be dropped.

While at it, move syn_retrans_before_tcp_fallback down from struct
mptcp_pernet, to avoid creating another 3 bytes hole.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/448
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst       | 13 +++++++++++++
 include/net/mptcp.h                             |  3 ++-
 net/ipv4/tcp_output.c                           |  6 +++++-
 net/mptcp/ctrl.c                                | 18 +++++++++++++++++-
 net/mptcp/options.c                             | 15 +++++++++------
 net/mptcp/pm.c                                  | 13 ++++++++++++-
 net/mptcp/protocol.h                            |  4 +++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  1 +
 8 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 1eb6af26b4a7..b9b5f58e0625 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -21,6 +21,19 @@ add_addr_timeout - INTEGER (seconds)
 
 	Default: 120
 
+add_addr_v6_port_drop_ts - BOOLEAN
+	Control whether preparing an ADD_ADDR with an IPv6 address and a port
+	should drop the TCP timestamps option to have enough option space to
+	send the signal.
+
+	If there is not enough option space, and the TCP timestamps option
+	cannot be dropped, the signal cannot be sent. Note that dropping the TCP
+	timestamps option for one packet of the connection could disrupt some
+	middleboxes: even if it should be unlikely, they could drop the packet
+	or block the connection. This is a per-namespace sysctl.
+
+	Default: 1 (enabled)
+
 allow_join_initial_addr_port - BOOLEAN
 	Allow peers to send join requests to the IP address and port number used
 	by the initial subflow if the value is 1. This controls a flag that is
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..b14e98b60958 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -157,7 +157,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 			  struct mptcp_out_options *opts);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts);
+			       bool *drop_ts, struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
 void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
@@ -276,6 +276,7 @@ static inline bool mptcp_established_options(struct sock *sk,
 					     struct sk_buff *skb,
 					     unsigned int *size,
 					     unsigned int remaining,
+					     bool *drop_ts,
 					     struct mptcp_out_options *opts)
 {
 	return false;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 47647a99e324..3dcc6880fd44 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1182,11 +1182,15 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	if (sk_is_mptcp(sk)) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
 		unsigned int opt_size = 0;
+		bool drop_ts = opts->options & OPTION_TS;
 
 		if (mptcp_established_options(sk, skb, &opt_size, remaining,
-					      &opts->mptcp)) {
+					      &drop_ts, &opts->mptcp)) {
 			opts->options |= OPTION_MPTCP;
 			size += opt_size;
+
+			if (drop_ts)
+				opts->options &= ~OPTION_TS;
 		}
 	}
 
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d96130e49942..c94a192f4118 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -32,12 +32,13 @@ struct mptcp_pernet {
 	unsigned int close_timeout;
 	unsigned int stale_loss_cnt;
 	atomic_t active_disable_times;
-	u8 syn_retrans_before_tcp_fallback;
 	unsigned long active_disable_stamp;
+	u8 syn_retrans_before_tcp_fallback;
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
+	u8 add_addr_v6_port_drop_ts;
 	char scheduler[MPTCP_SCHED_NAME_MAX];
 	char path_manager[MPTCP_PM_NAME_MAX];
 };
@@ -94,6 +95,11 @@ const char *mptcp_get_scheduler(const struct net *net)
 	return mptcp_get_pernet(net)->scheduler;
 }
 
+unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net)
+{
+	return mptcp_get_pernet(net)->add_addr_v6_port_drop_ts;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
@@ -108,6 +114,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
 	strscpy(pernet->scheduler, "default", sizeof(pernet->scheduler));
 	strscpy(pernet->path_manager, "kernel", sizeof(pernet->path_manager));
+	pernet->add_addr_v6_port_drop_ts = 1;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -362,6 +369,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0444,
 		.proc_handler = proc_available_path_managers,
 	},
+	{
+		.procname = "add_addr_v6_port_drop_ts",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -389,6 +404,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
 	table[11].data = &pernet->path_manager;
 	/* table[12] is for available_path_managers which is read-only info */
+	table[13].data = &pernet->add_addr_v6_port_drop_ts;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6990d6171980..a2d2ff7336a0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -654,6 +654,7 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *skb,
 					       unsigned int *size,
 					       unsigned int remaining,
+					       bool *drop_ts,
 					       struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -669,16 +670,14 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
-		    &echo, size, &drop_other_suboptions))
+		    &echo, size, &drop_other_suboptions, drop_ts))
 		return false;
 
 	/*
 	 * Later on, mptcp_write_options() will enforce mutually exclusion with
 	 * DSS, bail out if such option is set and we can't drop it.
 	 */
-	if (drop_other_suboptions)
-		remaining += opt_size;
-	else if (opts->suboptions & OPTION_MPTCP_DSS)
+	if (!drop_other_suboptions && opts->suboptions & OPTION_MPTCP_DSS)
 		return false;
 
 	if (drop_other_suboptions) {
@@ -825,15 +824,17 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts)
+			       bool *drop_ts, struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	unsigned int opt_size = 0;
 	bool snd_data_fin;
 	bool ret = false;
+	bool has_ts = *drop_ts;
 
 	opts->suboptions = 0;
+	*drop_ts = false;
 
 	/* Force later mptcp_write_options(), but do not use any actual
 	 * option space.
@@ -878,10 +879,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	*size += opt_size;
 	remaining -= opt_size;
-	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opts)) {
+	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining,
+					       &has_ts, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
 		ret = true;
+		*drop_ts = has_ts;
 	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a44b1c8acf8f..ad496ff3d6ad 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -905,7 +905,8 @@ static unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      unsigned int *len, bool *drop_other_suboptions)
+			      unsigned int *len, bool *drop_other_suboptions,
+			      bool *drop_ts)
 {
 	bool skip_add_addr = false;
 	int ret = false;
@@ -948,6 +949,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		if (!*drop_other_suboptions)
 			goto out_unlock;
 
+		if (*drop_ts && mptcp_add_addr_v6_port_drop_ts(net)) {
+			/* OK without TCP Timestamp? */
+			*len -= TCPOLEN_TSTAMP_ALIGNED;
+			if (remaining >= *len)
+				goto drop_ts;
+		}
+
 		if (*echo) {
 			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
 		} else {
@@ -955,8 +963,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			MPTCP_INC_STATS(net, MPTCP_MIB_ADDADDRTXDROP);
 		}
 		goto drop_signal_mark;
+	} else {
+		*drop_ts = false;
 	}
 
+drop_ts:
 	ret = true;
 
 drop_signal_mark:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 37255da6c0ed..c84e630c6e57 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -799,6 +799,7 @@ unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_path_manager(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
+unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net);
 
 void mptcp_active_disable(struct sock *sk);
 bool mptcp_active_should_disable(struct sock *ssk);
@@ -1212,7 +1213,8 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      unsigned int *len, bool *drop_other_suboptions);
+			      unsigned int *len, bool *drop_other_suboptions,
+			      bool *drop_ts);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list, unsigned int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5d4d0f127f79..634d82595f72 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3313,6 +3313,7 @@ add_addr_ports_tests()
 	if reset "signal addr list progresses after tx drop"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 0
+		ip netns exec $ns1 sysctl -q net.mptcp.drop_ts_add_addr6_port=0 2>/dev/null || true
 		ip netns exec $ns1 sysctl -q net.ipv4.tcp_timestamps=1
 		ip netns exec $ns2 sysctl -q net.ipv4.tcp_timestamps=1
 

-- 
2.53.0

