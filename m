Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F62E7397
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024930; cv=none; b=WEWXCVU6xmfMVcGKcUmAuVLp2k4/KmD0CbJee8SJxs++3BaCEzW8snGWdlxjRHZR+VyEfuQq/sGjIXklIZmy5htJzSmmqFZ7ix1MTEPiRNZvoZLARrCzndGSgbGtfAyg3m98m2Hnm3X809bLB+gzNWgjKJOxLsIzPPp1gQ8yIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024930; c=relaxed/simple;
	bh=QGOP5umiIFrQez8kjzAIOJJM4Q4KmApZmA+N59A+c5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNjYEr6Ugug/zoxghoReXzZ6HespNIChcqvNZZIA4YR4p+AHZFp0v7n8vc1KtI1Tbl8ShM0xG6pST4oO84xucs6ubKKxT6Nxfusq7fMqHw7l339e8fOmddOWllvRu2WQ05ZTnbOHcqVYFrNA3CGHQnfJLiDZ8hnPZ33wbdG06Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcXtsAQs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcXtsAQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E805B1F00A3A;
	Fri, 29 May 2026 03:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024926;
	bh=lGEk3Dyom8Wisfeh9yaoXbXopBrlEz7hvkqzDr5JJzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YcXtsAQszlVfRB/ebs7XsqRNeuxfY9BtwCOKkbSgqAnG8bvZfPOeSJkOgyGPjBX+F
	 NFSgH0ef78ZvEtzH5FJm92dzaGAFzFjhQn6m8AITpff/70fXs2/oVR7cy4tuFYnp2e
	 qXGDxXe4dk4HnUk22NrCcSEEWEeubzKH2gKqxGSyXp4LVxdwIgBi1i/hPcskDpHN8D
	 EED7hJGc+BN2m0X26SIae7T15CGHR3oavCN8RslqQPJ7oyjEKv4ZJsATXqNq9oJJVa
	 cLbZBPqpBS9IFlkQm2H/xQ0uClHraNKK1WhZPkL+/SLRhVE1H5IMNgJG0r0GAhGmzU
	 0dl6XNG8KNSFg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:43 +1000
Subject: [PATCH mptcp-next v4 05/15] mptcp: introduce
 add_addr_v6_port_drop_ts sysctl knob
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-5-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5509; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QGOP5umiIFrQez8kjzAIOJJM4Q4KmApZmA+N59A+c5I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWVmgjIXOREzX36rC5blAXWy06gp694eDf9
 DyZ0ZhIp5OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 cxGNEACYTMtBKsYFlAe035KdCkR41UmDGHxiSuUkfPQlrl3rEY6BiHE5ymZgIRY9hVSeJ7h5d0P
 IfqIUGjLrG4oknGaGWEsTFGaoUGzby4JmfjvNU3ealm77MOZarRWzom5lXtF0oKsmUFKgSgABHr
 kNIbalNlBdIlX+DIsVGbJ5KQwp9ucV4jpS3lGTblmr5hoT9rgdZklEA9R9ibakuNQ+++O9lrVmC
 qVADQ5tH7mr7rsu5DwJ5tjuae0Srtax5nDAXAB0c3H7BCTOAZ/nedzUwrWgF4pQx35FQcf5rDR4
 +ajwwDwnGfXogQuSy1v7Uh1qTfITd4UaJImLyjPL398td1X65OWHvmN9N8/iC1Vs+RRDnqFOoxl
 iEbUnU08tfatpSdKcA7n9oJdHeU0KrhvrXaqcRMp31Zqai2symIh+9f8THpNORCMKxjQO5B2Vec
 EjvqjrFiWf3jkQWrwVjAOSCp4JeOoOywWqwTnEI2L5kZkDHjKVFfhgIlKT5IaPRUAsHcfyTlXJ3
 XXiHr236oOo3NyNczXEwEG/muQLzuG6r/ULEXp27UsURzP/HElJQAI7SHRUyikstoQSa/bC7DxV
 +IDUn1Y/JpSdXWdycdaaa8HBR6n1L9qS6jWMw8EAvOu0IEGjeJgqiMTPh4TNBXtPqEB70KSnuFK
 mWdVZQ/AgD4KFEQ==
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
index 7379a49342e6..1c9376c5e8f0 100644
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
index f008a14006b9..d894efe1fb02 100755
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

