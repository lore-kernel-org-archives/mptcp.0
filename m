Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB23663C1
	for <mptcp@lists.linux.dev>; Wed, 24 Apr 2024 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921242; cv=none; b=ShVof72d/LnyvHoBwMgl/fuW4r8vaoBNViyd3H6IpmtqotNCnNMaSksx2Xbgvn7R9ZQMtzhIxXB8UQ/y/lgg9A1iyO74YR6yUkTV7vSIv8VQR+WQg4rZVo1pKN19TvDBQRqqzXwLvZjPxx05H8M6zg47ecmpHKZwBATJkDElrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921242; c=relaxed/simple;
	bh=m9nBafQZ/O5gWv4GLhqNntFGaxRhpOgDwmzIRW8ENJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TNrGnGxvHVgvFtgDbVxHrgSnkW+GVcrISLowNmMfkJZhI81qce95xNqMW3R9QHWDmrnlJd616uWi9+y1MTO7053yarMH25zyWNE2qxQi5zT1eSAQrMG0s8AsjZXDNcFSDccFLZajQ+iSkxYww5z0OWuUT84flxCek8hbREKXY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncDIXoXx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncDIXoXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3993C4AF09;
	Wed, 24 Apr 2024 01:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713921242;
	bh=m9nBafQZ/O5gWv4GLhqNntFGaxRhpOgDwmzIRW8ENJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=ncDIXoXxEnOykwKkZxYgakeUCeYWg5jx9qSewv6kcT3rw/yLJTcZiWL7EMSDtGEcR
	 JJB14ruAFskqg1oPTIMOY9fLV/JmvRIq5jQdOPUZYJ1PZ/sGf4QygXXUQE0inxpBIh
	 Z4fFcuAoMc8LTcsUhWo+gd7Sl9HCqQ5nZQa5TUv66p1GMB081PqoevPOBkMZpvV/rr
	 JvyqfnMph2m8M8RrQADTpSmy3vn5l9Q5ZS9vlooolCydEdM5PhF8iHpH14dPrS7f1H
	 Xl0CAYKWrNhnxWcAS1xHjc6zCDGMUJ7gYKegKgDJVG821pEOD6dWWLVPk/t27Yzq+g
	 UeTlidpdP2NGQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 0/4] setsockopt per subflow: BPF
Date: Wed, 24 Apr 2024 09:13:50 +0800
Message-Id: <cover.1713920939.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v9:
 - validate the return value of snprintf in patch 2 as Mat suggested.
 - patch 2 depends on "selftests/bpf: Add RUN_MPTCP_TEST macro", so this
   series could be merged in this order:
   1 selftests/bpf: Add mptcp subflow example
   2 selftests/bpf: Add RUN_MPTCP_TEST macro
   3 selftests/bpf: Add mptcp subflow subtest
   4 selftests/bpf: Handle SIGINT when creating netns

v8:
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

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 143 +++++++++++++++---
 .../selftests/bpf/progs/mptcp_subflow.c       |  70 +++++++++
 2 files changed, 195 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

-- 
2.40.1

