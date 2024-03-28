Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D954679
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613117; cv=none; b=StUiwe3K4E0egpXILYFV9I8rQ/jF/mHyeyhF/VwZJCYoHKCZ2SfG6dMke4XzMFHrOXI5ktk0jGrb+f+PDglaV+3BrcEUDyR+VP1oJ05g0z36x+o8w8049CkGBZq/upIY70sgJYIcWFO4AuHWZ+PVglSNys2mx4X5q8uHq4yYIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613117; c=relaxed/simple;
	bh=UV9+Hh6hNinzAFq4ZqpBO7KZVQmDdwYE6nnzHHEFFA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HwpbxdFRgsabkpDflP8VbdNX/mBLaCU0/khNWKupyeqKsqhJfw99hJgiwT5BeEanHiEmtIEh+pWWMnwvisCeD/TQVwCyxvv3MoNLR9TXb7f6ZhS0e2zkLsVC1M/RfKXbqTTbbmnbM37PL2k2/1HSWBMMhXbjRkIBW31lIMTXsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhomYSfX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhomYSfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C69BC433F1;
	Thu, 28 Mar 2024 08:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613117;
	bh=UV9+Hh6hNinzAFq4ZqpBO7KZVQmDdwYE6nnzHHEFFA8=;
	h=From:To:Cc:Subject:Date:From;
	b=GhomYSfXCKHRxdmBhGpsQRd2ntcvc99WoN3igvUIdz5pDJDFcoQxRsRZD+raEd5Q7
	 pBqs9IrmkkrnCQOhvJtKjevGq3B0QL9K/xZKFl1dHl8/EV0655n14Nvm1QnXGtXv8+
	 JYzTbvQ0EQ1D9j1KpLtLVjRP8mOtXho0+2mW+iyGnx/jcJUN3dcmfefen5L75PBzFt
	 FEa5LURHHRCYoEZEZjhhNaLnUNooAaEOeuZJ1FEPqFJTKvKhl6itSvQD+geo7/m34Y
	 TY1yMC6/UPsRyF/tiCC5fm/ndDGmcyLlzj9Asqy3tgFj9Y3GhDzDJK9OQFLKQV52oM
	 tiSxkbT4f/yiA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 00/14] setsockopt per subflow: BPF
Date: Thu, 28 Mar 2024 16:04:47 +0800
Message-Id: <cover.1711612876.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - #1-#7 Address #76: add new macros MPTCP_BASE_TEST and RUN_MPTCP_TEST.
 - #8-#14 add MPTCP_SCHED_TEST macro.

v4:
 - #1-#5 Address #76: add a new macro RUN_MPTCP_TEST.
 - #6-#11 Cleanups: add send_data_and_verify and SCHED_TEST.

v3:
 - deal with EAGAIN.
 - add _ss_search helper.

v2:
 - fix checkpatch warnings.
 - cleanups.

Geliang Tang (14):
  Squash to "selftests/bpf: Add bpf scheduler test" - fix
  selftests/bpf: Refactor mptcp_sock test
  selftests/bpf: Refactor mptcpify test
  selftests/bpf: Add MPTCP_BASE_TEST macro
  selftests/bpf: Add RUN_MPTCP_TEST macro
  selftests/bpf: Add mptcp subflow example
  selftests/bpf: Add mptcp subflow subtest
  Squash to "selftests/bpf: Add bpf scheduler test" - cleanups
  Squash to "selftests/bpf: Add bpf_first test"
  Squash to "selftests/bpf: Add bpf_bkup test"
  Squash to "selftests/bpf: Add bpf_rr test"
  Squash to "selftests/bpf: Add bpf_red test"
  Squash to "selftests/bpf: Add bpf_burst test"
  Squash to "selftests/bpf: Add bpf scheduler test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 465 +++++++-----------
 .../selftests/bpf/progs/mptcp_subflow.c       |  73 +++
 2 files changed, 264 insertions(+), 274 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

-- 
2.40.1

