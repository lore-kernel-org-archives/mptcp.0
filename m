Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F84536124
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583286; cv=none; b=IfClCJdzIkyVKXXW3z7/dJjBViJp4R19tVrsRXSZ8Dzz/vNa8uFrHaRxj7ZXUp5iqkmtXD/9lQJ25bbYMrszlBBLALTb9yqQ3p8Oq8lBbIiMex5idojAkoeXICGgiglD8J3EN9RA+JHXJIWy8sAoG2tW/B1KexePIxCBA5ubzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583286; c=relaxed/simple;
	bh=Ck0xCpE5SPCiAameISEKyLHYfOHRVNQwzStAdgTJj+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUSfX6LvCWXMEMFZwG0CFeVBtF/STLNlhvcRic6NGzKQfKRZ7X/wLAWtOPD4uHyhDOgKb5/Gz3l18DEjBDMxSDpsgklk08C8e1toM9s5OLMXPzsPJCVhHK/0Ji3dspX65zNQ9lO2lhba7DAKLf02qUtBgCCbTvUTxb2TP0o6gBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRkuxLLr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRkuxLLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6689C4CEC3;
	Tue, 22 Oct 2024 07:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583285;
	bh=Ck0xCpE5SPCiAameISEKyLHYfOHRVNQwzStAdgTJj+o=;
	h=From:To:Cc:Subject:Date:From;
	b=SRkuxLLrYnjnRcTvb9OJ3uVDG8nMVrg1YoVqf/WhSJ8IarqteVkdbo9iofu3HSHrG
	 Dnkmhm5Z0TLw9viwxDpOXEbHWg9ISbQ/8EeqZRQe8+WP2LhXD7oPE6/d7/cxD515CK
	 cCa6m7ljBgKHfZamoNbYWWV6+0mRhMQZmohhg3SRjr9UjEGD8QMdeH4SobpONUPA7J
	 vf9ZxUUcF46aHDv67e+6R0jlUdDti4MkWcIVn1QFZC9t6VUOR6NqhQjjgnxpGwoWo+
	 ZUsynD91MapnvBVhOGwOz4RndodeQKlaWM92eX2FH37r/kr/g6nt/qdsh9eEphcXet
	 yYDnUE9SgyhRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/5] add mptcp_address bpf_iter
Date: Tue, 22 Oct 2024 15:47:55 +0800
Message-ID: <cover.1729582332.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  bpf: Add mptcp_address bpf_iter
  bpf: Export more helpers used by mptcp_address test
  selftests/bpf: Add mptcp_address bpf_iter subtest

 MAINTAINERS                                   |   1 +
 net/mptcp/bpf.c                               |  66 +++++
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../testing/selftests/bpf/bpf_experimental.h  |   8 +
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 235 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |   5 +
 .../selftests/bpf/progs/mptcp_bpf_iters.c     |  39 +++
 8 files changed, 349 insertions(+), 9 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

-- 
2.45.2

