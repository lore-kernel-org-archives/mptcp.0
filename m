Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2440B39E;
	Fri,  5 Jun 2026 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651335; cv=none; b=IAoP35mcAZ1cfoJTm+SCYgLZCxAbnXHweNIXDrX/FSAsyGU1t6s7wOjj/v4it1wwHo3Wtgd/9NmC1Ssh3sAqFt1GjmAkov4p8s8OZq2gvHiPDJ/pPou976QI95sSXtJIETrFRnPlqSGmEVvxuqcann75JjD7BXx48eHYhM/rIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651335; c=relaxed/simple;
	bh=ioj31fCYdywMjCoiLQi0yNH1ROl+h6WOhuCRsAzTMXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NwD1QEMws25Gmel71ntXeIuCDCcU+X+If/+G4E6yt0qEgWv9yoaGJE6YnOqs1vRLeU7mqqtA6y8ka2Y4vmvFied7isttDxFMdOJgAwcAoLk2Ptig3ZIk0xseWsu9j/ycny7SETIbLJZKmOcaSl6n8xqNXoD4mJQmdOB7B/2k5lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow6LmtHS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow6LmtHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BE41F00899;
	Fri,  5 Jun 2026 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651333;
	bh=Jn+jv4J+mnQe29rTKcMoZd4FHc4QkUXPXIUHfKBPrRY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ow6LmtHShkBXW/wE6BvcYW+xmY2AVfjuRlaa5HwGNr1ZnWwtlO4fM4/MMnddOS4ma
	 H3YnT8/LPFDWBh8sKAH9v/sFqryTwlHZztap+ThQ4ImI6qt9AJ6hNpLSLijgclJdSC
	 7mQnlNf1DVyhTQjUtPvo6ahRzILjNo1bA2/vL7qpnZwzOXgXFSQOwz54doq3DWP2gl
	 1Jbl/bhZ2C2fJ4NII8IISkHfcMoLEpy0rKclnLNL7zC23ADBRXA/a3KJ0/GmwNm1WT
	 pbUh3sCmZ6G1ZzJAJT6SMYl3TbdCXFeugOYwEF0qVkoxtIF9POhS0HR8Vmivih9zJf
	 JB6J3D+rBMu3Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:48 +1000
Subject: [PATCH net-next v2 04/15] mptcp: introduce
 add_addr_v6_port_drop_ts sysctl knob
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-4-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5725; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ioj31fCYdywMjCoiLQi0yNH1ROl+h6WOhuCRsAzTMXA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUxItj0KhvuVum64CQpbFZptgFIjDQm+KnOy
 2Tle2qXLBKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c3CBD/wLdb9bzclZB0PJscIqjrloR3pCPIkpmXmgv1BxfaOUZkbNN35Og7KdI/VDXRow3MTNSnK
 zts1g/j0eh4408lpdYo8VAyQ4UOqjl6X989nUWd8+PbBFAhwANfFyIG+9Arc74h/EOznkIfZe9B
 /tIz1tv7Mcqz9oFXQzW9rKi1Ngrh4euesmkJHqTPqt8ov7RwJQRvKg7hhPpBQ3bRzjbHHyRJjTn
 xQMNBtZbL67UlhAiRSks9cKk/jmHtqyDvm6nvRVP0BbpR9PHXWFzWgYrMOLSe9Drq79IuuF/Gd1
 9EHVFnWBgyxI0j0cJ4jHiMbD2BkfjLtbT0Z53MWUnJ62pznSNAIcxm7xLjzGdUDNdhw25G6d0uo
 B/0fUj2wCZPMs8VgSrbvBP+8BQK3VfDHMf5cKijLGm5dqrPvUwGghUfEqWo2r8fVScI7fsptOcZ
 2bJIQJ6kz9wYZzR7JMt1XEvR+ijaxDgKPIqztZRgrm1F8UtDVDRLR8T6ex6y/yXdzqi007O23Z/
 /N3RG8budd+nO3s523Kb2yMkkE2i2U+GwOws1cJCfnSF/tVUDttUPi3paNq83X6FyK4J+xDKuZh
 Id9I6uJOgeCjKTz6ATI1KD6+I6phXLWOEn/s5A1kDDJkBd7Jc6I30/ouTCchaH/OLrJ8WDzO4eq
 OHDKa69Hhjgqs5w==
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

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
- v2: Use READ_ONCE() to read sysctl data. (Eric Dumazet)
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
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
index d96130e49942..63c5747f0f63 100644
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
+	return READ_ONCE(mptcp_get_pernet(net)->add_addr_v6_port_drop_ts);
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
index 4dfea209ac16..b43dae72e7de 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -798,6 +798,7 @@ unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_path_manager(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
+unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net);
 
 void mptcp_active_disable(struct sock *sk);
 bool mptcp_active_should_disable(struct sock *ssk);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ac8dc7051aae..70d5b26be4e0 100755
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

