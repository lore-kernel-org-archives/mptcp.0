Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D527CCC7
	for <mptcp@lists.linux.dev>; Tue, 29 Jul 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777364; cv=none; b=QNA/tdDBccA0Eu5/oMkp9tEKzLdobuJuZUSgBVz/S46mz80/7uyNZwowKNrC7NwELlqIfxSHC3c+q0keH813nsUoE7+k+FI0TBF3fcbsEvI5MAMDJqVn0uyNy0Hc3GWWO7bwlf6wBWAVs1PCPvBYXh7ti289TfZu2NQ8wag1nNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777364; c=relaxed/simple;
	bh=4SLld/O3NxZJuOjnaHqLXMNohhdDfaiwVl9qwASiMuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAXHEX1qbJ4jAXmnB1hWvlkvufG62QgO8+wqC5JJKTAesRfkmm3nOegZmlNNVt0VKuHtO6JePY2EB14379aSLQT6lQttNXrVFY1pbXgMvp28p2ifgyRcEQExX3pFDLh4k6CyRT2Zsx2TROKwy1UXQOE6Y8JOay5XnZkjBm9Tka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkLnbR3e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkLnbR3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E24BC4CEF8;
	Tue, 29 Jul 2025 08:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753777364;
	bh=4SLld/O3NxZJuOjnaHqLXMNohhdDfaiwVl9qwASiMuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkLnbR3ea7meLhiQpU5kiL/W64ZZ1cEQ6IpL0kG3qQPRiO7vay3skAuVr6tHgFglq
	 bhgu7V7QaGUuQ9gY0Tp42rED73iH9iuacdLdZcFPpMPIwGwRNxzjWyI+YXcrX9fgvA
	 irtnxatNp7P4zaEz8QA5hhIcoxfciNEAs5oUtSkfh9lLYi68a58Z3hBbvUuFbePiAg
	 8JXGDWVJ7lWNDmqLV0sjpysS/IJirZySJxxu/k4UA/8ry3KPicOT4wroSJ+uYO1off
	 w4XjJzuJkV29B6AFP4lhGN4Ympc25sYbSaA4S/LocQBPwUeinbjY6pEKeB66gjxDdu
	 wN8wDI2GnNomA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] mptcp: make ADD_ADDR timeout adaptive to subflow RTT
Date: Tue, 29 Jul 2025 16:22:32 +0800
Message-ID: <12b2e330c05554b030615375f82b5af1fb7b8289.1753777199.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1753777199.git.tanggeliang@kylinos.cn>
References: <cover.1753777199.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch makes the ADD_ADDR retransmission timeout adaptive by using
the maximum subflow RTT, while still capping it at the configured max
value (add_addr_timeout_max). This improves responsiveness when
establishing new subflows.

The change:
 - Adds mptcp_get_add_addr_timeout() helper
 - Uses subflow RTT when available
 - Falls back to max timeout otherwise

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 40e8ebe566e5..bf4d92293e1e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -268,6 +268,27 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static unsigned int mptcp_get_add_addr_timeout(struct mptcp_sock *msk,
+					       const struct net *net)
+{
+	unsigned int timeout = mptcp_get_add_addr_timeout_max(net);
+	struct mptcp_subflow_context *subflow;
+	unsigned int srtt_us = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		struct tcp_sock *tp = tcp_sk(ssk);
+
+		if (srtt_us < tp->srtt_us)
+			srtt_us = tp->srtt_us;
+	}
+
+	if (srtt_us && srtt_us < timeout)
+		timeout = srtt_us;
+
+	return timeout;
+}
+
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
 	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
@@ -302,7 +323,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout_max(sock_net(sk)));
+			       jiffies + mptcp_get_add_addr_timeout(msk, sock_net(sk)));
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -354,7 +375,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout_max(net));
+			       jiffies + mptcp_get_add_addr_timeout(msk, net));
 		return true;
 	}
 
@@ -370,7 +391,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout_max(net));
+		       jiffies + mptcp_get_add_addr_timeout(msk, net));
 
 	return true;
 }
-- 
2.48.1

