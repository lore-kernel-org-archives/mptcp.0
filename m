Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C771FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088446; cv=none; b=nlv7IVzCopnbPVcPRmvemkks6XOiDibgw+QZ1JDQkoctecWNUvBpXBFos2fFes+n1BiI6ESIAT1c2pecyReBIKiuozxAUzXIheo4+LFKrr1UsUmbn+hlzqLJmhMdZfDn3I7nBf6+zLrthbTKViSd2Jj+n8I8bW8Xw1ygXPIFrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088446; c=relaxed/simple;
	bh=rfajYf7DUQxZnDv2m+107j0h8ecz9/y4LAjNvWMtHe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVirRhG9O3yhT2wywWvn/lTktkPorYC057BLvwLNCVcg+6a9qXeuowy88KTmTwUDpFWiis1TmG0Njzxd3eLFI+5WQIlUUSKzWrPaX2ucw/4ottG1UtgXz3H5pYsewQFsQdJIWZlQQATpEEFqz47u++eiMjHOtVWzkNvj/ixJrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGniDt20; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGniDt20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB7FC4CEE5;
	Tue,  4 Mar 2025 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088445;
	bh=rfajYf7DUQxZnDv2m+107j0h8ecz9/y4LAjNvWMtHe8=;
	h=From:To:Cc:Subject:Date:From;
	b=KGniDt20pUiIJwYXz94ke59c94nMpU4Ha0G3AHAnmkmvUPBMqvGGOv+s28ZyKbhVE
	 B8g3u9UDuaou03d1jKcTiKlZY5likxHoDGXp5YWE0lSJSpfA0Kgee09r4Wt3ocIryN
	 Rl9lPE8iakMRknbkCC1b+qBZs9GijZldGOTvJ5ke8JXnZTWlNp+hS9gaRfjgW3of8P
	 WeEs5x+Rwp4seJY2ceWyQ2bIyt9oJCA63WqUXIqeTaHUDEIn4roOgX8VqMu5pfRZZu
	 ORWp214lypNfLhqqZjkdOjkAmFI6pnm64LzE5HoD6HrSEwEG4OwrI+5WOVQv/I0CxR
	 kLMxNLMUllNyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 00/12] BPF path manager, part 5
Date: Tue,  4 Mar 2025 19:40:27 +0800
Message-ID: <cover.1741088339.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v8:
 - address Matt's comments in v7.

v7:
 - addresss Matt's comments in v6 [1].
 - drop "type" from struct mptcp_pm_ops as Matt suggested.
 - map "pm_type" to new sysctl as Matt suggested.

Depends on:
 - mptcp: pm: code reorganisation, v2

Based-on: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>

[1]
https://patchwork.kernel.org/project/mptcp/cover/cover.1740320007.git.tanggeliang@kylinos.cn/

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
  mptcp: sysctl: new sysctl to set path manager by name
  mptcp: sysctl: map pm_type to path_manager
  mptcp: sysctl: map path_manager to pm_type
  mptcp: sysctl: add available_path_managers
  mptcp: pm: in-kernel: register mptcp_pm_kernel
  mptcp: pm: userspace: register mptcp_pm_userspace
  mptcp: pm: initialize and release mptcp_pm_ops
  mptcp: pm: add get_local_id() interface
  mptcp: pm: add get_priority() interface
  selftests: mptcp: add pm_type mapping tests
  selftests: mptcp: add path_manager sysctl test

 Documentation/networking/mptcp-sysctl.rst     |  23 +++
 include/net/mptcp.h                           |  19 +++
 net/mptcp/ctrl.c                              | 112 +++++++++++++-
 net/mptcp/pm.c                                | 145 ++++++++++++++----
 net/mptcp/pm_kernel.c                         |  35 ++++-
 net/mptcp/pm_userspace.c                      |  36 ++++-
 net/mptcp/protocol.h                          |  18 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  49 +++++-
 8 files changed, 393 insertions(+), 44 deletions(-)

-- 
2.43.0

