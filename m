Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298AC14A08E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494251; cv=none; b=dgYeP4IHVYtHfMTtohzp1obCY+kB7S6rnmHe2j8TRhlOcWDo201cF8AiCdYKEJxK8c7VquYKJVHRaCCH1HXtN4ABRFaTRtwTkqVgkwVfwYQiKUN0PBQ76YvEfdAuJ2yvuwWM7Thg1NJ03mO5WpKBxrCdSVHSkDXQ6OqrdmAhylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494251; c=relaxed/simple;
	bh=5ZwuEaCyrh7/4JVc+sYIO1AdjSTMJWmfCVu+Im7GrHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVJvShbFcFOP1m3k1hFnRfdKpTjXFnVlXPSwaKbg6tUADY03BDCk69DUsrfWIkjF0PmvDlDZMxub+jz073pQxqU68SHpZ+GYujANAMH7tQ4NSMhqHbcSQu+C7D2QhdAvqoUW5dQRoZ+HSHrNGnOWan171tTi2OTaVUK/9F84k6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMrdcn9v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMrdcn9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FA7C4CED6;
	Fri, 10 Jan 2025 07:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494250;
	bh=5ZwuEaCyrh7/4JVc+sYIO1AdjSTMJWmfCVu+Im7GrHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMrdcn9vMpcJFyynlpPaepYssa8EZRLkbc2AGRcwbTGNN1guRbkLAI1OncsNMJuW/
	 vbFxDUOfD3YENTKfur01Hj1Ur5wJY1BtpfaVDQjTrlYvs/ET7dF19kxSKRLt1C9V2J
	 T+LR0Sl2HYf1o1HJflmrEr6Tg7c6rAtF6NECwltv4wc3Za9QaaFl766zTShojWNCY0
	 dMmaVD16sFSdzyfw6bqSJeQlO1I6CKMPCFHstNF8v0oOeBnHWhbcPRY1UQPstro1zu
	 /K5Ya68wf7iAlgSIX/R/LygxrYz9C7M6U95T39tsDWzO05NeDyK6iI4mr4kcB04jJW
	 MahcgGDuK3W2Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 1/8] mptcp: drop info of userspace_pm_remove_id_zero_address
Date: Fri, 10 Jan 2025 15:30:35 +0800
Message-ID: <1a96bdebb079188a862447a2bb0983be12bd8320.1736493803.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736493803.git.tanggeliang@kylinos.cn>
References: <cover.1736493803.git.tanggeliang@kylinos.cn>
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

Plus, this helper will only fail when it cannot find any subflows with a
local address ID 0.

This patch drops this parameter and sets the error message where this
function is called in mptcp_pm_nl_remove_doit().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a3d477059b11..4de38bc03ab8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -253,8 +253,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
-						     struct genl_info *info)
+static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 	struct mptcp_subflow_context *subflow;
@@ -269,10 +268,8 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 			break;
 		}
 	}
-	if (!has_id_0) {
-		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+	if (!has_id_0)
 		goto remove_err;
-	}
 
 	list.ids[list.nr++] = 0;
 
@@ -330,7 +327,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
+		err = mptcp_userspace_pm_remove_id_zero_address(msk);
 		goto out;
 	}
 
@@ -339,7 +336,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
-		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
@@ -356,6 +352,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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

