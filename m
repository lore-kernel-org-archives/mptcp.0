Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B5383A4
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042163; cv=none; b=BSOTUudbQAgMe5r/6FBxofFJzljALkrbREEPn+b3Va36dSXHdu7uNS4IKM8kAK8cb5IRavvjr4nIXgkXr9JM41olHd2e0UEeAmlfzZx+jL9T1JctUbF7wmKCYVeeamK4uoKaeZa+yORKOXMLSMAZLa6S4YBCtPAJDM7Hm4rw9gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042163; c=relaxed/simple;
	bh=zTTFg5AkenBi9V4nCiEflHBncN4D3RvGgRGIQlO9jig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rb2nvZa13vGqAGbDHYKASCM0c74iUAJ56DYPuwctXc/wDw8xDaS/oJL+k603hYid5N8GWTctJK9Jzqtj1LvkMwpficP4/Mff37TVXiJl8qTL8RT0FLM+29zYs/IU6CD2jHTCdD1tjcM6r6zx0kQ94cbgdItDIHuXBAWz+n/cm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkGpUc4i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkGpUc4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ADFC43390;
	Tue,  2 Apr 2024 07:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042163;
	bh=zTTFg5AkenBi9V4nCiEflHBncN4D3RvGgRGIQlO9jig=;
	h=From:To:Cc:Subject:Date:From;
	b=rkGpUc4iE+PeRhcJbwtj6QygoZG0nqSC275V4+/eRX+JqU6gP0lXWIq+1WhDBJfH3
	 In1mxUTvqFgTdGBB/yrp1YyX3w7bOpL3kSZV5uZDqPKkBiM6zc2SHVxAGSwRT992sz
	 TVQNbq59C3lp4SiSU4zGi0/xTdj8DcAVuJK0epzegrovn/6gzhr2z4W5psaS2I8bbp
	 v3bs/VAHkjoNSGamPlL2RXW7QYwqR+molOsE/8r8wufTvklwEsTXX6mYTtySGaaCG6
	 fTag86b0QpjGoO//ol5Evxdqqp95iyd26qY3M+breGbeaDme02Lcf5bca3jyC3vk0z
	 wTJyoqhwq49Uw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 00/10] refactor mptcp bpf tests
Date: Tue,  2 Apr 2024 15:15:48 +0800
Message-Id: <cover.1712042049.git.tanggeliang@kylinos.cn>
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
 - drop patch 5 in v4:
  Squash to "selftests/bpf: Add bpf scheduler test" 4 cleanup

v4:
 - add set_nonblock to make BPF tests stable.
 - split 'Squash to "selftests/bpf: Add bpf scheduler test"' into 4 patches.

v3:
 - part 1, bpf schedulers.

v2:
 - add two more helpers, send_single_byte and send_recv_data.

Refactor mptcp bpf tests using newly added macros MPTCP_BASE_TEST,
RUN_MPTCP_TEST and MPTCP_SCHED_TEST macro.

Geliang Tang (10):
  Squash to "selftests/bpf: Add bpf scheduler test" 1 nonblock
  selftests/bpf: Add RUN_MPTCP_TEST macro
  Squash to "selftests/bpf: Add bpf scheduler test" 2 verify
  Squash to "selftests/bpf: Add bpf scheduler test" 3 time
  selftests/bpf: Add MPTCP_SCHED_TEST macro
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 276 ++++++------------
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |   1 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |   1 +
 .../selftests/bpf/progs/mptcp_bpf_first.c     |   1 +
 .../selftests/bpf/progs/mptcp_bpf_red.c       |   1 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   1 +
 6 files changed, 89 insertions(+), 192 deletions(-)

-- 
2.40.1

