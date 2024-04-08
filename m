Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180752F7E
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572019; cv=none; b=FmZOUi1swC9bCrZZ6nLmboHDP5pHn2nQ7fFxtawY/6/YTvdxV+dmPXNi6WwXp5IvKL1QIM5WEkQeW51cNzpD7CHpatM9xaVxVCyfNOut/Uh/bX28XJjspIu1Oe47UdrRdnFHt/4gBsTO+nRo6k8fa4RHzEzQZrPMWUvjobqCR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572019; c=relaxed/simple;
	bh=b4jk3+F9YnOIYfsrNJmYZbRXBmFGiWOzhGzindKe6e0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8aDlSvX91bgAlr1VcJvObrmBOzO1jQzLePuimrun1rOSBYbsmzRwtIBClZUOpwZAuPsDHnxNCAnQQ7oGeCoZ8tuAkV7yJ+Z0NAvfLbsEJtTvBqiRPDsnyGFdZEzb94jpgjcer95ZxMNLIy1PTXPRTwffHnxrkjil+/5b3C4ySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUx1AxyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUx1AxyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F78C43394;
	Mon,  8 Apr 2024 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712572019;
	bh=b4jk3+F9YnOIYfsrNJmYZbRXBmFGiWOzhGzindKe6e0=;
	h=From:To:Cc:Subject:Date:From;
	b=RUx1AxyJi5YvudqSJnf4rRf+iF6W0zWxxbQtfI0+VD90YIKOFTr75fN8Q8Fs1uJGe
	 cuOiobyaEP9akVBwIzKMmz8lJ4QiurL8OsrgguWS5L5FEAH/9E1+LBOFEM2rWnukL4
	 BO3W3EpNW4BbxaSPUTB/g7oct632L2UnzMQ0Ses551+704SVEJJT7EpWsLkM+WWarJ
	 XJhaGGWA5iDID8tIf250DtyJFb/SoQ2gYjDVLo14yL4UJCBJ5eoOIxJUoOeiDS82xR
	 4zs87VQJQuxIKZbe1/Z6nH5AogCO20a+2yVvvildLP78o/5ymcYgljqduf3Xp3JnTw
	 gDUzBJ/cDS/EA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 0/5] setsockopt per subflow: BPF
Date: Mon,  8 Apr 2024 18:26:47 +0800
Message-Id: <cover.1712571740.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v7:
 - address Mat's comments in v6 (thanks): drop MPTCP_BASE_TEST and rebased.
 - depends on:
 "refactor mptcp bpf tests" v7
 "export send_byte and send_recv_data" v2
 https://git.kernel.org/pub/scm/linux/kernel/git/mptcp/linux.git/log/?h=export

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

Geliang Tang (5):
  selftests/bpf: Add mptcp subflow example
  selftests/bpf: Support nonblock for send_recv_data
  selftests/bpf: Add mptcp subflow subtest
  selftests/bpf: Handle SIGINT when creating netns
  Squash to "selftests/bpf: Add bpf scheduler test" 4

 tools/testing/selftests/bpf/network_helpers.c |  19 +-
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 192 ++++++++++--------
 .../selftests/bpf/progs/mptcp_subflow.c       |  71 +++++++
 4 files changed, 200 insertions(+), 83 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

-- 
2.40.1

