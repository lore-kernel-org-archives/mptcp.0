Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8012B9B9
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925375; cv=none; b=DTIQRZdfrjT7Fhk581V5M8Y54u3kmj9Bqxw0HVOtVIhdJj+Rcwap/X5Drvjf+fymgMENfCANdJHqC1iMdpIjTKvcD3DoNai1fIqay8I7eiGAYFgJPfrqMeQOP+JBcUHLjiYxey/oqQaSyyIgGlY/K2yX/Aa/AHjI1NnGnCU4jkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925375; c=relaxed/simple;
	bh=7p4FLN8AsbkxA02eJmNNrG4uJVDGInMCvvC/1DcvPP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbCbZNjCcw7L8rkE77CIoulqyajncku030MrlZstgJsHRrzE7qtEAGkro99PNg0Rzc8B3qQ0OQHC7gaiDQYg2IWlbKXQ6genLkJ7B5xLsnO0frO9Im421GQpt1n0N2JfNSxvMVAin83d4LvxHSvs8xGn6hH0/Lzd7KUaDynu5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDqOi1rc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDqOi1rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DE9C4CED1;
	Fri,  7 Feb 2025 10:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738925375;
	bh=7p4FLN8AsbkxA02eJmNNrG4uJVDGInMCvvC/1DcvPP0=;
	h=From:To:Cc:Subject:Date:From;
	b=WDqOi1rcx79nprgriWC3TMaPpd/OK3OaEt0HL4ijRRd+Y/PCnSU2t8T+Y5WmkYr//
	 8AxE9yUsc70PHEPqZU/ERVPDdaePz3NZmQTmCo9g2h4J1FdiTmuFJkb26FLKfJjNaL
	 gcPRwNsGGSshT31CqxYs+CKS3foyKx27OkJAXX6vsnNy7z6KMfQublIZAbw8ST6Zwu
	 EVitcwvc9H3bTGYAX2e8HJSsqwtGiuPFuVr8tP9HQGOvunIGyPQxQbeyYLkX99IQJj
	 /QWfSf4We4GDi/ETVA+ZF5Pwfr897UHLk9cT/Cm+6ANBk4oSlyuyzNeDQ8PAappYll
	 Yv05nxQAqntAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/5] BPF path manager, part 5
Date: Fri,  7 Feb 2025 18:49:23 +0800
Message-ID: <cover.1738924875.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Depends on:

 - BPF path manager, part 4, v4
Based-on: <cover.1738919954.git.tanggeliang@kylinos.cn>

 - add mptcp_address bpf_iter, v5
Based-on: <cover.1738924354.git.tanggeliang@kylinos.cn>

Geliang Tang (5):
  bpf: Add mptcp path manager struct_ops
  bpf: Register mptcp struct_ops kfunc set
  selftests/bpf: Add mptcp userspace pm subtest
  selftests/bpf: Implement mptcp pm helpers in BPF
  selftests/bpf: Add mptcp bpf path manager subtest

 net/mptcp/bpf.c                               | 372 +++++++++++++++++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 211 ++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 185 +++++++++
 .../bpf/progs/mptcp_bpf_userspace_pm.c        | 275 +++++++++++++
 4 files changed, 1042 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_userspace_pm.c

-- 
2.43.0

