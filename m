Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C002FDC25
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021537; cv=none; b=ChqM+0yf4kmdrNL7+bMjrn74tzeI89wodE+8b74mGpjuWvtQzBqWyILctZvv1EhdQ0xd0ABwxYPRM1sKCPtAGy6n+Tp7WAEW1QDsQX3kAxWApKkso8GyXGf8q9zZCkvNu6sqU2SjIEE4Sq4qeh0+iRf5jXGYfEPQt91IvD+tDZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021537; c=relaxed/simple;
	bh=BBdOvE2AriIw5xw28ETj+/eLrI0VWJQRxeJ5yHjfv94=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PLGqRkI0WokObASV1J9E660eIRyv861qcZ7Z71+DuHdk3IQnudPIH65a0FM3/jdPrMxYcRFhSxY2lVXI3mrK4znPUpWcsgDrqv9P6aSC8NMgPTF26Jj6lCDxNdbZc+g/7VeCrLif2Yq8E4Al1FBkz+eDufx71EM7zVXQWh454mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y8nu3vB0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8nu3vB0"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bb73b63d2so5951949b3a.1
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021535; x=1755626335; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r2V1v9VHmhBBpIoyn/8bp16McXh5rwC69+hYhu5VhtU=;
        b=y8nu3vB0k+56+xOnqnUn43VNpBbR+GMlHuMiH2YslbF6SqvkUWyOsUtYhsRbQRxWY7
         5qBBq6WMFfhva8QC5fgHexpf2h0SPrTbqmTz6H5UcaJZ+Ofq7BELi/fQDZcirMcaTBwt
         JQ986Ce+bFsUgID/wwgjgd59H90iHHrqXE3Hr4IiT7j599eYpLrfxqsd3B5MfcXvAAli
         anvBsEYLoOS4qkrnT+Djvfu3ZpV2zWCJzICpaotaFT7dthcQQa8WuR+sZB9lKlpUkSLf
         UFJHbJ1keMjIR5mh6HtXbx1z4YkfzGehGPA36Wf4lLXVDr2we+62S+m6jZqDibTaU/fk
         f3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021535; x=1755626335;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2V1v9VHmhBBpIoyn/8bp16McXh5rwC69+hYhu5VhtU=;
        b=gVLCDBZB2S1dgKGOWNX/KTGWMWALHhidzt4NA6iAN9PBASX2EuKNSOJsU/PIqRy1Sb
         6jUYhuNQVZ1m3VEsi/yPWhb0RFCoCqLZnBzB0zyghTRhMHUuWqALfIvA2SODJFgEV65C
         n2PHJPLFBuLeth/RCVQ53/zatbJTDFI65HAN9szdcQg0LA1F2OAA68j07BDFOmd05E9H
         jnrxk9w6oPuFqnp9O9Jbtk/ncGqMwMrOHHQqYueidFEbL4MqwWLVzImw6nTHG/tpjg3W
         u/1i9IqKLDMcOCIFGB+Kl3ELn7PpKE8VzojrGn+RaWbZ4rGpNAf9Ud3QfSxkBTAl2aiw
         z4zw==
X-Forwarded-Encrypted: i=1; AJvYcCXIPKOU5Yh9TYMQyTMq4zrp7m0dR9slXI/Za+y+wmOIuSyB0cvZGKKcWYeKOeT5TPpVqmSbiA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywm8Bz+T7lQBi91pJ+DHK+xAcDcsESgPxe3AI3w8mkrqtdZW+Ej
	gg8KKboTbg5DZ7JsrTNznvX+fIeOzBfJcXzLEY2LEIpWoTgVo89ReF/BxNiXetMSA1aZOUlG1Y6
	7+2+Whg==
