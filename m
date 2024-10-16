Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B31885BB
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105534; cv=none; b=ZMGY/2TIF0pyZ4wUnMfec2oAm3JqlRjrJQMFbqK0bvsO+qJo0Nq4D3bnjXxG1+mCCSMULMk2aqCSE363UTcfsTjtim58Rl9Y77SAd7h7mr75CV4DcwfxSXNhEjP8vNdcXIGEQizdDTWzEA1ydrJzvunww30HOYciWVyeWc+wgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105534; c=relaxed/simple;
	bh=F0vVpZ1UHz2p1+vcBV4No9sFFsfS6l/eqa9mLGJZBXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1tYWpBigTtI2uHYZ/ljVpjnzpfeyyypRpaR44AK0vOOmYyK76VJ7I0Y4Ibt4mn0eEnbhdgdNwf/uu/2ZuLLJ3DNi2FmGrF6LWibW+OzA4l4acTUU8DzYBZu9yWjLJzIv4+DH18yINF8uswgBskyEFnpEfZSgpg2ZX6UTusrTnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8hBEZGL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8hBEZGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4B3C4CED0;
	Wed, 16 Oct 2024 19:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105534;
	bh=F0vVpZ1UHz2p1+vcBV4No9sFFsfS6l/eqa9mLGJZBXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D8hBEZGL+mho6MwYw6TY5hoxQHy7I+AlKGdOR8iVxN5dN0Acc8vzSdWQtWcJGykfy
	 HfHeGWkyJkIlp/aIN7z356KSBpj6sHQPdQf5xnevCR8ZeWfOSdIzBUefWdAKQk8+LF
	 K081Yyp6zSvG9o72HQK8zdTAG7dLNeSLjC8d59nDdrphdoUk5oSebv4alsHNBGBGdl
	 uFNlQWcjBY6M8w+B32H0iOqbiYaFfZ90uqVDV8kekp7vO/B/O+8xTK2anQjgEhXvsB
	 8SZXCERby6fd3HQO9PreV1Afjf6i5ahofiQtQCxyaXcWAfSNaW0yGp0H4DD/NL3uMZ
	 37cZPiXIrnSSg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 16 Oct 2024 21:05:19 +0200
Subject: [PATCH mptcp-net 1/2] mptcp: init: protect sched with
 rcu_read_lock
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-mptcp-sched-find-rcu-v1-1-5e9af4fbce11@kernel.org>
References: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
In-Reply-To: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2450; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=F0vVpZ1UHz2p1+vcBV4No9sFFsfS6l/eqa9mLGJZBXM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEA57OKXeL114tA1IafudTPOx2ix95qurGSWy4
 j0E5Y/OqxeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxAOewAKCRD2t4JPQmmg
 c2ixD/9hdCSgYWioEXVSCmFrQXYjur4+d+Se6gC1lIiqgv5siZYpVjDW6a5310wtLqLzTdYZLR7
 K1cCQvkeSWfRqwrqYmP2AvrqgzH1kjisR/g9X2PMjS4ftZLJB7CFKZSNyBgSLoVW0mQ8JrXGP7R
 uiBz1E+nZyollUi2Sc7KYZRJQvlwNqrtCEwoMM/LuD5oBz3mTy2aqPBHGRjt7mrawB2HsG2NpZn
 5YaWWsK609JxZNaxH857x3DbD+jAAHzJ8co31gbOKAIKhdXw8TG2fBmb4AQMf9D4b5XKJWiQEej
 dHZd4UGV95vFKJch9LTvOXBQQ9frq3eIJZm/SlLx4yOlSfOeeJ9iu9rGxngIKb8n0/Zy1s55A5c
 DKpUwIUjPe9erO2JtHbu/PgtfwEi4NQu+7vdT4sAmsWxc1jb3VSNYADgNai2PvB5nqb/pCZ4IvU
 YRFGwzQxAHDIdaRnCaPRcyUfdZLb0OIimBipqEIItS1POa9cTFtTechoslBHcAAATb6lMNMDgUv
 Oni6triUoUDPoa0W/0HWIKN/0+t9MPAfXNcK245j/VWm5dgnyemeIvyTe9Y6hekoJgDK8RIxHx6
 RDP4xAWjVzhtskn/4SDMDlPsNxQp6Lv6WLSkTLIaY3OOA3H7iZ0skgRd98lfG/MEjoQZAzhHi30
 1E0FRmR0PLJUKeg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Enabling CONFIG_PROVE_RCU_LIST with its dependence CONFIG_RCU_EXPERT
creates this splat when an MPTCP socket is created:

  =============================
  WARNING: suspicious RCU usage
  6.12.0-rc2+ #11 Not tainted
  -----------------------------
  net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  no locks held by mptcp_connect/176.

  stack backtrace:
  CPU: 0 UID: 0 PID: 176 Comm: mptcp_connect Not tainted 6.12.0-rc2+ #11
  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  Call Trace:
   <TASK>
   dump_stack_lvl (lib/dump_stack.c:123)
   lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
   mptcp_sched_find (net/mptcp/sched.c:44 (discriminator 7))
   mptcp_init_sock (net/mptcp/protocol.c:2867 (discriminator 1))
   ? sock_init_data_uid (arch/x86/include/asm/atomic.h:28)
   inet_create.part.0.constprop.0 (net/ipv4/af_inet.c:386)
   ? __sock_create (include/linux/rcupdate.h:347 (discriminator 1))
   __sock_create (net/socket.c:1576)
   __sys_socket (net/socket.c:1671)
   ? __pfx___sys_socket (net/socket.c:1712)
   ? do_user_addr_fault (arch/x86/mm/fault.c:1419 (discriminator 1))
   __x64_sys_socket (net/socket.c:1728)
   do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1))
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

That's because when the socket is initialised, rcu_read_lock() is not
used despite the explicit comment written above the declaration of
mptcp_sched_find() in sched.c. Adding the missing lock/unlock avoids the
warning.

Fixes: 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/523
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e420ce9bbfb6e0527ed3ce8cbe2a0990c6366d12..21bc3586c33e16471056fedf49ee044ba27731d9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2864,8 +2864,10 @@ static int mptcp_init_sock(struct sock *sk)
 	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
 		return -ENOMEM;
 
+	rcu_read_lock();
 	ret = mptcp_init_sched(mptcp_sk(sk),
 			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	rcu_read_unlock();
 	if (ret)
 		return ret;
 

-- 
2.45.2

