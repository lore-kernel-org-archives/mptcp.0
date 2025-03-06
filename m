Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FD20ADEE
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258913; cv=none; b=l41kZarfuHrRSgXktEBpw5t1bmDQgV8GDgM+C5sXD2QgTdZNRpdGawh48mfjRaGL6Tihn1bE0+CqgaqveNkRCoLFCnGfoT0R3Aiu31eXv8r0PFneps5P42t9c4TkfFaLSG7d6SGLDOl09tfS/siXPb2ZWMxIPH2BZXjUanyq+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258913; c=relaxed/simple;
	bh=2punb7U0SjAo/1+CnVMkBB1x3VZJFXixf4Cv7e9TKLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xx39dJ1CvaDWr9x4kpFRb8jYjUXr1gnb2H0bb9kjBxqrJS2rw3YSR8Hh5739a15kmMGhsBf5gOn85xh4shvjqmOlt3Ej35Bs3P0mj5FhmlV1FtvQfuT1a5x07faCZ7FqZyjqoBHRaxdb9nRfUt/FZA1yglcYJVqcF6+Y9iXfqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4XWKPQp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4XWKPQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C715BC4CEE0;
	Thu,  6 Mar 2025 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258912;
	bh=2punb7U0SjAo/1+CnVMkBB1x3VZJFXixf4Cv7e9TKLI=;
	h=From:To:Cc:Subject:Date:From;
	b=H4XWKPQpnDQk+3mWmnMXa4wSheOMFUTx7piUGM6ZnoOHu9+XDO8udTeTYQJr9yzHB
	 +mkSeKN2egLJtmm8UgfaANEK9tMacBL3K0cGDreE6AEl21f6JufPtSa3aQGB4Gh1J3
	 hIOdu5kKL/XI0GFgYDgFOgmDpfNMLlHiZcc3QwcGgDfnirnsX5JItOxftcZ3Ti541L
	 LCUTuvXzm2N/yuXlVqiSiOqOythhcsFLXDM4/roqcNruEy+FlunC6/lYh1VlnVuDwN
	 wK3yLWiRztgd7fyIY7Tv9TF+6j4Ceb5Ha30f3gEd+pyv9hxm5Cha8ocYfX12VnS6sc
	 WophA5hroCTgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 00/12] BPF path manager, part 5
Date: Thu,  6 Mar 2025 19:01:35 +0800
Message-ID: <cover.1741258415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v10:
 - drop pm->init in mptcp_pm_validate, move mptcp_pm_validate into a new
   patch.
 - remove tlb, use ctl instead in proc_pm_type.
 - use "strncmp() == 0" instead of "!strncmp()".
 - set pm_type __MPTCP_PM_TYPE_NR for other names.
 - add WARN_ON_ONCE in mptcp_pm_unregister.
 - drop mptcp_userspace_pm_init.
 - rename "struct mptcp_pm_ops *pm" to "struct mptcp_pm_ops *pm_ops".
 - drop pm_ops NULL check in mptcp_pm_release.
 - add struct_group for struct mptcp_pm_data.
 - move selftests into userspace_pm.sh.

v9:
 - rename mptcp_pm_nl_ prefix to mptcp_pm_kernel_.
 - rename mptcp_userspace_pm_ prefix to mptcp_pm_userspace_.
 - update commit logs.

v8:
 - address Matt's comments in v7.

v7:
 - addresss Matt's comments in v6 [1].
 - drop "type" from struct mptcp_pm_ops as Matt suggested.
 - map "pm_type" to new sysctl as Matt suggested.

v6:
 - add "name" in struct mptcp_pm_ops.
 - add some "sysctl" patches.
 - drop "struct mptcp_pm_param".
 - drop "pm_type" in mptcp_pm_data.

v5:
 - use "struct mptcp_pm_param *param" as unified parameters for all
   interfaces.
 - register in-kernel mptcp_pm_ops too.
 - only implement two interfaces "get_local_id" and "get_priority" in
   this set.

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

In order to implement BPF path manager, it's necessary to unify the
interfaces of the path manager. This set contains some cleanups and
refactoring to unify the interfaces in kernel space. Finally, define
a struct mptcp_pm_ops for a path manager.

Geliang Tang (12):
  mptcp: pm: define struct mptcp_pm_ops
  mptcp: pm: register in-kernel and userspace PM
  mptcp: sysctl: set path manager by name
  mptcp: add struct_group in mptcp_pm_data
  mptcp: pm: init and release mptcp_pm_ops
  mptcp: pm: add get_local_id() interface
  mptcp: pm: add get_priority() interface
  mptcp: pm: validate mandatory ops
  mptcp: sysctl: map path_manager to pm_type
  mptcp: sysctl: map pm_type to path_manager
  mptcp: sysctl: add available_path_managers
  selftests: mptcp: add path_manager sysctl tests

 Documentation/networking/mptcp-sysctl.rst     |  23 +++
 include/net/mptcp.h                           |  19 +++
 net/mptcp/ctrl.c                              | 111 ++++++++++++-
 net/mptcp/pm.c                                | 157 +++++++++++++-----
 net/mptcp/pm_kernel.c                         |  35 +++-
 net/mptcp/pm_userspace.c                      |  26 ++-
 net/mptcp/protocol.h                          |  22 ++-
 .../selftests/net/mptcp/userspace_pm.sh       |  58 ++++++-
 8 files changed, 395 insertions(+), 56 deletions(-)

-- 
2.43.0

