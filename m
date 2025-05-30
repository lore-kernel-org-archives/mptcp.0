Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EAE21771B
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592235; cv=none; b=prpH/GMWtNt72++uP2bjVxnMn3aHhvEDrvMSHu5E2m04UII6AHzvuSa1KBi9i+ZHE5EUURiH0FFMjXcf7GfkhbaetPEKztJBCUTgrMgHbQGXNHyp32BN9lgYvdL3kGC4cSeQLffCjKgSqcMffA3GHXEHJ2j1wbrUZ6yO2aLmMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592235; c=relaxed/simple;
	bh=WS20eT5SO03q+hfjDtTI2IBTtmCGW3WTo7NNel0gHKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkKhbe0kBMMgPG/vxOvC/6GS3wjASUiNM1mTe9nwMf6oh5+vZyRrVgi+/Dy99iuhRi3ZvJ2UFzFAGXsCRk59YCIdJA+6OsCse0PZO8F7JKurSN4wwNwkL3tqqtV+0/d6U8I+U22NZ5ZzRuNkZdIY4KGRVxsBRW9GOdfehOamgao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrgGIGgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrgGIGgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8394DC4CEEE;
	Fri, 30 May 2025 08:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748592234;
	bh=WS20eT5SO03q+hfjDtTI2IBTtmCGW3WTo7NNel0gHKw=;
	h=From:To:Cc:Subject:Date:From;
	b=RrgGIGgDzKdSzpyUnKqP8gN4bILBdZkLNaSmgi0eZBXJSs09AG9qgMPhNt9jwdFQq
	 +2k3h0NK+eRjY914TibWMVNOo5qjls2jtDalO7bUyT1eO1r91uaCnJ2cKoqaUZwJwN
	 nJj73xFah7IrBxg/LZpb+wWIxUHXBBz3weejPJUoMSspCE3SgkMJ2/fpZBfxCLBPmq
	 DyclRIdog0utTWnSgJkfcaC362tHT2wzLW0khK2MKv5Xnb4vrwdsiWoZZtaTvPfNA9
	 PLBgjC6cmFCgnE7p8ht9wOG0/MbLvEpBYH+CXA+MKP1wqtMwEbREP4YEEfvVi3lVRm
	 NBpoPjBCP8p2A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/3] Squash to "BPF packet scheduler"
Date: Fri, 30 May 2025 16:03:44 +0800
Message-ID: <cover.1748592117.git.tanggeliang@kylinos.cn>
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
 - put bpt_iter kfuncs into bpf_mptcp_iter_kfunc_set.

v2:
 - Drop mptcp_subflow bpf_iter subtest.

Some squash-to patches based on Martin's feedback for "bpf: Add
mptcp_subflow bpf_iter support" v3.

Geliang Tang (3):
  Squash to "bpf: Register mptcp common kfunc set"
  Squash to "bpf: Add mptcp_subflow bpf_iter"
  Revert "selftests/bpf: Add mptcp_subflow bpf_iter subtest"

 net/mptcp/bpf.c                               | 48 ++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  8 --
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 73 -------------------
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 59 ---------------
 4 files changed, 43 insertions(+), 145 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c

-- 
2.43.0

