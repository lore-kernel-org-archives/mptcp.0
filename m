Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80713A3ED
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020269; cv=none; b=rsyDC8R0ErLr5ZFglzVYKBz8Li7d8nk/DVwkRevoHMv8EuBvZFvV+AW9+L7Oxc9kyZQRMAWKu4gQ3txdAYZ965l8Fs1NqsMuIWWdzdygwtaXiZqz52avV4sPcoaRr4hJawzYxhMKGVqJuX5QccxVbGOLRMJTr6DDbZUGawt/1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020269; c=relaxed/simple;
	bh=ldOQrLusbg/Bdv5yC2VnZeszKVKnyVJdeQCc/aR5f2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpWMqQhvxxWfCGnketCZzDJ4Xi0KHLmwgYKILEK4WdBjoUaGXKbo87kQoGvNiHEhgsca0yRv7+SjSljiOBsTAAhfSj1ixPNbu181wZez0M8OCjQiT4L3caxVeQs/aqYZLq1XGbs9JnODo0PMUMDkHvkoAs5DqziSKYQFQkgleJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/F+TD3j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/F+TD3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EADC4CED6;
	Thu, 20 Feb 2025 02:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020268;
	bh=ldOQrLusbg/Bdv5yC2VnZeszKVKnyVJdeQCc/aR5f2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/F+TD3jXJGyhEIL/nFuGMRS/IHslWBOqO/RpE8+TLcSh+Mw6xAvMIcX67rWUpV9e
	 GOSQlGiuFsGN7dmUQlOJa9oNjzhrzTnVNpDBCUSGekMN50Wp7Y00iWbKWZApY5nldm
	 nh+naVWLCikC8eUqAWvmsE77qTfU8fWJdDGPp1Ky6IghSKOwcQTX0T/n+5vpG73iAF
	 DKibesmpdZjHGumj1lvFo0VpzXcPXDkPMCtiHD+wwSrJLwbUNZ6Q1v/Odoq7QyKLUS
	 i8T5vBp4gOLaalwOp5w1cf/JN+Tfx1CqZe0vh06qGXqFurycuGlf9eoE+2NmQoUDxV
	 iWWYfMFqkaNDg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 5/9] mptcp: pm: in-kernel: register mptcp_netlink_pm
Date: Thu, 20 Feb 2025 10:57:29 +0800
Message-ID: <e36ff7c51473783b1031db7426888a13b7b77eb9.1740019794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740019794.git.tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original in-kernel netlink path manager as a new
struct mptcp_pm_ops named "mptcp_netlink_pm", and register it in
mptcp_pm_nl_init().

Only get_local_id() and get_priority() interfaces are implemented here.
mptcp_pm_nl_is_backup() becomes a wrapper of get_priority().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3709ad2c06ef..e0f8754e261e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1172,9 +1172,11 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 	return ret;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+static bool mptcp_pm_nl_get_priority(struct mptcp_sock *msk,
+				     struct mptcp_pm_param *param)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	struct mptcp_addr_info *skc = &param->addr;
 	struct mptcp_pm_addr_entry *entry;
 	bool backup;
 
@@ -1186,6 +1188,14 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
 	return backup;
 }
 
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_param param;
+
+	mptcp_pm_param_set_contexts(&param, NULL, skc);
+	return mptcp_pm_nl_get_priority(msk, &param);
+}
+
 #define MPTCP_PM_CMD_GRP_OFFSET       0
 #define MPTCP_PM_EV_GRP_OFFSET        1
 
@@ -2373,6 +2383,13 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+static struct mptcp_pm_ops mptcp_netlink_pm = {
+	.get_local_id		= mptcp_pm_nl_get_local_id,
+	.get_priority		= mptcp_pm_nl_get_priority,
+	.type			= MPTCP_PM_TYPE_KERNEL,
+	.owner			= THIS_MODULE,
+};
+
 void __init mptcp_pm_nl_init(void)
 {
 	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
@@ -2380,4 +2397,6 @@ void __init mptcp_pm_nl_init(void)
 
 	if (genl_register_family(&mptcp_genl_family))
 		panic("Failed to register MPTCP PM netlink family\n");
+
+	mptcp_pm_register(&mptcp_netlink_pm);
 }
-- 
2.43.0

