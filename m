Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C51C3F1C
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151395; cv=none; b=Nv+z2pNDz8ANC2Tu1U5TEXBUcCL8Vek7Q2jpfd7E/XS4bHttbsFET3CiyDqf5vx0f6kCJMIEDx9GiLdEcW9/sDlgzp94QPNB+EHhHELbF+9wnKOvcLEc0gm0Qa8gKSnyXEIfgBmGoTNwQvRNjXH4mc8nY792SvosstwY0lm74bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151395; c=relaxed/simple;
	bh=ba11fF5Q4ulNBTGhKeDU2bYkYZQgdLMIzcse2sR2i94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2AD9zu518UB6TKYrecolfzSGlhLY6nYuT7rFWYZRe/0Dei6fnIYOfFaJrrDSK1jf3ypwEJTNWptrkA80icH4ju1nckMW5wSAKIGuDOtBz6htOj3YIdpBCpIQb90fPHt6DP4CI6qsVY62HlDqEWmlxeb/GdGCgV6LXtr2z6uXlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe9dmTwN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe9dmTwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A829AC4CED2;
	Mon,  6 Jan 2025 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151395;
	bh=ba11fF5Q4ulNBTGhKeDU2bYkYZQgdLMIzcse2sR2i94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xe9dmTwNzui54AH2pl3P/VTh+FHw3uF8iO+OMqSCdYCk4IOIo1Nu3Wl0I0b8xdsEt
	 EUpgwwen5Otbwia4C/T0OsPeu+NTYwBOmiZINIpwXPSjsqlfZK1rx0I8NcBmeT1IWa
	 ncNf98uBpXrGuQkWoRJOHWJKQQbBw+BWcNR3a1BjGIbXysvRD+xNFVbnE0/wgrR2fb
	 Rg4+eNfLgV072o6G7cZH0UEEVPlKG93UUCXyIZ13revxMIdzq4LRRFpMZSQlFcxImc
	 ObsY/IJrQErWYRjPaC6/vXKIeryC80FECe65gW31L4ykAzbRuecrX9vhxMnDttbkoZ
	 xz+tomM6JB0ig==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 06/11] mptcp: drop info of userspace_pm_remove_id_zero_address
Date: Mon,  6 Jan 2025 16:16:11 +0800
Message-ID: <ee4732a33038d9d16df114dd278278112219c5ca.1736150983.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736150983.git.tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The only use of 'info' parameter of userspace_pm_remove_id_zero_address()
is to set an error message into it.

This patch drops this parameter and sets the error message where this
function is called in mptcp_pm_nl_remove_doit().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 0f703e06d771..a6580942e628 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -259,8 +259,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
-						     struct genl_info *info)
+static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 	struct mptcp_subflow_context *subflow;
@@ -275,10 +274,8 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 			break;
 		}
 	}
-	if (!has_id_0) {
-		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+	if (!has_id_0)
 		goto remove_err;
-	}
 
 	list.ids[list.nr++] = 0;
 
@@ -336,7 +333,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
+		err = mptcp_userspace_pm_remove_id_zero_address(msk);
 		goto out;
 	}
 
@@ -345,7 +342,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
-		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
@@ -362,6 +358,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = 0;
 out:
+	if (err)
+		GENL_SET_ERR_MSG_FMT(info,
+				     "address with id %u not found",
+				     id_val);
+
 	sock_put(sk);
 	return err;
 }
-- 
2.45.2

