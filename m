Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128824A7E8
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737013141; cv=none; b=g2F1PjtGaQbwPIgsUs62gYpJ66v14ly4nelzAGEhzCI+g/Uc/K/TpnxZw0UJ+7VtnZ8XO8HN0+rcgaQjpoEmSSSqNtBKC7nxnplWJh83xebyraWOoyzLdzISUiupMg3JgIGVk2KIIvYlvHmfaAM7GHwd2jzZxhbO6s/j5fqaIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737013141; c=relaxed/simple;
	bh=CFSFajDdMiJk+1yUYyQsKgMi4XCSwIi0H5nn+BnCRCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BM7ZN9/S+i8okQLkUKD2KVXCiRagxtOJ7DsPw1//o0danI00GBwlJAYysT+ZdcopQJiAZSSuDC6mc+WdsUcv+0uCTqcAv4KvgEtr2bKY4fgH/lkd+pbQoQyz1CL/lNF4I5FqAnHCuWc5vfhaXPUyJeNuOpEzIH3owXDfBavB1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqOzyxcC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqOzyxcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87841C4CED6;
	Thu, 16 Jan 2025 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737013140;
	bh=CFSFajDdMiJk+1yUYyQsKgMi4XCSwIi0H5nn+BnCRCs=;
	h=From:To:Cc:Subject:Date:From;
	b=sqOzyxcCOZSVP7ZrfrHQTkVgz1EzR38KIpYau9xKffkoeOkhAdx6lBicd2mVCDICF
	 f4gGTI2Ic2b5HM/mde/VZcA4s6WzMz9IBRZZr99TSOCdtoq/h9ciwCgJp4a2bwY4cX
	 Qtb3xRqtG/c9v56ckNYOQc3KcwIDDbHUVY2/ptMErLOyRbXp6LG0vT7kGTkRO/vupI
	 IoUgojJoMFbgteGgkrauc4jmY631K1TwhHCLB0bYflpZ/t2lpYav+FmUTQs0UXFuWe
	 Y1cahcRXiA0kQDZ2Bsw2cVoBVcC2y+ML81NpczugQ7k/WRSPq2KGBc+8kqOd7YtH2i
	 LS0CdWU4iA/kg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/3] BPF path manager, part 4
Date: Thu, 16 Jan 2025 15:38:50 +0800
Message-ID: <cover.1737012662.git.tanggeliang@kylinos.cn>
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
 - rename the 2nd parameter of get_local_id() from 'local' to 'skc'.
 - keep the 'msk_sport' check in mptcp_userspace_pm_get_local_id().
 - return 'err' instead of '0' in userspace_pm_subflow_create().
 - drop 'ret' variable inmptcp_pm_data_reset().
 - fix typos in commit log.

Depends on: "BPF path manager, part 3" v4
Based-on: <cover.1737012165.git.tanggeliang@kylinos.cn>

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
			    struct mptcp_pm_addr_entry *skc);
	u8 (*get_flags)(struct mptcp_sock *msk,
			struct mptcp_addr_info *skc);
	int (*set_flags)(struct mptcp_sock *msk,
			 struct mptcp_pm_addr_entry *local,
			 struct mptcp_addr_info *remote);

	u8			type;
	struct module		*owner;
	struct list_head	list;

	void (*init)(struct mptcp_sock *msk);
	void (*release)(struct mptcp_sock *msk);
} ____cacheline_aligned_in_smp;

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/74

Geliang Tang (3):
  mptcp: define struct mptcp_pm_ops
  mptcp: register default userspace pm
  mptcp: init and release mptcp_pm_ops

 include/net/mptcp.h      |  27 +++
 net/mptcp/pm.c           |   5 +
 net/mptcp/pm_userspace.c | 374 ++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.c     |   1 +
 net/mptcp/protocol.h     |   9 +
 5 files changed, 313 insertions(+), 103 deletions(-)

-- 
2.43.0

