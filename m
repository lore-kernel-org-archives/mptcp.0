Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159961AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622678; cv=none; b=MdktprVHZ+QpM+hFZC/oDmx7BiXzhPR6P3bDIxF6tzod4uDPKX2dwTV5rgRbwYC1+QSTKbZRK1BbLsLtuu8QcqM7vSK0iEwwB5Oz2N7vzxEjdo/4RCx7geg10/gaCgyS+iAwNk3AYcytsqkckZK5q3esIAcS9fv4cpvHmhTj3WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622678; c=relaxed/simple;
	bh=83Yc98aUb4dJcBaxvFPw/vmbUFQ1FzmjsqRrIZAKJLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cu5/EK6ihZXVvCZsOJ6I57l5285hxkIIeIXva/RMH2izvwN/HnGx1eK6P+enoAyKr9GxJSSpve2qsNH8iuM7LjaCLPIplQ6Y67Uq+vPtWG9pCYW6zAc5p6K7/5VMmWVLmddDJ6s1lR1BlTTf2K6eI+L3nI5cmXtLCREwy8NH87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPLeuqFE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPLeuqFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7CBC4AF09;
	Fri,  2 Aug 2024 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622677;
	bh=83Yc98aUb4dJcBaxvFPw/vmbUFQ1FzmjsqRrIZAKJLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qPLeuqFElK1Xi+kIieCPpfqaIBZ5zOdAElIzuKIPqc71d972WdRKP9vWuq+w+10c+
	 P2gHcL+R6NMConAGSv5Gch1+HJIBp1PBxZt0q1wirHnwbyZoFXvb129tqHOYIdq0Ao
	 V/yvC+qf1yO1Nv/KUcXyenC1Mz9EjRawPsbRc9MSpBHmJVXOjcDN3WwBezdqhMlWFs
	 lJffjgUySVS/ukuXMr5SBgc9NOQqkWexKCPMUP9zb3qEl/86/T2ZuO4ADt+mE6NKL3
	 ktZ6vWjqrXiGNl6+tInC2RU6LWxreG+FN0Axqv3gX92jV5+ErXmuhqCXxDnutqWfak
	 NDkLfOSwLeMew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:44 +0200
Subject: [PATCH mptcp-net v6 07/11] mptcp: pm: reset MPC endp ID when
 re-added
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-7-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2668; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=83Yc98aUb4dJcBaxvFPw/vmbUFQ1FzmjsqRrIZAKJLs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLLCpO7h+qwcm73EHmpJgGIhsRjWkC1MaAOH
 Pybz/jW/SeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iywAKCRD2t4JPQmmg
 cx6lD/4zlw9++OcWOLrkbr0XAIek7T1nar5UXuTeyTI/aVPEoO2gDwkw4vXobpb503M8y5xPe8c
 5/JyL6xfTqI/JtYdGbD8lm/eelEiPucDEFVcno9N1GwD/fjaVdel1LSlP1QUYGXrGp11I3f0X6p
 0Lm9MvuHWFDYwBerNENwLwS7vs1M0boXIKy5lkWCD0py7MUeyIa871NxXXLYO4vRoD/WvFal3Tw
 Cyss7/Sy+FWyd9HSu6Db+5syfw8qDlDnCf/YYUm36ljY+mDafVr1kNSVTz2Y1pa0jY64fFvdD4Y
 3WLJhONLh0Lku0tncNBxOzxSVqxG2TYNo2sXTq6lQ7nSKkUyj9lidCmbn8RjBX7t1HagIRWlyId
 cJwanBB5gsXe+uVvx33PGavnEI/lSWXhcdcwhk1c6qg4/TgxS6Ay0rLGDs7tVVYWogK49E0Vxgw
 3r1gsMSmsVnUZKQtx+2e2/HpFKdr2LCnba1JqqzLLo7MQ5cXWrTT3HPgok1siMtSwsIZTVjdVTV
 rDDLE2fvgArKhGMw3kFoQ0MZB0MOrYu/Cj4V4mYb8Ya7mSx05uKFrZq7G/dmDBLIDogHn73SM8O
 h0x8DWghH8AKw4Q9a6u636fvbQdFrmLwuePC3EFlxoboZnwVGE1WZGzFVRuy997G4vObDO1PC2C
 dBvkkN1cX90Fz3Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial subflow has a special local ID: 0. It is specific per
connection.

When a global endpoint is deleted and re-added later, it can have a
different ID -- most services managing the endpoints automatically don't
force the ID to be the same as before. It is then important to track
these modifications to be consistent with the ID being used for the
address used by the initial subflow, not to confuse the other peer or to
send the ID 0 for the wrong address.

Now when removing an endpoint, msk->mpc_endpoint_id is reset if it
corresponds to this endpoint. When adding a new endpoint, the same
variable is updated if the address match the one of the initial subflow.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5d66f6b1d58c..d3b1b459e6f3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1321,20 +1321,27 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 	return pm_nl_get_pernet(genl_info_net(info));
 }
 
-static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
+static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
+					       struct mptcp_addr_info *addr)
 {
 	struct mptcp_sock *msk;
 	long s_slot = 0, s_num = 0;
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
+		struct mptcp_addr_info mpc_addr;
 
 		if (!READ_ONCE(msk->fully_established) ||
 		    mptcp_pm_is_userspace(msk))
 			goto next;
 
+		/* if the endp linked to the init sf is re-added with a != ID */
+		mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
+		if (mptcp_addresses_equal(addr, &mpc_addr, addr->port))
+			msk->mpc_endpoint_id = addr->id;
 		mptcp_pm_create_subflow_or_signal_addr(msk);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
@@ -1407,7 +1414,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out_free;
 	}
 
-	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk));
+	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk), &entry->addr);
 	return 0;
 
 out_free:
@@ -1505,6 +1512,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 			spin_unlock_bh(&msk->pm.lock);
 		}
 
+		if (msk->mpc_endpoint_id == entry->addr.id)
+			msk->mpc_endpoint_id = 0;
 		release_sock(sk);
 
 next:

-- 
2.45.2

