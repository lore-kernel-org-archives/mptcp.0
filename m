Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1F37E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160477; cv=none; b=V9lT0xp+9xQLSPcvbki2vP8N7h6GECZ+J5yGvgTbC90ab6VVWV84+fbeygQmOpVWfjzKiZSP7vfSa5k/6Nw97ktI24RmTEyVLA7c8fkSQz+ED9L9Ce94VjolNQH+njwXWPGw5Pw4wFES87qU0NT3z1H/fdmkr/7vJB5A9fQV6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160477; c=relaxed/simple;
	bh=NCgQtoMnzQH13d/KPP4+SBdFO8kWUqjCwDA6gasEubQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQPksXqx7RVjrduS+UfD5pZp6esbZVvsIutQoA1HfGR0Te1Vly3VCqESZaZKKJJ9YzmqZQS/Yd7ZmjaQpyYtaKah9VZjPgbLOuAHSk30SH9vLqNNMJ41RlWoyRHgA178m4Sztrv9P+qeQy5y3NJH3g80fRs/Lfet4PRKfjpC58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PndHZBZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PndHZBZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246D41F000E9;
	Sat,  8 Aug 2026 03:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160476;
	bh=ugAHe7Fp10njp3PaZyFUsgrUSP9vjBSAfLlTOF0wUsM=;
	h=From:To:Cc:Subject:Date;
	b=PndHZBZ7ylQBs2bngWyMhz4+8kqXYvsjIHuT8sd4IeuJEoIuWyceQrTWa69wAcVuX
	 Dv8bfqtkfn1/yQWo+zHnkYrc5JWbmskJ9KXBB78V4Hc2SGsbN+W5aTyStmh2yDf73m
	 xDVMnhpliprLzklP2eY5AYjG661T0JaLw9nbWvK2kU+xO2yCEVsl1PYw0rBs2ObmrF
	 AwdNSBJZy9XjwYlU7Yq4UuTSNmYaw3NQbvPAVypZRuwLrWzEdNXURCalVkooafnRne
	 vT0dv8nHX4403cUH/CWmRgNhREUPEOyh/df5A8kUK48pM7fqbRReJXTlwjqoFqwngc
	 oH4r1unzWqlQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 00/11] Fix socket options used by NVMe over MPTCP
Date: Sat,  8 Aug 2026 11:40:30 +0800
Message-ID: <cover.1786159812.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

NVMe over MPTCP relies on SO_LINGER, SO_PRIORITY, SO_REUSEADDR, TCP_SYNCNT,
TCP_NODELAY, IP_TOS, and SO_BINDTODEVICE. This series contains fixes to
make all of them work correctly, and adds tclass support for it.

v5:
 - Include Gang Yan's TCP_MAXSEG cleanup.
 - Include two v4-mapped addr fixes.
 - Patch 9, set rcv_flowinfo to 0 for v4-mapped addr.
 - Patch 11, use rcv_flowinfo instead of np->tclass.
 - All comments from Sashiko on v4 regarding "CONFIG_IPV6=m" are false
   positives.

v4:
 - patch 1: skip ssk->sk_bound_dev_if = local->ifindex when local->ifindex
   is 0, so __mptcp_subflow_connect() doesn't overwrite the inherited
   SO_BINDTODEVICE binding.
 - patch 4: assign tcp_sock_set_syncnt()'s return to ret so an invalid
   TCP_SYNCNT is propagated, not silently dropped.
 - patch 6: skip IPV6_TCLASS setsockopt/getsockopt paths on AF_INET
   sockets/subflows (inet6_sk is NULL there).
 - patch 7: treat IPv4-mapped IPv6 as AF_INET for the TOS/tclass path.
 - patch 9: gate ip6_sock_set_tclass() behind sk_family == AF_INET6 and
   IS_ENABLED(CONFIG_IPV6) to avoid IPv4 NULL-deref and link failure when
   CONFIG_IPV6 is off.
 - patch 10: gate tclass on sk_family, skip IPv6 branch for IPv4-mapped
   connections, wrap IPv6 in CONFIG_IPV6.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1785378180.git.tanggeliang@kylinos.cn/

v3:
 - include tclass patches.
 - I also included three NVMe patches here because they have dependencies.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1785238723.git.tanggeliang@kylinos.cn/

v2:
 - Drop "mptcp: don't reset dst when setting default 0 tos"
   and "selftests: mptcp: sockopt: cover LINGER, REUSEADDR,
   PRIORITY, NODELAY, SYNCNT": the 'if (val > 0)' guard
   blocked the legitimate "reset to 0" path, and the test
   only ran val_in=1, missing the SK_CAN_REUSE "any non-zero
   -> 1" normalization.
 - mptcp: bump setsockopt_seq for subflow-only socket options,
   so secondary subflows created via MP_JOIN re-sync
   sk_reuse / sk_reuseport / sk_bound_dev_if from msk.
 - mptcp: copy the subflow's TOS to the msk on accept
   (alongside the existing ssk->rcv_tos copy), so MP_JOIN'd
   subflows inherit the reflected outgoing TOS.
 - mptcp: propagate sk_reuseport to subflows via
   sync_socket_options, so secondary subflows inherit
   SO_REUSEPORT, not just SO_REUSEADDR.
 - mptcp: tighten TCP_SYNCNT bounds check
   ('val < 1 || val > MAX_TCP_SYNCNT'), so out-of-bounds
   values are rejected even when msk has no subflows yet
   (where __mptcp_setsockopt_set_val would otherwise return 0
   without invoking the set_val callback).
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1785054808.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1784985085.git.tanggeliang@kylinos.cn/

David 'equinox' Lamparter (1):
  mptcp: sockopt: implement IPV6_TCLASS

Gang Yan (1):
  mptcp: take TCP_MAXSEG handling into setsockopt_set_val

Geliang Tang (9):
  mptcp: handle TCP_MAXSEG getsockopt in common case
  mptcp: inherit sk_reuse/sk_reuseport and fix dev bind override
  mptcp: add TCP_SYNCNT setsockopt/getsockopt
  mptcp: skip ip6 options on v4-mapped clone
  mptcp: report v4-mapped subflow addrs as IPv4
  ipv6: extract and export ip6_sock_set_tclass helpers
  mptcp: copy the subflow's tos/tclass to the msk on accept
  nvme-tcp: support IPv6 traffic class
  nvmet-tcp: support IPv6 traffic class

 drivers/nvme/host/fabrics.c | 18 ++++++++
 drivers/nvme/host/fabrics.h |  3 ++
 drivers/nvme/host/tcp.c     |  8 +++-
 drivers/nvme/target/tcp.c   |  8 ++++
 include/net/ipv6.h          |  3 ++
 net/ipv6/ipv6_sockglue.c    | 31 +++++++++----
 net/mptcp/protocol.c        | 20 ++++++++-
 net/mptcp/sockopt.c         | 89 ++++++++++++++++++++++++++++++++++---
 net/mptcp/subflow.c         |  4 +-
 9 files changed, 166 insertions(+), 18 deletions(-)

-- 
2.53.0

