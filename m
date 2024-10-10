Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756A178372
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539292; cv=none; b=PVnQuZ7Pog46XeggsxNra51qdKGqv6xuGxCyJ6v+5DE4VVup6ZBs2zni3dGdUWK221QkuRFlnsQbOG8CB+GQNKB6y9cl82+VGjXfm2r0G5a2GLBzRVnrgKCZ/LykRhzGdTeTcqXtDkSo7morLNKdHVQVlM0glYJ8nBedNV0hkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539292; c=relaxed/simple;
	bh=krUOwXJLUN+fqjuerSUU4G59lOnIqgt4DUsd1Huazr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxhWC7PBdp/kStvqbaMk2HjYhH/5klrJhTrVY2YbzrKO6nMoOl991xrdPNgaq6m0+RlSJ9wNwvv7CSmVBqcN6AFLZl6pVE1nq9STs7BQU25C6j20EZwE+j3XzX89vJ8vNIUnHfDR67R+thpKpu72rf+WOAIYZ9m+NT+byuC3iU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLnSbl3i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLnSbl3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDDEC4CEC5;
	Thu, 10 Oct 2024 05:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539292;
	bh=krUOwXJLUN+fqjuerSUU4G59lOnIqgt4DUsd1Huazr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLnSbl3iPKsC+zuRAgOl0UFRkhwJ7CyV42pWlEvXEs6Q3UIbzgZs2hDq0fMz3mAuO
	 30Fb51X2Lux71loq4yvuSVav+a8BhB+QyksANcVvZ5JOGxR28eqv/lcZCnyHDLb7j8
	 02XwaSi7r2m/IGTEZZROImuskS7Tb6v1agj1V1edLmYyE1h62KQHGWEhOh2jBLlSZE
	 DgTDezYfiEt60C4LBhuTJ08UhRA3WaSEcgxyMIi6p+TKs0b3XBdBL0Pl2ezSf9XydQ
	 Go8AC6BCfJyF7e0G0S1BF0FE0PzxGRBFFpHBGldW7LmAf8MDqnRpF2/Vjy3QsnVVH6
	 ae00gg1QHyovQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 03/15] mptcp: reuse sending nlmsg code in get_addr
Date: Thu, 10 Oct 2024 13:47:48 +0800
Message-ID: <9fda01ae94466616a138b94f91e4549d410e3a85.1728538976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728538975.git.tanggeliang@kylinos.cn>
References: <cover.1728538975.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With the previous commit, we can reuse the send_nlmsg() code in
get_addr() interfaces between the netlink PM and userspace PM.
They only need to implement their own get_addr() interfaces to
hold the different locks, get the entry from the different lists,
then release the locks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 58 ++++++++++++++++++++--------------------
 net/mptcp/pm_userspace.c | 33 -----------------------
 2 files changed, 29 insertions(+), 62 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 76c4520f7cb5..353878f64e8e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1797,21 +1797,7 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry *entry;
-	struct sk_buff *msg;
 	int ret = -EINVAL;
-	void *reply;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
-	}
 
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, id);
@@ -1821,21 +1807,6 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	}
 	spin_unlock_bh(&pernet->lock);
 
-	if (ret) {
-		GENL_SET_ERR_MSG(info, "address not found");
-		goto fail;
-	}
-
-	ret = mptcp_nl_fill_addr(msg, addr);
-	if (ret)
-		goto fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	return ret;
-
-fail:
-	nlmsg_free(msg);
 	return ret;
 }
 
@@ -1851,13 +1822,42 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr;
+	struct sk_buff *msg;
+	void *reply;
 	int ret;
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
+				  info->genlhdr->cmd);
+	if (!reply) {
+		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
+		ret = -EMSGSIZE;
+		goto fail;
+	}
+
 	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
+	if (ret) {
+		GENL_SET_ERR_MSG(info, "address not found");
+		goto fail;
+	}
+
+	ret = mptcp_nl_fill_addr(msg, &addr);
+	if (ret)
+		goto fail;
+
+	genlmsg_end(msg, reply);
+	ret = genlmsg_reply(msg, info);
+	return ret;
+
+fail:
+	nlmsg_free(msg);
 	return ret;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5c9f740bd9ac..4c4693c5aae9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -634,10 +634,8 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	struct sk_buff *msg;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *reply;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -645,20 +643,6 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 
 	sk = (struct sock *)msk;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
-	}
-
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
@@ -669,23 +653,6 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
 
-	if (ret) {
-		GENL_SET_ERR_MSG(info, "address not found");
-		goto fail;
-	}
-
-	ret = mptcp_nl_fill_addr(msg, addr);
-	if (ret)
-		goto fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	sock_put(sk);
-	return ret;
-
-fail:
-	nlmsg_free(msg);
-out:
 	sock_put(sk);
 	return ret;
 }
-- 
2.43.0

