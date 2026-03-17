Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2D355F48
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741508; cv=none; b=tA5DsDlw+1BmgII3OSqZ+9DDtQFlrg2cayjem3iaFAOvox0aS4docYrn967yEggUQNg2D0oDU1UQ4qU4c6cGT95TNbr5ToziJGrVHkUbhAFVgXEr0H6hkpI6WFa4NiHBDaY1+3ztTBOb+7tMNgmcoqDbOLdq0PnqpwvuZR6h20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741508; c=relaxed/simple;
	bh=6wBWG+8o8HdbkawxcuciIDPo0acvyOp1c+mw55O5zA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l44uTRqgduxbdU5vp62vj7bSH7vsv+7uGPgiDJXqPiEQ/eemRJEarw/5v0aDtqwaVoK67y89G0KcwXmf4EFEDE1j8zcGhqEtxZRLKnxmD/cTJ1JSbLoskv/Olni8YNRck/EJrB8aH0ma+sBLdIvwDh+0luA1Xz0KHI3cDNFU+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+Oq5X5l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+Oq5X5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327BBC19425;
	Tue, 17 Mar 2026 09:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741507;
	bh=6wBWG+8o8HdbkawxcuciIDPo0acvyOp1c+mw55O5zA4=;
	h=From:To:Cc:Subject:Date:From;
	b=T+Oq5X5lV0P6oI9SvPUIjTzUjsV8h+3dC7PctfMdhY0XSIRmeqWsDvDph0lIKdrnf
	 F4wxDsJLvI6ick0nwFWKcTYEhuqlRphlE0uiJoDqp5M44YjwGYq8WvSW/3xoTgpWRF
	 hPSJYoZsHM62Ny2y4ywWvL/UQJ5FF7agUCQS1DrcoETbKCWzfZGqvktjoR1KWqY7BD
	 yYnKOaPYhYeO8cPXZeruJVmAKUvpvj7g4P51fYvebm5EYy/iyZsM+xSuFRiPoHZgKD
	 nf1F4Y4JJXmcVOPhFmSDyuVqypvEhkPIVsK1fQmF11FtoKYZqlpRs76FkOsLY/DB2F
	 IHO5nSjl92U5g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RESEND PATCH mptcp-next v2 0/2] implement psock_update_sk_prot
Date: Tue, 17 Mar 2026 17:58:09 +0800
Message-ID: <cover.1773741427.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

RESEND:
 - rebased.
 - to trigger ai review.

v2:
 - Include mptcp_bpf_update_proto within CONFIG_BPF_SYSCALL to fix the
compilation errors reported by the kernel test robot.
 - Add checks for IS_ENABLED(CONFIG_MPTCP_IPV6).

Implement psock_update_sk_prot, for basic MPTCP BPF SOCKMAP support.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521

Geliang Tang (2):
  mptcp: implement psock_update_sk_prot
  selftests/bpf: Update sockmap tests for MPTCP

 net/mptcp/protocol.c                          | 105 ++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |   4 +-
 2 files changed, 107 insertions(+), 2 deletions(-)

-- 
2.53.0

