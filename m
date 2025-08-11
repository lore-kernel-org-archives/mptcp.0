Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCF311C16
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933492; cv=none; b=VN6EbREMyPm1t7/k0Jvlcz2t9CuyWjfYRieKpKsuzRhCCQ5f3ZFWGcN0RB+RteefCAijX//Fh5oZAN9OoaEpKeV0Dlf+9HujeLX0A4FfoDp9sibXVW8DQ0lLDL7jkb76z5HPkWG+1t06MHeJa6+AgynOZHyDi4FOumI14zZBkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933492; c=relaxed/simple;
	bh=wjBddw33igPbjaGFSG/M03kBeoib+ICuiTs+4RgVDNw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nihucfcje0sgdISZfRf53qnO+Ff0gNTmeH6nYZ6yXUHM6Kc5ZdgO8CfR0bypxY/cGzAXFYipJR4ZhilkchDQFI3vDJhXN70D/oUgAKCZI+E6H6gXZbiUj4pTxPqRL+rikNHXsVMHW5QwkmZb9H1oEeT1ZYdtPDepP/BanGQHmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4l/N6F+M; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4l/N6F+M"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bef13c254so5074629b3a.0
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933491; x=1755538291; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZTb4ZYMYPpk1ACseddHrcz3FiaeJvW+qXE8HO8bxlXA=;
        b=4l/N6F+MGqADhgwppGIZVYqWL+QOCe8SfY4PpPkSRVjJJagFJrZ/kI/1+rnSl38ByR
         9oKERk3nRvYCpDL4BuJI6vs+HNapkLA6EZHA7f3hbVYEHIs38VDpQBnR1Ljtb3Ow0kdW
         9dYTJ3+w9zLRwAcHXbqwuPftvpdjnRjAvahozTzNOw28v6p0wXBls8HcesbnkBGZNrX6
         dKkkcoLLH4nNOuJnaMlX1Y+9+/0CT7PX+m2r8/ZZz7BtYBbQDVSi4cPaBFKmPUga9WJ8
         0JfMd5etmmtIkZx9Bq/0HmQRgiXQ4ir8wiN8lIZJIh6UiWkCCX2dfYFivDpDUK7ASdtd
         zfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933491; x=1755538291;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTb4ZYMYPpk1ACseddHrcz3FiaeJvW+qXE8HO8bxlXA=;
        b=W2nFKO5sVD6kK4W7EYRP4FgI1PFTBvAcX+1EN6KMOx3O9fGGk6N8BXf9uQ+pXYzhHE
         ijZddCToB/vKYqHJA03eIT9BJnMQrSraPcL6Lf4vyz0Syu6BDQwKLehIXOctuCAiG+Q5
         3fAQom9luqWCUvUDLZ6hfAdXXqGGBq2GrxSo2rfEad/8yaFj+zyFLRl508smw99tFVIQ
         VHFUmP4KDwUbUWpu34Tfgy6MqSK0bjBw9kIvgiYotV7/7BhIJTxpVUnzTzwfz6iddnLl
         /k/Ro0R1smeh4WzUkTveY1UeunvHd4CJXGS/GtKuoDFD/G3wDbnDFUE1LNVk4XXQHkCB
         feWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2VjBAVk/q1oF0UVYUbE2ebBdl8WdudAlDFQswiPDktFgF9fBOK76xN87qc3NDpkQudWVGoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxT4zVoO+k+Jihfzte3mYjx+lusZSMAfhtPUHumlrmtsG+GzUOH
	rRzEfcFfmnPGZLvFkNa0zBsa9Va0zop5CGyrP5o/STz6DyclsjBXGnmk0NBgGQ/4iiRepKiVro+
	ecmOnBA==
X-Google-Smtp-Source: AGHT+IGKr6oqVCjBFIQc4hDZq54MhrQz3SYGcbPyQOfRTd5efyFcfkryP7IWXH22Nn+DBiaaLRdr8LG3oKg=
X-Received: from pfll28.prod.google.com ([2002:a05:6a00:159c:b0:740:5196:b63a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:401f:b0:238:351a:f960
 with SMTP id adf61e73a8af0-2409a4ab650mr442290637.23.1754933490717; Mon, 11
 Aug 2025 10:31:30 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 00/12] net-memcg: Decouple controlled memcg from sk->sk_prot->memory_allocated.
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
  v2:
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
 net/tls/tls_device.c            |  3 +-
 13 files changed, 253 insertions(+), 99 deletions(-)

-- 
2.51.0.rc0.155.g4a0f42376b-goog

