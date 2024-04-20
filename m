Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3029421
	for <mptcp@lists.linux.dev>; Sat, 20 Apr 2024 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713612255; cv=none; b=sCZdGSuXjl2kSPjOnmEg6qmG57lWKNWt7HTBVH1US4HA9VEuYU0T2yv3xoxqsQhLb0SY7r0RAjle6aKLQ2bovy2BfILdMHE7I+VhePJ8bnsUFpS1YmKMNL58F9jhCMhM02MGwovy7JlHLLdPaupR7blgEoPbEiAaByyv0Be0U0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713612255; c=relaxed/simple;
	bh=wXzMs16bGmQGZZTY/L3lEngwLyiiLAPQ59McCIFEVJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eKngZ/eRkXIkZ2VzMEvYYdVM4nlVyFjthZuxMexUyiT7ggxpHr3xV0ylZx8pT7EBQlREajJdl+qjYZMnMsiQ8+FJss5HIp6fd78GFVaDRovfeK8V5wM1kfg5lBRHUVSfl4we8XQqrqYEDuPB7vQuU2rXjrcBKjGcqxrKDkQAyL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOqp0NX4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOqp0NX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F21C072AA;
	Sat, 20 Apr 2024 11:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713612254;
	bh=wXzMs16bGmQGZZTY/L3lEngwLyiiLAPQ59McCIFEVJg=;
	h=From:To:Cc:Subject:Date:From;
	b=MOqp0NX4m1wKLOrgjIQIZgsIWwu5FRhMbH5L5k0Xyd6TvGM5CCesUe+jL7o/J2cZ/
	 Y3qIrNd6uN+9gP67AgJfSeYAimVat13GAxSCqU8FBDh9KXQ951eZAetqTheGGs/tvd
	 2nhi10rz/hvf88wBDKC02HgPfvE/seI9VGAJ8UCP72YK+Nrk3Atmop/0IStmRSqYiW
	 tDxK97EEkgoVGbshTAr4lX7sxHMjdTvihYPsw+UGtqbtc45JbebMoGc73KpSY+0IPQ
	 pQXazHqIca/T1Qdo89FmVAAzHmwz/ihkDDBicbmFhK7N9FsneKW8XmTo2zsjZUjrKW
	 jf/lczLQf26Gg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 0/4] setsockopt per subflow: BPF
Date: Sat, 20 Apr 2024 19:23:25 +0800
Message-Id: <cover.1713612119.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v8:
 - rebased on "export/20240420T092451"
 - update the git metadata to add Nicolas as the git "Author" and add a
   "Co-authored-by" tag with my name in patch 1 as Mat suggested in v7.
 - use send_byte in patch 2 instead of send_recv_data, to make this
   series independent of the commit "selftests/bpf: Export send_recv_data
   helper", which is in bpf-next, but not in mptcp_net-next at this moment.

v7:
 - address Mat's comments in v6 (thanks): drop MPTCP_BASE_TEST and rebased.
 - depends on:
 "refactor mptcp bpf tests" v7
 "export send_byte and send_recv_data" v2

v6:
 - Deponds on "[bpf-next] export send_byte and send_recv_data" series.

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

Geliang Tang (3):
  selftests/bpf: Add mptcp subflow subtest
  selftests/bpf: Handle SIGINT when creating netns
  Squash to "selftests/bpf: Add bpf scheduler test"

Nicolas Rybowski (1):
  selftests/bpf: Add mptcp subflow example

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 139 +++++++++++++++---
 .../selftests/bpf/progs/mptcp_subflow.c       |  70 +++++++++
 2 files changed, 191 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

-- 
2.40.1

