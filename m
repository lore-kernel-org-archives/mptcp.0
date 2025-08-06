Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A038D
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 03:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450265; cv=none; b=NeXWXFHj+3Tk0HeGkuOkzmROkqQcDGDvchveMbKV9Mi8srKcCFq0zX66Kv7FC6PwSuX53kWPtXoXSHY2M5MvJWj6My7IAZS1F9dcUG5/6urJpvWvesTWX8OmQkk9SMUgvfxLqjl4C1CcUMS2AGE39gfCDw8crcCD61E5B+B1niM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450265; c=relaxed/simple;
	bh=owLI5asS97YyvcETqEgiYcsJ82iv3Ha7lxRbgvu9PO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osWEW4huG1Zt9d+qGqo6L4s5brt4DDEDBuWxvszxOG/g1SHNPHz/NEI1D1haiZRsjK/L5UgQ8pQkvmkgvMaGQNhW6AkwiSSETV23UdsXlqlzDHvLR26yjgyMn55ehXJ7QwQ37jSKkE4eSleGiFWzJsPkjWibPfFlQTMwrcsjTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa68irgj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa68irgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DECC4CEF7;
	Wed,  6 Aug 2025 03:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754450264;
	bh=owLI5asS97YyvcETqEgiYcsJ82iv3Ha7lxRbgvu9PO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wa68irgjN8mPoZMVPzzChi5kaaNnfV4wTSDpB3YLdUdHfve0As35cQKg8aBM6x1Dd
	 wdreo4hu0ORjXQ01Dy3PZS8YPgxvnxwP6MDrPy/Hi7J00GBmIEi0PKUJ87Ej5kGBCB
	 /rmas2DzIYyvE1uiGhnUR66MJ9krFVdy7rjmTbDGdToX1e7BeYTI5zDnPnG08kKj6Y
	 UUuYOjeKyF90N+hqMfX5Zb0QTDaJ4ZzBP3MT25g/rgkAT4oLahJbSn9MYRBa5bapbs
	 FIDJJhNF9UqwuzJ5eRvFt53SLOcia51v9cj+LuXO5D/lpuPyw8IUA4hhNQZvwTDHlx
	 mdSt8h+s68iEA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Christoph Paasch <cpaasch@openai.com>
Subject: [PATCH mptcp-next v3 2/3] mptcp: make ADD_ADDR retransmission timeout adaptive
Date: Wed,  6 Aug 2025 11:17:35 +0800
Message-ID: <c559f29eea1e019b6d25a35f05bbeb85fdd578e1.1754449947.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754449947.git.tanggeliang@kylinos.cn>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replace the fixed ADD_ADDR retransmission timeout with an adaptive
mechanism that uses the maximum RTO among existing subflows. This
improves responsiveness when establishing new subflows while maintaining
an upper bound through the configured add_addr_timeout value.

Key changes:
1. Compute timeout as min(max_subflow_RTO, configured_max_timeout)
2. Apply exponential backoff based on retransmission count
3. Maintain fallback to configured max timeout when no subflows exist
4. Update documentation to clarify add_addr_timeout is now the maximum
value

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576
Reviewed-by: Christoph Paasch <cpaasch@openai.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 Documentation/networking/mptcp-sysctl.rst |  4 +--
 net/mptcp/pm.c                            | 30 ++++++++++++++++++++---
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 1683c139821e..2b8e8fb99ee2 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -8,8 +8,8 @@ MPTCP Sysfs variables
 ===============================
 
 add_addr_timeout - INTEGER (seconds)
-	Set the timeout after which an ADD_ADDR control message will be
-	resent to an MPTCP peer that has not acknowledged a previous
+	Set the maximum value of timeout after which an ADD_ADDR control message
+	will be resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
 	Do not retransmit if set to 0.
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1330af6a2154..34cc4f45bc7d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -268,6 +268,30 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	unsigned int max_rto = 0;
+	unsigned int timeout;
+
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		unsigned int subflow_rto;
+
+		subflow_rto = __tcp_set_rto(tcp_sk(ssk)) * 2;
+		if (subflow_rto > max_rto)
+			max_rto = subflow_rto;
+	}
+
+	if (max_rto && max_rto < timeout)
+		timeout = max_rto;
+
+	return timeout;
+}
+
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
 	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
@@ -292,7 +316,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
-	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (!timeout)
 		goto out;
 
@@ -307,7 +331,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + timeout);
+			       jiffies + (timeout << entry->retrans_times));
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -373,7 +397,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 out:
 	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+		       jiffies + mptcp_adjust_add_addr_timeout(msk));
 
 	return true;
 }
-- 
2.48.1

