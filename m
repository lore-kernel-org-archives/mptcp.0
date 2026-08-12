Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E233D4F0
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517755; cv=none; b=i57vEzqC01V7HY9q3rIQvMieeMetXODZcvLTAI7Ha74sWiS74gRyitciGBOWaqiLn72Etx+OKmn/NgfccMSNvYepvm3DT5LBzB4SleZscJsso/kMmw7yBBvF7cgm/Ugg0acy0en0VFEOPyE/Ngb552TboDiSoILRW0YgdGMhlFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517755; c=relaxed/simple;
	bh=d+hGvlft1GXVevQ36GlNl9i4MU41Hi6k1dGK2AeP1qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3CR0MtVt3h+tjAPloVib7PZMMqdbr3E8fyfn6u9KkTfrO22iaa6osdeBo5uJrSNltfIAmmXbVPRNVrfDcbIqbDHH8Y9QGBfR7NDBbjy5g/3I4/555G4pNSnilj90YK9z7IShZyPtjHylJGQm5h5ZIdYsihT74EKFR9Fh7IwXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=c0Q8LgR7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="c0Q8LgR7"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf50c6f235so10377735ad.0
        for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786517752; x=1787122552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NJNNWT6iByUpyruOEy/sAQL0kaUqK3YMB0wE0k8+1dw=;
        b=c0Q8LgR7nZOsf4c1NV8OwsweX4ppmHuPfAZo6gfPzGRMky0gOg5qLCD6xXQBFsIeCn
         Ct+t6lYK+ZAXOJ+r3QsGXmaSKJmNv7CSgJChEfAJr9FNiuiCW/mMyC//J2yM9+jl+H4P
         X8CmvolBibFlPY89gM7OiLWGfr+PpSLQSlUPLwn9R6dhe4Lo/WRDCf0MpxGMNJ4H0hcC
         Q7yGDeMDQNk5hk8OVqyRZfMh8+NK8NoTdk1uQUKMhyMYDK8Ilc6jv89nyJkPln49EUkc
         arS/S3JsjcjNtLJ3vAbI/u5CML18ZPg6vFwNOd++Wh/F8gnRgDk4JBrE89rKm+PDMgwe
         Xlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517752; x=1787122552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NJNNWT6iByUpyruOEy/sAQL0kaUqK3YMB0wE0k8+1dw=;
        b=TKXABdxY3kcDHRtaFf86NC8CdjJ2Z3PE4iBffJJtm9U+SH84feoHtqnlCA54/bMimJ
         xQgI9UKzSEG6dn1TtZaJo/qkm8H9HCw6+lT8Cq6p93ktOj1CyGwzdttR8CfcrlcM7JZ5
         ex/ner83b85RVRuRh9kh+xVFTOZkuBzJh2gAVY+i6nrGLJM3X30hD/5EuIIpE9FUSxFX
         XJ0ghbRDk3nWjivGs79sfXG7DKNyfbID0NF2vFqnKtvA28NIBtp7vHjGbJSBjFI7l2p+
         M7T0CAi9aGhrb5dfeH8Kj93U8F26zIwhMKJZBdnWfosqQY1fcl4atiLIeqNVZkTvOAJQ
         fRzw==
X-Forwarded-Encrypted: i=1; AHgh+RpwpxsACoV6y976oHrys0zRcLM8YvLYKzI4jo0VU4a4927/WYQPb5CrHfn6IyyGTTh7VWwlXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjkuPX1nPUUa4OwXsprAfckmDPnChBRQdk/6c13qYBhNy/J1lM
	hgYrBd7RMg+9VXvoMK090Fu7jstkTCKBkFZCKhLO/7FYtFm3ukyEybr10dH0Gos9lx6x
X-Gm-Gg: AR+sD10h3D3UUz4iHtXId91H9CdKF4GA2CNwGnbaCw3D+zRsb0Hoe4bAVa5CmKoBrDu
	CQC6xGcjZhrPndQmoRpGJTPT7na0GA39+oL1gi53jMO2QNNhuyJskreCOgHEqn59mnWz5Ca+JVy
	RgPxvIc3JTqM9U2Mo9HPs5ovbPsfm4noDyj5cXBJzlX3kSxA9uG0cvJluYCYgfcmDx2YRKNflRX
	6m5zTmylH6XMoLH4MCg4mL37UzWsobg+uHor2bPNdW4o33AOlrh/Eo0WmOgVoju7cJplLEM9M12
	AMgmmA16SOxjMKUop0l0wCSIdiBDvve34uNAtELjRNiKoXjz1h0xBKWOCmYPzeRjCDpKGNALtWH
	qNz5lNEj8PRN4wFr+ygJ3rgoOHh3+1qLkafnf6k2qV0lKaSO5ivOWcnaupC/dOAwzxPMYHIhvV7
	98fVrxwjsBhT0Q3yhvRQncO8PyGpCrCLl/gJOoGkg75Ra+ezl4U/G1UDXEDPdPpBbf25cUFQ==
X-Received: by 2002:a17:90b:3f85:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-393012c974amr3318496a91.10.1786517751853;
        Tue, 11 Aug 2026 23:55:51 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8d00067sm2546980a91.12.2026.08.11.23.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:55:51 -0700 (PDT)
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
	kafai@fb.com,
	daniel@iogearbox.net,
	kylebot@openai.com,
	david.lee@trailofbits.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 0/2] mptcp: fix request migration ownership
Date: Wed, 12 Aug 2026 14:55:44 +0800
Message-ID: <cover.1786497414.git.yuantan098@gmail.com>
X-Mailer: git-send-email 2.51.0
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
Some MPTCP request fields carry ownership which cannot be transferred by
a plain byte copy.

For MP_JOIN requests, subflow_req->msk holds a socket reference.  The
clone inherits the pointer without acquiring its own reference, so the
original and cloned requests can drop the same reference.  Patch 1 lets
the cloned request take an additional reference.

For MP_CAPABLE requests, token_node belongs to the original request and
is hashed in the token table.  Copying the node gives the clone invalid
hash state, while concurrent request migration and RX processing can
observe different owners in the ehash and token tables.  Patch 2 moves
token-table ownership from the original request to the clone under the
bucket lock, and makes token acceptance and destruction tolerate a token
that has already been removed.

--------------------
Changes in v4:

- Rebuilt the series from the final v3 patches.
- Kept MP_JOIN and MP_CAPABLE ownership fixes on the MPTCP request clone
  path, matching v3.
- Replaced the TCP-only tcp_done()/inet_csk_prepare_forced_close()
  failure path with MPTCP-specific clone teardown.
- v3 link:
  https://lore.kernel.org/all/cover.1785995291.git.caoruide123@gmail.com/

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
 net/ipv4/inet_connection_sock.c |  4 +++
 net/mptcp/protocol.c            | 31 ++++++++++++++---
 net/mptcp/protocol.h            |  4 ++-
 net/mptcp/subflow.c             | 13 +++++++
 net/mptcp/token.c               | 61 +++++++++++++++++++++++++++++----
 net/mptcp/token_test.c          |  4 +--
 7 files changed, 109 insertions(+), 15 deletions(-)

-- 
2.43.0
