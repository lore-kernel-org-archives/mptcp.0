Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C4D3CF200
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258820; cv=none; b=M3GvKgmyMahVbHFAyQFKcZ68HRGCpncKvtG1XcZNivp3Lr9xy3vX0qGlMgW/s/hZ8A9OWldZ03jROOQ176FkvqMLhfS5buQgbo57baMChHmWmKtA+ElBHXXPwlX6LQbAI55g7rKRboQks4banr9gsstR5/gyuUudyBveY2stJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258820; c=relaxed/simple;
	bh=7P1Su9xD9tU7u3oXc6HGPUKR3D/H4OgQ2yWbyafi75I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O57Aokfy9uphpc0d+KsBZwY8yCDDLikXqI8A8mXaXNWn2fDvZFlmkv4RMGUdT91O1ewRarzfTxt4FlFDsR4iHlqPo1ImEW17WtneLuiEqjHgbE67VnOefQh6Ipbf8h1Qa3QUY2FPVMU102Xsvx/9X7pO/O7WObI1JJIiHJQrl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=rAHnUy9n; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="rAHnUy9n"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so766842a91.2
        for <mptcp@lists.linux.dev>; Tue, 01 Sep 2026 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788258819; x=1788863619; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7cU+bWCENsLX+frMtZ+bjJJiJ5Lc94BmOPSpkNEJ1ps=;
        b=rAHnUy9nLxXIoAKqIFNE2PHsOwMp23DrGCLveqCmq7VOaLK3zL/R1UqGIvDLzMWVhk
         x+a6wwL9BGPObvvycMb0if63Y3CXODAJwoIjVzQWcIcQ2tydvdHmCcE1fRQ0rBAMzYey
         7PUn2Dxct1l3RZ3n3OxS+4+lF4stnaC1SpTRkI14Hf29GAKjruY1eA137rHVyK/cbY1R
         FAfIICPtqAoYNm2xGid3b//Z69RkLLDxC/SeZUWRx+8sh9ngCnDIEdxAF6hZ0Iy9Fmgp
         DJM6cEog9MAEprB6Tz0G+zCSsPBwpIhQylDfIL8tYDmkh0LEGMCQrtfmJFLw8e70Q9dk
         uLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258819; x=1788863619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7cU+bWCENsLX+frMtZ+bjJJiJ5Lc94BmOPSpkNEJ1ps=;
        b=Icq7iL5RJhRdZIAaeu1nvajwgyZgaeVzFudvtH5Wfv5G1UCpa26X3dpC6FLM1xCBB7
         CyDgTFYqC8hApD1MgBE+qHB/cYMJUxoiDcAbZrPTnZlnkU85jNEV59OXpW0xl42zO6R/
         2Fn4ZoOkgajaU1i6naOndYff1WBf/Ikj5vuw+teIoIOSVmkkfNQuyZTwArYqz1YsbKhJ
         1xW4HVtgYdBDYzNjxJJyNF3pzm3iEh1EUZtdNfF8e/9MlaJ8MkEoFSWSQzHcnM9ayUh3
         mPjYHUcPSCu2r8zRwhQN1xL/61Bx0vCH2hA2c3Xg17A8CRPZcC8iXMsjIzRjF7xQE5kX
         HawQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+u3FJ5tG0OAS/0gLMm6fQSzkvKhOlOxiW/s9/dtdOaGs9EzGTYhkra3Ta/pqKaLNeuTXsQg==@lists.linux.dev
X-Gm-Message-State: AFuF++kiPx7uwOFMon0oC62KC52F3njKuESDwiZ5mbycKvueUaLfm7+W
	/AI3Lq0vs/6sG67IavqtrFuI+mOo0ZQ9q0QzGoofZWAZfg7G+YJtg7PM+7xiKcEzDclb
X-Gm-Gg: AYBFou0BTVsRdDv8bGIutLi9cDrI5r2VmZkE5dhtGVI53khn9b3QNpV0Vf3sdP47Pe+
	BSt+RQY6+M0fsOOfwCwyki5vac6H+sjH5JzUbhcj0cVxXwvfoWM0195o8kT5ipgqW+5dprIQ/Kx
	vv9yc1bo2Uw3mjbnYJJPFSatcecR899zEWunZF1weZGJ6jK10Vm/Gf73C5anFxeCE/NfDW3OFaM
	DzU2sBoimAzD8lKwzgy1FJHPTNCAJzKIfEC8yRybYuoiH50iwrUnpfrxBTHDI1yHqotvwB7FC7Q
	Z7c9k3rT+p4NENWUc0NjPQgpZZL/aT4FBJg3SxxDwIppdIhbOTrCVIVpHlGkzyI6FZuJ+4vYRKj
	Hnx8MgZtra0vBGAGwBnVxbvPsWalOYQeCm5SAgwWR2v+CjD+HQJhdMg+hz1UN4+nTdILULJpbR4
	EJqneHTelDCLyN3fEaZbQG4+rLRZnZtjufa0rW66fYrBnA7PtSA3QMLTqtlLWoqV4ONoy7sks=
