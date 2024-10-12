Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537D38384
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742800; cv=none; b=gXODCrb4FX5YKAr5HH2DKdsiknHlSAe80eMh7C2U5saFA4MH1IPjoo8FR/KphqkFF5oAgKLdb4F9tmkZBRz73U4nfMg0/b5Zhs4kQg3U2/zZFzjMYYKPGSoUOI8pUShCEOqmxEsLDLyHrQ9NUa6CDp8u00S+XhwxcGAzmKq2ydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742800; c=relaxed/simple;
	bh=KvUh/Go673qgUoieRa6QswUg249fg3neqwIQjxKn+rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ly57mkih4ikgpDYbLKJ637gzv27zmUfFkBI0R/UZ4hIOdx/oUhF+gpiurXWODtjd/YAsQBganYZI05VOPo39LSyq/yf24TjLi/fySp6PJS3V5BdYvJ1se8ehfVZXnlzIPhCIOQLzZXxHkIs8m6C2cjkM6SOS2nvgjDJNBlYQCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCXvW7Zq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCXvW7Zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD50C4CEC6;
	Sat, 12 Oct 2024 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742800;
	bh=KvUh/Go673qgUoieRa6QswUg249fg3neqwIQjxKn+rg=;
	h=From:To:Cc:Subject:Date:From;
	b=rCXvW7ZqfwsZ27f6jJ2UV65OYrmSde288MCI1s8j86GNLk0LSg0TZr1jtCpmCH1h/
	 bDcleQnxwr4a+sGhEXxyTFrNk/QhLDRy7PXi/4jGG9OmeULOqS93oVIAdIYS2qfiAE
	 jrQYocmXe0uJvAQ1oAEhNH/rhp0RtlgK3+nkC2uQFzG4G1wEPUFZ3Br93pyqGrqP/s
	 7G6eR33JgqXOndmDS9+uYaVJdWGXj3a74kDtSFLMpeoSx5VjEwc+EBFhAu7J7ZuGsj
	 nGxxGMGe7oapPO3sMPEmGbYNY5PHGRJ1m0jaTJR2KKmmN9cDEkdIBuTJ0z3eshkoCJ
	 LujSlW8WObpog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 00/11] cleanups for PM interfaces
Date: Sat, 12 Oct 2024 22:19:40 +0800
Message-ID: <cover.1728742591.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - a new patch, add mptcp_for_each_address() and
   mptcp_for_each_address_safe() macros.
 - update commit logs.

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

Geliang Tang (11):
  mptcp: add struct mptcp_id_bitmap
  mptcp: add mptcp_userspace_pm_get_sock helper
  mptcp: use __lookup_addr in pm_netlink
  mptcp: add mptcp_for_each_address macros
  mptcp: use sock_kfree_s instead of kfree
  mptcp: add lookup_addr for userspace pm
  mptcp: change remote as mptcp_addr_info
  mptcp: change local as mptcp_pm_addr_entry
  mptcp: make three pm wrappers static
  mptcp: drop skb parameter of get_addr
  mptcp: drop skb parameter of set_flags

 net/mptcp/pm.c           |  25 +---
 net/mptcp/pm_netlink.c   |  99 +++++++++-------
 net/mptcp/pm_userspace.c | 250 ++++++++++++++++-----------------------
 net/mptcp/protocol.h     |  23 ++--
 4 files changed, 171 insertions(+), 226 deletions(-)

-- 
2.43.0

