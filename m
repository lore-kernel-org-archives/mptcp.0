Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A12FFFA4
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913545; cv=none; b=HaEZ4XFalYUTeEOD3N+Bs/WZG6lymsDq2k3fEh0iXInEIuIqBGSPrpgAotNhtav3ed8Iv/W7slzsqwP5dOkOFhzHcLKMX+kPGP7aC5Ju2YXxfp1DYe0QZriC+kfkENhgFMqSxyKoerQQLFccsb+ZjStcIZvM2uZKc7/0WL+mxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913545; c=relaxed/simple;
	bh=myieSN7Rfa2GUFngwy1fIOXfiVhtIWrt7pN5/V+ND4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbJzJMP0ue8vel5csBmhKi5aR23Tx6BdjVVoHYgUIHuuwsUgff/+PYOLBgbKmqPfUWDq6lKC+RF+rCBK2bsDF1ZV1MpvRbRCM9+ZsITEhpKyK6MlGOKyfRuK3BXhcyhbh1fLdw04lLIyZ0ZfmRuNaKB3XYFlKuDBhI2jz1uopSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBUlycLb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBUlycLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DCD1F000E9;
	Mon, 13 Jul 2026 03:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913542;
	bh=zu8pbvSi9sawrVmV1JANnQiJA36EIK0nCl+c625pGGM=;
	h=From:To:Cc:Subject:Date;
	b=eBUlycLbRu5vcNK3s0iRe9luI2fwMyOF/dRxYfZEWHlhovafkINKwnjIx2QNSNyXO
	 ohjQpMMgC8X7nSTvicOScMlcgjRLrSZqeSFmtmVYGo4qKthIs8PgOtUwzfsEpeAC9D
	 v8HC2MYsfoP1uLKr3EQq3KWQ05Am1+N9RAQ8IMBcEclg60Pm0Yrq/mE2+XvtR9sqiQ
	 BK5EhK6Qa1c+zHIA7o8DR6lG1iF81naHu8PKbbPhRqcRlEtM3nTx1EfyWj80fr3ePl
	 0WZCtmmWdOHICGnqtlgpQVtpCudBr/eoR7J/ID/v/boCMF0d31xAma/W5OFvIMVwYu
	 RGU5wbT/1yB6Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/5] mptcp: add MSG_ZEROCOPY support
Date: Mon, 13 Jul 2026 11:32:08 +0800
Message-ID: <cover.1783913332.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series adds MSG_ZEROCOPY support for MPTCP sockets, allowing
userspace to transmit data without intermediate kernel copies, and
provides corresponding selftests to exercise the new path.

The first patch is a small cleanup that introduces a local 'tp'
variable in mptcp_sendmsg_frag() to avoid repeated tcp_sk()
dereferencing, preparing for the subsequent zero-copy changes.

The second patch implements the core MSG_ZEROCOPY support. The design
follows TCP's reference-counting model, with a single ubuf_info per
sendmsg tracked by three reference buckets: one held by sendmsg itself,
one per MPTCP dfrag in the retransmission queue, and one per subflow
skb. Completion is reported only after all bytes are acknowledged at
both MPTCP and subflow levels. The feature is silently downgraded to
regular copy in cases where zero-copy cannot be safely performed
(MSG_FASTOPEN, fallback mode, or memory pressure).

The third patch handles SO_ZEROCOPY in setsockopt.

The last two patches add a new 'zerocopy' I/O mode to the mptcp_connect
selftest, and a wrapper script to run it as part of the regular test
suite, ensuring the zero-copy path is exercised in CI.

v3:
 - Force fresh skb when mixing zerocopy and kernel-copy fragments.
 - Simplify zero-copy availability check by using SOCK_ZEROCOPY flag
   directly.
 - Validate SO_ZEROCOPY value in setsockopt and avoid affecting
   fallback subflow.
 - In selftests, drain MPTFO partial data, use poll+recvmsg for completion
   notifications with timeout, and verify getsockopt round-trip.

v2:
 - patch 2, never mix PURE_ZEROCOPY frags with kernel-copy frags in the
   same skb; handle fallback, return values.
 - patch 3, a new patch to handle SO_ZEROCOPY in setsockopt.
 - patch 4, set SO_ZEROCOPY, handle listen_mode, error queue.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783821830.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783774784.git.tanggeliang@kylinos.cn/

Geliang Tang (5):
  mptcp: use local variable tp in sendmsg_frag
  mptcp: add MSG_ZEROCOPY support
  mptcp: handle SO_ZEROCOPY in setsockopt
  selftests: mptcp: connect: add zerocopy io mode
  selftests: mptcp: connect: cover zerocopy mode

 net/mptcp/protocol.c                          | 117 +++++++++++++++--
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  17 ++-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 120 +++++++++++++++++-
 .../net/mptcp/mptcp_connect_zerocopy.sh       |   5 +
 6 files changed, 249 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh

-- 
2.53.0

