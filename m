Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E343C469
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764754; cv=none; b=O0uHorpCS6FeeQFOgHbLlGyw0uk6fPpeZarEMijAVkWPnggVhdyBHRGPTNNECHOGcnQYEve3j0fkiz8BY5ThtadGAcgD4VAkH1uC5nsCVaJjAoQr+n6CL17+blldUquo+PsdJ0GQledD36jJylwjiTLwWrdSG9FG1BUitO0fbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764754; c=relaxed/simple;
	bh=Hrg2bUtfefYcSiOtvay68csoP6XOzPk1fakYhM+R2Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N04xkJgwpKURX9cHjTkSlgGLV2TinG2ScYcHb8KbOR4zzuGTbpk2MrJORo5PRgOdnElkt3JANS2ELD++HnNAXIDr5ecFRB5k0YjcTJpNf03Yry/wcEDwlnHeS+4A2O8xKzh1u/hQMDmYkm3SICGTvld+xh0/VVClzIy5Wh1INMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE5+26wD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE5+26wD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7DBC43390;
	Thu,  1 Feb 2024 05:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764753;
	bh=Hrg2bUtfefYcSiOtvay68csoP6XOzPk1fakYhM+R2Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LE5+26wDvOAPEzT89Qgo76C+WCrIUlTh0bjpvu3q8GzVXur+A1ZdO/Qf3aXrDa3Yv
	 3SxGk+02jZsWZLHKkbSbP4h1WcudLdRkTb2omuMEd+Rf0waC5tnV2ft+StJVkwWady
	 UhECLXbVAfgAmZkZoW9T2t+6JwrOFy7WEUlZ39bYUeSwx4NpRu2fk3QVHjmh7jJywW
	 8ybISuuyeUmo90Zz0u0uceFotJX2mddsAcZIVQEKTkJY0ptqvpZfyLbQ2O9eHqkb1k
	 ZZQdvCoDrK5+x/TOgErueFt+kOXT1juKYbwp+/q1fu2/qGvo3s+cPmN2kV5IXC1Szy
	 Ixd9mZtIzViLQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 01/15] mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
Date: Thu,  1 Feb 2024 13:18:51 +0800
Message-Id: <03ae7973456dcb1f5a51c839dfccf4a7e3f3b509.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch exports struct mptcp_genl_family and mptcp_nl_fill_addr() helper
to allow them can be used in pm_userspace.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 9 +++------
 net/mptcp/protocol.h   | 4 ++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9367ab506908..4d06a710aee6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -18,9 +18,6 @@
 #include "protocol.h"
 #include "mib.h"
 
-/* forward declaration */
-static struct genl_family mptcp_genl_family;
-
 static int pm_nl_pernet_id;
 
 struct mptcp_pm_add_entry {
@@ -1633,8 +1630,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static int mptcp_nl_fill_addr(struct sk_buff *skb,
-			      struct mptcp_pm_addr_entry *entry)
+int mptcp_nl_fill_addr(struct sk_buff *skb,
+		       struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_addr_info *addr = &entry->addr;
 	struct nlattr *attr;
@@ -2278,7 +2275,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static struct genl_family mptcp_genl_family __ro_after_init = {
+struct genl_family mptcp_genl_family __ro_after_init = {
 	.name		= MPTCP_PM_NAME,
 	.version	= MPTCP_PM_VER,
 	.netnsok	= true,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eefd1397106d..b6664f58e0ad 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -343,6 +343,8 @@ struct mptcp_sock {
 #define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)			\
 	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
 
+extern struct genl_family mptcp_genl_family;
+
 static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 {
 	sock_owned_by_me((const struct sock *)msk);
@@ -964,6 +966,8 @@ void __mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflo
 				     const struct mptcp_options_received *mp_opt);
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
+int mptcp_nl_fill_addr(struct sk_buff *skb,
+		       struct mptcp_pm_addr_entry *entry);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
-- 
2.40.1

