Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169EB37F75C
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033693; cv=none; b=lKyfShAkefL/sqA9x/hdLCuryn/1CwTM9ZKIe3VYNzh0S5Qgj7lgU2p/wd6O6WFQraloPNn4+ah58bPqOyCvrSOOaWBFVL1R0JZwlwjFJUu2dPr+umNtj3uZu/LknTK7Id+wzWaL1OEtkoWejQKp7YDrTQQtIH+O82qqh4rMD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033693; c=relaxed/simple;
	bh=A3Co2a4H/z4lzAwcRWkXHH2BKIk/1WgZgjYNWqSzxEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWNP15dR/MV1vkLwGaBCl43C3a4+HbT5pVqxlP7NjcSxZfLoYwUFQOnbQcLzxlM64eCfeiya5gQQgyLSvAHlJ1a6sAgdiRvB3aIxWe/1B8g+cokOOGgGQ5Kw3qX44cxkS2w2WmwVpWHluvvAv18UnWjwvUfHgITh7h4rJWnlFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rwWZkQ7k; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rwWZkQ7k"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775033690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+fWd7F8rY4zniKf5qSk+FcTWeVr3SrS7sdM4+T6WhJ4=;
	b=rwWZkQ7kOL4H4xKkbKyaz/mIGMj9L8BNpicbRalszaiuSPOS33FYR3E8rYvwbhi8szGJgo
	U6Azkb7pf+5Hws2VyBA2NJjN/wzjVQ0zMPmwRSRttluaGxVaRQap2c3gpmWW1kXTm2Qnkv
	3sSvTUTTxo8hm/Oiw+eJQu90WbtJshU=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net v5 0/5] mptcp: fix stall because of data_ready
Date: Wed,  1 Apr 2026 16:54:13 +0800
Message-ID: <cover.1775033340.git.yangang@kylinos.cn>
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
V5:
  - Patch 1 fixes missing initialization of msk->backlog_unaccounted in
    __mptcp_init_sock() to match the commit message.
  - Patch 4 removes the 'else' branch to fix potential TOCTOU race and
    fix typo in title.
  - Patch 5 drops the redundant tcp_rmem restore.
  - Add notes in some patches of the series in response to the AI
    review.
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
  mptcp: fix the dead_lock in mptcp_data_ready
  selftests: mptcp: test transmission with small rcvbuf

 net/mptcp/protocol.c                          | 110 +++++++++++++++---
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  17 +++
 3 files changed, 112 insertions(+), 17 deletions(-)

-- 
2.43.0

