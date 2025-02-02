Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065B1C07C8
	for <mptcp@lists.linux.dev>; Sun,  2 Feb 2025 04:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738470964; cv=none; b=O5n5ZmznuYaKxiNv9ySgrFKs9DLWCSYVM5I2XDbkwKvqF9F00tdmn9+9BqWVF3D/99w0mVgYpjHrxn4vwUlPdG587/4jMwtgZ/ILRwUxzxg55GTPmy6Qn9/c4owCWnG3JeT7e1NGlorKOk4yEYsVA2vAiB0hbY6mjd+N0ZH2nt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738470964; c=relaxed/simple;
	bh=mc7y/KBbM/nBmyGiT7IkQysGzjfGYKHa0cdBbJhMvfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qo/QWLUSq1uxak5Umi7IpvqiuDAqRyccomwzrteyapPWFOByIrSqQDYLovNy9Hkj9rwq2uF4rAj/FBEKwg2u1MVUMdtVPWFwgXQTGoxpQzimVC0s7/HPGrkEXnbTgnwD721cYgpAW4EN409QTkcRRONKRo0bR393BD0Yw6U8png=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1DRqRuv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1DRqRuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0361EC4CED2;
	Sun,  2 Feb 2025 04:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738470963;
	bh=mc7y/KBbM/nBmyGiT7IkQysGzjfGYKHa0cdBbJhMvfQ=;
	h=From:To:Cc:Subject:Date:From;
	b=G1DRqRuvZqt1ZKs6gSgP2KQAbu/Dq6EYqCdo5ZLpOnzCo6cA6Rpka+lLthyy9D97G
	 iN7cBfC0LbDGKmcB5eiGxn9E4q2JkntjIj7dpGNCQfyV2DyyCpNOsHY3l3mldQnRo1
	 y+mUG53f7lAlFN+Fu69b/fIzc3kHESfxfcUbErDTmN63XJDcVo/mxVVObAq0JZEqin
	 Bfj/C6HMxeVHSPVuYMXadjCobAe4cyNPDd6ABGpQU4Ap0Eoye83dPgZtgj4Q6mlry8
	 efn6X8XETTltpxqpuhM8idqMjcZgaM84KzlgX7gdKHx1s7XjlqEDEsPZ9CU/xteFnt
	 7HCxBSeAsDogg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/5] Squash to "Add mptcp_subflow bpf_iter support"
Date: Sun,  2 Feb 2025 12:35:06 +0800
Message-ID: <cover.1738470660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - Drop bpf_skc_to_mptcp_sock
 - Check the owner before assigning the msk as Mat suggested.
 - Use bpf_core_cast() in mptcp_subflow bpf_iter subtest instead of
using bpf_skc_to_mptcp_sock().

Address Martin's suggestions for v2.

Geliang Tang (5):
  Revert "bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock"
  Revert "bpf: Allow use of skc_to_mptcp_sock in cg_sockopt"
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Revert "bpf: Acquire and release mptcp socket"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 include/net/mptcp.h                           |  4 +-
 kernel/bpf/cgroup.c                           |  2 -
 net/core/filter.c                             |  2 +-
 net/mptcp/bpf.c                               | 43 +++++--------------
 .../testing/selftests/bpf/bpf_experimental.h  |  2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 --
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  8 +---
 7 files changed, 16 insertions(+), 48 deletions(-)

-- 
2.43.0

