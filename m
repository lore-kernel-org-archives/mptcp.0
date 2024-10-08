Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F73175D32
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381520; cv=none; b=od+V9Wq3CHrwE2kXKQEvlPUXpqL1KpxA5qFmqCVpRof1uuuvBGhSVP1DIKwkxs8rRK8Vyrg80Cju6vyGBafPv0Ec9rtnapAr4tPqAlCpX9nIWWSpOTt5tu4fOD0uzRxcCev16vskj+qBjIxxb7pjyX4+1W2wl3iJj1Q2gBHKqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381520; c=relaxed/simple;
	bh=qLb7lc0Dkl+HmK7OhQ/VpkagzD4Mzq0RXcLwu3voLRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbdFva3nctvqSnnR+TwIypGtF+7cM5b+7fuxbzRuCzzwaGB4OhOqpvTrQ8YVoEaGZTKVJaAbOOb1YvBCe5S6nxLecNLH0TuEPc9yG7wPnxf3q47S/6WmnCHBX4pzILzMsdE20+hXb2TlTfBjSDw07zBjZS7C6Ah6REK8Feqc4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVKpSURe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVKpSURe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CEEC4CEC7;
	Tue,  8 Oct 2024 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381520;
	bh=qLb7lc0Dkl+HmK7OhQ/VpkagzD4Mzq0RXcLwu3voLRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVKpSURe30b6Jr2PShq6/sT36xhOeV3oOCTSZiQDvBpYZdsZpwiYNSYINEdOmFkzp
	 VElgjdGvDqibgJiFCWxd27tD903NKVnwBfvEow01mnqO1S/Nc02mGXPV49hkue5pWY
	 mqC+UKsnLpAlYlDPNYpbW1KmejOGQAWJUiDvYR3CFIV6ZhGIGjAAO0wHxf5EGbAs4G
	 qp2/ZCOgR23XyrxV08cd8HfQjkd+CaYgGRdYjE9b0Fbwi9jvSg/1ia0/ejklp4jba+
	 EYOKmzRtI8IfRDeY5tPU5mwrcDvs86ofHXQoKafsMniC7glByLgenEsqtG6iNNbc7A
	 VzzDRMoYVkV0Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 08/13] mptcp: add loc and rem for set_flags
Date: Tue,  8 Oct 2024 17:58:12 +0800
Message-ID: <c65907a06788564be70ca583a76bff3b9d3daa3e.1728381245.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728381245.git.tanggeliang@kylinos.cn>
References: <cover.1728381245.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch updates the interfaces set_flags to reduce repetitive code,
adds two more parameters "loc" and "rem" for them. These addresses are
parsed in public helper mptcp_pm_nl_set_flags_doit(), then pass them
to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 38 ++++++++++++++++++++++++++------------
 net/mptcp/pm_userspace.c | 26 +++++++-------------------
 net/mptcp/protocol.h     |  4 +++-
 3 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 15ec8a193279..2a995e60ce87 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2044,25 +2044,21 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-static int mptcp_pm_nl_set_flags(struct genl_info *info)
+static int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
+	struct mptcp_pm_addr_entry addr = *loc;
 	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	u8 lookup_by_id = 0;
 	u8 bkup = 0;
-	int ret;
 
 	pernet = pm_nl_get_pernet(net);
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
 		if (!addr.addr.id) {
@@ -2098,16 +2094,34 @@ static int mptcp_pm_nl_set_flags(struct genl_info *info)
 	return 0;
 }
 
-static int mptcp_pm_set_flags(struct genl_info *info)
+static int mptcp_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+			      struct mptcp_addr_info *rem,
+			      struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(info);
-	return mptcp_pm_nl_set_flags(info);
+		return mptcp_userspace_pm_set_flags(loc, rem, info);
+	return mptcp_pm_nl_set_flags(loc, rem, info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_set_flags(info);
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
+	int ret;
+
+	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
+	if (attr_rem) {
+		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
+		if (ret < 0)
+			return ret;
+	}
+
+	return mptcp_pm_set_flags(&loc, &rem, info);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8858877d82b0..5175c30bcd64 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -536,12 +536,10 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -553,28 +551,18 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
-	if (ret < 0)
-		goto set_flags_err;
-
-	if (attr_rem) {
-		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
-		if (ret < 0)
-			goto set_flags_err;
-	}
-
-	if (loc.addr.family == AF_UNSPEC ||
-	    rem.family == AF_UNSPEC) {
+	if (loc->addr.family == AF_UNSPEC ||
+	    rem->family == AF_UNSPEC) {
 		GENL_SET_ERR_MSG(info, "invalid address families");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
 
-	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, rem, bkup);
 	release_sock(sk);
 
 set_flags_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0a4edb7ee1ed..3dc113ced4e8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1035,7 +1035,9 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_userspace_pm_set_flags(struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.43.0

