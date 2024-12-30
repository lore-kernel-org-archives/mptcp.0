Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0711A8406
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565068; cv=none; b=Zxq/Ae//eNSm/TrzxgCO9ryk7bGnMCLNrdEg0KKmdfpw7VcDMjScL/PsPAF5Gb2p+H9JXQWBcjXcK7IGUZj/APt23uTjRRcqbE1IujHDtrdNUz/w0HxK416C4bUUk0Vgqkr15Q6h7sK8PDib/BO5cCcpXvUFkzVQOQP/6OXfqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565068; c=relaxed/simple;
	bh=jU3KoUk61mM6lLOZmdsm0ye4ezUmGBGTaSB9Fi8Wid0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTMuBxb9HoZjYYHazryJALLNuo44vp8+6YXINY6h71RkpdHnnlEvNLhr0fOb8V623SxcmbGLn3Oz2pJqVak1TRlXRZErhzQkZjbLlP79SbYCkZSkgb13stda/LD9mK0UOXfjwc2r6DR6aTME/uhdiSyE0EkLTMrNqvc4B6iyAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uieXrGCW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uieXrGCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1AEC4CEDE;
	Mon, 30 Dec 2024 13:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735565068;
	bh=jU3KoUk61mM6lLOZmdsm0ye4ezUmGBGTaSB9Fi8Wid0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uieXrGCWMMtwcZgMPG97j12x4LBs/DIbJbj7S38z6wq26oO1/JsXCxA8UpPt1sPjK
	 S0yfKbTNbGDHUcM7Vx8NndcvoNdkzW8FKvwYu8xPvPrHIhrSQ2JW+5LgL/GT/rkbAl
	 8EMXQwkUPng0pacNQxDPiZAU49PvXcAR+wqKNeFbbFRnwp+AnrRHqeswYta7m9D/MH
	 p0a/JF3KvOfgX/tjgmrUWyPrG+58sRnk5zVIvpR93tGcMIaoeOl5gYtHUayM2X9P36
	 00koo53+q/75+qntgE0/ysL+LkP4+nIEfOfzOD0bNZtRSyyfRIsI7yDBaBG45i/A2j
	 2HBG/8NpahKSg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Dec 2024 14:24:10 +0100
Subject: [PATCH mptcp-next v6 3/7] mptcp: pm: improve error messages
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-genl_req_attr_check-v6-3-3ec9103559e7@kernel.org>
References: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
In-Reply-To: <20241230-genl_req_attr_check-v6-0-3ec9103559e7@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2948; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jU3KoUk61mM6lLOZmdsm0ye4ezUmGBGTaSB9Fi8Wid0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncp8KthzMuhUPEpGvfofoyBBc8RKH29eJpF7eG
 yRQp2uCAAiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3KfCgAKCRD2t4JPQmmg
 c6JNEACyjUMh6BDLMzW/dBEqSKbtg6R4l+CfGdpCMHAhgtfIcY5+l/WHd/kKPuQRZU77jvsIhyD
 S7wNZie6oeqlv00IlxXDBiQi0aXrHnHH5m0FIYM8pEKyQ5iM6tcy9iqWqCOATStN8GbczVkHIDF
 y5sw3EUiON+aYACulJ7IDWWV/yl2wWZy34SFw50lo5RRnBL1fYl9LctwVRffVZdKknnrcmg1RMV
 sdvmkOXw/AydwAgTBB1TxlkDLAYHMYb5Kmkqxh74Ebir3sD4GnKo7/KhZ+ZG7IWoJh3eBlCbf0Y
 mIrw+hTs6isMOlpMZcnHEZjen5iYWKISn5RMSmQOZOYFnS0nxLoHRNCSu8X+43QWiLqluc+ROCV
 yyb2FM9yD8/sJUYc+I07lDUJ1U8IqJjplDX2s+FBvSW8C6Rf7tGanAuIAinuwVm5qdlTFWaewv/
 WIsgWcX+EhVCwnic+AnR64l+NfG4NnrwSv1wRqXbSWKwkCHikuXzJlTbtg0KgtWgJcdPtSRlLER
 F2QJy7K0ljULQKHoBIXbKRcGITWBnQMbYVbrukwOcEb6J9GHAZNjjuMcS2Dh9EaEaTjIkriuIJK
 fCW9tXGMOXq/fnuCqBSE7xrepoNF2u/dT2kG6W5HFXt/ia7ytCd2LlkiE9JIorWjtdZq83VR7bS
 SQDb5lFMFPpIqDA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some error messages were:

 - too generic: "missing input", "invalid request"

 - not precise enough: "limit greater than maximum" but what's the max?

 - missing: subflow not found, or connect error.

This can be easily improved by being more precise, or adding new error
messages.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 7 ++++---
 net/mptcp/pm_userspace.c | 9 ++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 49c34494e156ff6c3277b107c3840ee29dd3afbb..3bb213e2a967e87d4244dc0f1ba58d3ba21fb371 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1878,8 +1878,9 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 
 	*limit = nla_get_u32(attr);
 	if (*limit > MPTCP_PM_ADDR_MAX) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr,
-				    "limit greater than maximum");
+		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
+					"limit greater than maximum (%u)",
+					MPTCP_PM_ADDR_MAX);
 		return -EINVAL;
 	}
 	return 0;
@@ -2008,7 +2009,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 		lookup_by_id = 1;
 		if (!addr.addr.id) {
 			NL_SET_ERR_MSG_ATTR(info->extack, attr,
-					    "missing required inputs");
+					    "missing address ID");
 			return -EOPNOTSUPP;
 		}
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9c0bec588c498e0aa78acf4018db509abe90cad2..a8f73b082460ba00f7fa998cf7646368f8201e2e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -191,7 +191,7 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token,
-				    "invalid request; userspace PM not selected");
+				    "userspace PM not selected");
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -433,6 +433,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
+	if (err)
+		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
+
 	spin_lock_bh(&msk->pm.lock);
 	if (err)
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
@@ -557,6 +560,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
 	if (!ssk) {
+		GENL_SET_ERR_MSG(info, "subflow not found");
 		err = -ESRCH;
 		goto release_sock;
 	}
@@ -634,6 +638,9 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);
 
+	if (ret)
+		GENL_SET_ERR_MSG(info, "subflow not found");
+
 set_flags_err:
 	sock_put(sk);
 	return ret;

-- 
2.47.1

