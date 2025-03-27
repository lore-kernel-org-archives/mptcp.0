Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581FC8EB
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055471; cv=none; b=X5U4kC63h9fc/4OpE5cPg180uLH1MoADrORqBfu7Jwerj2L66SEiZbsG3b+zl2zhUQRO1+VpK9KN8KjmQa96KVU+Swf9gKoHtLJ9Q50KiiVrMn5xFsm+POgJC8Am4mAz6boxpMj6zhTQ8/fW2JR2QhoLGbTOYlaGveh/rxqmHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055471; c=relaxed/simple;
	bh=5T5hRNcJeXHk0+sIJkDnmWuST7gl+o1uBxemxcEZBlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itWadtYvNt1qrqqaXyPcWYGwG6/pTUUOpFIg5esgjs7EKt8b+0Eahkin4GsWd2/XM57rc490Se1kByBVPidBpxoRudFPuWubAtvliN6eGaeCZjfmCWVguIy4tUBuXey+OG68BbZNqMnbKqwwgGrM6Y2/vbpA22bG6X5PYTPbfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBFVoTi7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBFVoTi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892DEC4CEDD;
	Thu, 27 Mar 2025 06:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743055470;
	bh=5T5hRNcJeXHk0+sIJkDnmWuST7gl+o1uBxemxcEZBlw=;
	h=From:To:Cc:Subject:Date:From;
	b=FBFVoTi7Ubgt2T9ARMUqc/XKErQcguTx7fO4qiy05k1IQy/Hr4eQ5oTKxmdMDBx92
	 kuqGbpu4YPxBU4wzrak7bADyzq/LYbtsPdaRFkF1v1SpmCvT/AQOBDVGgePmweKGP6
	 t2+r3pu9GhOr7IXeQC+Anz6nI07l2YRiiW+V3Ei0AaHkDGdkGVf0ndjq9VIzbLjmxC
	 48FAr4XSuhmJcxgesllIBDkgUnRyC+spw+lts3IYWTohZJfLajJsfc0W7860QgkXrJ
	 cYpJ3UchGAGmVEA+SGMVMYfkVX6dxBv+sQigK7I+CTqAdvtjfBmvu/Og0K6OI0ZfnM
	 RuwxSvNwI87VA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/7] BPF path manager, part 6
Date: Thu, 27 Mar 2025 14:04:10 +0800
Message-ID: <cover.1743054942.git.tanggeliang@kylinos.cn>
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
 - add comment "call from the subflow/msk context" for mptcp_sched_ops.
 - add new helper mptcp_pm_accept_new_subflow.
 - add "bool allow" parameter for mptcp_pm_accept_new_subflow, and drop
   .allow_new_subflow interface.
 - use a copy of pm->status in mptcp_pm_worker.
 - rename mptcp_pm_create_subflow_or_signal_addr with "__" prefix.
 - drop "!update_subflows" in mptcp_pm_subflow_check_next.
 - add_addr_received/rm_addr_received interfaces will be added in the
   next series.

v4:
 - address Matt's comments in v3. 
 - update pm locks in mptcp_pm_worker.
 - move the lock inside mptcp_pm_create_subflow_or_signal_addr.
 - move the lock inside mptcp_pm_nl_add_addr_received.
 - invoke add_addr_received interface from mptcp_pm_worker.
 - invoke rm_addr_received interface from mptcp_pm_rm_addr_or_subflow.
 - simply call mptcp_pm_close_subflow() in mptcp_pm_subflow_check_next.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1742804266.git.tanggeliang@kylinos.cn/

v3:
 - merge 'bugfixes for "BPF path manager, part 6, v2"' into this set.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1742521397.git.tanggeliang@kylinos.cn/

v2:
 - address Matt's comments in v1. 
 - add add_addr_received and rm_addr_received interfaces.
 - drop subflow_check_next interface.
 - add a "required" or "optional" comment for a group of interfaces in
   struct mptcp_pm_ops.

v1:
- https://patchwork.kernel.org/project/mptcp/cover/cover.1741685260.git.tanggeliang@kylinos.cn/

New interfaces for struct mptcp_pm_ops.

Geliang Tang (7):
  Squash to "mptcp: pm: add get_local_id() interface"
  mptcp: pm: add accept_new_subflow() interface
  mptcp: pm: use accept_new_subflow in allow_new_subflow
  mptcp: pm: update pm lock order in mptcp_pm_worker
  mptcp: pm: add established() interface
  mptcp: pm: add subflow_established() interface
  mptcp: pm: drop is_userspace in subflow_check_next

 include/net/mptcp.h      |  7 +++-
 net/mptcp/pm.c           | 88 ++++++++++++++++++++--------------------
 net/mptcp/pm_kernel.c    | 52 ++++++++++++++++++------
 net/mptcp/pm_userspace.c |  7 ++++
 net/mptcp/protocol.h     |  1 +
 net/mptcp/subflow.c      |  6 +--
 6 files changed, 99 insertions(+), 62 deletions(-)

-- 
2.43.0

