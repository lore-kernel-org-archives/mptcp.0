Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594C3E5A2F
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225932; cv=none; b=BFcuRY+kdUSIqU4Hcoxefuw6rJH6nbmdnUoNdenKOwLhbrWtlTPJjZAE8GY5ZhhMnpJ+z4GPTulhXhxmZ5Km8pD8Kd3k71BCrkWHPl1JjmgODkMYEu++QkFDno3J8DQfOCCLb9YHZiLrEeVbex6IK98zyup2HIsx0RjyJtiOfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225932; c=relaxed/simple;
	bh=Lfapml52c4YxQaCIFzES2KyoPMvS4GYxDPJ6FVcELjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UgqksyND6kR/Imls9Z0OQTwGwPnOj+URJ7baS/5+d1QJOrSTwLpuW88zd1uqDsk58delvmEehW+/ntGGVzpmXCGqEvwukPDFjYIpNhKtJHQSfESrZ0m2xvfctFCzflXiWthJFBh/rcaUV8uY3OCFc7//MZViVAZt0ad383Tpowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSL1/drw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSL1/drw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DC11F00893;
	Tue, 19 May 2026 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225930;
	bh=RkIwGgkOb2a4tyhLeRzD84fwjk97EFA2htu9ktcQIR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GSL1/drwHJrc3HMHuh/U64cWfNU4rjTR/i1wNv8EeEBthb15BTg8hY9r50zhwsZm9
	 Meh5Y38u6kNFukoO9qPmJDhC/t7+T4t8DrhUwAKCmIzwdn3BnEykvG6HdFleLafbw9
	 hQvwBadyZlsqZDDWQa4ZchlECsKGwq/IMgZLVC6EjaE6oDSD9GFC8g2wtWZVLAm/an
	 Qknu0/gajxHYoTKEoQf7RoJNrgD/H6f75nsdIq243wADaMLSxEm8b4LBcAUSryNUxz
	 bu3+Bb4+pXv1zR4hhWLTJSw/RdiCvKs5/e6xp5dspBhNcCy50eiPzfa+AOv5qp++2c
	 uqdsAsrg8f2Gw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:16 +1000
Subject: [PATCH mptcp-next v3 05/16] mptcp: introduce
 add_addr_v6_port_drop_ts sysctl knob
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-5-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Lfapml52c4YxQaCIFzES2KyoPMvS4GYxDPJ6FVcELjc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBN6a21V3Ble81rB9Ar3z/bJo1CT1x9Qxxt
 uzF9a2DvFKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 c5/mD/9qYt2PMvMfCpG+u9wJlpEdG6wKOUQtDGZcEnqjV/StYC5PzH2nWXrmsrfAkOBI7xdeIj5
 T4DtUNqTaq6EriGYojAvJD4OTa1Gu5HYbil1dm9J4wiprYNMSWEAuJ3qcrfmAFbOysbEji4AZbO
 zM5hK/habZikuZvxyw8DWYiBLBRGzFJSEJfW2bWiixuv8xfimS/tzyaCXXyouzM96wsPzcZ5u1J
 WobTOpMhbj/vd9khO9RCdfN+pqDjKSvTCBRRStLtOW6Rf3v2abJ/j7iEI9x8YpgG/yAiI68woBW
 hklTUE1+ma+J76gGj/yeVsRIfp5EqfwbEWPYoL9gj2phRbpW7uLcSrgJoXmN9ofviKLg/j6E3Il
 heysSmQ2s5jZ3oUPoZuCtJZ71w0/lRlXYElR3Jiz5H3UY4mBx6CypsHA6+idhEWRZ6I2OWzs5mM
 d0w0JoBxrsJYfmm2zP4JzWEC+CWOcDcbYSzudI7MYDISWUJGmxNgD+atLlHlStmwfXy+fmbCfxS
 Ic/2KjiEhEZPgUWxc7H6L1qn72rX32NNhNhLWtudZ3d8ibb2oPo4sn/Eq7Sm5gatrsjnwRbjGVz
 KdnTmF6RPhtPt3usT7M3HJTcdbv/PuUhbe+Q4yUyTKpYz/ir5AH6uCyafpD+jttrhI6Khhgu9nJ
 vBooAefLKIzlijQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This sysctl is going to be used in the next commits to drop TCP
timestamps option, to be able to send an ADD_ADDR with a v6 IP address
and a port number. It is enabled by default.

This knob is explicitly disabled in the MPTCP Join selftest, with the
"signal addr list progresses after tx drop" subtest, to continue
verifying the previous behaviour where the ADD_ADDR is not sent due to a
lack of space.

While at it, move syn_retrans_before_tcp_fallback down from struct
mptcp_pernet, to avoid creating another 3 bytes hole.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: split (Paolo) + fix new sysctl name in selftests.
---
 Documentation/networking/mptcp-sysctl.rst       | 13 +++++++++++++
 net/mptcp/ctrl.c                                | 18 +++++++++++++++++-
 net/mptcp/protocol.h                            |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  1 +
 4 files changed, 32 insertions(+), 1 deletion(-)

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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6fb5caeebc35..2d6c8b1829cd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -799,6 +799,7 @@ unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_path_manager(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
+unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net);
 
 void mptcp_active_disable(struct sock *sk);
 bool mptcp_active_should_disable(struct sock *ssk);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5d4d0f127f79..23b17957686a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3313,6 +3313,7 @@ add_addr_ports_tests()
 	if reset "signal addr list progresses after tx drop"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 0
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_v6_port_drop_ts=0 2>/dev/null || true
 		ip netns exec $ns1 sysctl -q net.ipv4.tcp_timestamps=1
 		ip netns exec $ns2 sysctl -q net.ipv4.tcp_timestamps=1
 

-- 
2.53.0

