Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503B17D378
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069966; cv=none; b=DZYkqAA0sgoCXq50HsgQcj/xstCTA6tmFmDrq6QVLEg7/naElKKE857dhbhARtOWvW2qscg2iyKBXho9c9efyIXFuZMFSuONRyx3KLBk1TY10BmF08JTbaRCQ4cxfFS8zfuuMvm3KcmafTkgkZqOKIZN3LjGd5e6sCwg7lqpr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069966; c=relaxed/simple;
	bh=Vq4QxH+KKQyflbmhwnUxPaud0M3zMXGBFbWZ4LjW5xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/rxqhVvQVH9RhbPiZ5ELjJYmmWCDoKCIM1f/2F28gSksMtugfTNxpCgus1Z+q2su5Z2t/x3O2GMlkMfAu15pTn1mGsSteB4oH1NWXkfkkX5SeCICgZ461hr+P4dkZy5FKkF3amUoYH6IdNIdybwlPlixgfx/ggWLIPv0OqdVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwhatgHb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwhatgHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D244C4CEC5;
	Wed, 16 Oct 2024 09:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069966;
	bh=Vq4QxH+KKQyflbmhwnUxPaud0M3zMXGBFbWZ4LjW5xM=;
	h=From:To:Cc:Subject:Date:From;
	b=JwhatgHbSbRaspivaqkQz8415HNRw83+Nj+HncBEEk/GHmyGhh9k0HkykU03QLTfh
	 avnTVE19tCcjv2Cdwch4Y1Wrdm7ZTM7dUFhTA3xGeF2KHxrehDjLNFTGLQ2bIrZ68t
	 z6PbsdDrlaIdHXnr6qKhQbUmmYCf96+/ExWXPCtBPlfeJkcu+nAy/VLpRIohvxhdYo
	 cExw9boLAXBDKGMwwRyalFLUmj3wyU4SnAAW5NLP2BczRR44I+j7KcECI8xrRSTlHR
	 9sKghL3dpusRe37x6xIps8vYnPgSL6lPHJ72dqLokjySCC3jz6N/chthOg+RQ7J/dL
	 cesWeE23ExEng==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 00/33] BPF path manager, part 1
Date: Wed, 16 Oct 2024 17:12:04 +0800
Message-ID: <cover.1729069853.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to implement BPF userspace path manager, it is necessary to
unify the interfaces of the path manager. This set contains some
cleanups and refactoring to unify the interfaces in kernel space.
Finally, define a struct mptcp_pm_ops for a userspace path manager
like this:

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

The BPF-related code will be sent in the next set part 2.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/74

Geliang Tang (33):
  mptcp: drop else in mptcp_pm_addr_families_match
  mptcp: use __lookup_addr in pm_netlink
  mptcp: add mptcp_for_each_address macros
  mptcp: use sock_kfree_s instead of kfree
  mptcp: add lookup_addr for userspace pm
  mptcp: add mptcp_userspace_pm_get_sock helper
  mptcp: make three pm wrappers static
  mptcp: drop skb parameter of get_addr
  mptcp: add id parameter for get_addr
  mptcp: add addr parameter for get_addr
  mptcp: reuse sending nlmsg code in get_addr
  mptcp: change info of get_addr as const
  mptcp: add struct mptcp_id_bitmap
  mptcp: refactor dump_addr with id bitmap
  mptcp: refactor dump_addr with get_addr
  mptcp: reuse sending nlmsg code in dump_addr
  mptcp: update local address flags when setting it
  mptcp: change rem type of set_flags
  mptcp: drop skb parameter of set_flags
  mptcp: add loc and rem for set_flags
  mptcp: update address type of get_local_id
  mptcp: change is_backup interfaces as get_flags
  mptcp: drop struct mptcp_pm_local
  mptcp: drop struct mptcp_pm_add_entry
  mptcp: change local type of subflow_destroy
  mptcp: hold pm lock when deleting entry
  mptcp: rename mptcp_pm_remove_addrs
  mptcp: drop free_list for deleting entries
  mptcp: define struct mptcp_pm_ops
  mptcp: implement userspace pm address interfaces
  mptcp: implement userspace pm subflow interfaces
  mptcp: implement userspace pm others interfaces
  mptcp: register default userspace pm

 include/net/mptcp.h      |  32 ++
 net/mptcp/pm.c           |  49 +--
 net/mptcp/pm_netlink.c   | 313 ++++++++--------
 net/mptcp/pm_userspace.c | 768 +++++++++++++++++++++------------------
 net/mptcp/protocol.c     |   1 +
 net/mptcp/protocol.h     |  77 ++--
 net/mptcp/subflow.c      |   2 +-
 7 files changed, 681 insertions(+), 561 deletions(-)

-- 
2.43.0

