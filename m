Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71E242D65
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202157; cv=none; b=uuIq387oTQEc2FqwEOHVzo/qexVQR3FnK/hcBd9kRA60UNviMqBSoA9xLeXk2sd6wScfFBIICMvrBWNsQccJU2jOyhSQzl8v1D+isDHypdQHAynNzGh3Lt8fEEd26xE6ea8Kvm+LtnaJ4YIu8krkKFVlg6rUoZy1gkn6yi4GoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202157; c=relaxed/simple;
	bh=XRFloEn6WUdoHP1BiKO+9NyjAYqAlyAeTcjtp3BnPEo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cbxKnLBWnfF7FCTXP/kZT+eq05UmtbH6Q3FbZaPWWmFcckaiK5s3tJbhmVy2h2FEZpktfSYxDMGoV9qdhhf/ODzRdauQajgTSqJCevhJQJpPtwQyhiSeQ51Md0PsmDrtjN2XQAAAER/z+XSZYv6/bDlR9+tPqlKmDvWtyVGSP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E07Vl7BZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E07Vl7BZ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326779c67so1319730a91.1
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 13:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202155; x=1755806955; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HPx3oS3D/U5/Z6SJp4+G98+eGPb8Zkxs9lelPKWCUiM=;
        b=E07Vl7BZv7d7GLZRUGGicJU1wznBVUorruK6qysb09T/9mp2fglrJIXLQeR6SpYG7g
         +Y9y6M3Xag9TRjN/zHXPD54rUo6yLtirzGsnuItO4qmVtopgD6k1LDaInzSyCC3IXehD
         GXkGZbDI+aMNfovQ9GvnhecxjGMA/6m1FCMA+puoIeat69daYHDBF2ikaLr18guQaNrE
         Ul27tcct6MVNHCDdsR1WVaGXCCQ4R1A04QzEGTk5yj484oP3PjDRwZ2Q91c+Gm3tYlyR
         HNIByZaqVWUqMGaV58SRz2vzIM3MoqT60YgcBIzc8Otz+GbDnpxhBp/A98jloz5WukUS
         ZOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202155; x=1755806955;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPx3oS3D/U5/Z6SJp4+G98+eGPb8Zkxs9lelPKWCUiM=;
        b=Av40OUlWL+pFAmHrwre8ZhcTA00dGt41Je5TUbx+b3BDfscwxlz8h/hjnI2YVEMZaJ
         xSy7x4s3h2MpPRdLqAHSpVa1BrstVT/vYJ3kfmodU/mJDliGPZ9v7kWa0BETMiyGQHOd
         +vC2cUqPJR8B/gYy3wcjiI0og15iIqEAn00FQNildfmPI7NG6nbPMBb/n0HqQXnPvqU1
         xMWbUs/EJrrribOD20WRnI5SUFMfcrJwCC3N6NApNdHQMfAkUAOLy4FHm7Q4oymGVgHH
         2ImX2QNOanpHZD5qIDLdk/Ijyvf3rpNWK8IqfJUQrzAgmAnMvMtUqSwHG5FICa9xJUIX
         S14g==
X-Forwarded-Encrypted: i=1; AJvYcCVJi+CJBLQDUGm8zPzcfPqdBMU6B+SXFM17J+3wb/DhFzJoCl1TGvzZ5QhE8GrUqBwVSq0XVA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkxn4VAkPqpn1bXf43An4x3NUvXBEajm6Wd/zKH5A5H03zTU6B
	XW/gL3GMJqPyVVi675zsZAjbAEdlq2qQB7sT/M6ALUPiaOOGM56sYlpIZ5vl+6bet45kNfN6ulT
	MNNmyCg==
X-Google-Smtp-Source: AGHT+IHoeO4kZujSsChFOwaTNJ8uA4UdHGwa9a1sAiH+eAKhd1r6y1himci0q94O8Kz1fkx16/6OM5R2r0A=
X-Received: from pjbsy14.prod.google.com ([2002:a17:90b:2d0e:b0:31e:c1fb:dbb2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c2:b0:31f:6d6b:b453
 with SMTP id 98e67ed59e1d1-3232b7b76damr5551630a91.30.1755202154816; Thu, 14
 Aug 2025 13:09:14 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-1-kuniyu@google.com>
Subject: [PATCH v4 net-next 00/10] net-memcg: Gather memcg code under CONFIG_MEMCG.
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

This series converts most sk->sk_memcg access to helper functions
under CONFIG_MEMCG and finally defines sk_memcg under CONFIG_MEMCG.

This is v4 of the series linked below but without core changes
that decoupled memcg and global socket memory accounting.

I will defer the changes to a follow-up series that will use BPF
to store a flag in sk->sk_memcg.


Overview of the series:

  patch 1 is a bug fix for MPTCP
  patch 2 ~ 9 move sk->sk_memcg accesses to a single place
  patch 10 moves sk_memcg under CONFIG_MEMCG


Changes:
  v4:
    * Patch 1
      * Use set_active_memcg()

  v3: https://lore.kernel.org/netdev/20250812175848.512446-1-kuniyu@google.com/
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


Kuniyuki Iwashima (10):
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

 include/linux/memcontrol.h      | 39 ++++++++++++++--------------
 include/net/proto_memory.h      |  4 +--
 include/net/sock.h              | 46 +++++++++++++++++++++++++++++++++
 include/net/tcp.h               |  4 +--
 mm/memcontrol.c                 | 29 ++++++++++++++-------
 net/core/sock.c                 | 38 ++++++++++++++-------------
 net/ipv4/inet_connection_sock.c | 19 +++++++-------
 net/ipv4/tcp_output.c           |  5 ++--
 net/mptcp/protocol.h            |  4 +--
 net/mptcp/subflow.c             | 11 +++-----
 10 files changed, 124 insertions(+), 75 deletions(-)

-- 
2.51.0.rc1.163.g2494970778-goog

