Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582315D5C1
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298407; cv=none; b=PBArigyLj3f3/43IiD6R46z5JD347BZITO7EkeB+BHGgQOFg05pnPOkAX24y8uP8vp0wU7drcWJ74BW2rm3QQviAxELs3rNVlaeGWtQ410c8I6miR+FZH2QgTeluokZfBBPAFb7IFG7PXiul7pGGtkD1XYznmNUZlyS6/N5Jn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298407; c=relaxed/simple;
	bh=0nnRpqzP2ZWsB9naUbSubl6I2blw6Hazs4kwW9pEgko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F83YsqLbVEMr30aR9qHY5Xca6EDVNroK4aq0RR4W3hItj0aWDmjf65IEcUGYyRdJTycFUjMMjvGl/Z+EeGKs4pHvTyFZX0cKSEPDT6WztsQJgIoyeDzNTcKRWe8vYeFqRdDNJbTZ2qjuFqtFgFlP6rbFCjQt0U/G8UzERNR1zpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ7k8QLB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ7k8QLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FA9C4CECC;
	Mon,  7 Oct 2024 10:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728298407;
	bh=0nnRpqzP2ZWsB9naUbSubl6I2blw6Hazs4kwW9pEgko=;
	h=From:To:Cc:Subject:Date:From;
	b=rQ7k8QLBaA8FvFJscC7ssN+dn0eXKW968Jp1R0g6aFPe5OgJWJjCfPOtCCwh1Ralg
	 6TCR7iF1djaB7Cuf7BVY1yyf28QPyajlRj8lUgxC0KC0efnswl1kry/vuMs3TtHbKe
	 vKSS+RY/nOTSA/Y3IZ3N7AGqJpka/k5pjmgzc6jkJk8Dqrf58S08y6Bi+uPzEWmfgo
	 MLQv6Q6Lw9RvnwezbyeXW50mclHLidHARBNjhFRahjS/5t5seW9vleHPcRYRCXGTml
	 H2Pr/D6nYXVfdIpBZ5sTOoqZIK3hRfZZlO09Rfxny/GagFIbtu1vMCEPNIolRUWISP
	 TnbcWzxERLtBg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 00/10] cleanups for PM interfaces
Date: Mon,  7 Oct 2024 18:53:12 +0800
Message-ID: <cover.1728298100.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - a new patch, use sock_kfree_s instead of kfree.

v2:
 - add a new helper mptcp_userspace_pm_get_sock.

In order to implement BPF userspace path manager, it is necessary to
unify the interfaces of the path manager. This set contains some
cleanups for unify the interfaces.

struct mptcp_pm_ops {
        int (*address_announce)(struct mptcp_sock *msk,
                                struct mptcp_pm_addr_entry *local);
        int (*address_remove)(struct mptcp_sock *msk, u8 id);
        int (*subflow_create)(struct mptcp_sock *msk,
                              struct mptcp_pm_addr_entry *local,
                              struct mptcp_addr_info *remote);
        int (*subflow_destroy)(struct mptcp_sock *msk,
                               struct mptcp_pm_addr_entry *local,
                               struct mptcp_addr_info *remote);
        int (*get_local_id)(struct mptcp_sock *msk,
                            struct mptcp_pm_addr_entry *local);
        u8 (*get_flags)(struct mptcp_sock *msk,
                        struct mptcp_addr_info *skc);
        struct mptcp_pm_addr_entry *(*get_addr)(struct mptcp_sock *msk,
                                                u8 id);
        int (*dump_addr)(struct mptcp_sock *msk,
                         struct mptcp_id_bitmap *bitmap);
        int (*set_flags)(struct mptcp_sock *msk,
                         struct mptcp_pm_addr_entry *local,
                         struct mptcp_addr_info *remote);

        u8                      type;
        struct module           *owner;
        struct list_head        list;

        void (*init)(struct mptcp_sock *msk);
        void (*release)(struct mptcp_sock *msk);
} ____cacheline_aligned_in_smp;

Geliang Tang (10):
  mptcp: add struct mptcp_id_bitmap
  mptcp: add mptcp_userspace_pm_get_sock helper
  mptcp: use __lookup_addr in pm_netlink
  mptcp: use sock_kfree_s instead of kfree
  mptcp: add lookup_addr for userspace pm
  mptcp: change remote as mptcp_addr_info
  mptcp: change local as mptcp_pm_addr_entry
  mptcp: make pm wrappers static
  mptcp: drop skb parameter of get_addr
  mptcp: drop skb parameter of set_flags

 net/mptcp/pm.c           |  25 +---
 net/mptcp/pm_netlink.c   |  99 +++++++++-------
 net/mptcp/pm_userspace.c | 244 ++++++++++++++++-----------------------
 net/mptcp/protocol.h     |  18 ++-
 4 files changed, 163 insertions(+), 223 deletions(-)

-- 
2.43.0

