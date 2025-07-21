Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADED23B639
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130189; cv=none; b=iLOpDHxy7HV7BvbBshuyYTMxrtHaQSONgd9qe0ksMXa0okTxRrBTP+LtqhRKTYAB+1jgnR47GpmiRDPbrt7EQdYqqiN7xHkJSboQw1WJPuJSJIw8teSvH9x+gdhpLsnVw3YCsBA/tEdE1iSsQ5Q2mt1DicsmtXJUR9rFbDy1Kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130189; c=relaxed/simple;
	bh=Mf+wXwtqiNBJ220Spx55PfcTo/VnsTRGv6hporKbrjQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nfCqA7e4BOlt8DzEbZklT9L8DdU9TNqmPo2xO4f4VnvYcHYncXmakpfEXJmszAkt4kdKnvR/rHnRqN6Vs9mcOduJWB6/VA7XHd4ezWdl+0H07uBVPTkEW5bXRG+WrUdFxpUL7WMBNMW+1GWmA6JHdASqhtpNoAnbFmvLwYVcpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mfi5kRav; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mfi5kRav"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3642ab4429so3295888a12.0
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130187; x=1753734987; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=51pOOLX0fQOfAGdnQSkiq2EVyVpnq9ZJH4RYM8SkY+0=;
        b=Mfi5kRavhg5NzaQs/r59SarRmZJGDtjvBxSW9elrOJZ5c6S6TAa83KgaVzXaXAAgat
         6EA4TOL9CbpmXVvRCrhpR+UxuH60YRrG1QZVaPLOTioO88iz6dQzVlwWs9zPuIQMsXc4
         hzY9Yp8sIaAwcOwTtSbvNPBXONX445E21m45xLl0dNla7kcwFemnM0yUays0sTaUqsoW
         a7ePTQOjIhNhkOpUELq3rv68nB7+XwWr6161kOGPBIITigKWdLFGvxb3iP/9dDPIC4XH
         NT4zLzUV+8ascPfR5zFwmgt5J1ZURr0Om+IdC/TfZG/CcrLifuqk0wFYUmVvZMPs7yUE
         A+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130187; x=1753734987;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51pOOLX0fQOfAGdnQSkiq2EVyVpnq9ZJH4RYM8SkY+0=;
        b=uT0n7kTxWZgtuTEVBzUHsCV+G6/urvtr2zEFjvGyc64DA3TWRCA3T8qZDf4YIefx8F
         sDXUJVqWvNREBJ6bZDHje/8nasZ6jynKvPpvVxJ8/QD3pNJFUuW5biJHO0IYAoqHJhI6
         8ENk7WxfJ25B71PoO/FuKZUiWwq9pUofDtjCAPah3JoI7uK5JHRy7lJOeCJeiSAQzHgr
         0GGBChDyEeMSazxDKFRwfrtakE77LHAoO9aCazrzLYXNQiLxpCznZCq+KmgJ1JQm8oPE
         PfZM+sAQS3y47A6STAkg7YxISg47YiJaCdfDI1qlX1hWjig+k9RMPLBEMb2qUwJHiRg9
         mtew==
X-Forwarded-Encrypted: i=1; AJvYcCXRbZU6GS8MmMFMV7Ia3bDAyhsaM32rCyIcDGZT9FmSB+jWHT3mzCOJEGcS8GGkxTFQEHR6rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvP6SCo1YzmdncOQ7uXPP83w6iIMzZXhGhtqTn5294Z2GmTb15
	/9D0xK0W2sxkJSSUNfAMTMJl80zOUUAxSf5VKmOUOeRG2aSdDXfD/dOtBnUuS6aLrpLIJ5Eq1rq
	0xoIvWA==
X-Google-Smtp-Source: AGHT+IGVZNNr93fPRWqdHxWab0gu7wbq9VcEZmziUgmJKmb9TSvPtgxLvPeY0lMsvl6TgzUysEMGklwL2vA=
X-Received: from pfbjc22.prod.google.com ([2002:a05:6a00:6c96:b0:747:b6ba:35b6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:ae0a:b0:238:f875:6261
 with SMTP id adf61e73a8af0-238f875633dmr23007475637.23.1753130187000; Mon, 21
 Jul 2025 13:36:27 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 00/13] net-memcg: Allow decoupling memcg from sk->sk_prot->memory_allocated.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Some protocols (e.g., TCP, UDP) has their own memory accounting for
socket buffers and charge memory to global per-protocol counters such
as /proc/net/ipv4/tcp_mem.

When running under a non-root cgroup, this memory is also charged to
the memcg as sock in memory.stat.

Sockets using such protocols are still subject to the global limits,
thus affected by a noisy neighbour outside cgroup.

This makes it difficult to accurately estimate and configure appropriate
global limits.

If all workloads were guaranteed to be controlled under memcg, the issue
can be worked around by setting tcp_mem[0~2] to UINT_MAX.

However, this assumption does not always hold, and a single workload that
opts out of memcg can consume memory up to the global limit, which is
problematic.

This series introduces a new per-memcg know to allow decoupling memcg
from the global memory accounting, which simplifies the memcg
configuration while keeping the global limits within a reasonable range.

Overview of the series:

  patch 1 is a bug fix for MPTCP
  patch 2 ~ 9 move sk->sk_memcg accesses to a single place
  patch 10 moves sk_memcg under CONFIG_MEMCG
  patch 11 & 12 introduces a flag and stores it to the lowest bit of sk->sk_memcg
  patch 13 decouples memcg from sk_prot->memory_allocated based on the flag


Kuniyuki Iwashima (13):
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
  net-memcg: Add memory.socket_isolated knob.
  net-memcg: Store memcg->socket_isolated in sk->sk_memcg.
  net-memcg: Allow decoupling memcg from global protocol memory
    accounting.

 Documentation/admin-guide/cgroup-v2.rst | 16 +++++
 include/linux/memcontrol.h              | 50 ++++++++-----
 include/net/proto_memory.h              | 10 ++-
 include/net/sock.h                      | 66 +++++++++++++++++
 include/net/tcp.h                       | 10 ++-
 mm/memcontrol.c                         | 84 +++++++++++++++++++---
 net/core/sock.c                         | 95 ++++++++++++++++---------
 net/ipv4/inet_connection_sock.c         | 35 +++++----
 net/ipv4/tcp_output.c                   | 13 ++--
 net/mptcp/protocol.h                    |  4 +-
 net/mptcp/subflow.c                     | 11 +--
 11 files changed, 299 insertions(+), 95 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog

