Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A9346E7D
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119385; cv=none; b=t8AoSfKo6bzqPWcGHjWI6dlxbvE7tt4obj5BnSO5Rg0vbF9XOg57S1MoESlhMectV9KLR97DsjQqbjIJzVcedHwjcuJHk+8ZT3C3dowiD0WqR5rQAF0saFp+7XvvdCrLdL+u/kS90y3RcbYav4XA784CskLL3V5lqH7ioUhKF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119385; c=relaxed/simple;
	bh=8AnkUXlv+GCXqtgYyIX1Z2xzOb1Qtyv9Gh/YmG+cmPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtUIcPNMkle+JXgsW7nHQbmQyN1/kpwxjv6UChrNqacjc59Pm8K+2wTPyV8IF4Jf0pv5uHi7V7OJL84ltio/XjsKT+Ui23fSAKHiM4Uqq6Yh2Sk2JGHkiINB1ovT2X758afaS7JYEOv8towiBj5oYnZUiqljCIeKUDy5Wb8VHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fdvmtg8H; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fdvmtg8H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785119380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HS/4VpOPxzXByOC2YOylfwdzxIObcJSVe0rVTM6uSuQ=;
	b=fdvmtg8HqYLQ1SBc97XqKYHJbZ7yevkJ4o5SpdpGiHMLI/QqJR6fkC8532s7gfUfR5lVFA
	Uz5t59JsxCPs6BGcHKiOiBlwoH7RHeDZvR5zM/iQ7hGMd0pC77RlBBUNq2LER4/b4Bg58n
	YuI6jq1maUroR9fMp6+57gZp9Bw7ZH4=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/7] mptcp: add bpf_setsockopt support
Date: Mon, 27 Jul 2026 10:28:42 +0800
Message-ID: <20260727022849.20923-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Hi, Matt, Geliang, Paolo

Patch 3-4 have been reviewed by Paolo before, and ready for merge
[1][2].

Changelog:
v3:
  - Patch 2 keeps the mptcp_setsockopt_all_sf as Geliang suggested.
v2:
  - Patches 1 and 2 are new in this series; they address TCP_MAXSEG
    handling in the bpf_setsockopt() path.
  - Patch 4 adds an early return to fix msk->sk_rcvlowat being
    unexpectedly modified, an issue seen in v1.
  - Patch 5 makes the hook safe for the non-tcp master socket: it guards
    bpf_sock_ops_cb_flags_set() with sk_is_tcp() to prevent out-of-bounds
    heap reads/writes through tcp_sk(sk)->bpf_sock_ops_cb_flags, and does
    not set is_locked_tcp_sock for the msk (unlike tcp_call_bpf()). That
    flag authorizes the verifier's direct tcp_sock-offset field accesses;
    since the msk is not a tcp_sock, leaving it at the default 0 is safe.

v1:
  Link: https://patchwork.kernel.org/project/mptcp/cover/20260713095735.1222033-1-gang.yan@linux.dev/

[1] https://patchwork.kernel.org/project/mptcp/patch/20260522-sockopt_lock-v5-2-108629a46e98@kylinos.cn/
[2] https://patchwork.kernel.org/project/mptcp/patch/20260522-sockopt_lock-v5-4-108629a46e98@kylinos.cn/

Gang Yan (7):
  mptcp: drop unused @max arg of __mptcp_setsockopt_set_val
  mptcp: take TCP_MAXSEG handling into __mptcp_setsockopt_set_val
  mptcp: use sockopt_lock/release_sock in sockopt
  mptcp: reject sockopt requiring ssks' lock in BPF context
  mptcp: enable bpf_setsockopt on the master socket
  mptcp: add TCP_CONNECT_CB sock_ops hook
  selftests: bpf: verify mptcp bpf_setsockopt from TCP_CONNECT_CB

 include/net/mptcp.h                           |   9 ++
 net/core/filter.c                             |  10 ++
 net/ipv4/tcp.c                                |   1 +
 net/mptcp/protocol.c                          |   6 +
 net/mptcp/protocol.h                          |  29 ++++
 net/mptcp/sockopt.c                           | 127 +++++++++++-------
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  61 +++++++++
 .../selftests/bpf/progs/mptcp_setsockopt.c    |  32 +++++
 8 files changed, 223 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_setsockopt.c

-- 
2.43.0

