Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA254A18
	for <mptcp@lists.linux.dev>; Thu, 29 Aug 2024 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724900015; cv=none; b=MCM+hrD52xCspJKdEPm5xxdYW5nO3hOvmMQpTctCF33CLoZRFoVzRT99sos7zqRqqSpIPUrRdrZYw6HKjZZ4lTWaNvXd6VY73ADe/iNrlygs9yXUGVMe1nPt+M8/JdjJV9JJaWSCTF3Z+6kx6NTu7HvPrJl5rKjw86uTqFumDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724900015; c=relaxed/simple;
	bh=dt3crhIaG/qZWDstqS8QrjsEVh9vMqCvEoi2TFkellg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvt+xumhTDwmDDbKQ7NC5Ccud/8KuNtORP8dqiqoKhrpcKFy8RatY/ilEOFz8yyJTajLQk2bL2Lqc77zrkndssw/2/YD7WTjNwmJZe/HckVgwZFwUxMqkdiIwW7oQjgfnm2aQ4eUEjHOcie1jjpGFNXkLBrwxcjaMhrI0e3alfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiUjqx4V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiUjqx4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAD7C4CEC0;
	Thu, 29 Aug 2024 02:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724900015;
	bh=dt3crhIaG/qZWDstqS8QrjsEVh9vMqCvEoi2TFkellg=;
	h=From:To:Cc:Subject:Date:From;
	b=BiUjqx4VPE00nx5Gk4Tm9/8uQEOx/HhtbXPfZCPG0lx1x2XPYCkWvWeCVYsjV05eR
	 PpAvOLq7W85CWlsEDCNn4luNfRkIuI1KTnGLLDuJIabJhSgReyGJtUgas5paexXMr2
	 69hQDSF3PnQ6S8RCj3kYoPYYvX14dbajIw8n9m3hKzeo+7Zr7TOx8WnfD/+lYIotEc
	 aEC7lpQrZ86KXgWXrN71R4NVYYrmlwj5Qr+3GpX17Ujz/smY0fitTJJHe0/W26dhyt
	 QPz/BnBNbsXlv3voBMOP95m+4Byzg818cxPVNUVXHWSYGDZEdPpz8576Ti1Iu4Tgnb
	 BQJKn9VJCe/qA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/3] fixes for "new MPTCP subflow subtest v4"
Date: Thu, 29 Aug 2024 10:53:24 +0800
Message-ID: <cover.1724899785.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - rename _check_getsockopt_subflows_mark in patch 1.
 - address Matt's comments in v4.

v4:
 - address Matt's comments in v3.

v3:
 - drop "ss_search" from subflow subtest
 - fix mptcp_for_each_subflow_safe
 - add cond_break in list_for_each_entry/_safe

Two fixes address Martin's comments in "new MPTCP subflow subtest" v4.
Patch 2 will conflict with "selftests/bpf: Add bpf_first scheduler & test".

Geliang Tang (3):
  selftests/bpf: Add getsockopt to inspect mptcp subflow
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  Squash to "selftests/bpf: Add bpf scheduler test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 60 +++++++++++-------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 35 +++++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 62 +++++++++++++++++++
 3 files changed, 135 insertions(+), 22 deletions(-)

-- 
2.43.0

