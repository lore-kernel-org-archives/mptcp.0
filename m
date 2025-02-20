Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEFF1DED51
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020263; cv=none; b=iho+O2hJZ71YEZIjtPtfo2o927rbCjOuHyHo7erof5ycxrmUMswbQq+IwECOOOjPnKo6SBSJB87PZigoJXwMvWT4Xodx0/LXtPsB0kPuK5ajmnBmADMzLA/NRnSd5r0711KEPz/WsqIcg0dSQTMw6pooPXbUFZA3PKMYozjZ35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020263; c=relaxed/simple;
	bh=WVgr4A3EdPwPJAa+oHyF1lb+6fnFrG/P7EXW7947JqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tbg1ZksiFaQv7kQg39b7Ul5hIOVcOuF0tsJq95TXgnLjd0ocfU0nmLslHFNkqnGAIQ2n2HMMwnh5/o1pwZKpz9GC4iKEKMo8FVl6AFfEGCvDuz/FRJDsWofrOAVjsu0h9KZJOUH+lIaFyQa/LX+tQJs2taDlKHZcw5Q6NlAWNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxXarvuy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxXarvuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AD7C4CED6;
	Thu, 20 Feb 2025 02:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020262;
	bh=WVgr4A3EdPwPJAa+oHyF1lb+6fnFrG/P7EXW7947JqM=;
	h=From:To:Cc:Subject:Date:From;
	b=MxXarvuykqDTdItdnFnAx2ukMPXhYCNWjEEDbt2ct/bKWYuetwxbxgWwzKDJz8P6P
	 xlG5tILf+a1v0hBoewmSvWl6WRsugk45E0i0IYu1KdKoLCIvZDaOFsxpEPqbPWbBaU
	 3noOit9ERnk72IbJG9KenYAQpPQP6iIEqArVhHUkaxU9MhjlR34otgt27VQVMl3kGo
	 ed/zyilPIdUCpI7Z5FRRcmZOOXQEWfZKQe0QAjXA7vBQjBT0WkD5gtrYLcPEJydBg8
	 THpBH9/JzH/dKjAKYENudYdc6lCpxTPy2yXt0jYnomfWALW8M01yeJIR2tLjTZTdiR
	 FWs1OrQBI+DIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/9] BPF path manager, part 4
Date: Thu, 20 Feb 2025 10:57:24 +0800
Message-ID: <cover.1740019794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (9):
  mptcp: pm: use addr entry for get_local_id
  mptcp: pm: add struct mptcp_pm_param
  mptcp: pm: pass pm_param to get_local_id
  mptcp: pm: define struct mptcp_pm_ops
  mptcp: pm: in-kernel: register mptcp_netlink_pm
  mptcp: pm: userspace: register mptcp_userspace_pm
  mptcp: pm: initialize and release mptcp_pm_ops
  mptcp: pm: drop get_local_id helpers
  mptcp: pm: drop is_backup helpers

 include/net/mptcp.h      |  42 +++++++++++++
 net/mptcp/pm.c           | 131 ++++++++++++++++++++++++++++++++++++---
 net/mptcp/pm_netlink.c   |  23 +++++--
 net/mptcp/pm_userspace.c |  37 ++++++-----
 net/mptcp/protocol.c     |   1 +
 net/mptcp/protocol.h     |  24 +++----
 6 files changed, 216 insertions(+), 42 deletions(-)

-- 
2.43.0

