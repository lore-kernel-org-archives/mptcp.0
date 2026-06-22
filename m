Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07BC219FC
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107116; cv=none; b=V0HtlAClPspEjraEx4zyA7ZKrsn5ilmJ8RiJmFLk0P52BnfPZSuUzh7UjlpHF0nCIe0A3FGAoe4khD0t7VYLKp2yEB0QvzWl3QjNEDX5j7kzVAIysQ4poIpwJwuL/2iRmqg9YFGurjnxRapWAg4k3lu1aOc8jKI/GbFiVrIdnbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107116; c=relaxed/simple;
	bh=UR25zKlEVFrAITden8pbDfVwKffQB+Cm8VBt7wq3o8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqSSPed/cABkSmOmjWk6PE9tjbANXa4/dqibYY8iSvrXIkmME1CDjfQxwbftExXr938HM/R0y6FofYsZL5PE9hKBmy6Qs+2YuTiZTBOZs+AMYAetTojYolZbgm68ylsSL2FBVFSor7XMZbd0CrEatg4YW0HFuoQLpQhyN2M8Csg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8efUmyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8efUmyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B731F000E9;
	Mon, 22 Jun 2026 05:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107115;
	bh=+PuC+r9p9IhQqlGkWSL+Qrccq/408wkvUtVr0oXHAuE=;
	h=From:To:Cc:Subject:Date;
	b=G8efUmyzJTf7g94l+jX9SEssVSxpCVVMjDFmbSSFCiHqTh6s9uMi1kH9ewv6U1dmA
	 Zd30EoEV0Y6dtGZAiYcf1JbY/IzHoHcLkVFoRK3RnceUBaaaVgEKVpHgJiPh8fafzA
	 wBoJ1y7Kp+NzFxOvgZkbF9ymhbI6NsrTiBBzOTrezegdTVp4aYTufIugb+bfMMzTs0
	 9n7PYgTDkYRfUl73EyuSfmZ1NQ4xxaLGIOvjKtSVEcuE+hccVOatLzMyKT8/+rfR2q
	 TIq152Em2BEM5O5fSAgBp1RNKLYiIgd5cp8zxgnwx18J8VQx/v03bEzGkDIaCd7XHe
	 HUKdP2fB3wFhQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/7] bpf sched updates
Date: Mon, 22 Jun 2026 13:45:00 +0800
Message-ID: <cover.1782106180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - new patches 2-7, address Sashiko's comments to drop __ign in
   arguments of bpf_sk_stream_memory_free() and bpf_mptcp_subflow_ctx().

v1:
 - Link: https://patchwork.kernel.org/project/mptcp/patch/10a30ed6484cc4d48009625f1ed8e12802e78e94.1781699193.git.tanggeliang@kylinos.cn/

This series addresses BPF verifier issues in the MPTCP packet scheduler
helpers and their selftests.

The initial motivation was to fix an incorrect return value in
bpf_sk_stream_memory_free(): the function returns bool but erroneously
returned NULL. This was fixed by changing it to false and dropping the
KF_RET_NULL flag.

However, further review revealed that both bpf_sk_stream_memory_free()
and bpf_mptcp_subflow_ctx() used the __ign suffix on their pointer
arguments to bypass verifier checks. This approach is unsafe because it
allows untrusted pointers to be passed into kfuncs, potentially leading
to verifier rejection or runtime issues. In practice, passing pointers
like msk->first (which are not marked as trusted) to these kfuncs
triggers the verifier error "R1 must be referenced or trusted".

To resolve this cleanly, the series:

- Removes bpf_sk_stream_memory_free() entirely, as its functionality can
  be implemented inline in the BPF scheduler (burst) using MPTCP-specific
  memory checks (msk->notsent_lowat and subflow send buffer).

- Removes the __ign suffix from bpf_mptcp_subflow_ctx() and updates all
  BPF schedulers (first, rr, burst) to avoid calling it. Instead, they
  use bpf_for_each(mptcp_subflow) iterations to obtain trusted subflow
  pointers directly, eliminating the need for reverse lookup from an
  untrusted sock pointer.

With these changes, all BPF scheduler tests pass verification and
function correctly.

Geliang Tang (7):
  Squash to "bpf: Export mptcp packet scheduler helpers"
  Squash to "bpf: Export mptcp packet scheduler helpers" 2
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"
  Squash to "bpf: Export mptcp packet scheduler helpers" 3
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test" 2

 net/mptcp/bpf.c                               | 16 +-----
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 53 +++++++++++++++----
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 17 +++---
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 30 ++++++-----
 4 files changed, 71 insertions(+), 45 deletions(-)

-- 
2.53.0

