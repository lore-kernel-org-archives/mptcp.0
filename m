Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902C3B4E8E
	for <mptcp@lists.linux.dev>; Wed, 18 Mar 2026 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826857; cv=none; b=OJWJBS1uRRVuKEzoJedGCylENz62TDivO262caME2o1S2hxLJ8BS9SMhj2Sr5t0b8zo1gnmzb3cyM5w4qXdy0HzPi0IFuT9Bzy/jKJk3iCVhAzkA+vgXYpfgj/iVZNLvkASk+rAoyZXBd/b2E0TGMDh5gXnFmBB/fxNmtI3rdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826857; c=relaxed/simple;
	bh=UO9lm0cBRh412SC4Bdh9Y2UtkWgly9nh0zTbGw3Dhow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3yL56nTmmjlMXJxkQJQMEjex1mPu0OclTdpVtyAAqUAU4xBqmZH3PU0hi8UKHv79yc1cjxAT2oQ4etPkLAoqiyObJa0NlJzIR8CHxa7NuwZOPBSm4Ah/6QFMX66uOAzsrBr4jzzuD7MB40AIuBDIPpKdmxNpUbIAnks/urzcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGUS3AHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGUS3AHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800B8C19421;
	Wed, 18 Mar 2026 09:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773826856;
	bh=UO9lm0cBRh412SC4Bdh9Y2UtkWgly9nh0zTbGw3Dhow=;
	h=From:To:Cc:Subject:Date:From;
	b=ZGUS3AHcQDGsVAk6OEkrENTzL/kmJA9Tu/TDjCVwaUoFLliSLJHnHP7c5XhgVQ43x
	 ruDVtEDQMcmpke4Qc9m50LDDaqTnZg66yaSlL6DCMpmt13iFZ9RcY8tGSk6jaOWxsS
	 zRsqmZxWvXEDDcxZ1YzxsE6AP0+Zs8g4Rcts1P8apdqO5IxpPYvlWXfQHuWKKjXjlv
	 TWark5qQSqs3oJYmplX+311xj/RS7H/mMhf12/GR84M6UVdZiEXr4lZnuZQM5hiu7D
	 qpweRZ4x+Q2KwEtXSkuqM+Bbt37+2gr3y5TITRjOtiQmbI+NPx4b4TQBDhCNzrmtaY
	 zZljzJFltlSfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] implement psock_update_sk_prot
Date: Wed, 18 Mar 2026 17:40:48 +0800
Message-ID: <cover.1773826662.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - Address the comments by ai review.
   - use WRITE_ONCE to set sk->sk_write_space.
   - update the selftest, set a new key for client socket.
 - Fix line length warnings.

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

 net/mptcp/protocol.c                          | 113 ++++++++++++++++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  16 +--
 2 files changed, 121 insertions(+), 8 deletions(-)

-- 
2.51.0

