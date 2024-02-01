Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D743D3C485
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764752; cv=none; b=oZgNQFGBY8/wuDOnHzIjX8J+T3sjQrNeJnKqGO48G5bX8nZAa0j6K0XfzeK0RugNoFpufIoS0E/Wbxb3VWZ4h+8xvuN/aUGxzbTPH3DR0TLkU0OOo1h3PhujW8GimdcImXxGCwLvk2fC/yL777DDin1MCDLGUkxE1oZezuJOLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764752; c=relaxed/simple;
	bh=7aYx5HpjLGmSXdc5YyTglgIGUXlmyO8hMloPJiuAP6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LLUetBrcidCUIpcTSYgyQrk4CtBBlHVk1mFO3ed8VpH5J3X7bCGUCNO4jMwc8E5teUaYxjlWI5h46PmDKR37Drb13TKFUEnSZn/MwgwatnPJbfUo4X+tvOk0sFq5H8JGwVt+xzE7Q606QOHG+pHC8VRdAwjAVSxLtiziusk98X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFCGv9Df; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFCGv9Df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888B9C433F1;
	Thu,  1 Feb 2024 05:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764752;
	bh=7aYx5HpjLGmSXdc5YyTglgIGUXlmyO8hMloPJiuAP6E=;
	h=From:To:Cc:Subject:Date:From;
	b=gFCGv9Df6159vQgLCisoi83wgB0vSqIxOT7xuOgQuYQsvCGciPvjAnHyrl82Lc7X2
	 c+Ledd0LUDxP3QA1WpmyUEGhzV6eMhqiMUHWX+cROVMz+pNBpL9aPjWb8Xydn4v79I
	 tJ0ON/Up71geAItoGEmeEEGojperf5+tahUI2uuVe0tkzChcUwCoYtl2aefNjuSO9N
	 TmS2UEWwFWOSvc83dUUjXWvAFWHgCOcpGjfbys8AHxm0j/aE0gsh76ZkTDaymjBvRN
	 Jbx1DPUiTG4Q7bAnum28JcGTtfXxp7Frx1x3FLBJykCUZwnqANEt14Nj671pu9mUsA
	 tYSENW4e2FuHQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 00/15] dump for userspace pm
Date: Thu,  1 Feb 2024 13:18:50 +0800
Message-Id: <cover.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v11:
 - update patch 5 as Mat suggested.
 - depends on "fixes for userspace PM" series.

v10:
 - fix a checkpatch.sh warning reported by CI.
 - fix build warnings reported by kernel test robot <lkp@intel.com>.

v9:
 - add missing "sock_put(sk)" in patch 7, 17 and 21 to fix the "kmemleak"
   errors reported by CI.
 - rename the helper to mptcp_pm_has_addr_attr_id.
 - use my new mail address.

v8:
 - Address Mat's comments in v7

v7:
 - fix checkpatch.sh warning reported by CI.
 - fix build errors reported by CI.

v6:
 - patches 1-5, fixes for -net
 - patches 6, 15, selftests for "fixes for -net".
 - patches 7-14, 16-21, update "dump for userspace pm v5"
 - patches 22, 23, cleanups for set_flags
 - patch 24, flush selftest.

v5:
 - patch 2, save bitmap instead of id.
 - patch 3, drop token in reply.
 - update patch 4 and patch 12, add mptcp_pm_dump_addr and
   mptcp_pm_get_addr wrappers in pm.c

v4:
 - update patch 2, patch 3 and patch 12.
 - fix the warnings reported by CI in v3:

Unable to validate one commit: 7633a101a mptcp: get addr in userspace pm list
Unable to compile mptcp source code with make W=1 net/mptcp/pm_netlink.o
Unable to compile mptcp source code with make C=1 net/mptcp/pm_netlink.o: net/mptcp/pm_netlink.c:1656:5: warning: symbol 'mptcp_pm_nl_get_addr' was not declared. Should it be static?

v3:
 - fix the errors reported by CI in v2:

[10:55:51.288] [  897.523894][ T5664] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[10:55:51.288] [  897.532157][ T5664] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5664, name: pm_nl_ctl
[10:55:51.289] [  897.539503][ T5664] preempt_count: 201, expected: 0

 - drop mptcp_pm_nl_put_entry_msg and mptcp_pm_nl_put_entry_info
   helpers.

v2:
Address Mat's comments in v1:
 - patch 2: pass token to dump_addr too.
 - patch 2: add back id in mptcp_userspace_pm_dump_addr().
 - patch 5: update mptcp.yaml

v1:
Address Mat's comments in "userspace pm enhancements" v14.

Geliang Tang (15):
  mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
  mptcp: implement mptcp_userspace_pm_dump_addr
  mptcp: add token for get-addr in yaml
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm flags
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add token for dump_addr
  selftests: mptcp: add check_output helper
  selftests: mptcp: dump after creating id 0 subflow
  selftests: mptcp: dump userspace addrs list
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: implement mptcp_userspace_pm_get_addr
  mptcp: get addr in userspace pm list
  selftests: mptcp: add token for get_addr
  selftests: mptcp: userspace pm get addr tests

 Documentation/netlink/specs/mptcp_pm.yaml     |   3 +-
 net/mptcp/mptcp_pm_gen.c                      |   7 +-
 net/mptcp/mptcp_pm_gen.h                      |   2 +-
 net/mptcp/pm.c                                |  16 ++
 net/mptcp/pm_netlink.c                        |  26 ++-
 net/mptcp/pm_userspace.c                      | 177 ++++++++++++++++--
 net/mptcp/protocol.h                          |  13 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 102 ++++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  39 +++-
 9 files changed, 353 insertions(+), 32 deletions(-)

-- 
2.40.1

