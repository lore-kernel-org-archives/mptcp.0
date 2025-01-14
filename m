Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB401C1F0C
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876275; cv=none; b=P8VUmEZKC0h0iFTT/YMYXDTe7ie1NcDgp/gz3pZwWyVAyLmMPMxBIdhPxXqibjCC0vuJ6j5aIdLiGpmqnss0Nd7gRCdkAtc72l3HBZ7xclNKH1LyU7/J/aF+W5Tg8h0xVVe5xiwx5F8/2FyRfEfki27Jell9v3K/ufJOKAqnCJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876275; c=relaxed/simple;
	bh=MSjCygcl9xLxQiPI2nHHiYd4fjpdhHUVkG+AnWEq9G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aem8GNUNMvIMJphmllkXEGSU+/75yJ2FAIaFK8U/INXeEf603OpsLGdVE+Wt0w+yABgTlYQ6Y3TvwHIMcE0/ltCgayUXpOjpheWuCGhZSE9FME6vKUJ5bf9Z1bm/vLCtytJeVMi1GRJz2r+q3AgXS2TcyQDLqDNW6SKLayTUQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpGfCn8O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpGfCn8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16972C4CEE3;
	Tue, 14 Jan 2025 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736876275;
	bh=MSjCygcl9xLxQiPI2nHHiYd4fjpdhHUVkG+AnWEq9G4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UpGfCn8OOBs0RE8Z+exVSLId5yCBbUmRLw/P3znHNpgQmQ6VmncF17JGjAp4pkwWA
	 RvtXEaub/SawSU9YAqCBcwx/cZ6GYrbN08xfNfeJWjNswLe2X7dFlgwgV7fbzOuzCt
	 lN0jXSwGdOFEwgBNePWTct88DD342PsvTKd2MJjB/7ijmuNwb938dklVIqGr0sHImj
	 JSgjDcw+2QMbMYQSDwGYuoom8+1F38RHwyTAg1pctsCmLuuitVR6yJdDVgjDoU9xGu
	 w5spi+bDHCszQaO8BPkU7ih70zZFKj+4BJOOQGGfyvcNNTkUrZIVbAEdwJ3gUTpdZE
	 +xE95tkOpEcog==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Jan 2025 18:37:48 +0100
Subject: [PATCH mptcp-next 2/3] mptcp: sysctl: add
 syn_retrans_before_tcp_fallback
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-mpc-no-blackhole-v1-2-994bd2a357fb@kernel.org>
References: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
In-Reply-To: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5069; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MSjCygcl9xLxQiPI2nHHiYd4fjpdhHUVkG+AnWEq9G4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqDwnNkqDQvJSp8LaPeO11jm9FTsr7/4cCQrZ
 kqIMBOGmSSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4ag8AAKCRD2t4JPQmmg
 c42WD/wPGCrkCbcxPXubPaLZ+8Wkls2oJciFl6ZHTGUaR7dtiMyHJxmAow88Pv0U7TMOc71ECUz
 cMEXAqGL62ppV+7eLdfQKXyo5whxjwldaFdzzPnfuT/uYgi+Dh+R6Zc8+WEFdNS2d7PyQ/bwGdI
 4k333fnkwslg6DR8ms1DBy7a/fxZGuDX476KDt3+P8XR8hnjW/6glZjMnAgGAgFhcKorJfA4Tos
 8JnD0st8siBcukMEX+B4cpV5ZZAOjVCSu+eT3af1RSqC/y+BT7Uz28Y1a9hHNdzfMmm2mcMBQwc
 hVguyfL/p6b1C8wF+l7crfQCMGest4YjOPWAgeRhHRlIqsZr1UbgWtagw2Ztsa91e/oXE4aNVWL
 eJiRzwCfgerXTKhKhQ8m5iJRmbKw4tsJBUk07mXz3tbS6s65dPlKW7CHu8amyFaGBNKhPxLb6kN
 NZupOGBsV1CbTaABeFhO0X844EI0eJEZvm2EqVE5Ve39QiMHQWUGWKIQS2CH2Sqe23nvQ8SqYWY
 jEhbuKeQtNT5fXoUd1IomOGEYnseThM1xqONBLsnpUnZeU6D990psqdLhv+BEKxg8m6PL4cGx/T
 Mc7q8lh0XzT7Pz21+TEiD+6ekqAJ0TRMvi1FeV+EFSFkCc8vL7pOWCxjI8CMO+hFOGqXoVbvS/p
 Tgs7xMc2NokLeAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The number of SYN + MPC retransmissions before falling back to TCP was
