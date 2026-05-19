Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74FF2D978A
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169881; cv=none; b=dwWV3swpYrAl+P5plGpXCHlizRFC2ovBtuJfXlED8WugXB6K9TlW1G3bKkNPQKKyXTmoMyHz+suiJJCkH4Q0vGfLhyexh7Ysdy+jGH/galvf6r4UhoKuzxv9U84Drs9lCZhrRFK7YcQXZt0U16r8VyH66kVtwMw818lY/bbezkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169881; c=relaxed/simple;
	bh=Lfapml52c4YxQaCIFzES2KyoPMvS4GYxDPJ6FVcELjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7JMm+4oExQyE56zs8rmCkuofY3IYxHy6RfOdM4mT1+vNYk7sUa8q64NGhfQLQhRTYh9z5IZirp3kejxQ+t36iGePG0OC734XkVEl0w5KldgsuCmN5Vv1Nr4JwdexUiiIMZonGigI9lt77eiDZwevaXQgjNNXdqWl2GmHVetM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r141b9ET; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r141b9ET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C13C2BCC6;
	Tue, 19 May 2026 05:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169881;
	bh=Lfapml52c4YxQaCIFzES2KyoPMvS4GYxDPJ6FVcELjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r141b9ETBdj3cm9UHDcP9mieWj+MPMOednVootqlnMBDLGBN7UBK6C785mkNwHfYU
	 ZufXC8CUK4E96713LGW26do7PTeBuPVdPbc1vRXVQPhUw+LfhZaMqIjH7SsavogK+b
	 BviDImSWVhERl03Z2i1LL4jaH/r2Hc6I5cL+gfOndGeak/2oJxZlH84i3Gwx2mZ/fR
	 8NyNloC37mM7IaU3Wzp4X2WQipXdfaeB4pPkDW9fwPxktR4e0Sal3OBA/JrL0xPcSc
	 CTXemegT4xR+nW4s/hqRG3J5VjHAmS1VutpTRemXWZ7UAIBA5opoc/7OSCbNHj7ED2
	 NSZl6EOq0TIeA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:14 +1000
Subject: [PATCH mptcp-next v2 05/15] mptcp: introduce
 add_addr_v6_port_drop_ts sysctl knob
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-5-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Lfapml52c4YxQaCIFzES2KyoPMvS4GYxDPJ6FVcELjc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pSZfCHvpxEL3OwqCw4qgjCKUw3zk8RHQ1nL
 k5cw/ekaHuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 c1MfEAC7u0Z/Dk6Va2ezh1Q5EZ9V/sKQ+pOgAYu8frop5XBVYkijuV5RIkVZhk9JWDqCxJtpv7r
 Csg0fperHpA/tuc7GZALLLSd/bFD9gaf26CdR+m8f6Atfv9LCDVJRTk5LWQhZrnYOscmGTyRMKL
 +nGPTIDEhkFlHyR+PFtyzezhD5EjHdd55QuDg1K6nd9WACsWGiK4rZnR8FN/j3cycfGBS3UwT2w
 r9s94OUonB7kDxzjrld+Eg3vKuKadCOi9VvGMtVewvGYJ4c72jUPi2fPhHUkcqnZZgMk1rSQWCR
 MLNkPFAgcVV6JpoIaqyX0qZ0EmamNRV89LAVO1kr7lrGMyBWgCfQkoHkU80JkjXieI0wEhuC/h0
 xABOXnMw3HzTJkG9FgKyFGlXFF25s1sKOnHdpvtpp4IWBA08FcdZMofnRnB1hvMjwbWeLh8VteS
 FiIXDRZ/Aej/qxLqCjLKB9Bq8uFQweTH8I2gq+JZ713WoeVpFYueLMLiGKsyMSME3P5lV1yUiYQ
 ALsPsX1Q5LcXBmmD1wEBzaRSTbbga8jQmNiQd372kGPozaYMwo1g2XXjCObqQZdIvvZdQhrpO/T
 LsbBtX/XXPE0qrl82QQHdwepJKW1pRbgEzvSQEXnIwYJDA0Qh7S5bGi3y9P20d5D7AN9mjYChXV
 BD6AxbjAUpfA2jA==
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