X-Received: by 2002:a17:90b:1f87:b0:395:5f43:4ec4 with SMTP id 98e67ed59e1d1-396d0a6589dmr51188369a91.0.1788258818362;
        Tue, 01 Sep 2026 03:33:38 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm6126574a91.1.2026.09.01.03.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:33:37 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	daniel@iogearbox.net,
	kafai@fb.com,
	kylebot@openai.com,
	david.lee@trailofbits.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net v5 0/2] mptcp: fix request migration ownership
Date: Tue,  1 Sep 2026 18:33:21 +0800
Message-ID: <cover.1788202924.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

Hi,

TCP request migration clones pending requests with inet_reqsk_clone().
Some MPTCP request fields carry ownership which cannot be duplicated by
a plain byte copy.

For MP_JOIN requests, subflow_req->msk holds a socket reference.  The
clone inherits the pointer without acquiring its own reference, so the
original and cloned requests can drop the same reference.  Patch 1 lets
the cloned request acquire a reference while verifying that the original
request still owns the same msk.

For MP_CAPABLE requests, token_node belongs to the original request and
is hashed in the token table.  Copying the node gives the clone invalid
hash state.  Patch 2 moves token ownership under the bucket lock and
makes token acceptance and destruction tolerate an already moved token.

--------------------
Changes in v5:

- Read the MP_JOIN msk from the original request instead of the raw-copied
  clone.  Use refcount_inc_not_zero(), then re-read the original request
  to verify that it still owns the same msk.
- Use WRITE_ONCE() when the third ACK transfers msk ownership from the
  request to the child.
- Document the ownership invariant, the RCU/SLAB_TYPESAFE_BY_RCU lifetime
  guarantee, and the ordering dependency between the two patches.
- Document the rare plain-TCP fallback when an MP_CAPABLE clone moves the
  token but subsequently loses ehash ownership arbitration.
- Patch 2 has no code changes from v4.
- v4 link:
  https://lore.kernel.org/all/e3aeafa4dc2afb7ea36143eae163635eee23395c.1786497414.git.yuantan098@gmail.com/
  https://lore.kernel.org/all/6abadc83940143e099fa3b54ec6dea2fb95da090.1786497414.git.yuantan098@gmail.com/

Changes in v4:

- Rebuilt the series from the final v3 patches.
- Kept MP_JOIN and MP_CAPABLE ownership fixes on the MPTCP request clone
  path, matching v3.
- Kept MP_CAPABLE token publication after first subflow setup and
  documented the MPTCP-specific teardown that avoids TCP-only
  forced-close helpers on the MPTCP master socket.
- v3 link:
  https://lore.kernel.org/all/74e00d4f4fedec635ef06a16b1bf28a281b9e7e5.1785995291.git.caoruide123@gmail.com/
  https://lore.kernel.org/all/a12d76b7f2305b5a8d64c3d6c3585e39684ff792.1785995291.git.caoruide123@gmail.com/

Changes in v3:

- Split MP_JOIN and MP_CAPABLE into two patches.
- Reworked MP_CAPABLE token migration to happen during MPTCP request
  cloning.
- Made MP_CAPABLE accept/destroy paths tolerant of already moved or
  removed request tokens.
- Added a packetdrill MP_CAPABLE reproducer and decoded warning.
- Dropped the redundant IPPROTO_TCP guard around the direct MPTCP clone
  call, as request migration is TCP-only.
