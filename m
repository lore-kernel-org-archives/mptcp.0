Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD262C689
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042675; cv=none; b=msMtoRycBbWRvKQcFZPe+fovrVMWi4TBqaNwU3Ia3GlKCqXU4wAg8Ool3B3NmRW1EpODtLmmNScbyxvgHVfRSWHHAiDcV3IDTlgjKbTeJaV94OUaat5sfa2OkdWnE92VbeIne902N9rmv2L3FbvaH00DnDZc9C6RMuaMlgYDtts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042675; c=relaxed/simple;
	bh=3hDJkG1W43WiFiKDlkqxUGFMFprEMdNt6/VpmsdTrSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mi25z7c9lvra9l1QlJgEza8m6OqiWom0Y4AtBDek4VBGbvWJ1Utt239Gsnfu/wE4mLtIgA2o0AGC8mS2Afl3AWg0E+I4px8IeMkLojQ7I3VLK7MU6dmVyIGNb3t9weChLiawYZYJmMOCRmucVcXrbFNTbX8RW9Ik0dqH7XPred4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANe9yWC4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANe9yWC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF1EC433C7;
	Tue,  2 Apr 2024 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712042674;
	bh=3hDJkG1W43WiFiKDlkqxUGFMFprEMdNt6/VpmsdTrSs=;
	h=From:To:Cc:Subject:Date:From;
	b=ANe9yWC45FCCh3qHZ9lEkRe5ZI6Lcr+trU2i/rY9LVllXDPjBHI5nWzmHhmzBJgM/
	 NRTXyC5Rs5q7asyTHBKcEcwcNZtarao2EJs8T/uoFYn7ybBYIiwBWxkpv01/s30MjD
	 fvQ6j0QzeEGNPi4NY5MEOl2TiUaVTy4+TBFhq8BfOSCZaMXHikODvlRpfCar2/fCRl
	 7q21G3PjcA7+WjESqsUeWpN6cn6Pt5VwM4sn3FIe7lzUX1j8GKqZ8rVpyWrJbb7DtD
	 Wg8Rf8yYeD3FgQZTK8dikC4OdogBmNgV4pv1EqF69R5eVJqOI5gwYGQ/xKe70o4DQS
	 unWguC665yC9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/8] setsockopt per subflow: BPF
Date: Tue,  2 Apr 2024 15:24:20 +0800
Message-Id: <cover.1712042529.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (8):
  Squash to "selftests/bpf: Add bpf scheduler test" 4 send_data
  selftests/bpf: Handle SIGINT when creating netns
  selftests/bpf: Refactor mptcp_sock test
  selftests/bpf: Refactor mptcpify test
  selftests/bpf: Add MPTCP_BASE_TEST macro
  selftests/bpf: Add mptcp subflow example
  selftests/bpf: Add mptcp subflow subtest
  Squash to "selftests/bpf: Add bpf scheduler test" 5 endpoint_init

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 264 ++++++++----------
 .../selftests/bpf/progs/mptcp_subflow.c       |  73 +++++
 2 files changed, 189 insertions(+), 148 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_subflow.c

-- 
2.40.1

