Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB76286D73
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848794; cv=none; b=k3uybUmhtXMb+J0Q8AVeID4CWjdZY9eOMt/dGFM3o0bO+ixA2VIyvc9WbHTim1LdsbH9GCBlsVcV8EfqhbHICHO+wSdkEO423uMT4MVWvsNT1MYlIICEAqGcFn0FcxY+3bIxJ3sHXCS4/C+xqAo0Fd+HvJL+dHK6OeoDVaM5Lqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848794; c=relaxed/simple;
	bh=efQh//uYFn/oYbToUEnBI8cW9Y/pU3CfPQLyKYy5HsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jabDMHv/27ZyNXw/qKbSK3CKnfxyk90iT1u8QbcqU9RqHA4CNVc8D3SDxQpi6bH2Xy/cP1GkglFVVgWQh8ax2Gln4W4hI1zoY3w8YQWNRn3FbE75zHKGtnSzzJt3jhGj1LmRczlLWV1uUbnxnroXLJ+Hhi9c17k5lN1Wec/PPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=whP3Psna; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whP3Psna"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774848791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUx3lmn9LCa7YFiFS5lXiooDvN38q5XlRO3vV8Q0t9Q=;
	b=whP3PsnaQHD4F56IHZBhyKTEKiWq02eLdL3dO/PmE+GUirQF3/yuQZncEX/q2w8gb+90fD
	1ZQmRHCNFiRvtWI1bwUH82zGiz9J1DQm2kDsC63HEvlJScgi+lHuv55mEOlwZummWGAhXS
	DAqaQL5SeAqrr58fNVHVOhJUQTwioK4=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net v4 0/5] mptcp: fix stall because of data_ready
Date: Mon, 30 Mar 2026 13:32:55 +0800
Message-ID: <20260330053300.15717-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Changelog:
  v4:
    - Pass 'delta' to 'move_skbs_to_msk' to fix the potential problems,
      and add a helper named 'move_skbs_from_backlog' to achieve this.
    - Add a test case in mptcp_join.sh which can reproduce such stall
      prolems.
    - Fix a dead_lock problems which is imported in the 1d77124a6322
      ('mptcp: fix the stall problems with data_ready.').
  v3:
    - Replace backlog list with backlog_queue(rb-tree) to solve the
      stall problems.
    Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1773735950.git.yangang@kylinos.cn/
  v2:
    Link: https://patchwork.kernel.org/project/mptcp/patch/20260209084717.506379-1-gang.yan@linux.dev/
  v1:
    Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1770273341.git.yangang@kylinos.cn/

Gang Yan (5):
  mptcp: replace backlog_list with backlog_queue
  mptcp: fix the stall problems using backlog_queue
  mptcp: fix the stall problems with data_ready
  mptcp: fix the dead_loack in mptcp_data_ready
  selftests: mptcp: test transmission with small rcvbuf

 net/mptcp/protocol.c                          | 112 +++++++++++++++---
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  20 ++++
 3 files changed, 117 insertions(+), 17 deletions(-)

-- 
2.43.0

