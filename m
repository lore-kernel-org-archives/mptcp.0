Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7819F13F
	for <mptcp@lists.linux.dev>; Tue, 29 Jul 2025 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777363; cv=none; b=cCZyIerCNkbIGjSOQnQMrfj0kWLp8CDLBAmcUOmeAH8RImBocWRjmhX4gJVi41UDtDXQCjvdMVMy4MRhu1wmI7zHlL0wmWb9Llt9+Aut6wkrEPh59nrrhXFQbjzEu8o5gizXSQYxhLYtbltr5LgxZ+qkNCWhswISnNIBl41DTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777363; c=relaxed/simple;
	bh=JJNYkFUeD0+//jxkA4HZOgvt6efJpFfJltYxr1Oy910=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tK11eSXW3q+QMNl3vGjVTmQEl59/dj4ogWQw+yDPwGN6WoV1uKPfKP56ieBkLK2m1EE4UiHGXTAxD9d37Z7M80o4de5QBMGDey5829qy5wnsObEL3irtlF7COj8e/MNgzae6OPTVJJjE9Jiu2ATzV32KDD7vijEOHbl/x0K6/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AavxryJ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AavxryJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68149C4CEEF;
	Tue, 29 Jul 2025 08:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753777362;
	bh=JJNYkFUeD0+//jxkA4HZOgvt6efJpFfJltYxr1Oy910=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AavxryJ1k2x0U72axmG/mmOsbb0lsW8JDfOSCGxthIHRbFUVe+rj3Bps+NohN05b+
	 0Nh//tIf6OwgwErUgnEb5dpn9TCiklFMsyH+5UNVckw33xME20vI1MZ7Y0rLeOYk9j
	 GqmbSmRqXdY+wdJhiDRxDw/NMdfys8ZBdJb8kusjC23DzvW1ti1lOSPTrAGuCjIuQn
	 GV8/DhqKOAsZPCP0QRibrAOt9ukR+BZN5mlfLZTn7sJQ7gtvy7ansW6OSZs1WGFxkc
	 Xng7Bdc/pTjZ46m6AeUJsii/9ZaXmXVYQ/zQZuGkMTNx4rJEdFZB/eOPpWaWaf2CQ7
	 zzuxvzVnA0tQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] mptcp: rename add_addr_timeout to add_addr_timeout_max
Date: Tue, 29 Jul 2025 16:22:31 +0800
Message-ID: <ce610ee45e07da2680d5838fd605b1c26543782a.1753777199.git.tanggeliang@kylinos.cn>
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

This renames the MPTCP sysctl variable to better reflect its purpose as
the maximum ADD_ADDR retransmission timeout.

The patch includes updates to:
 - Documentation/networking/mptcp-sysctl.rst
 - net/mptcp/ctrl.c
 - net/mptcp/pm.c
 - net/mptcp/protocol.h

All references to the old variable name have been updated to use the new
naming convention.

The functionality remains unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst |  6 +++---
 net/mptcp/ctrl.c                          | 12 ++++++------
 net/mptcp/pm.c                            |  6 +++---
 net/mptcp/protocol.h                      |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 5bfab01eff5a..1af35757a235 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -7,9 +7,9 @@ MPTCP Sysfs variables
 /proc/sys/net/mptcp/* Variables
 ===============================
 
-add_addr_timeout - INTEGER (seconds)
-	Set the timeout after which an ADD_ADDR control message will be
-	resent to an MPTCP peer that has not acknowledged a previous
+add_addr_timeout_max - INTEGER (seconds)
+	Set the maximum value of timeout after which an ADD_ADDR control message
+	will be resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
 	The default value matches TCP_RTO_MAX. This is a per-namespace
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index fed40dae5583..9a408e96c07f 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -27,7 +27,7 @@ struct mptcp_pernet {
 	struct ctl_table_header *ctl_table_hdr;
 #endif
 
-	unsigned int add_addr_timeout;
+	unsigned int add_addr_timeout_max;
 	unsigned int blackhole_timeout;
 	unsigned int close_timeout;
 	unsigned int stale_loss_cnt;
@@ -52,9 +52,9 @@ int mptcp_is_enabled(const struct net *net)
 	return mptcp_get_pernet(net)->mptcp_enabled;
 }
 
-unsigned int mptcp_get_add_addr_timeout(const struct net *net)
+unsigned int mptcp_get_add_addr_timeout_max(const struct net *net)
 {
-	return mptcp_get_pernet(net)->add_addr_timeout;
+	return mptcp_get_pernet(net)->add_addr_timeout_max;
 }
 
 int mptcp_is_checksum_enabled(const struct net *net)
@@ -97,7 +97,7 @@ const char *mptcp_get_scheduler(const struct net *net)
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
-	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->add_addr_timeout_max = TCP_RTO_MAX;
 	pernet->blackhole_timeout = 3600;
 	pernet->syn_retrans_before_tcp_fallback = 2;
 	atomic_set(&pernet->active_disable_times, 0);
@@ -284,7 +284,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.extra2       = SYSCTL_ONE
 	},
 	{
-		.procname = "add_addr_timeout",
+		.procname = "add_addr_timeout_max",
 		.maxlen = sizeof(unsigned int),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_jiffies,
@@ -377,7 +377,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	}
 
 	table[0].data = &pernet->mptcp_enabled;
-	table[1].data = &pernet->add_addr_timeout;
+	table[1].data = &pernet->add_addr_timeout_max;
 	table[2].data = &pernet->checksum_enabled;
 	table[3].data = &pernet->allow_join_initial_addr_port;
 	table[4].data = &pernet->stale_loss_cnt;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 687dbb59d084..40e8ebe566e5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -302,7 +302,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + mptcp_get_add_addr_timeout_max(sock_net(sk)));
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -354,7 +354,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
+			       jiffies + mptcp_get_add_addr_timeout_max(net));
 		return true;
 	}
 
@@ -370,7 +370,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+		       jiffies + mptcp_get_add_addr_timeout_max(net));
 
 	return true;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index db50b216143a..f2dd45148e63 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -708,7 +708,7 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 }
 
 int mptcp_is_enabled(const struct net *net);
-unsigned int mptcp_get_add_addr_timeout(const struct net *net);
+unsigned int mptcp_get_add_addr_timeout_max(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
-- 
2.48.1