- Based v3 on the latest net tree rather than the current mptcp_net-next
  export, which has not yet merged commit a0ab2ba83e35 ("tcp: fix TFO
  max_qlen accounting across reuseport migration") and therefore lacks
  the overlapping inet_reqsk_clone() changes.
- v2 link:
  https://lore.kernel.org/all/40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com/

Changes in v2:

- drop the generic request_sock clone callback
- call MPTCP directly from inet_reqsk_clone() under the TCP protocol
  check
- keep cloned MP_JOIN requests holding an msk reference
- clear raw-copied MP_CAPABLE token hash state in the clone
- move MP_CAPABLE token ownership only after successful req migration
- avoid exposing token internals to inet_connection_sock.c
- update the commit message accordingly
- v1 link:
  https://lore.kernel.org/all/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com/

------------------------------

// poc for MP_JOIN:

// Minimal reproducer for a stale subflow_req->msk after reqsk migration.
--tolerance_usecs=200000
--non_fatal=packet

`sysctl -q net.mptcp.enabled=1
sysctl -q net.ipv4.tcp_migrate_req=1
sysctl -q net.ipv4.tcp_synack_retries=1`

// Listener A and the owning MPTCP connection.
+0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
+0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
+0     bind(3, ..., ...) = 0
+0     listen(3, 8) = 0

+0.0   <  addr[caddr0] > addr[saddr0]  S   0:0(0)         win 65535  <mss 1460, sackOK, TS val 1000 ecr 0,    nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
+0.0   >                               S.  0:0(0)  ack 1             <mss 1460, sackOK, TS val 1000 ecr 1000, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
+0.1   <                                .  1:1(0)  ack 1  win 256    <nop, nop, TS val 1000 ecr 1000, mpcapable v1 flags[flag_h] key[ckey=2, skey]>
+0     accept(3, ..., ...) = 4

// Make the MPTCP socket fully established so it accepts MP_JOIN.
+0.1   <                               P.  1:3(2)  ack 1  win 256    <nop, nop, TS val 1001 ecr 1000, mpcapable v1 flags[flag_h] key[skey, ckey] mpcdatalen 2, nop, nop>
+0.0   >                                .  1:1(0)  ack 3             <nop, nop, TS val 1001 ecr 1001, dss dack8=3 dll=0 nocs>

// Leave exactly one MP_JOIN request half-open.
+0.1   <  addr[caddr1] > addr[saddr0]  S   0:0(0)         win 65535  <mss 1460, sackOK, TS val 2000 ecr 0,    nop, wscale 8, mp_join_syn address_id=1 token=sha256_32(skey)>
+0.0   >                               S.  0:0(0)  ack 1             <mss 1460, sackOK, TS val 2000 ecr 2000, nop, wscale 8, mp_join_syn_ack address_id=0 sender_hmac=auto>

// Listener B joins the reuseport group, then A is closed. The next request
// timer clones and migrates the half-open MP_JOIN request to B.
+0.1   socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 5
+0     setsockopt(5, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0     setsockopt(5, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
+0     bind(5, ..., ...) = 0
+0     listen(5, 8) = 0
+0     close(3) = 0

// Wait past the first SYN+ACK RTO, then release the owning MPTCP socket.
+1.5   setsockopt(4, SOL_SOCKET, SO_LINGER, {onoff=1, linger=0}, 8) = 0
+0     close(4) = 0

// The migrated request expires on its next timer and its destructor uses msk.
+4.0   `true`

------------------------------
crash log of MP_JOIN
[  280.449259] [      C0] BUG: KASAN: slab-use-after-free in subflow_req_destructor (net/mptcp/subflow.c:45)
[  280.449417] [      C0] Write of size 4 at addr ff1100010e008d40 by task swapper/0/0
[  280.449525] [      C0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc5-00353-gc27e36054537 #10 PREEMPT(full)

[  280.449637] [      C0] Call Trace:
[  280.450422] [      C0]  subflow_req_destructor (net/mptcp/subflow.c:45)
[  280.450504] [      C0]  subflow_v4_req_destructor (net/mptcp/subflow.c:694)
[  280.450581] [      C0]  __reqsk_free (net/ipv4/inet_connection_sock.c:906)
[  280.450681] [      C0]  reqsk_timer_handler (include/net/request_sock.h:137 net/ipv4/inet_connection_sock.c:1147)

[  280.454937] [      C0] Allocated by task 10014:
[  280.455381] [      C0]  sk_prot_alloc (net/core/sock.c:2246)
[  280.455516] [      C0]  sk_clone (net/core/sock.c:2488)
[  280.455611] [      C0]  mptcp_sk_clone_init (include/net/sock.h:1848 net/mptcp/protocol.c:3564)
[  280.455683] [      C0]  subflow_syn_recv_sock (net/mptcp/subflow.c:883)
[  280.455772] [      C0]  tcp_check_req (net/ipv4/tcp_minisocks.c:934)

[  280.457177] [      C0] Freed by task 0:
[  280.457603] [      C0]  slab_free_after_rcu_debug (include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6439)
[  280.457688] [      C0]  rcu_core (kernel/rcu/tree.c:2645 kernel/rcu/tree.c:2897)

[  280.458199] [      C0] Last potentially related work creation:
[  280.458426] [      C0]  kmem_cache_free (mm/slub.c:2638 mm/slub.c:6377 mm/slub.c:6504)
[  280.458518] [      C0]  __sk_destruct (net/core/sock.c:2289 net/core/sock.c:2391)
[  280.458607] [      C0]  sk_destruct (net/core/sock.c:2419)
[  280.458700] [      C0]  __sk_free (net/core/sock.c:2430)
[  280.458793] [      C0]  sk_free (net/core/sock.c:2441)
[  280.458885] [      C0]  mptcp_close (include/net/sock.h:2020 net/mptcp/protocol.c:3399)
[  280.458969] [      C0]  inet_release (net/ipv4/af_inet.c:442)

[  280.459536] [      C0] The buggy address belongs to the cache MPTCP of size 2968
[  280.459593] [      C0] The buggy address is 128 bytes inside a freed 2968-byte region



------------------------------

MP_CAPABLE packetdrill reproducer:

// Reproducer for MP_CAPABLE request token ownership during TCP req migration.
//
// The first listener owns the request created by the MP_CAPABLE SYN.  A second
// SO_REUSEPORT listener is added only after that SYN, then the first listener is
// closed.  The SYN+ACK retransmission timer migrates the request to the second
// listener, and a later request timer destroys the migrated request.
//
// On a vulnerable kernel, inet_reqsk_clone() raw-copies token_node.  The clone
// is not the token table owner, so destroying the migrated request triggers the
// MPTCP token ownership bug.
--tolerance_usecs=250000

+0     `sysctl -q net.mptcp.enabled=1`
+0     `sysctl -q net.ipv4.tcp_migrate_req=1`
+0     `sysctl -q net.ipv4.tcp_synack_retries=2`
+0     `sysctl -q net.ipv4.tcp_timestamps=1`
+0     `sysctl -q kernel.panic_on_warn=0`
+0     `sysctl -q kernel.panic_on_oops=0`
+0     `ip tcp_metrics flush all >/dev/null 2>&1 || true`
+0     `tc qdisc replace dev tun0 root pfifo >/dev/null 2>&1 || true`

+0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
+0     setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0     setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
+0     getsockopt(3, SOL_TCP, TCP_IS_MPTCP, [1], [4]) = 0
+0     bind(3, ..., ...) = 0
+0     listen(3, 1) = 0

+0       <  S   0:0(0)         win 32792  <mss 1000, sackOK, nop, nop, nop, wscale 7, mpcapable v1 flags[flag_h] nokey>
+0       >  S.  0:0(0)  ack 1             <mss 1460, nop, nop, sackOK, nop, wscale 9, mpcapable v1 flags[flag_h] key[skey]>

+0     socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 4
+0     setsockopt(4, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0     setsockopt(4, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
+0     getsockopt(4, SOL_TCP, TCP_IS_MPTCP, [1], [4]) = 0
+0     bind(4, ..., ...) = 0
+0     listen(4, 1) = 0

+0     close(3) = 0

// Let the retransmission timer migrate the request to fd 4 and let the migrated
// request expire.  On vulnerable kernels its raw-copied token_node is not the
// token-table owner, so the request timer trips the token owner assertion.
+8.0   `true`

+0     close(4) = 0

------------------------------
decoded warning from MP_CAPABLE reproducer:

[  314.661418] [      C2] ------------[ cut here ]------------
[  314.661636] [      C2] WARNING: net/mptcp/token.c:364 at mptcp_token_destroy_request+0x2b0/0x330, CPU#2: swapper/2/0
[  314.661931] [      C2] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 7.2.0-rc5-00353-gc27e36054537 #10 PREEMPT(full)
[  314.662092] [      C2] RIP: 0010:mptcp_token_destroy_request (build/../net/mptcp/token.c:364 (discriminator 1))
[  314.663001] [      C2] Call Trace:
[  314.663043] [      C2]  <IRQ>
[  314.663107] [      C2]  subflow_v4_req_destructor (build/../net/mptcp/subflow.c:694)
[  314.663213] [      C2]  __reqsk_free (build/../net/ipv4/inet_connection_sock.c:906)
[  314.663325] [      C2]  reqsk_timer_handler (build/../include/net/request_sock.h:137 build/../net/ipv4/inet_connection_sock.c:1147)
[  314.663762] [      C2]  call_timer_fn (build/../kernel/time/timer.c:1748)
[  314.668915] [      C2] ---[ end trace 0000000000000000 ]---

Ruide Cao (2):
  mptcp: hold MP_JOIN msk ref when cloning reqsk
  mptcp: fix MP_CAPABLE token migration when cloning reqsk

 include/net/mptcp.h             |  7 ++++
 net/ipv4/inet_connection_sock.c |  4 ++
 net/mptcp/protocol.c            | 31 ++++++++++++---
 net/mptcp/protocol.h            |  4 +-
 net/mptcp/subflow.c             | 35 ++++++++++++++++-
 net/mptcp/token.c               | 68 +++++++++++++++++++++++++++++----
 net/mptcp/token_test.c          |  4 +-
 7 files changed, 137 insertions(+), 16 deletions(-)

-- 
2.34.1
