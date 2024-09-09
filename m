Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8BA28DBC
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845815; cv=none; b=Wri4BiDNlpcwY5g8YAvYJ31j7XPeV17lYdD9VP2D3SKQ61gOYks4WZK5DOwPnT84/7OKT3wcqPmCzT2D8oBpene7ZxdE/ema6tT2Lsu+2ZP6bQJoLTkCWcorbWAgXdgJu71kMkakeHP2YeFFDYtUl7GPhSXlLXKKS2mEv8YXLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845815; c=relaxed/simple;
	bh=xNX0vdfBAWzEsSlpUZgeQz2Zu65OAjTSIDAy5PEO20o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYqAJDmcjRn0K/IRGchqfTa2hWhspEz2OaQnC00vdPDfcYxUFRN2MkFQ+taR0WphKSKSjeXJA3S4pv9IFidOztjLb8XhRVGtRYQ1SuF0/EKedcG5vuwK1wyvE+tP5zPdK0a41wuvzsXQh9qWtSO0j//Uvr37d5mgXNN6tSxqrbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7QtBUb3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7QtBUb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02806C4CEC6;
	Mon,  9 Sep 2024 01:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725845815;
	bh=xNX0vdfBAWzEsSlpUZgeQz2Zu65OAjTSIDAy5PEO20o=;
	h=From:To:Cc:Subject:Date:From;
	b=g7QtBUb3Bv6gP+9MAEVBRynMlL5Oz/yHd8Tm9ea4qmUmdaGF0UAaMATF08+aV8lnT
	 A1iRzjKZFMFCOM/aD+LOGdFiklNjCN+0CFGovuE3UQOWtMkzM0GP3IL8juUPwBwNeL
	 gddDV5hJMBu3gKKlqGO6x53SlfBQNaouq70LSJIcsB/5ERyxzqvgJYefityoilM/iw
	 1NUXmuhSwl8lrBCchskiz4WrA6AIVtDiflr9viyC66lOeApoPEZewp+/yd6JRZgsbZ
	 AsM3cdJrPyEe9tN3VhMXLazcvmhT9KBNAssAoy7CmGnu46+Cd/4DUAXOkZBLdIc8pd
	 PgaWNySexdDgA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/4] add mptcp_subflow bpf_iter
Date: Mon,  9 Sep 2024 09:36:43 +0800
Message-ID: <cover.1725845619.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - update patch 1 as Martin and Andrii suggested.
 - fix warnings and errors reported by MPTCP CI.

This patch set adds a mptcp_subflow type bpf_iter, and self tests.

Geliang Tang (4):
  bpf: Add mptcp_subflow bpf_iter
  bpf: Register mptcp tracing kfunc set
  selftests/bpf: Add mptcp_subflow bpf_iter test prog
  selftests/bpf: Add mptcp_subflow bpf_iter subtest

 net/mptcp/bpf.c                               | 58 ++++++++++++-
 net/mptcp/protocol.h                          |  6 ++
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 85 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  4 +
 .../selftests/bpf/progs/mptcp_bpf_iter.c      | 38 +++++++++
 6 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iter.c

-- 
2.43.0

