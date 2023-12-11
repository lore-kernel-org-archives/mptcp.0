Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7C20B19
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hXPSvenA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702282713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ARyCMoSBXASqSKYtBQ5+lcQ8fw+z4zrkLZWSSobd5jU=;
	b=hXPSvenA3z1d0+VqnrJkvQRUJRHtL0Bd82ZPcFIVLhDXyhbnv6k0t5xiutlW9JuX3r7Mw7
	Rb5wRV+m/qmteqehi5G4PAppXUj2t1mQl5cFK9vOnB7t2ZwkmXe4YqZFmxAUYSENV2IZvo
	Dnf4f+07DaB4cH198xu//xW05hsPlf4=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v4 0/5] add MPTCP_MIB_CURRESTAB
Date: Mon, 11 Dec 2023 16:19:12 +0800
Message-Id: <cover.1702282650.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v4:
- rebased.

v3:
- add mptcp_set_state helper

v2:
- use ftrace_regs_get_argument instead of regs_get_kernel_argument to
  fix build warnings reported kernel test robot.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460

Geliang Tang (5):
  mptcp: add mib counter dec helper
  mptcp: add a current established counter
  mptcp: add mptcp_set_state helper
  mptcp: use mptcp_set_state
  selftests: mptcp: join: check CURRESTAB counters

 net/mptcp/mib.c                               |  1 +
 net/mptcp/mib.h                               |  8 +++
 net/mptcp/pm_netlink.c                        |  3 +
 net/mptcp/protocol.c                          | 57 ++++++++++++-------
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/subflow.c                           |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++--
 7 files changed, 92 insertions(+), 25 deletions(-)

-- 
2.35.3

