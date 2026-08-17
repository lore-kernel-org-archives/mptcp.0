Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD32472AF
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 03:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786939041; cv=none; b=YaJ7m4tEosoTNLm42k3qFh3Hoe7FR0qll73occCzaE5OL0zZDhIawmsww4FTvIln9tvtxtmu+gtFzWJ2RDdXec6nGHSdADRfYTs8NodMaSFIMvVDJkog0JmjvfjwU02b0CTbWvJ/LcKKpUwbLsD8ADZJjexWvy8cAUPPtOoYmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786939041; c=relaxed/simple;
	bh=cuDtaPx5hBwggxfa3/ZKusoUVPWehwG4nikowWpU8zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrbMM7CGRWd7KOU5hk56guvMbF01Xh9CTFgjXPNN/teJQNLS1o4P1W4MnQJg7UWG/MJj47PRd7VtKewhD480IY+Q3NkdTT4ioW7TO2oM6zUs1YPf+0Can5H/jiU2uWIRIqRS0z8XRc7ZAMtXFcaCIusrBMiUqcV2e1jiYBym8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F76oDBr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F76oDBr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417661F00A3A;
	Mon, 17 Aug 2026 03:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786939040;
	bh=1FU1R6ct4S7br5YNyVjxKrD8Yt1sUVus+boHrHAAVQ8=;
	h=From:To:Cc:Subject:Date;
	b=F76oDBr4QP+8xt2IDrvbtQawQyDF+XiiAz6i997MujHpK4PUoCcHlZte3UV45KEQU
	 e0qB6bG0k0IL+VjQICnSrwMMMn/D38OUpt9ugnJ+L3+xYwUIpHoXFY4rPfKebuCWzu
	 BqzF3BlN5h/ikcQOD8azOQwLSEjFc/Hho0/cNN2pqmGzc7DfJICffYIkI54ASA3asd
	 uFuyulCXw9q64jbI5OP1EHe5UwMzSy0akI68/u0WZRf9DfQ5OQ60z6G0FnemTXlOLE
	 SOLQzSClZfIva7SgijuqMa0tlduyTFK3254lwxOAZoKePc3MbRdoeDGQJVXiq/Md0q
	 5/9gYBk1O+fOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/6] Fix socket options used by NVMe over MPTCP
Date: Mon, 17 Aug 2026 11:57:07 +0800
Message-ID: <cover.1786938892.git.tanggeliang@kylinos.cn>
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

v6:
 - Remove NVMe patches from this series.
 - Remove v4-mapped address patches from this series.
 - Squash "ipv6: extract and export ip6_sock_set_tclass helper" into
   "mptcp: sockopt: implement IPV6_TCLASS".
 - Patch 4: move tcp_sock_set_syncnt before __mptcp_setsockopt_set_val.

v5:
 - Include Gang Yan's TCP_MAXSEG cleanup.
 - Include two v4-mapped addr fixes.
 - Patch 9, set rcv_flowinfo to 0 for v4-mapped addr.
 - Patch 11, use rcv_flowinfo instead of np->tclass.
 - All comments from Sashiko on v4 regarding "CONFIG_IPV6=m" are false
   positives.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1786159812.git.tanggeliang@kylinos.cn/

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

Geliang Tang (4):
  mptcp: handle TCP_MAXSEG getsockopt in common case
  mptcp: inherit sk_reuse and fix dev bind override
  mptcp: add TCP_SYNCNT setsockopt/getsockopt
  mptcp: copy subflow's tos/tclass to msk on accept

 include/net/ipv6.h       |  2 +
 net/ipv6/ipv6_sockglue.c | 23 +++++++----
 net/mptcp/protocol.c     | 16 ++++++++
 net/mptcp/sockopt.c      | 82 +++++++++++++++++++++++++++++++++++++---
 net/mptcp/subflow.c      |  4 +-
 5 files changed, 112 insertions(+), 15 deletions(-)

-- 
2.53.0

