Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F2C2DA
	for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="glG73nRF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702447046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EcRAa0VDuiDYM+qBrtI3ql2AOmaiw3f4eTlfVZVUgEQ=;
	b=glG73nRF7He3DZcGdtRbwCWJwVVnCQS5G/0QP0kqiqGuf31TlIYn4Lf2YX9rLAm+y3xOyF
	+PDhOEHwMd7sQEinBkJgOKRpPqAEuPQQMlRPFMKM9hjVKiu8ov19g0iIhDPaeSS1mVMm96
	pap2Mp82ebvbW3Z0yPesRhDQV1zcKbI=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 0/3] add MPTCP_MIB_CURRESTAB
Date: Wed, 13 Dec 2023 13:56:36 +0800
Message-Id: <cover.1702446832.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v5:
- merge first three patches into one as Paolo suggested.
- drop "EXPORT_SYMBOL_GPL(mptcp_set_state);" as Paolo suggested.

v4:
- rebased.

v3:
- add mptcp_set_state helper

v2:
- use ftrace_regs_get_argument instead of regs_get_kernel_argument to
  fix build warnings reported kernel test robot.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460

Geliang Tang (3):
  mptcp: add mptcp_set_state
  mptcp: use mptcp_set_state
  selftests: mptcp: check CURRESTAB counters

 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  8 +++
 net/mptcp/pm_netlink.c                        |  3 +
 net/mptcp/protocol.c                          | 56 ++++++++++++-------
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/subflow.c                           |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++--
 7 files changed, 91 insertions(+), 25 deletions(-)

-- 
2.35.3

