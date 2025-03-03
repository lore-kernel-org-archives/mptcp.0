Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA1158D8B
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975919; cv=none; b=qaevUgwTa6v6cys6tTS9ycPNKmB6GThtYpdbxlMSrGz3A0Pc5sgRcwoQITVnz0AZiRC1FCIg/zm7MmKABCwTZrlhTFlaqcRujnRZPM47cFgPgHvhZFYMBFBN7fOWwuk0jpsxJhCo0p4CPHX3crMeNWRFhU+iXziMqyWV+PIgrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975919; c=relaxed/simple;
	bh=75ij3+TJuyDNW7NXmctqEF+0G/vYJVXt4zUNDUu+i78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHNnKNqxFNfCNF57FJ/viOm8OdgblIhMc8VqQWf/ySt/ZpZJVrbrdpu4Om2HbBivt5Nn1KrN9czLbb02q32lh32kYtI2S9iGk6FIe36Qy9nHQtt8OOWepfA45JnhUSr6kXg/LAf7p94uoESCgsMIlqI5NM9kND1uKqDrX8HPD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtKa84wS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtKa84wS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEDEC4CED6;
	Mon,  3 Mar 2025 04:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975919;
	bh=75ij3+TJuyDNW7NXmctqEF+0G/vYJVXt4zUNDUu+i78=;
	h=From:To:Cc:Subject:Date:From;
	b=qtKa84wS6sr8dzUO5YJMINJAFAkIFG90I/sjngrNzLnCWvdQCA6m8JSD9vzQwcLmu
	 BMHrw9VCh+WNd6p3Te1lEreC2bBF+clHucfptBaqf1Fg+IJxL5/UkysjMwQlNjf/xc
	 hPMLy3XMvYr+ev2w6HcJ8hqkhVeT5M7Pa+MGoGRQoOHkkcI97kyZRtE8eANyR39e7d
	 P5FBs80v0mXtq/d9pQ0DeWCT5DT7Rs79YObeZ/2wa8OhtXJk263q3wX/CRfUg1sID0
	 qukoFklgT+eelc7tUry6vzezvp4Wc/65v2E/JMhzmmDa18FruMhBI8mlH2/9GRmCpL
	 FuNn7V+fMz8NA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 00/11] BPF path manager, part 5
Date: Mon,  3 Mar 2025 12:22:48 +0800
Message-ID: <cover.1740975633.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (11):
  mptcp: pm: define struct mptcp_pm_ops
  mptcp: sysctl: new sysctl to set path manager by name
  mptcp: sysctl: map pm_type to path_manager
  mptcp: sysctl: add available_path_managers
  mptcp: pm: in-kernel: register mptcp_kernel_pm
  mptcp: pm: userspace: register mptcp_userspace_pm
  mptcp: pm: initialize and release mptcp_pm_ops
  mptcp: pm: drop pm_type in mptcp_pm_data
  mptcp: sysctl: drop get_pm_type helper
  mptcp: pm: make get_local_id helpers static
  mptcp: pm: make is_backup helpers static

 Documentation/networking/mptcp-sysctl.rst |  26 +++++
 include/net/mptcp.h                       |  19 ++++
 net/mptcp/ctrl.c                          | 107 ++++++++++++++++-
 net/mptcp/pm.c                            | 133 +++++++++++++++++++---
 net/mptcp/pm_kernel.c                     |  16 ++-
 net/mptcp/pm_userspace.c                  |  26 ++++-
 net/mptcp/protocol.h                      |  25 ++--
 7 files changed, 317 insertions(+), 35 deletions(-)

-- 
2.43.0

