Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DA320F
	for <mptcp@lists.linux.dev>; Thu, 22 May 2025 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897521; cv=none; b=C9uARgba3Rbsq0SCzVV9BE412HldbcmhtIdWzDy13tLeHbHLUBbMvgAa61VvQ2wnWykVtOgNd2n6B3usVQwIV4IqtGFoReBbqHKDCAQIXSPaY4zWsa+uQYNy9/7fmWomzg6jXiv5tFMQwcm4MuP0wHNTQZVpLoN+ZRuzPgjYefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897521; c=relaxed/simple;
	bh=RBgIbbRTS1PbiBRhOEzD2UGFwE0TSEHNnMyZUrFp0SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbJ9XLDRXsM4fAZ4LteIfxN6OmfSdXEuSxSzgk1fWnULj7vV88gqWFTXUhUef1ttcoZBcrKrngSA4V5PkbqQ4BNevorB8pBMaY61z31LRWV6TT91h/tNalnFGZIXRRuei6v4HXa14CJ6dsHEG0B6NA/wbt21DDSquuPgx7kH7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaX7nPLQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaX7nPLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27527C4CEEA;
	Thu, 22 May 2025 07:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747897521;
	bh=RBgIbbRTS1PbiBRhOEzD2UGFwE0TSEHNnMyZUrFp0SQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CaX7nPLQCIPO/QA03sztSb/vw+Q7nuIWh1+gamY4A+8eEnUT9icpMsUWX/y/DNoGw
	 3HE/tKAgT2WIpAsuiVqww8rL7VBbyP/QW7TVVI4cYAmnpyFU1Mn/8yIOyxp27gQRmV
	 xjdttA4CcXU5iWjKzqq15dgiM4uMHb1pP5gekS0Os0oz7ughTpmRq2NLSwEzbZIqNW
	 mPmHm8TGWzaZq8KDBb7MDO35ynJ4YrqwzyXO8HdmgoaIacfSbNSgVV4SmpjLYEXu9d
	 yFnAt2Sp8Wn7ov9FeFwuuiNpWmXy9rdHIpklVyKmeBKF9qtxZAwPSB2uki6WjLwwdj
	 sqPh41Y9Ndpmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] Squash to "BPF packet scheduler"
Date: Thu, 22 May 2025 15:05:15 +0800
Message-ID: <cover.1747897261.git.tanggeliang@kylinos.cn>
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
 - Drop mptcp_subflow bpf_iter subtest.

Two squash-to patches based on Martin's feedback for "bpf: Add
mptcp_subflow bpf_iter support" v3.

Geliang Tang (2):
  Revert "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
  Squash to "bpf: Export mptcp packet scheduler helpers"

 net/mptcp/bpf.c                               | 23 +++++-
 .../testing/selftests/bpf/bpf_experimental.h  |  8 --
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 73 -------------------
 .../selftests/bpf/progs/mptcp_bpf_iters.c     | 59 ---------------
 4 files changed, 21 insertions(+), 142 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c

-- 
2.43.0

