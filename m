Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CED14F98
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004142; cv=none; b=fv4Dr/9pGqV3BdVT2sPdgm6XOoraCK284fE2aFCrHA3moS9LkIYKUSxjwy1Ff6mqIB6E35OeJlfAlmUXM2JTtp6Zd+7LNqy6n2LZzAUdrlhufIryPiss3tAP0+K0NR1RZdfKKMfxF/M5uAmEbWFIZKvPspvwXC8Om0pEVGr5aD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004142; c=relaxed/simple;
	bh=9T+WiOCMIIVS1xBSk46oaY6QkN2fkOwPwioxV9pvQSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ulaPfX6E0n6vW/TJI1+ely6xHLqJp6k9lR+Lm0Q+Y6YUEZBga/fYElouvoQMNZEXqy94DoWsLFOBjMEtQGs1NzZozMjTndYjIfI9N6kiCwSf6p/3Z3Ypup6dXx8zaAxkpRb21g+2dzKxSsu89nG+/myqPwrWQUPOmF3sLauvwqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF3xuswX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF3xuswX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F438C4AF07;
	Fri, 26 Jul 2024 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004142;
	bh=9T+WiOCMIIVS1xBSk46oaY6QkN2fkOwPwioxV9pvQSY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GF3xuswXet9mHXbOI+qkRAR/pV8g8VBCeSXBnCQhonPgoMIvcV8fnW2cV6VTrPIIB
	 RbJwPfEaS1CukfN09C8IB07RVgSK/gOD8xPv2VxEL2pJHAgCAjBtptPneCstGnaQhA
	 V/8Suq5hueUvGVyd2nmJgCXaHJiTs7SL4SnGYffVohuqFdn7XbO6SAdzDSUfp9CdEv
	 aFbWslhi4Tm2CPwnZCDEV3VN6BDqM3O2lt5TWnMkhMnZkJhFnRAFMKzyg6a+CjvNFc
	 ODbg/WxggCj0QuGhjBsfygPHTgvVeNezwQAunAuMWyCEdPqFrNlGNAFkEh1FsmyZ8l
	 BoPjyAMShgEZQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:38 +0200
Subject: [PATCH mptcp-net v5 12/13] mptcp: pm: rename helpers linked to
 'flush'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-12-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9T+WiOCMIIVS1xBSk46oaY6QkN2fkOwPwioxV9pvQSY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KcQcV1BaHqa+6cq+xpEkCL7yWpO/dYXBDJv
 Jq0wfktRXOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 c5A3EAC8jmyV0MZoZOJNirN9GnGqpSqUj8OmBmRc33pSJuLgOVmLbvvA3rVz30B1D+699Ra9ALd
 fcmFMJy/LT9HIF9Zw7lSMub0EKfe+vLO4yOmQQwG9JX3XjFu4Evm1zccvCebS2MfD38kgznoeat
 mxMeX38hMw7cDjw/aMUjeJ830MxZMT/8b/Q8HygGc86vh1HtSpFO7H1m/GhbaOG9bVrVbok7+IU
 oUs88jWYO7WUNOLne4dEZMG2JZaNFQwVzNLqtUkoodUSf4RZQxaHmLrfkHEvoOgjGgK6vNCX21d
 TbradA4e1WQNXMh7ZWci4Q2nzGZhDJjFPkxLaREwKJOXe69Sm/dFfoDdA7vngnovFE6oYgq7FgE
 zbA8kE9j98FjET+uo5NpzMB/ROdyjnsDhSqKfyMsHcuDz3TgYDC83bc6RQbNFpI88THgOpf2V9Z
 BVe5GkkAdgvToTRqf/mOgHXQnn4PGJVk1NZpX9uuckq5f6rsICqPHF5DTgky3e2fSYjKy8vaVNW
 Q07lqssAXtkLQVM4IoEQf08TKQOEsfHqodVfFYGbuwTB+cxj1dL9XWiTdb1mRcfZipR56Wi0Lvw
 v8Hejj67Xu+KV2mI+A3v1jQ0TJQnyqIa5iOY/ndaMK3qTpYKE7K2PBrAmmCj+FV9Hl90KWjt/f1
 FIBAR0dnjnnkMHg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Rename all the helpers specific to the flushing operations to make it
clear that the intention is to flush all created subflows, and remove
all announced addresses, not just a specific selection.

That way, it is easier to understand why the id_avail_bitmap and
local_addr_used are reset at the end.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - This patch is for net-next
  - v5:
    - This patch has been extracted from "mptcp: pm: re-using ID of
      unused flushed subflows", without any other modifications.
---
 net/mptcp/pm_netlink.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 36e179f1f888..53355f629846 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1644,8 +1644,8 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
-static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					       struct list_head *rm_list)
+static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
+					      struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
@@ -1673,8 +1673,8 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_nl_remove_addrs_list(struct net *net,
-				       struct list_head *rm_list)
+static void mptcp_nl_flush_addrs_list(struct net *net,
+				      struct list_head *rm_list)
 {
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
@@ -1687,7 +1687,7 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 
 		if (!mptcp_pm_is_userspace(msk)) {
 			lock_sock(sk);
-			mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
+			mptcp_pm_flush_addrs_and_subflows(msk, rm_list);
 			release_sock(sk);
 		}
 
@@ -1728,7 +1728,7 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
 	return 0;

-- 
2.45.2