fixed to 2. This is certainly a good default value, but having a fixed
number can be problem in some environments.

The current behaviour means that if all packets are dropped, there will
be:

- The initial SYN + MPC

- 2 retransmissions with MPC

- The next ones will be without MPTCP.

So typically ~3 seconds before falling back to TCP. In some networks
where some temporally blackholes are unfortunately frequent, or when a
client tries to initiate connections while the network is not ready yet,
this can cause new connections not to have MPTCP connections.

In such environments, it is now possible to increase the number of SYN
retransmissions with MPTCP options to make sure MPTCP is used.

Interesting values are:

- 0: the first retransmission will be done without MPTCP options: quite
     aggressive, but also a higher risk of detecting false-positive
     MPTCP blackholes.

- >= 128: all SYN retransmissions will keep the MPTCP options: back to
          the < 6.12 behaviour.

The default behaviour is not changed here.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 16 ++++++++++++++++
 net/mptcp/ctrl.c                          | 21 +++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 4ce31a2ac85be2daeb84c5447f06f69aabd18ef7..03e1d3610333e29423b0f40591c9e914dc2d0366 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -108,3 +108,19 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
 
 	Default: 4
+
+syn_retrans_before_tcp_fallback - INTEGER
+	The number of SYN + MP_CAPABLE retransmissions before falling back to
+	TCP, i.e. dropping the MPTCP options. In other words, if all the packets
+	are dropped on the way, there will be:
+
+	* The initial SYN with MPTCP support
+	* This number of SYN retransmitted with MPTCP support
+	* The next SYN retransmissions will be without MPTCP support
+
+	0 means the first retransmission will be done without MPTCP options.
+	>= 128 means that all SYN retransmissions will keep the MPTCP options. A
+	lower number might increase false-positive MPTCP blackholes detections.
+	This is a per-namespace sysctl.
+
+	Default: 2
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index b0dd008e2114bce65ee3906bbdc19a5a4316cefa..3999e0ba2c35b50c36ce32277e0b8bfb24197946 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -32,6 +32,7 @@ struct mptcp_pernet {
 	unsigned int close_timeout;
 	unsigned int stale_loss_cnt;
 	atomic_t active_disable_times;
+	u8 syn_retrans_before_tcp_fallback;
 	unsigned long active_disable_stamp;
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
@@ -92,6 +93,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
 	pernet->blackhole_timeout = 3600;
+	pernet->syn_retrans_before_tcp_fallback = 2;
 	atomic_set(&pernet->active_disable_times, 0);
 	pernet->close_timeout = TCP_TIMEWAIT_LEN;
 	pernet->checksum_enabled = 0;
@@ -245,6 +247,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.proc_handler = proc_blackhole_detect_timeout,
 		.extra1 = SYSCTL_ZERO,
 	},
+	{
+		.procname = "syn_retrans_before_tcp_fallback",
+		.maxlen = sizeof(u8),
+		.mode = 0644,
+		.proc_handler = proc_dou8vec_minmax,
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -269,6 +277,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	/* table[7] is for available_schedulers which is read-only info */
 	table[8].data = &pernet->close_timeout;
 	table[9].data = &pernet->blackhole_timeout;
+	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
@@ -392,17 +401,21 @@ void mptcp_active_enable(struct sock *sk)
 void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 {
 	struct mptcp_subflow_context *subflow;
-	u32 timeouts;
 
 	if (!sk_is_mptcp(ssk))
 		return;
 
-	timeouts = inet_csk(ssk)->icsk_retransmits;
 	subflow = mptcp_subflow_ctx(ssk);
 
 	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT) {
-		if (timeouts == 2 || (timeouts < 2 && expired)) {
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDROP);
+		struct net *net = sock_net(ssk);
+		u8 timeouts, to_max;
+
+		timeouts = inet_csk(ssk)->icsk_retransmits;
+		to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
+
+		if (timeouts == to_max || (timeouts < to_max && expired)) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
 			subflow->mpc_drop = 1;
 			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
 		} else {

-- 
2.47.1

