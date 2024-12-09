Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F14314AD0E
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724757; cv=none; b=QQLxcjRuU6/Qnz2iKYgm06Pacpe/QO2rNFz+BPcEb3aHqTXf2j6zbrazaCAThmdz61rBHKs7D9qrcTs2yQHQEEwAZkf5/p/S9OcwGexf83HpJbKHyDgDH8oc3oTBy7kBHgkvA2eTbF1yIxhQ+VRQikFgPkabALOtdZTmXINYkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724757; c=relaxed/simple;
	bh=3MpgyqQcL+jo3oJrdhrJ6nERxDfqRdMuZpwU9Rb8YnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mP9ZBSJWZ/FIqPoPPa9lbPdrtGGu8sdIJT7dv2GcOWxC3X8oesVSjzGpJrdRSUxyhOHnJy97AH+Jd3HcDNy4M7/O1xLiPs5blazBTOUHA43gUReuqkKIyNczKGlKpQ0OTh3vDQsqXJ3RBPB0qGv+Q9AS8x+10UGIZ4ODOlL6WJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E76x3RG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E76x3RG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC758C4CED1;
	Mon,  9 Dec 2024 06:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733724756;
	bh=3MpgyqQcL+jo3oJrdhrJ6nERxDfqRdMuZpwU9Rb8YnI=;
	h=From:To:Cc:Subject:Date:From;
	b=E76x3RG9BbroBRciFwzRXjY1Xb7zrO0sb37jI90Hy1AuAT+7wU+dud3QcHfNYybYu
	 L83kk9S8AjWDLPHAAwPS+MBWyo7RCja5IyXUpFGpqMcou/itlmIF8kPSTvq3tJM3E9
	 ZpCFN8opIcTE4yz0M054nAauqARWZHYg+Oj33UbSxPL+sszC0DbCFJ+hzyWpscs4jl
	 1tZi+MYUOOeNC9oTmHNc8KPVGYHV3PbosoyhSGHlX6UXIXvHGVXYjvo1+0RX/ZxxZb
	 wn5JABbfbGtCjq1QQL2031a4grE8M2OoJaNu0qVfkjcZaR2v8UdEDt0vPzrvHvaUT/
	 RZgN80j+g9Pfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/5] Squash to "Add mptcp_subflow bpf_iter support"
Date: Mon,  9 Dec 2024 14:12:25 +0800
Message-ID: <cover.1733724383.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - check sock_owned_by_user_nocheck(sk)/spin_is_locked(&sk->sk_lock.slock),
   instead of lockdep_sock_is_held(sk).
 - add "sizeof" and "alignof" checks.
 - drop bpf_mptcp_sk() and bpf_mptcp_subflow_tcp_sock() definitions. Use
   bpf_skc_to_mptcp_sock() and mptcp_subflow_tcp_sock() in mptcp_subflow
   bpf_iter selftests instead.

v2:
 - add CONFIG_LOCKDEP check in patch 2 to fix the build error reported
   by CI.

Address Martin's comments in v1.

Geliang Tang (5):
  mptcp: update bpf_mptcp_sock_from_subflow
  bpf: Allow use of skc_to_mptcp_sock in cg_sockopt
  Squash to "bpf: Register mptcp common kfunc set"
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 include/net/mptcp.h                           |  4 +--
 kernel/bpf/cgroup.c                           |  2 ++
 net/core/filter.c                             |  2 +-
 net/mptcp/bpf.c                               | 34 +++++++++----------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  1 -
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 11 +++---
 6 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.45.2

