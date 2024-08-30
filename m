Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9C374D1
	for <mptcp@lists.linux.dev>; Fri, 30 Aug 2024 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000939; cv=none; b=L5DePsm3fIUZGQQqslcRgvPVLWgR+V4kWx2R3Dmgj/Vk0KMRae0eOcE3Jz52lMM7eRr8Yo2kfqndKE4FcVdPyN9bzRsx+nUR8yZBzlMXaYnH5x19Q4IW/yE9+OUvwxlx4lyFyBUGyx0FnLmaVbZOpcYt46E+ISiOrLSXNj6ncI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000939; c=relaxed/simple;
	bh=yfAcXJXCYC2ItHqRjU4zIPffLFSXrYKtBSR2uRAxyiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxkcb/bdnvh8z9yfZcD4/R0AaAo49InvLGfmFk9SZHomlZq7bGS8UfF3whksZIb3Ps0zCBQn8fN4h2aql76CBY8VJQu55s4bJ0ov1+5y2UcTiLkh9pPiOPA6mpPL3tF1KtfwAeggOTl344mIvVxnQN4YX02fIZ8r1sbyEWKUwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTI77uxA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTI77uxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A68C4CEC2;
	Fri, 30 Aug 2024 06:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725000939;
	bh=yfAcXJXCYC2ItHqRjU4zIPffLFSXrYKtBSR2uRAxyiE=;
	h=From:To:Cc:Subject:Date:From;
	b=QTI77uxALlhtVN565gNa5M+YVJeZSvqLQltoXDh6AUemyQheIb8Q3bta0uo4f0wwF
	 omg6pYZv90RkFqLr0rbltv9i0F1qyCs3fJdgWQZiPV48Qd89GemQBFYAgP4jZTy0K9
	 2aoVMU/PMCUNNVK8lFSSb96dBZl5usbpksbLsj0Tpip2VPp180OEVaCGPFWJTf2Gkh
	 hip8uY3/RTy+NTfCxwtOq0A+Bsfq2Mft1k/q86/Fl5SROLfZZB8hhxL2vyEMa67H11
	 KXgIRR+39/ZklZCdyPiNQXXvGprzVtFPweCQq4bqV1f56clf/fjmcr/F9ZxXfWxJ9X
	 t5GuLCt5w4J2Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/4] fixes for "new MPTCP subflow subtest v4"
Date: Fri, 30 Aug 2024 14:55:29 +0800
Message-ID: <cover.1725000687.git.tanggeliang@kylinos.cn>
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
 - address Matt's comments in v5.
 - use mptcp_for_each_subflow in _check_getsockopt_subflow_mark.
 - check msk->pm.subflows in _check_getsockopt_subflow_mark/cc.
 - add wait_for_new_subflows helper.

v5:
 - rename _check_getsockopt_subflows_mark in patch 1.
 - address Matt's comments in v4.

v4:
 - address Matt's comments in v3.

v3:
 - drop "ss_search" from subflow subtest
 - fix mptcp_for_each_subflow_safe
 - add cond_break in list_for_each_entry/_safe

Two fixes address Martin's comments in "new MPTCP subflow subtest" v4.
Patch 2 will conflict with "selftests/bpf: Add bpf_first scheduler & test".

Geliang Tang (4):
  Squash to "selftests/bpf: Add mptcp subflow example"
  selftests/bpf: Add getsockopt to inspect mptcp subflow
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  Squash to "selftests/bpf: Add bpf scheduler test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 65 +++++++++++------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 35 +++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 71 ++++++++++++++++++-
 3 files changed, 149 insertions(+), 22 deletions(-)

-- 
2.43.0

