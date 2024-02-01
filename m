Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772239AF6
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764759; cv=none; b=GWHuOcsWxFerv1nh6TvqYuR2T1n364TuzjSNlA0AF1kZmNffmh9/vaae+PbMY61pZF/Ywbm5et6Url/qTdGS0huSwDmSiHoLhHPOPixVXLCiXKyY1z8IUhe5Toe6/NH+Itoqoh4AzO9MFNPAFT85aMEPIXlmmTnuObbBCCODi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764759; c=relaxed/simple;
	bh=f9a5iLfxbWamrzwnX4LvWWFSGNyu+aEDxaCmTYiwYmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hb7QcjzNfV4XfNA9kk0I5rwOxM7JUvdpHOGguQuAoiWWsbtq3wK/RCVwb5dtsrPJQ1rPIC5QitvyW2RmnK0mGOjbtd5SrpFKOxtW172Wj+lFKWEdjRqV9vvVOMd1jb9CwTh+srBTV/6v3+CtUftujD4h4PgE32T3c1AjV+9gpPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZW913SO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZW913SO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49944C43390;
	Thu,  1 Feb 2024 05:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764759;
	bh=f9a5iLfxbWamrzwnX4LvWWFSGNyu+aEDxaCmTYiwYmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZW913SODg9l0tmGBg2A5xcSAtVLXzlIXFLT+Sj3ZBe6eSV9IwFjsb0gYDOIsTrkn
	 yfPTpUF7k+eh8RfsaXPRetSA51JGWRg50TuRMeRIxdmPCJgDcnD/jbNCLYAqzjBWRv
	 UBE6STz0KopGJI6sn11EGDqGf4aFXEn0ko+BCyu1YCWgC94AXUGz4vJM7dJ5ruj/DJ
	 ySSAvkMjuVlCWwLcwbbFxzHoV7EsAYDdiQGc+m2KZgrZrZpwkEB/MU9c57u28YwGMs
	 zObN8jCWueEE6WujuaJleBBY+LNFSVkOhTSH6rGsowJkPynVJkZJA+muppFU4M21Uj
	 m8SGOm1icYQ2g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 05/15] mptcp: check userspace pm flags
Date: Thu,  1 Feb 2024 13:18:55 +0800
Message-Id: <756a6593e59670bbf5a96270b91a01b941d1a21b.1706764519.git.tanggeliang@kylinos.cn>
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

Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
announce mptcp_pm_nl_announce_doit(), PM flags should be checked in
mptcp_pm_nl_subflow_create_doit() too.

If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags field
in the output of dump_addr. This looks a bit strange:

        id 10 flags  10.0.3.2

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the PM flags of the entry and check it. MPTCP_PM_ADDR_FLAG_SIGNAL
flag shouldn't be set here, and if MPTCP_PM_ADDR_FLAG_SUBFLOW flag is
missing from the netlink attribute, always set this flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 199fcc900219..53fa19755b1e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -360,11 +360,20 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
+	addr_l = local.addr;
+
+	if (local.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+		local.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
@@ -378,7 +387,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-- 
2.40.1

