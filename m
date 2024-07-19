Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA283CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391892; cv=none; b=fz4XJwQTWP0wU1HdWRW1esdrDZOtqOuhXX3v8nJkZgkbkvwg2KBu6N/+h6ugXorUaAbE6dshiRBHNTy300XHUn2zsX5gcB+hfyVAK/9Soi+FdjuduM1MElcdKym5ZhMejcczRLePc/iJhQGWs/agJjyc5T2cKTLWl8FBLSEJ82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391892; c=relaxed/simple;
	bh=DeLnnNqaKgMl/0xcB+x46WxsWT6jNX6wQUj5lqlSQtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYgj/jvVpy8ZyzIPeqbxgWqRJLpOxeLFWdsZgagJTlIzZc9XpKBcFpagNaVAa26zFj44+KsX057CzVI0IQJvUoUJNVv9nw2h7ui2xyf5YxwyuHYUclshosICllLaezz1BByOYuJ1zZoLhniBPuyfG9QyAcIkPwJXomWHCXxls/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv2hrj33; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv2hrj33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D297AC32782;
	Fri, 19 Jul 2024 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391892;
	bh=DeLnnNqaKgMl/0xcB+x46WxsWT6jNX6wQUj5lqlSQtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kv2hrj33GnD7d/9TDZoi4KxMNe9KvtW2SP/nBCEmRWuxL8o1gAlbgyJK1TNmgmfk2
	 8YBIwMijohfR4yVXihGaVP8LPqskQNAZACttLNuxfcSlPmSm2ACmFspi9ZXDUzl14K
	 6Jsc9mTXrZwDTYHNcklXuONov0g55r6WRscFWUwWQclLBQZN0pPkvyyjzTK4QHhgJx
	 bH0rmU2jK8ZleqkdNl5b5VzYMI3mHAq8VU7cGsKLSeZfjxoCaDCO6lukho7cx+oOop
	 w61uVil00ZoV3xIAWyhJENXqtV3IVjZUGbzos8i/vzsKMR+h89GSpo2KXI7f9sFj12
	 mfveCVAGake+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:27 +0200
Subject: [PATCH mptcp-net v3 16/20] mptcp: pm: only decrement
 add_addr_accepted for MPJ req
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-16-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DeLnnNqaKgMl/0xcB+x46WxsWT6jNX6wQUj5lqlSQtY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsAiZ7MoDrA0+Hitu3TgvhHdiYcjISJJsAf4
 KdOxlZH9W+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 c9S3EACU++rg7KrBRuJrDsV1Zdpem8O8SdxIAwAPOAUSP00NroV6GM09UF85mVyssfE3VOJhN/l
 Q3da/dIsUaPoSjEQr0+fhv9pS9DnEJUFqx2q78cax7DGPCP69o9OPYiXC8gEVIylz5apcmVnTEc
 NPEE1VBseo4ki07rvIAXxDLrKWtIhMaeW6XImGVIVhJOUrdrc0ojXsoed5wl+WlZisa3R2J6pmK
 sXuCLVaYyyiwEtUbeAqkrHQEFAsVEUWY1dw8r8KBpqbrGutXFnM1eYY0hQhblWh/P78LLwiiTtS
 qGNOXbZoPf0pvw6hxua01I0rXz3QOvpijeN8WX4CnLjBx2XAiK+V/Dqx7IfUjOwQK8MtxmyGhzr
 3oa7n6sbxCx22b+iwhPFIiW6xrky2zOJiApfXrYRxqj5saM8M5W70vWkVmD5qdcGW4cQIFNpI5E
 t5+B+uIRN1LuA0JEY9hdg2NJUKlqC+FsmSWhdaIpZ5TcIrtF178aReqCwnes9WGdEH0MhTnCfmJ
 PAY3UDco30zab6557GSbIOXXC/+HV0EVABePZuQpMIt1pi5VLUPPeesTnVXK1EP4vU/0zM39f5G
 Dk7WCp1ToFdp6x/V+FClXTcJP5pusO5Nn0bO+vFKR6Ys9Km92ktU5Ff2NW2GGCkojRvt4rhjjJg
 FAUKiPJpNSNij2w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Adding the following warning ...

  WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)

... before decrementing the add_addr_accepted counter helped to find a
bug when running the "remove single subflow" subtest from the
mptcp_join.sh selftest.

Removing a 'subflow' endpoint will first trigger a RM_ADDR, then the
subflow closure. Before this patch, and upon the reception of the
RM_ADDR, the other peer will then try to decrement this
add_addr_accepted. That's not correct because the attached subflows have
not been created upon the reception of an ADD_ADDR.

A way to solve that is to decrement the counter only if the attached
subflow was an MP_JOIN to a remote id that was not 0, and initiated by
the host receiving the RM_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ea942c9f998f..d040cf8af412 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -830,7 +830,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed = true;
+			removed |= subflow->request_join;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
@@ -844,7 +844,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!mptcp_pm_is_kernel(msk))
 			continue;
 
-		if (rm_type == MPTCP_MIB_RMADDR) {
+		if (rm_type == MPTCP_MIB_RMADDR && rm_id &&
+		    !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+			/* Note: if the subflow has been closed before, this
+			 * add_addr_accepted counter will not be decremented.
+			 */
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
 		}

-- 
2.45.2

