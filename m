Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A041567D
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881336; cv=none; b=U/HgTD38pZ7U96vrvcycTxCWqWsk9ZYzvnd5dT70nde4p2nhIWyC6uN65z53Kx03DcdJo0Hef9OmAqsQH9iBQGcD9qUm+KaIAfMQwmOKt3Nirrn7iz6avrwGna1EFHs/AUPkpZyGUpKmsWyeEJeXymnNLq4OGlsePLbFQ8/BEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881336; c=relaxed/simple;
	bh=9gAMrj3rtc/c79aZHt7/nZg85VuJDwemdMmn6OAOFDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxQj/4R8I2mDXeVPBQDiRk5dmF8LwaArt5UlcjKu1Y3GKEpvzauW3p/CxkbW13oREhHG5mpO4azah0sFWxNDIBE0Yus4SKyh7n9WXWp7JIbSKT36v694B93Gb4EAjh9IhCUp3nOLrwsD9Fgtk5sAZ0jlLKt0V68/qYQe4VoCZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kyq5+9em; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kyq5+9em"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F807C4CECD;
	Wed,  2 Oct 2024 15:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881336;
	bh=9gAMrj3rtc/c79aZHt7/nZg85VuJDwemdMmn6OAOFDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kyq5+9emVD14NRfBAo/pSTwseYeGRGC1542KVFIcpzWh0shLsCctbYLq3YJbvVQLt
	 pxHm5eD5IRV+PA6GTPTW3nJ+WohepIp4fV0UndZYB2xNi8Gd0u81mncuuG58fGYfHt
	 m7PiFbm0H52CWOQXOx3ayaM+HbO3bm2X+5/eLYi/LTvG2qA3NPm0KUqvGJQqDYEyNE
	 53eGT+q/GcDjpnTvs1x//gg8eBTn/KYEq5rj5uUI+ua3qiwUh/JyAPOG9MPwQCepvC
	 SfpK5KvCXQnq3Ss7T+6vy/g1TxOeogbFP+AR+xI8kzFIZ4fh8MquC7YL52UpoJ/hs+
	 88JX2oQ3TDvMg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 8/9] mptcp: drop skb parameter of get_addr
Date: Wed,  2 Oct 2024 23:01:58 +0800
Message-ID: <fc77f5b50dfa54d5a29381100b3f6409c8db45c9.1727881073.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727881073.git.tanggeliang@kylinos.cn>
References: <cover.1727881073.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameters "skb" of all three get_addr() interfaces are now
useless. This patch drops them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 10 +++++-----
 net/mptcp/pm_userspace.c |  3 +--
 net/mptcp/protocol.h     |  3 +--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d7a4199b142e..f02378e9a9c8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1790,7 +1790,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1840,16 +1840,16 @@ static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_get_addr(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(skb, info);
-	return mptcp_pm_nl_get_addr(skb, info);
+		return mptcp_userspace_pm_get_addr(info);
+	return mptcp_pm_nl_get_addr(info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_get_addr(skb, info);
+	return mptcp_pm_get_addr(info);
 }
 
 static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9ff441beebe6..6711c1e1dac7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -629,8 +629,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr, *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 95533d5b82c4..238fb2ddb68a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,8 +1127,7 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info);
+int mptcp_userspace_pm_get_addr(struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

