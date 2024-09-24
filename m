Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641D15539F
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170122; cv=none; b=CMPFqJBXgR2Hf2phDliHL4s1fLnH03+6kCICxF1/R/pqehqTL3Fky1q6z5VYsyQOA1OhjXmMkEiED4VUSatwjO5AxPdIimCMPG+tePtPfwH+EV+j/qNmfJGBdwIRyQ3eZGYsXw6soRa4gz3jhXnV/GEVP5S+fxD4I8wZMQia6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170122; c=relaxed/simple;
	bh=dVt5hCREjrE4E8KnfGH41o5jxsDG21u8a57TVLB1/hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sy/Ct8yymUOoQ7Xx1FlVMt1lczhYvqNAN6EVHVVIOV0x0zym/HfhUyFUZIo6J6lwTdBXH10aaKhCk6ryTlO66K03Xz1LE65jz3Zr+bOf3/7OqaYALm2e1DgsDISS34+tVTRcHq5B1brPiL7ABisDuHom5ohVvbGuES1k0IzGO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qf8ZGySC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qf8ZGySC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A566CC4CEC4;
	Tue, 24 Sep 2024 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727170121;
	bh=dVt5hCREjrE4E8KnfGH41o5jxsDG21u8a57TVLB1/hw=;
	h=From:To:Cc:Subject:Date:From;
	b=qf8ZGySCW4l/bI8QH0dPg5BPr9AcWzZGUGm8Z+Q4vxeANcLg2cHespU68H6yiTCdt
	 lXvFwKXG4zMU+uQCaeBsRtIVatl4olM3eJrxpOJ6n+d+MfMxldmMHnxN9f1IO8//xz
	 H4MqenioQ36aHRQcPMQhbC0FOA7Q1lpmIc8bnx4rHRu67xrabOI6kGizoJeJEp4pch
	 3GzJ0xsf6w1DI9nARuHnoSKQ0Rp/a2KpZnZTYpSLx7JUoiVorIfdGSshssXZY+SZU3
	 j6U6yy4QJEQnnezeISub1TKfx9JiOfRVu/TGgQnwp3bn1vjmLP6qhFMxDNjb+Uov5O
	 dJ6BVf8qGLIIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/8] use bpf_iter in bpf schedulers
Date: Tue, 24 Sep 2024 17:28:28 +0800
Message-ID: <cover.1727169534.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With the newly added mptcp_subflow bpf_iter, we can get rid of the
subflows array "contexts" in struct mptcp_sched_data. This set 
uses bpf_for_each(mptcp_subflow) helper to update all the bpf
schedules:

	bpf_for_each(mptcp_subflow, subflow, msk) {
		... ...
		mptcp_subflow_set_scheduled(subflow, true);
	}

Depends on:
 - "add mptcp_subflow bpf_iter" v6

@Matt, I forgot which keyword should I use here to trigger the
CI test with dependencies, please tell me again, thanks a lot.

Geliang Tang (8):
  Squash to "mptcp: add sched_data helpers"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  mptcp: drop subflow contexts in mptcp_sched_data

 include/net/mptcp.h                           |  2 -
 net/mptcp/bpf.c                               | 25 +++++++-----
 net/mptcp/sched.c                             | 22 -----------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  2 +-
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 16 ++------
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 39 +++++++------------
 .../selftests/bpf/progs/mptcp_bpf_first.c     |  8 +++-
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  8 ++--
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 18 +++++----
 9 files changed, 53 insertions(+), 87 deletions(-)

-- 
2.43.0