X-Google-Smtp-Source: AGHT+IHpI2A58X7fiHu4X8DLCY/YyPjXlJ8KtqdQYuS0Jk77Gj/N6hjXCZ5aN91Gfz65dY+Oy92efigaL18=
X-Received: from pfbde4.prod.google.com ([2002:a05:6a00:4684:b0:740:5196:b63a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:939d:b0:240:1119:d70c
 with SMTP id adf61e73a8af0-240a8bb39dcmr219488637.44.1755021534987; Tue, 12
 Aug 2025 10:58:54 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 00/12] net-memcg: Decouple controlled memcg from sk->sk_prot->memory_allocated.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Some protocols (e.g., TCP, UDP) have their own memory accounting for
socket buffers and charge memory to global per-protocol counters such
as /proc/net/ipv4/tcp_mem.

When running under a non-root cgroup, this memory is also charged to
the memcg as sock in memory.stat.

Sockets of such protocols are still subject to the global limits,
thus affected by a noisy neighbour outside cgroup.

This makes it difficult to accurately estimate and configure appropriate
global limits.

If all workloads were guaranteed to be controlled under memcg, the issue
can be worked around by setting tcp_mem[0~2] to UINT_MAX.

However, this assumption does not always hold, and processes that belong
to the root cgroup or opt out of memcg can consume memory up to the global
limit, which is problematic.

This series decouples memcg from the global memory accounting if its
memory.max is not "max".  This simplifies the memcg configuration while
keeping the global limits within a reasonable range, which is only 10% of
the physical memory by default.

Overview of the series:

  patch 1 is a bug fix for MPTCP
  patch 2 ~ 9 move sk->sk_memcg accesses to a single place
  patch 10 moves sk_memcg under CONFIG_MEMCG
  patch 11 stores a flag in the lowest bit of sk->sk_memcg
  patch 12 decouples memcg from sk_prot->memory_allocated based on the flag


Changes:
  v3:
    * Patch 12
      * Fix build failrue for kTLS (include <net/proto_memory.h>)

  v2: https://lore.kernel.org/netdev/20250811173116.2829786-1-kuniyu@google.com/
    * Remove per-memcg knob
    * Patch 11
      * Set flag on sk_memcg based on memory.max
    * Patch 12
      * Add sk_should_enter_memory_pressure() and cover
        tcp_enter_memory_pressure() calls
      * Update examples in changelog

  v1: https://lore.kernel.org/netdev/20250721203624.3807041-1-kuniyu@google.com/


Kuniyuki Iwashima (12):
  mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
  mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
  tcp: Simplify error path in inet_csk_accept().
  net: Call trace_sock_exceed_buf_limit() for memcg failure with
    SK_MEM_RECV.
  net: Clean up __sk_mem_raise_allocated().
  net-memcg: Introduce mem_cgroup_from_sk().
  net-memcg: Introduce mem_cgroup_sk_enabled().
  net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
  net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
  net: Define sk_memcg under CONFIG_MEMCG.
  net-memcg: Store MEMCG_SOCK_ISOLATED in sk->sk_memcg.
  net-memcg: Decouple controlled memcg from global protocol memory
    accounting.

 include/linux/memcontrol.h      | 45 +++++++++-------
 include/net/proto_memory.h      | 15 ++++--
 include/net/sock.h              | 67 +++++++++++++++++++++++
 include/net/tcp.h               | 10 ++--
 mm/memcontrol.c                 | 48 +++++++++++++----
 net/core/sock.c                 | 94 +++++++++++++++++++++------------
 net/ipv4/inet_connection_sock.c | 35 +++++++-----
 net/ipv4/tcp.c                  |  3 +-
 net/ipv4/tcp_output.c           | 13 +++--
 net/mptcp/protocol.c            |  4 +-
 net/mptcp/protocol.h            |  4 +-
 net/mptcp/subflow.c             | 11 ++--
 net/tls/tls_device.c            |  4 +-
 13 files changed, 254 insertions(+), 99 deletions(-)

-- 
2.51.0.rc0.205.g4a044479a3-goog

