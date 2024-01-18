Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1078F4F
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558330; cv=none; b=Xb1bn8/q8Cw92scYVuGewglx3s1pxyIbp/ebKanr1AAYTFkJqYTBWC0npv1oi1UQ3GhoSi+MavYk698lhnyverRO9hQIbaq+XyDwU7nnnLG9f9vo4YNEIH0fDBsZrXhlGDRi9JHgqtxCUkF5FVfXsoEalt6GSLw9fATtpbwcaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558330; c=relaxed/simple;
	bh=c6y3uYM4LtlWZlCsKB2PtSfYpeWHPGbBGRR9dzI75OU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=HIVrObX51IceGK+gRhz9kFJbs2OioJe/Vo5h1xlM3szsYJxszpNNiXEJ8XyCuIngVqDYKjpghg+kUN2Nw8om6u8mWKd8EX95kUnj57QR4BgUYGELnkRDKaVmTFPMgzBZaf8ENEIRiwJlEFCG3kDHLnIiqi9RJCPek0MfyUVf/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4obPH4F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4obPH4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB92C43390;
	Thu, 18 Jan 2024 06:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558330;
	bh=c6y3uYM4LtlWZlCsKB2PtSfYpeWHPGbBGRR9dzI75OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W4obPH4FNLerpjFAejsJTDRNylgR14jo7JhwrOLFuk8F9Txg6Jv4w/C5ySShjlDjU
	 ZFymuqG7c1HEwJ+PId6FbyIkr+Zv+YsIWo1kuIcAVqC6IwaRoZ++1kGDEtOdJwqBJ9
	 tEyT+6mK+xVk7DjDAn25sR6Ou5Wlvch0rrfmehsA6t1JCl2igp9C541jWxEDLXPlwx
	 m8RoWPelQeUlrdbNdhDEmPgJRhmge6i8pz04Lt9mR9SGBy1ZvtLhL9R/6gvtNC7TXa
	 S98qTqEU07KVpFLg1J24V1BVrRQ8bsm20poDAzSwKWwVWnwTJCl7G65+ko14mgSjqz
	 1DO+v92qkIo2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 01/23] mptcp: add pm_has_addr_attr_id helper
Date: Thu, 18 Jan 2024 14:11:41 +0800
Message-Id: <9d4caf4cbb5f75d8bc057cdd2f073c243a2dcf92.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper mptcp_pm_has_addr_attr_id() to check whether
an address ID is set from PM or not. It will be used in the next two
commits.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 12 ++++++++++++
 net/mptcp/protocol.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ae19113b8eb..6856d10368be 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -533,6 +533,18 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
+bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
+			       struct genl_info *info)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+
+	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
+					 mptcp_pm_address_nl_policy, info->extack) &&
+	    tb[MPTCP_PM_ADDR_ATTR_ID])
+		return true;
+	return false;
+}
+
 void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d442d876f465..0d634e01c47d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -887,6 +887,8 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 			 bool require_family,
 			 struct mptcp_pm_addr_entry *entry);
+bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
+			       struct genl_info *info);
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
-- 
2.40.1

