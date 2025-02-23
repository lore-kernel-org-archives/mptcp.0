Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48B26AF3
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320449; cv=none; b=VRGSchaz2rxpZYvcF8pF7rj35GTckYv4MTuJzT4hYrx5rBgj3M9sPPo/4FUxWaIQVD7Dk5VuwY33m6Q5xCm5xgvY2U90LLxmcZm2mT+rffu3C+b3sq3vXQfR20S98kxAz7rXju7gMDbstuZ8lbYPgXhUBi1mNIoO6qfzlwHudnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320449; c=relaxed/simple;
	bh=htqwXJhXE2U0vPOLKtxBBOoEVMRyyYw9syXm3jheN+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/K8iokKIOw8BdjePOvM/znSLZE2M3ccGCXqTFgeVuLrnX8xEEdVDPo2pOXxwmORysLJcUcXKULdiUYO5+iIst/PRJlp77GhRwW1Avx9oxkLfJjev/3Gm/FccArY3PiMb+PcklWZdP7koUlN6w08Uz3PaY7bmOhVYYQLLypd7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9pmxG5F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9pmxG5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1148EC4CEDD;
	Sun, 23 Feb 2025 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740320448;
	bh=htqwXJhXE2U0vPOLKtxBBOoEVMRyyYw9syXm3jheN+k=;
	h=From:To:Cc:Subject:Date:From;
	b=T9pmxG5F4xF+8HQMlzvikxNLWqkDrIsDvfzA33H9jH/sVYhivbWCOiURn8QSAKQaV
	 MxxyiwvZtqJSLVdMi8qnu0CQhWyi1GSOTJAcHPq8iE9o1wwJTBIoeRboeQJnt9A5Zf
	 lgzy1quGo8W2ycjUhAxUtfCKAvmhJuELLntO+dkRejy5Ha9xSyMAT8UyOPIkSt9esA
	 PPdu/jz8YDl/MzIEXO533I9/dwCp2jXLNpAKaJTHQhG0NVs3tH7uuBGQp5T2y+ukuP
	 QcafNrgdg3mlmQ+dJzephfDZiDQKl+ybUjy+ytAzaNqQ9RCHuTN6+XgtzrCPwka1hh
	 wC3jHzVvgtkMg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 00/13] BPF path manager, part 4
Date: Sun, 23 Feb 2025 22:19:48 +0800
Message-ID: <cover.1740320007.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (13):
  mptcp: sysctl: use index for sysctl table
  mptcp: sysctl: add path_manager to set pm name
  mptcp: pm: use addr entry for get_local_id
  mptcp: pm: define struct mptcp_pm_ops
  mptcp: pm: in-kernel: register mptcp_in_kernel_pm
  mptcp: pm: userspace: register mptcp_userspace_pm
  mptcp: pm: initialize and release mptcp_pm_ops
  mptcp: pm: drop pm_type in mptcp_pm_data
  mptcp: sysctl: drop old pm_type sysctl
  mptcp: sysctl: add available_path_managers
  mptcp: pm: drop get_local_id helpers
  mptcp: pm: drop is_backup helpers
  selftests/mptcp: use path_manager instead of pm_type

 Documentation/networking/mptcp-sysctl.rst     |  14 +-
 include/net/mptcp.h                           |  39 +++++
 net/mptcp/ctrl.c                              | 104 ++++++++++---
 net/mptcp/pm.c                                | 141 ++++++++++++++++--
 net/mptcp/pm_netlink.c                        |  24 ++-
 net/mptcp/pm_userspace.c                      |  36 +++--
 net/mptcp/protocol.c                          |   1 +
 net/mptcp/protocol.h                          |  23 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  26 ++--
 .../selftests/net/mptcp/userspace_pm.sh       |   4 +-
 10 files changed, 324 insertions(+), 88 deletions(-)

-- 
2.43.0

