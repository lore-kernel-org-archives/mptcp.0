Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0342A7A4
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238814; cv=none; b=llYzojIvvOK7srS1dTCtG3ssIQrm6XrHlL+zx+bQXbYHb7LYIdYCDqazvEk9PVHwOMSvvbS8IX40swkU4SgpfYjursNti9hydYpgDNVEKozMJ24EwU+Ak9yiqf2UkWtAZ+F4R45H7Rmqd6hTL2eWyPjGq+N549VpiiM4IjMNsw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238814; c=relaxed/simple;
	bh=Aly6um8SjaExYJO/ahBDDBjG5wrS7b0imsTdvh3zlWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQDPYl8x53kR9mT7AD/5M0mUQ+lxL0A6QpOASLK38SRlcUd2tvl4IqGpdpZmh5D7l1VMaSdxLhrYQXajg7FV206+eu9PEvwelnuBO5asxe3DT755tGU9FLASyOMkehIilEHkeSLU+SActJr5PTjbc0/MSZ6LMQ59NiX5BHeZnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfapkZUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfapkZUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1511F000E9;
	Tue, 28 Jul 2026 11:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238811;
	bh=ahfVjMm3p9JzXKCXnb7WiaUI/6/VvDIKI0205s8LulA=;
	h=From:To:Cc:Subject:Date;
	b=UfapkZUqLKEwo/d+dkOTC6D1x9K71EqVZVVbN045PTgTLpC/wgOmYc0eyZTOde3Lo
	 +unfHQncQx1dSpv1lw/xNt3AL/tMoFW8E7GnGmG6X8Hjf2wGWmllde0oI1dUqfXmlv
	 wlNEyTgyVwj96WsG+anC9zMNwfSdJhKvZT4zTzIUR0yOCIEp/M6bo0+TrFr5ql0eNd
	 AGnFixw1SEQJTX+QwzhnvnBy8o/zLzYOxwl0R8suwmGdeDF8PBoeJZrFJg3RaKet7S
	 u8DQu+MVkGDaUseDMbmE+QSOiEfhh0WkdCJTRKPzS1bW2X97tN5R+VEh/+PNPBpm81
	 8WhODZO2aZg2Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/9] Fix socket options used by NVMe over MPTCP
Date: Tue, 28 Jul 2026 19:39:33 +0800
Message-ID: <cover.1785238723.git.tanggeliang@kylinos.cn>
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

v3:
 - include tclass patches.
 - I also included three NVMe patches here because they have dependencies.

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

Geliang Tang (8):
  mptcp: inherit sk_reuse/sk_reuseport on subflow creation
  mptcp: handle TCP_MAXSEG getsockopt in common case
  mptcp: add TCP_SYNCNT setsockopt/getsockopt
  ipv6: extract and export ip6_sock_set_tclass helper
  nvme-fabrics: add IPv6 traffic class option
  nvme-tcp: support IPv6 traffic class
  nvmet-tcp: support IPv6 traffic class
  mptcp: copy the subflow's tos/tclass to the msk on accept

 drivers/nvme/host/fabrics.c | 18 ++++++++++
 drivers/nvme/host/fabrics.h |  3 ++
 drivers/nvme/host/tcp.c     |  5 ++-
 drivers/nvme/target/tcp.c   | 14 ++++++--
 include/net/ipv6.h          |  3 ++
 net/ipv6/ipv6_sockglue.c    | 31 ++++++++++++-----
 net/mptcp/protocol.c        | 11 ++++++
 net/mptcp/sockopt.c         | 68 +++++++++++++++++++++++++++++++++++--
 8 files changed, 138 insertions(+), 15 deletions(-)

-- 
2.53.0

