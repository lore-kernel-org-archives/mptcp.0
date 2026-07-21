Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6333689D
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601675; cv=none; b=g/XPfsdg2uYA++pfFcFu2wO58juh9cSmnietDJyXpnJQQH2THxyU4vgcpA+w77/YgEBCcZ/8ZTFD1Bn2GN8iV7d3E9Enj5nPtuN8+pip8d+NcsYV6x8yZl3JHIjVZ9JN51OypYlYD8Q3gnRlJxxGcxOFKaBoCCuB3UlZ9QpoUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601675; c=relaxed/simple;
	bh=riqDSM8I2gXLZ6gaEzgPmh+iJYoWPbOMw4uhJ82DTck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekSCcc5J+s2XUFKCqIJTLoi2+DFngXFyJdrkzLp02F6sZLYlccV6lKzl3vYQRYyK8s9awXoRbxKnyHeQENSuPSAQz+68tNS+1GdMm0TUyqxl3BO9tl5OHU+lUt9m8cHI/RK1zfiy/UfpJ4uMh620+mSef4p1KZEoF9qvvvwb76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hNLxJlBN; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hNLxJlBN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784601670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a4FC3STKSoprfUgOEuBPG6f6DDrxaFv+uAG37y6XBGM=;
	b=hNLxJlBNoDTVc1qMF8mP0lgGBHKhnXso8eYIqZusWFahXw5ou2hp5KgSZLkfE3l9lm6Vi9
	yuPecZTjChNcWrvfJOCI/aUfYsJvlh8wLNFDKNZty0sybCcxhbwZgP2Gx87vlW3pAkd+kj
	NZB+c2N1VKI25soyzH3eQOcgyv2ZDkc=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/7] mptcp: add bpf_setsockopt support
Date: Tue, 21 Jul 2026 10:40:55 +0800
Message-ID: <cover.1784601268.git.yangang@kylinos.cn>
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
v2:
  - Patches 1 and 2 are new in this series; they address TCP_MAXSEG
    handling in the bpf_setsockopt() path [1].
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
 net/mptcp/sockopt.c                           | 149 +++++++++---------
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  61 +++++++
 .../selftests/bpf/progs/mptcp_setsockopt.c    |  32 ++++
 8 files changed, 223 insertions(+), 74 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_setsockopt.c

-- 
2.43.0

