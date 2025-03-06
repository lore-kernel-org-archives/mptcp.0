Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393A2907
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227346; cv=none; b=JpGN/dHXzYgTpQWJ7ZtBhSbCtOxfqPsIsbtccipBSjPABhbFh+xO8C8ZSlut3Fd79qlANxrdTUIZwW3am+fwIWOXIK9xlDe7yVxvB7apjnr5HV+CMqEEXlrDcoppA5J00bxoIYOWmkEhcOb2UaX2EAVyvliiKIDZKGfO2yd4KgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227346; c=relaxed/simple;
	bh=pL7P6jAkJvdr/oioJWlQaesbaZlSVmo9tGlbhOiRYyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZYojb/sJasQvCErxpm9dWhHfXKpVSu8tb7deeOJWqOdhuhf3ktq/fb4ah8juxqVV8dEIM2aiOqE0sClIivb7c9RXWB2dtEPktFr4nyBNXiQMHX8OzcvRS3xfnB8YoTlHuttG4U2gTJlmwOTO2rYucwuSitNeeQhBAL97TFH0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgjapXYT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgjapXYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F6DC4CED1;
	Thu,  6 Mar 2025 02:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741227345;
	bh=pL7P6jAkJvdr/oioJWlQaesbaZlSVmo9tGlbhOiRYyw=;
	h=From:To:Cc:Subject:Date:From;
	b=VgjapXYToUmL3B0bL7qaGk7+AvhKFtiEKRRiZmVHHz3axvvP07NKU4cR4775HFtFB
	 Zn4vTDOgG0/xj2EBS7Dr65lqabTBPXK28IdraGAN87r7LWejPo4xrFR+VymfS+d2Mz
	 0Im5Oxhlrnp+xYox9nrIjTCxh9Zg0Ne2tdaiTsqRr/eGKp8AO19LMd692jvoq8KESH
	 70Ou91eFgCLg/U8zkaU9W6fCgMSxKiKhAhR3WNtqiPFwtswsBbr8WvhZPIKNWOsIyD
	 oAo+IB4Ik4fxJrXp8qu3h0eztE3enVCVzKlezUHpGxKqCojrnOd0K53qnNqPpxa2Fi
	 Yf5nbw+6jed5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/8] cleanups for bpf schedulers
Date: Thu,  6 Mar 2025 10:15:32 +0800
Message-ID: <cover.1741226722.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

1. Add validate_scheduler.
2. Drop mptcp_sched_find in bpf_mptcp_sched_init_member.
3. Drop mptcp_sock_type and mptcp_subflow_type.
4. Move netns_new() out of sched_init().
5. Use .struct_ops.link instead of .struct_ops.

Geliang Tang (8):
  mptcp: add mptcp_validate_scheduler helper
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add bpf scheduler test"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 net/mptcp/bpf.c                               | 32 +++++++------
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/sched.c                             | 17 ++++++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 45 ++++++++++---------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  3 --
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  2 +-
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 10 ++---
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  2 +-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  2 +-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |  2 +-
 10 files changed, 63 insertions(+), 53 deletions(-)

-- 
2.43.0

