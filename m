Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F9B26AC3
	for <mptcp@lists.linux.dev>; Fri, 28 Mar 2025 04:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743134502; cv=none; b=r87yWtqk09bCOwoqIHdYrGQaB4O5IGNdmdyH2JLNKSzC6I4G5GETRN674L4D3vSwhpwo+c6nPGuoFdAtzOzjD/nmrP2biSAIptsXbZbEzl8VbLKkjrManLPR8Mk3JDGlp4JaRQpwU6kLUnbGon8x/ga6Q6B1n96bGBt1fnyQ8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743134502; c=relaxed/simple;
	bh=IJ7bxNCWZxeBJWEsmEPvibs2H4SETG+Lapk0y94/hoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+KdaOA8QWYgPb0k7Ro4D1yV/1vxMwMjGGldIKHPJAlFZ7hS2Z83FJgiWobE+Jp7izpSQtyB5rSfFT8fe1qceRdQFoI1PiVgAmF2fktLDLUlV133JwcnQNPJIhS6eDhajE6bl9IL6wqNTe5MEnW32EtljDq6kmIHaQsWl0bbPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5yAz0ko; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5yAz0ko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F51C4CEE4;
	Fri, 28 Mar 2025 04:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743134500;
	bh=IJ7bxNCWZxeBJWEsmEPvibs2H4SETG+Lapk0y94/hoE=;
	h=From:To:Cc:Subject:Date:From;
	b=P5yAz0koFC4r6Qt4Fc29dTObC1dC5qsrRyfwpxULeAc2OdLqWydhZ4nfaTwhrD1Xv
	 s/R+FkWTKcBnv3EZhGqEuN/RQBfpRwe1Wq+pjCE6EKTnrWbz/I1r2mLyepHuwzN7YU
	 bdPN1Km48cXmCjsCpwWh6KFPD7+hkauszyyfMBzNroPzHwhny4tE5ovKzKZW97ba0v
	 XDUsgzth0bT3a+vUIlYaMjC4NaKpytx+cBcsSjH7tb9gyW4tHeGK6vHNF6MaeanPgK
	 KReXkC93gsh2zy88IC4donouHMic+Y1f+/NB7J8djbgwLE/ffiFUii3BqVROp09V5c
	 TbiOp/EW9eRag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/5] BPF path manager, part 6
Date: Fri, 28 Mar 2025 12:01:30 +0800
Message-ID: <cover.1743133948.git.tanggeliang@kylinos.cn>
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
 - squash accept_new_subflow patches into one.
 - change "pm->subflows == subflows_max - 1" to
	pm->subflows + 1 == subflows_max.
 - not to call accept_new_subflow under the PM lock.
 - add mptcp_pm_accept_subflow helpers.
 - drop READ_ONCE in mptcp_pm_worker.
 - clear all the pm status flags once in mptcp_pm_worker.

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

Geliang Tang (5):
  mptcp: pm: call pm worker handler without pm lock
  mptcp: pm: add accept_new_subflow() interface
  mptcp: pm: add established() interface
  mptcp: pm: add subflow_established() interface
  mptcp: pm: drop is_userspace in subflow_check_next

 include/net/mptcp.h      |   5 ++
 net/mptcp/pm.c           | 100 +++++++++++++++++++--------------------
 net/mptcp/pm_kernel.c    |  47 ++++++++++++------
 net/mptcp/pm_userspace.c |   9 +++-
 net/mptcp/protocol.h     |  27 ++++++++++-
 net/mptcp/subflow.c      |   6 +--
 6 files changed, 122 insertions(+), 72 deletions(-)

-- 
2.43.0

