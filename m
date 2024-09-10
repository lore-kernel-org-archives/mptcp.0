Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D538D167265
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946654; cv=none; b=cihpZ2AqSPHoRKVenCGnHkbN5ZobuTabs6QigtfApOmNec9O2I/yOTtBYAwRBYbnWkK9Cx4236UxNKGWvP9lw2fHegg8AWbA/w+QsawO51bjUEm+2QElfx4d/W6RL2WN89kePbOiNe8QrZBCpzExBfzyjPKODt4/RdnVvP6BRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946654; c=relaxed/simple;
	bh=r7Jhh7ZInF+SvmGuZdGIw9Ebm1pmUL6P3C35eEG3HPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Owmnul0fz8oQq4tLgrRvxnU3mu1CEQ8A1icpxkQC5OwiOVqI1xXUCiKm99pvq1ezG+uKHxV3Mk2IaHJa0HtZHnU/W32Uo+iAqiIeR/JZxKFxx+2K/LkmFc/T+8JZpKvYZJLJSM/pyd1gT5e/p7u/87KBaW4a7uDnVvbaTHEn7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqWCdUeR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqWCdUeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DFDC4CEC3;
	Tue, 10 Sep 2024 05:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725946654;
	bh=r7Jhh7ZInF+SvmGuZdGIw9Ebm1pmUL6P3C35eEG3HPE=;
	h=From:To:Cc:Subject:Date:From;
	b=tqWCdUeRSlXFlBZ6MpFYlDpB7E9zzMNckz5eQME4Nuy2yF0+8n9tWQwj8Luh3X/xo
	 9l0brb1wQInPUDLMFccDDdhAMLX6y9iHEHNAEocyAJbeDlLOT6A389tF68jek3nDnt
	 l9KztE/xOgypBPAgnG2p4J+7rinJ7YFDcAfXfcCOhAkoaAKLNbZUbOGoXVtjV453gc
	 +yYTx3WUUvwaaG7TsJe02EoTo5rkDme/0CMseB5o+nSpop+gIE7rf0D6RGPpvtkLm4
	 AOPdLbqpNVj9LwcLdH9hQ/RMJc+9iEhcT3xm7Ohp08UpE79RIfrYzwVawoX8Tf5XbS
	 Z9+R1N6ptcrZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/5] add mptcp_subflow bpf_iter
Date: Tue, 10 Sep 2024 13:37:22 +0800
Message-ID: <cover.1725946276.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - drop bpf_iter__mptcp_subflow, __diag_push, __diag_pop and
 __diag_ignore_all
 - drop declarations for bpf kfuncs

v2:
 - update patch 1 as Martin and Andrii suggested.
 - fix warnings and errors reported by MPTCP CI.

This patch set adds a mptcp_subflow type bpf_iter, and self tests.

Geliang Tang (5):
  bpf: Add mptcp_subflow bpf_iter
  Squash to "mptcp: add sched_data helpers"
  bpf: Register mptcp tracing kfunc set
  selftests/bpf: Add mptcp_subflow bpf_iter test prog
  selftests/bpf: Add mptcp_subflow bpf_iter subtest

 net/mptcp/bpf.c                               | 54 ++++++++++--
 net/mptcp/protocol.h                          |  2 -
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 85 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  4 +
 .../selftests/bpf/progs/mptcp_bpf_iter.c      | 38 +++++++++
 6 files changed, 183 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c

-- 
2.43.0

