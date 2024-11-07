Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42981BA2D
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 04:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953759; cv=none; b=pYp1aJmSXPL5nqTK3TFMBI8PrX3hdnFYokuoHrBTFeZpI/5BZfTj96GK+Dzsu1xIE9ZtY2wxTOZ6UYlKlUkXZa0HdbExRoO1EjGllrdJiwFi0LkvgLlRKx0wggpgqqtH/DRDmlFTeC7CjX5PaDqXRts61bC4dx0aKR2Se/IGh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953759; c=relaxed/simple;
	bh=jAwi+OKarWNBiLrHSYpVEd5QWV1kyHTEBeT6erDWqc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oomlYWCOBP7v+Kpy/v1KyN6xlzlhgWTi0fuHh1yxXx39FbsfBr3edO9th26aZ4bzQKq+fN3eEKl7USStA55oxJguT1U0AV5Hib0GN6EgiqlNBjMwm5aQT6+lSS2+a7xhlZZ/r8g3b/iO9OF4Eu4lbKfeq4nL6Mb3vf1UpNY5Tp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGPOABdi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGPOABdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDDAC4CECC;
	Thu,  7 Nov 2024 04:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730953759;
	bh=jAwi+OKarWNBiLrHSYpVEd5QWV1kyHTEBeT6erDWqc0=;
	h=From:To:Cc:Subject:Date:From;
	b=EGPOABdigCtbxaBFNH2Uq53BBuUvre4yN/EF1mdes0SnH02rEsVLMdMnhXM3CSwv2
	 X3m3rYzkgVEbQmUNyMMleQayUqtD0WXYlNwp5C7Nn1LAp4ZT8IAY/zcwDY06x4lPrU
	 bUZ/A+gOknqfXaqNy1Dhdd6T5O+ZVsn0u6moIkepr02/84Zz+EG0om3CidHRV3DnT7
	 owbEq9J0f5+2/5OX1U4f3FB1wDC2qDAIcu+OUFww/GFJCkyfZTLRX4i4FpKvuHRHin
	 LY7DPyq1QcTbcJcJURjiVJmgF6L6o0rYxHwAR5HZgvdF4neKKhvhgIXb/GxPkL2wVl
	 uHX2F0jJa1bew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/5] add mptcp_address bpf_iter
Date: Thu,  7 Nov 2024 12:29:05 +0800
Message-ID: <cover.1730953242.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - rename mptcp_address to mptcp_userspace_pm_addr as I mentioned in [1].
 - rebased.

[1]
https://patchwork.kernel.org/project/mptcp/patch/b6b53fd730a0edd0024963468d078488ad5e67aa.1729588019.git.tanggeliang@kylinos.cn/

v2:
 - squash patches 5,6 of v1 into one.
 - patch 3, use lockdep_assert_held instead of spin_is_locked.
 - update patch 5 to make it run normally in btf-debug mode.

Another bpf_iter for BPF path manager to traverse all address entries
on userspace_pm_local_addr_list of an MPTCP socket is added in this set.
Userspace pm tool is needed by the self test, so add pm_nl_ctl link in
patch 1.

Geliang Tang (5):
  selftests/bpf: Add mptcp pm_nl_ctl link
  selftests/bpf: Use pm_nl_ctl if ip mptcp not supported
  bpf: Add mptcp_userspace_pm_addr bpf_iter
  bpf: Export more helpers for mptcp_userspace_pm_addr test
  selftests/bpf: Add mptcp_userspace_pm_addr bpf_iter subtest

 MAINTAINERS                                   |   1 +
 net/mptcp/bpf.c                               |  67 +++++
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../testing/selftests/bpf/bpf_experimental.h  |   8 +
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 235 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |   5 +
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  39 +++
 8 files changed, 351 insertions(+), 9 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

-- 
2.45.2

