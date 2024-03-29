Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF534381B8
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688216; cv=none; b=mAI+HxwN54CB69bAhQzi1sKRmyRdGAUCrf7fyrPS/wchGe1Ag8UQqjAYJTVgnOcSbbadh4zqE2toLcnlWrZs0aH3avY5ZUcNIdEPRtXe5EM1RhsiQ793ciNuDvkRe2EzCr7bc9IS2QE9mo3jvpWW60N4NqOxnYGViamu6a9+m/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688216; c=relaxed/simple;
	bh=WnKUTa8tSNsrhVMIig3ppM/PAWAunbx2dBFuPuz/d9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=np8fVU6VQ0kzk9lGj3ckYiumWGUUVHyjBX6ltII3rb40EcMmsZRvkh+wCyJjrDATd3d/KYEWvWsDCse1j8YJIxHoXFSYYxhkUPc6SPQTFuB0Rw9iYyyb3n1MLOdZykKvqThWK1ajdB5DjnFUlPjFxk8M+QAjYcx+3TCL40ZZ7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4dnbTNY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4dnbTNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B6DC433C7;
	Fri, 29 Mar 2024 04:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711688216;
	bh=WnKUTa8tSNsrhVMIig3ppM/PAWAunbx2dBFuPuz/d9U=;
	h=From:To:Cc:Subject:Date:From;
	b=N4dnbTNY5C4pgpsxXoPCmqhVwYaSnSwSWMHh6sT4bk9lqYwJUtIzskjCXAtTmLg/M
	 e5BKAlGJMZISWg9TQ7tsGRUHCt0LScR585fjwrqFvLDUd5oQMoYDmjr2ZifuvSF40n
	 Vqgw97CETw73VE/SZbf/NF+XK/X0sbC4x0V+KKoDrtqJTBG4a8Cc5c90NKpsjMX0l8
	 v+i5UoaYMOw2SfFw9omhJ/5whoVNgK53lQLDJVV9KymLB6Or4Br7DcJ9SvB7tp6s/+
	 TKS5KBCdogv5WJhXubN8EO+qHzr2G0iZS0tclXgzU1++bJnZXcAHp8JZPTH5+q2cPZ
	 WicQQUpnzXjsw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 00/15] refactor mptcp bpf tests
Date: Fri, 29 Mar 2024 12:55:56 +0800
Message-Id: <cover.1711688054.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - add two more helpers, send_single_byte and send_recv_data.

Refactor mptcp bpf tests using newly added macros MPTCP_BASE_TEST,
RUN_MPTCP_TEST and MPTCP_SCHED_TEST macro.

Geliang Tang (15):
  Squash to "selftests/bpf: Add bpf scheduler test" - fix
  selftests/bpf: Handle EAGAIN in bpf_tcp_ca
  selftests/bpf: Export send_single_byte helper
  selftests/bpf: Export send_recv_data helper
  selftests/bpf: Refactor mptcp_sock test
  selftests/bpf: Refactor mptcpify test
  selftests/bpf: Add MPTCP_BASE_TEST macro
  selftests/bpf: Add RUN_MPTCP_TEST macro
  Squash to "selftests/bpf: Add bpf scheduler test"
  Squash to "selftests/bpf: Add bpf_first test"
  Squash to "selftests/bpf: Add bpf_bkup test"
  Squash to "selftests/bpf: Add bpf_rr test"
  Squash to "selftests/bpf: Add bpf_red test"
  Squash to "selftests/bpf: Add bpf_burst test"
  Squash to "selftests/bpf: Add bpf scheduler test" 2

 tools/testing/selftests/bpf/network_helpers.c |  85 ++++
 tools/testing/selftests/bpf/network_helpers.h |   2 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  72 +--
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 468 +++++-------------
 .../selftests/bpf/prog_tests/tcp_rtt.c        |   9 +-
 5 files changed, 208 insertions(+), 428 deletions(-)

-- 
2.40.1

