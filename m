Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6311DD894
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920579; cv=none; b=JcbeH8K0Ovx+rzhKqkbHTGmdjhr3l7J9r5nkUkTXSeDPBp9tPHDx/EaVL+YsknQM5lSobfI1Jx+wtaSml+8G9cILyhtH5z3APf+9ErhJxPvIIekoCE33r4Ki9uA9JjOM1tvSTlLTwaopIqY0aP6w1aRwvEiEGX9Uxd2jPlQJZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920579; c=relaxed/simple;
	bh=M4sa1KmbmPjJzO1yVd4kcCRXg2vhVEpDOygmmc3GCmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuLcY69zg8mXCRWtJvTGcMdRoFS9LlctCpfJzk+3rowHkK5x6R7owrBoBfSyE84hEjlKhiJLqdVSvydy81PEn7Vo5/34+SLBn85WflOmRkJETJDIZX34t0tBYytfNp4RSbw4kN1pCjl3OpLKqHtXFZEL08DIa27jTzKEt8CQKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9AKmJ4v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9AKmJ4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C6BC4CED1;
	Fri,  7 Feb 2025 09:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738920579;
	bh=M4sa1KmbmPjJzO1yVd4kcCRXg2vhVEpDOygmmc3GCmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=O9AKmJ4vQHi/vVHU72iEYiMzM/xgQkgo0c4BUXz5gQxW+NhYFYyG6dxSkpD29g1Ev
	 R6TGiRYThboW1CVO2fJeUEx7xqdesSeSCuUOi9kcrRBidXWCwo6HrKFReFzXJi1A+G
	 sRdxShNV0NfNX56JJNcfIdu1gpgB7KOKOGX8n+x3AaYNP76TJqWE/dU1g2wnifbB4D
	 gIcARrjO+Smo8i62bqedmOqLRFqQ7o5jgEXus1AyWGWVGNC7PK/FnLVCR+AlyhFqu0
	 6Akp3kdq1iz3bpcPxMe6dn2k9cgToWYd27gC4HOd3TxEtZ3ILr5xxYauRRN3p8U2tm
	 YQosnSP/zxGNw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/4] BPF path manager, part 4
Date: Fri,  7 Feb 2025 17:29:30 +0800
Message-ID: <cover.1738919954.git.tanggeliang@kylinos.cn>
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
 - include a new patch "define BPF path manager type".

 - add new interfaces:
	created established closed
	listerner_created listener_closed

 - rename interfaces as:
	address_announced address_removed
	subflow_established subflow_closed
	get_priority set_priority

 - rename functions as:
	mptcp_pm_validate
	mptcp_pm_register
	mptcp_pm_unregister
	mptcp_pm_initialize
	mptcp_pm_release

v3:
 - rename the 2nd parameter of get_local_id() from 'local' to 'skc'.
 - keep the 'msk_sport' check in mptcp_userspace_pm_get_local_id().
 - return 'err' instead of '0' in userspace_pm_subflow_create().
 - drop 'ret' variable inmptcp_pm_data_reset().
 - fix typos in commit log.

v2:
 - update get_local_id interface in patch 2.

get_addr() and dump_addr() interfaces of BPF userspace pm are dropped
as Matt suggested.

In order to implement BPF userspace path manager, it is necessary to
unify the interfaces of the path manager. This set contains some
cleanups and refactoring to unify the interfaces in kernel space.
Finally, define a struct mptcp_pm_ops for a userspace path manager
like this:

struct mptcp_pm_ops {
        int (*created)(struct mptcp_sock *msk);
        int (*established)(struct mptcp_sock *msk);
        int (*closed)(struct mptcp_sock *msk);
        int (*address_announced)(struct mptcp_sock *msk,
                                 struct mptcp_pm_addr_entry *local);
        int (*address_removed)(struct mptcp_sock *msk, u8 id);
        int (*subflow_established)(struct mptcp_sock *msk,
                                   struct mptcp_pm_addr_entry *local,
                                   struct mptcp_addr_info *remote);
        int (*subflow_closed)(struct mptcp_sock *msk,
                              struct mptcp_pm_addr_entry *local,
                              struct mptcp_addr_info *remote);
        int (*get_local_id)(struct mptcp_sock *msk,
                            struct mptcp_pm_addr_entry *skc);
        bool (*get_priority)(struct mptcp_sock *msk,
                             struct mptcp_addr_info *skc);
        int (*set_priority)(struct mptcp_sock *msk,
                            struct mptcp_pm_addr_entry *local,
                            struct mptcp_addr_info *remote);
        int (*listener_created)(struct mptcp_sock *msk);
        int (*listener_closed)(struct mptcp_sock *msk);

        u8                      type;
        struct module           *owner;
        struct list_head        list;

        void (*init)(struct mptcp_sock *msk);
        void (*release)(struct mptcp_sock *msk);
} ____cacheline_aligned_in_smp;

Geliang Tang (4):
  mptcp: define struct mptcp_pm_ops
  mptcp: define BPF path manager type
  mptcp: register default userspace pm
  mptcp: initialize and release mptcp_pm_ops

 include/net/mptcp.h      |  32 +++++
 net/mptcp/pm.c           | 109 ++++++++++++++-
 net/mptcp/pm_netlink.c   |  11 +-
 net/mptcp/pm_userspace.c | 294 ++++++++++++++++++++++++---------------
 net/mptcp/protocol.c     |  10 +-
 net/mptcp/protocol.h     |  15 +-
 6 files changed, 355 insertions(+), 116 deletions(-)

-- 
2.43.0

