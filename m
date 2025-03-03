Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422613C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975930; cv=none; b=lc/JKAjZqRi0vF38KZQOb2E2rrjWspBO/8pmdAInJwwQQjf9o8dztr4g9usM2VoDNZxi8rFYMRTzsgwXimkhkGxdIJciPACRiKHtDIdsmPSnXlt8npcCIXIEffH88dhzwtK3dOT1Cq2cpfth8uXUhwWqi61l3hmuBgcAfL/alAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975930; c=relaxed/simple;
	bh=oREgXKSaBOtVXsjI6mBw5QYR1vD/O+hZ8GpelkZnlLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnCbiVlP8y+YtjZtzIE7/KNGu841e9fUVAOXshyxx6orYuyzKymzUhiN0BINoq1AP3exnutHUu2p/yxx7gKxxawAWyG59YFBD7c4/R2SDaxKSL6cDAOclroDsI3jyZfb34BGe/ZCesEHGc5khBOBnM2DhdkV8kugGvkgcOTPAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cie5zU9G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cie5zU9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39071C4CEE4;
	Mon,  3 Mar 2025 04:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975930;
	bh=oREgXKSaBOtVXsjI6mBw5QYR1vD/O+hZ8GpelkZnlLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cie5zU9Gq/3fyKI3YcQIMHW9ywr92yJwjblzJoaiqsPk8p31eFt+e2MQ5PN1kaUpz
	 3Z0Q7xGmDPTaO5tvor1mBg28XPKvgQ3qSvtniCr4pMUSneNtEYR1F3dZzVe2vlSo+j
	 LV/+XVwptaXlJ1PrMIH+B+d65mjkMwOqbXDc3qexbBk7Xyy9JQ7m81XO5R2oQtMEre
	 k/P30xCp32xbHsxjq+i60i5ArT97lQWUsYI2ugva3NtIfB2IELP3eW7oDnGmqsmFCY
	 vZMrX1xjREOhKD4m/SfDkiyB/ky71elG+ohQpYMP0J9FytvXxwqkgr8GXUB5IDX9IB
	 axWHJOzm7BMTw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 06/11] mptcp: pm: userspace: register mptcp_userspace_pm
Date: Mon,  3 Mar 2025 12:22:54 +0800
Message-ID: <cc2a3970c6bea22cb4562c074dc573aae864247a.1740975633.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740975633.git.tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original userspace path manager as a new
struct mptcp_pm_ops named "mptcp_userspace_pm", and register it
in mptcp_pm_data_init().

Only get_local_id(), get_priority() and release() interfaces are
implemented here. mptcp_userspace_pm_is_release() is a wrapper of
mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  1 +
 net/mptcp/pm_userspace.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 20 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e648cb522320..98f81221786f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1028,6 +1028,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_nl_init();
+	mptcp_userspace_pm_init();
 }
 
 /* Must be called with rcu read lock held */
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8f9e749e9b1a..d53f44df9641 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -683,3 +683,21 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	sock_put(sk);
 	return ret;
 }
+
+static void mptcp_userspace_pm_release(struct mptcp_sock *msk)
+{
+	mptcp_userspace_pm_free_local_addr_list(msk);
+}
+
+static struct mptcp_pm_ops mptcp_userspace_pm = {
+	.get_local_id		= mptcp_userspace_pm_get_local_id,
+	.get_priority		= mptcp_userspace_pm_is_backup,
+	.release		= mptcp_userspace_pm_release,
+	.name			= "userspace",
+	.owner			= THIS_MODULE,
+};
+
+void __init mptcp_userspace_pm_init(void)
+{
+	mptcp_pm_register(&mptcp_userspace_pm);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 56d3a7457f80..979ee8762fd4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1162,6 +1162,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_nl_init(void);
+void __init mptcp_userspace_pm_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
-- 
2.43.0

