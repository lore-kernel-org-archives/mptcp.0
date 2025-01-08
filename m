Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD513792B
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300670; cv=none; b=UCfQKdrePLhFOnAKyRN1Q+6fqCagJdPzGetYZKOV1Cu0Kjqy+BsEEfofGJgng9az6aYC7ARO+yXmZo9uZ/pTy1xzF30cjFJ9y5Zh6rvnG6/Ult/R1AeF8bEan9edpa/3roO5xKtECi9+NXNShiBo+hBNF9vqUSfRnzbdva5RRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300670; c=relaxed/simple;
	bh=FnzzqbayxNIm8b3fUmAziev6iX9LYmHm31pnvEZbORQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/EO1Wo0/Iwr6ngjExiLW1L9pE0PUSn3x07PhSEc2mkxDjJNzHtRRXrVSxVYjy5zpOOiLis4wZveWaC3t1xG6ylSpJp9gA7ebv5nhB1/d5kUzZzcuMJbp/TrC7LElfp+weSgw2FkXKdraB7BmO9R+y8oFkQO9+WpFHETmdUwYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcsYd6MC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcsYd6MC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93774C4CED6;
	Wed,  8 Jan 2025 01:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736300669;
	bh=FnzzqbayxNIm8b3fUmAziev6iX9LYmHm31pnvEZbORQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcsYd6MCH8BXxkLiIl4d9bvrILrTo2eSnQC260a+eQp6OEm62B20qILtqH4k0flIy
	 NhF5US1lf61w4OyDoaDwk/D0AjAsrgaP7Vwh70RFafdTMLej6UP7GYeWox6+bwQNCl
	 +VaHWmdcZIe8YnJa+hygb00OUCzmO/j4QJt9ewkUyJNKHbGXZgCQwbb5Y8icSg/NZY
	 7Wb1mvUBF9JyekU0OnSZWxlvjnemw5ekbvxHw3/cbSurORAln55Nl8m77URjj1DX5+
	 FRmRFrLqkqYj3Mgcjql50nEln7jcEinvQ+9Td1OL6ggzGjGVs6yvPvjPqKGmNWO0Kj
	 4hkDfVH9xLZtg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v8 6/8] mptcp: pm: remove duplicated error messages
Date: Wed,  8 Jan 2025 09:44:07 +0800
Message-ID: <ac01a5d320cc24ab7d2ba31d2b462096d6bb5e76.1736299989.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736299989.git.tanggeliang@kylinos.cn>
References: <cover.1736299989.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

mptcp_pm_parse_entry() and mptcp_pm_parse_addr() will already set a
error message in case of parsing issue.

Then, no need to override this error message with another less precise
one: "error parsing address".

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 90272cd99f7b..7c6b1241664a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -216,10 +216,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
-	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "error parsing local address");
+	if (err < 0)
 		goto announce_err;
-	}
 
 	if (addr_val.addr.id == 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
@@ -386,10 +384,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+	if (err < 0)
 		goto create_err;
-	}
 
 	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
@@ -400,10 +396,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+	if (err < 0)
 		goto create_err;
-	}
 
 	if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
@@ -509,17 +503,13 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+	if (err < 0)
 		goto destroy_err;
-	}
 
 	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+	if (err < 0)
 		goto destroy_err;
-	}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (addr_l.addr.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
-- 
2.45.2

