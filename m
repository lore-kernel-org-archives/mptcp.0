Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C53305E28
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380055; cv=none; b=ibOfZ538KHNgwWFk3o+fv2DTFtSjZ4CyTIsgxXsrN9URnACfiUmDDv+KQ+1uV28brGbBNT/9Jn23fq6psiazGbJBt8htQKxq957/AamhHRGg4dMPjElHPvKF3Tn2CF90ApiicKokkQJOHt43AmsAk68EYDopQmARQMH7LNoIW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380055; c=relaxed/simple;
	bh=RXsSk3+Yuh6jtFImRXX5HF8dIUuJdKVaQ+3lklhiQUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiQjhggMPQyKbtacdq308rTkPIJrSe69g9q3STuLtHvfUm+/LzRBmwNCeLZtpwVX0vkRDLHAa7HpXl/e8fGHmVoL07b2bEv9OJqXwAGIXfn7oR9rZrqTkxpVILTWTlBVh8JQCV9qPCbUYbEEFZqHtS58nkTAIFxjA2jvfp6ZhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIGbcHLb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIGbcHLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FDC1F000E9;
	Thu, 30 Jul 2026 02:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380053;
	bh=hgSaGYmyRk3+d1y6ZYYEEm3BimjTPoEuxkNdesnJvZI=;
	h=From:To:Cc:Subject:Date;
	b=BIGbcHLbZEJlRWbIw6scdL6EVCp+x2YS9iVj8+Bm01tddLjzVxTRXt1gJ3lnc8h1c
	 PvZr4/Ge6P0oodE/T5ANPf+7oX4xQ8LqTQ0UamTdAJ2OOcI47OBypD4B/6T8bOFTpi
	 LZ2r21U+TqVVZDDTAzSxwYtXbTDEX3vazTTQhYgadvUIuaQW4h6sRrAnU/pAxs2xQw
	 I/IyEMZGESrMYYs6bt2XoazLrnYFOqZ3Ae2q2vN2Zu5M58BrPp/ko+g2ZsAOGA6s+u
	 nHBpbzoBNJeSp66zIxZ7NJAEIk88xXLjvY9kxfAssseRVon/PemYtsA4MxJM/MDLBc
	 VJuOklBs4tpMw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 00/10] Fix socket options used by NVMe over MPTCP
Date: Thu, 30 Jul 2026 10:53:53 +0800
Message-ID: <cover.1785378180.git.tanggeliang@kylinos.cn>
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

Geliang Tang (9):
  mptcp: preserve msk's sk_bound_dev_if on PM-default subflows
  mptcp: inherit sk_reuse/sk_reuseport on subflow creation
  mptcp: handle TCP_MAXSEG getsockopt in common case
  mptcp: add TCP_SYNCNT setsockopt/getsockopt
  ipv6: extract and export ip6_sock_set_tclass helpers
  mptcp: copy the subflow's tos/tclass to the msk on accept
  nvme-fabrics: add IPv6 traffic class option
  nvme-tcp: support IPv6 traffic class
  nvmet-tcp: support IPv6 traffic class

 drivers/nvme/host/fabrics.c | 18 +++++++++
 drivers/nvme/host/fabrics.h |  3 ++
 drivers/nvme/host/tcp.c     |  8 +++-
 drivers/nvme/target/tcp.c   |  8 ++++
 include/net/ipv6.h          |  3 ++
 net/ipv6/ipv6_sockglue.c    | 31 +++++++++++----
 net/mptcp/protocol.c        | 16 ++++++++
 net/mptcp/sockopt.c         | 76 +++++++++++++++++++++++++++++++++++--
 net/mptcp/subflow.c         | 10 ++++-
 9 files changed, 160 insertions(+), 13 deletions(-)

-- 
2.53.0

