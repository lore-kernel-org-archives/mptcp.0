Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A311B4234
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325503; cv=none; b=GJCNgvYHfb8eUU1ihrt5qDDHo53JUMnD//tGTv8XFS8gsqy0k4wkgwoXMbh9MuMaSCuwKp8hDf8zDj/A+bqUkZCnB/Bw6xKevfaTF01PLMVg/12SZf+oIMHUK1qvHwFZTU92yw+4nfC+JOUIOM7OTHrtfrfe+l48UBBeesUTWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325503; c=relaxed/simple;
	bh=9fjhVqJTyw3Lev1U3CvVN+zDWrL3FORJ7EuDwoy7EcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONQw+gQUbnK3ayaV4OpUQRaX0TQD0fBJBrqiO80nL34kXkNg3YWX+C4NZ9IEhylfkVr9PEtgerhnjXbm0y7SXz/BnFYnMt1HB4T9BOJFYlE2JiGwgz7cBlxoEmNKlaA7Q7gqz98AVi3QAvez2+yxBxnUrIRLN1UTX/v372Q7Vpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rshwBQju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rshwBQju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9AFC4CEE0;
	Wed,  8 Jan 2025 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736325502;
	bh=9fjhVqJTyw3Lev1U3CvVN+zDWrL3FORJ7EuDwoy7EcA=;
	h=From:To:Cc:Subject:Date:From;
	b=rshwBQjuZJ5+JgUX1c5o/Er1X0eKUHa0Iu9oomIqWMzZ/vReNqJ4pkaslKmUYWJXH
	 Cf7xMC7K9rCfyB81z9VirwMbY4vi5hE2Yb73ni3j075ig+sbQU1qS/hMFT2aBuFXOo
	 Yx4ZO238lwLfsltt1odOV3TDWwyNBIVh/75G1/myz2hnsTz5RSmbx8LlS0Da1Xwoid
	 3mJMgca+WHXOdazrYc30VnKSFRXQ/VjeFvBEZLyn3k7OYpGA9+N91uHx3MpjKU47Kb
	 fDVXXw1Hys8omIM5I1UjfDAh8nPIHOEkaKq20ql+NCOBgLGUg8V7IpzM3otwvCTyUN
	 zDgg3BLPzUNkA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/5] add mptcp_address bpf_iter
Date: Wed,  8 Jan 2025 16:38:07 +0800
Message-ID: <cover.1736325184.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - patch 3, use spin_is_locked() instead of lockdep_assert_held().
 - patch 5, use ipv4_is_private_10() for the selftests instead of using
   ipv6_addr_v4mapped().

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
 net/mptcp/bpf.c                               |  70 ++++++
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../testing/selftests/bpf/bpf_experimental.h  |   8 +
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 235 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |   5 +
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  38 +++
 8 files changed, 353 insertions(+), 9 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

-- 
2.45.2

