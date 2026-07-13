Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA03D9DD2
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936671; cv=none; b=monKOzcGqqBnlZAKth2pcVBG1b6Fjc6SyPxr8ahvfmz+H4ZxbOG4BlRP3nTFNQeEoRrlWZnyjM4wsPPddR0GWshT8t+8v7y+pO/5nprQnFs15VjBo9mL/wfTEy4szR3omyHqR5aTQ+9CT1VeM9gmXnLmvB5G4DjhN3fhLugbLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936671; c=relaxed/simple;
	bh=nqhqpak3o96Ht9AfAFmD56npOTc6is2K9HL0xykocTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awVcMoa5OcfUlCFppy7r2+ufSaB3FO/1CaCVpKWFbl12sS+ZxB7wor5ErBqO6i1PPKWe3hN8a22TYqFrTTuzPZJCDUFH9HDI3YAhq9bTAGDHccyISRdw8X/3i0q8bLbnI75r+asDO9aUZ9G3Ja7DcGokr+OzcnIObqWnoBgdodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rZx7PwwM; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rZx7PwwM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783936664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WhZW6cMDs629Sv/ceUJrPXd1fQsHPCeBLeTjAJXQ8jk=;
	b=rZx7PwwMZkMq+gbnrCixl5yUUtH1zJbIFlCZHNx4DAexd2P2hax7Li2zycDoW8god1ke/Y
	02uvoG3L73zsMB1kAALiCNXRHxOUAariHhV27iGqOtFCkqpUzjpdcE6n9HyuZG74HeDzXc
	w+dxXDQwCHh/Atw2/uIGzdbnWJM0vXk=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 0/5] mptcp: add bpf_setsockopt support in
Date: Mon, 13 Jul 2026 17:57:30 +0800
Message-ID: <20260713095735.1222033-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

It adds a hook in mptcp_connect, which enables setting socket options
automatically before the connect.

- Patch 1-2 have been reviewed by Paolo before, and ready for merge [1][2].
- Patch 3 let mptcp_setsockopt to take cover all the sockopt levels for
  msk.
- Patch 4 introduces a helper and a hook like tcp does.
- Patch 5 adds a self-test case for bpf_setsockopt in mptcp.

For now, I only used AI to help with grammar optimization of the commit
messages.

[1] https://patchwork.kernel.org/project/mptcp/patch/20260522-sockopt_lock-v5-2-108629a46e98@kylinos.cn/
[2] https://patchwork.kernel.org/project/mptcp/patch/20260522-sockopt_lock-v5-4-108629a46e98@kylinos.cn/

Gang Yan (5):
  mptcp: use sockopt_lock/release_sock in sockopt
  mptcp: reject sockopt requiring ssks' lock in BPF context
  mptcp: enable bpf_setsockopt on the master socket
  mptcp: add TCP_CONNECT_CB sock_ops hook
  selftests: bpf: verify mptcp bpf_setsockopt from TCP_CONNECT_CB

 include/net/mptcp.h                           |   9 ++
 net/core/filter.c                             |   6 +
 net/mptcp/protocol.c                          |   6 +
 net/mptcp/protocol.h                          |  30 +++++
 net/mptcp/sockopt.c                           | 111 +++++++++++-------
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  61 ++++++++++
 .../selftests/bpf/progs/mptcp_setsockopt.c    |  32 +++++
 7 files changed, 213 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_setsockopt.c

-- 
2.43.0

