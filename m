Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158A25C71B
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804392; cv=none; b=IXGnkCqpihWoKE3XqV+uiJ4XRUJEEwB5wirt+ubhgDNnUEquYg7bfKY1kqQvnXMutLR0PF7IJryY0zmwdUisv2GWwlYfTncP2yBSYSpqB0PPpoIQnW0/lkSS/bN3ccrNcBWKweFDPhtNVhzjyDfQ58UxzHaH1cbuNZPu//lb1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804392; c=relaxed/simple;
	bh=n7g4YALJxaYWH2Iy7eqnI2+OpGJ7DjJ0wUxAcaD0o2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTc0EWkK7CXw3lZvPVG5AmrC3RqAOvK2mz6IMpRcPtVdoz9yQ4qFA4jOFyr547eOGrgSns4ZiS3HKbf0E+sJADSbRHQV4mPV3s5paGUOFSeeWAus1/oh89ju6vkj2eK94YVSkxgzVcvKuze6IvH483K6WOYXAlvm2lag4dkFTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngwMqAj4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngwMqAj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89936C4CEDD;
	Mon, 24 Mar 2025 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742804391;
	bh=n7g4YALJxaYWH2Iy7eqnI2+OpGJ7DjJ0wUxAcaD0o2E=;
	h=From:To:Cc:Subject:Date:From;
	b=ngwMqAj4GMDiqbGYuRtpmzwLHnEuQR4xdgjY08+Wte4fN7FOarzDLUE83InkB28E0
	 /xIcJiIrjtrxg2f7Kwt3KedkyHDXXFygc8kZJrmYcxIwXqug/sEX58p93CwUlODhvW
	 fRWXfyGqr+gLH/ZgLhS0zvxWRtOhP/I/anrwes8hWfeE81jEPXzcQE3rPUVjw8x+HJ
	 0ftrkmgZqfjcBI1sF124asZcvdf5HG72mV2mJB5ZQECsEYKW4wG2NtsuONohvKBVNe
	 UBV6FJQqhMnosFzd7VVSHC8EueX03FncC7M4hJbGMXUxiKYxniwssNse5KPtL+Ux4G
	 8+DkJgHPKqDeg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/9] BPF path manager, part 6
Date: Mon, 24 Mar 2025 16:19:34 +0800
Message-ID: <cover.1742804266.git.tanggeliang@kylinos.cn>
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
 - address Matt's comments in v3.
 - update pm locks in mptcp_pm_worker.
 - move the lock inside mptcp_pm_create_subflow_or_signal_addr.
 - move the lock inside mptcp_pm_nl_add_addr_received.
 - invoke add_addr_received interface from mptcp_pm_worker.
 - invoke rm_addr_received interface from mptcp_pm_rm_addr_or_subflow.
 - simply call mptcp_pm_close_subflow() in mptcp_pm_subflow_check_next.

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

Geliang Tang (9):
  Squash to "mptcp: pm: add get_local_id() interface"
  mptcp: pm: add established interfaces
  mptcp: pm: drop is_userspace in subflow_check_next
  mptcp: pm: drop redundant MPTCP_MIB_ADDADDRDROP
  mptcp: pm: add add_addr_received() interface
  mptcp: pm: add rm_addr_received() interface
  mptcp: pm: add add_addr_echo() interface
  mptcp: pm: add accept_new_subflow() interface
  mptcp: pm: add allow_new_subflow() interface

 include/net/mptcp.h      |  15 ++++++
 net/mptcp/pm.c           | 114 ++++++++++++++++++---------------------
 net/mptcp/pm_kernel.c    |  91 +++++++++++++++++++++----------
 net/mptcp/pm_userspace.c |  13 +++++
 net/mptcp/protocol.h     |   3 +-
 net/mptcp/subflow.c      |   4 +-
 6 files changed, 148 insertions(+), 92 deletions(-)

-- 
2.43.0

