Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D791DF74F
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375189; cv=none; b=FWFrBFTUmfxvgTi6qKGCDbx7NgL65IZ9Cro7jDq4cZztS8yrMofjDPOuhU2nPYlMEQjuyLPmtbSnmmMF55sxBMKmoizussYAFgWXBNjoy9EJApv7utca+qL0Js0e4afpPuR5aO9z//vnRRqNFZLC6azOaSajqZHfVypsrNs7WVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375189; c=relaxed/simple;
	bh=/ky29D3EoF1hhGkO0dd7zNaJG9sZ1FGoKRLh0EVJInU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GiWVDwg9n2T3HOqQMynsyoZ3Ayi26PQXKPrEHsAeEUjmP6D8Bl92Wl1ms0lV2cGU+4aB6XKjO7FAqoaSQmRbJlEYhhhkyjCwZ6UU1rC7fioKha/khRMbFmoB8zePseuyJhc63q7W0PhEfWWy0QP/JpB8zMt6akh3ErvZFyyTmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8sRFPMQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8sRFPMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247ABC19421;
	Fri, 13 Mar 2026 04:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773375189;
	bh=/ky29D3EoF1hhGkO0dd7zNaJG9sZ1FGoKRLh0EVJInU=;
	h=From:To:Cc:Subject:Date:From;
	b=J8sRFPMQjvE0UJ0qcHtMWP8cNgyt1Z35OWlos0I9R/7zBoYs4YPFuVNtC1NzInj8/
	 DZh7HvLSnOcFKthjjKDHNTE48Fom0xk/zuP+/+iuiTWdb6B5NEMoSpNR/aDsBbGtAG
	 y/AIevNaiPXwwZ3ad5fFYqGSv8m9o8y+xcPambOFCuE7ho50sPtZ6k1NT89dXbd2Wt
	 diW+NuwXPhtMdvZvt6AoaF0M27xoIdehxEl21pGRKMcG0/dmx8kf1Kmdeo5QmGO0zf
	 6TnqLKz7be4u7UHFciVRyNXtEYH8fP8pPnlqUDa6DZAeGXKYPwQZv6yywEtmfaQcvL
	 zEhBuoO8+a59w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v5 0/7] VME over MPTCP
Date: Fri, 13 Mar 2026 12:12:44 +0800
Message-ID: <cover.1773374342.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - address comments reported by ai-review: set msk->nodelay to true in
   mptcp_sock_set_nodelay, set sk->sk_reuse to ssk->sk_reuse in
   mptcp_sock_set_reuseaddr, add mptcp_nvme.sh to TEST_PROGS, and adjust
   the order of patches.
 - remove TLS-related options from .allowed_opts of
   nvme_mptcp_transport.
 - some cleanups for selftest.

v4:
 - a new patch to set nvme iopolicy as Nilay suggested.
 - resend all set to trigger AI review.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1772683110.git.tanggeliang@kylinos.cn/

v3:
 - update the implementation of sock_set_nodelay: originally it only set
the first subflow, but now it sets every subflow.
 - use sk_is_msk helper in this set.
 - update the selftest to perform testing under a multi-interface
environment.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1770627071.git.tanggeliang@kylinos.cn/

v2:
 - Patch 1 fixes the timeout issue reported in v1, thanks to Paolo and Gang
Yan for their help.
 - Patch 5 implements an MPTCP-specific sock_set_syncnt helper.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1764152990.git.tanggeliang@kylinos.cn/

This series (previously named "MPTCP support to 'NVME over TCP'") had three
RFC versions sent to Hannes in May, with subsequent revisions based on his
input. Following that, I initiated the process of upstreaming the dependent
"implement mptcp read_sock" series to the main MPTCP repository, which has
been merged into net-next recently.

Depends on: mptcp: fix stall because of data_ready
Without this fix, NVMe-over-MPTCP test will probabilistically fail.
Based-on: <20260228011511.440437-1-gang.yan@linux.dev>

Geliang Tang (7):
  mptcp: add sk_is_msk helper
  mptcp: add sock_set_nodelay
  mptcp: add sock_set_reuseaddr
  nvmet-tcp: add mptcp support
  mptcp: add sock_set_syncnt
  nvme-tcp: add mptcp support
  selftests: mptcp: add NVMe over MPTCP test

 drivers/nvme/host/tcp.c                       |  26 ++-
 drivers/nvme/target/configfs.c                |   1 +
 drivers/nvme/target/tcp.c                     |  38 +++-
 include/linux/nvme.h                          |   1 +
 include/net/mptcp.h                           |  27 +++
 net/mptcp/protocol.c                          |  53 +++++
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 205 ++++++++++++++++++
 9 files changed, 356 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

-- 
2.53.0

