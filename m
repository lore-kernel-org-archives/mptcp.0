Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F047F2EB
	for <mptcp@lists.linux.dev>; Tue, 15 Sep 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464930; cv=pass; b=LoyzZSCpmb+lUo1Xh00Ve9tXCbjSw2VBluoD1BYxHLeGUxfi5rwcd4nWvn1e8hB4Jfwewt3UOxFNZ9LfHddQWN4QK4aFQ0aQjrMJfP+9E4K5IU8kSZCJmpLwHqEwX0nS/8n+yr5vOejo6r2vtNd4Os7XOfRGM+5uSanRULDGvro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464930; c=relaxed/simple;
	bh=cR+Y37y8jeWsJ+Pah2puHpKj5qmxPiSmcffs38Ojqbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsArmmgRNxBuXwJ0hM6hNc0sp7DVfKKhlGGmodyzRUcZdiTfLDP1WXkSOpbBtMd0XMTnARQjy3lxYK8eTWoelkZt9GT82nVf7JeKA8B9zCRqrwaZ9gOcbGDZUaojvakZnr3V+2o9YZap+2NrS9zHSwWdSkqIeaiVL8822M4WqtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=Ga7oyu/p reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="Ga7oyu/p"
ARC-Seal: i=1; a=rsa-sha256; t=1789464920; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ag2z0QaOMSMl60FTlpS25IGWhpTVfkMmaNxBVrPfnjTLkCZIXIROlQI0K4cTpUcSwYj96gAUs2V5jP5rSI/9duLiB5d+86Ge6Pycux471cYYtHn4vumaB5rC/JCm04/A9SXeTj4EEZKYu6ec9AKsutSXynqtSSfiSHSi8r3Sqh8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789464920; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l8Ks36IyVXE+Piv6lhuV4Wb+WDMzWwvGQytwsjP50t0=; 
	b=jjioRJKn0fAbV98Tpli386kPjXi8senP1lWpAyfZ66+4/3BCMt/U28eY8mJnnrQULQr93Ld07NsKjiY9+gc3Qw4KPJ/4FCtFxGoi1BV3RfXj4HLyYKBoqg7eIDf1vdogQxYBAxqt2dCsPYjG6fSbC0O/rHDxpZno8avn/Kb0/lU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789464920;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=l8Ks36IyVXE+Piv6lhuV4Wb+WDMzWwvGQytwsjP50t0=;
	b=Ga7oyu/pLQ56OjWS+9yz1uSHTbrLn33C+oSO0LETdfelJFjofnqcTT0Qf8jtd9xU
	ymeJdTufVMoTyppE0GhlowAkijBvj1rVakc3vBLDNOwcIDX+W6VTOoXpVI0AbQVGtkj
	M8yXrnYycazh0+G6iT1yQ4QtO+wtRvVhIJ17tsb4=
Received: by smtp.zohomail.com with SMTPS id 1789464919609231.85398446682348;
	Tue, 15 Sep 2026 02:35:19 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com
Subject: [PATCH mptcp-next v5 0/2] mptcp: sched: let schedulers mark a subflow to avoid
Date: Tue, 15 Sep 2026 15:05:04 +0530
Message-ID: <20260915093506.465110-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The core benches a subflow via the "stale" bit after
net.mptcp.stale_loss_cnt retransmission intervals without progress.
That bit belongs to the core and is tightly coupled to the RTO: it
gets cleared the moment a packet is acked on the subflow. A packet
scheduler has no way to bench a subflow for its own reasons, such as
too high latency or instability, and keep it benched independently of
ack traffic.

Reusing "stale" doesn't work, and "scheduled" doesn't either: the core
clears it right after every send/retrans pass, so it can't express a
standing "leave this subflow alone for now" decision, and nothing
outside the scheduler that set it can ever see it.

This adds a scheduler-owned "avoid" bool that stays set until the
scheduler clears it, is honoured by the default in-kernel subflow
picker on both the send and retransmit paths, and is visible through
MPTCP diag alongside the existing BKUP/FULLY_ESTABLISHED flags.

The avoid state is kept as a standalone bool instead of using the
adjacent flag bitfield. This avoids a race with
mptcp_subflow_data_available(), which clears map_valid in the same
bitfield from the receive path while the scheduler can update avoid
from BPF context. The avoid accesses use READ_ONCE()/WRITE_ONCE().

The default in-kernel subflow picker skips avoided subflows for both
send and retransmit operations. Custom schedulers can explicitly
honour the avoid state according to their own scheduling policy.

The avoid state is exposed to BPF struct_ops schedulers through
mptcp_subflow_set_avoid(), and is also exposed through MPTCP diag as
MPTCP_SUBFLOW_FLAG_AVOID. The kfunc is marked __bpf_kfunc so it remains
available for BPF BTF resolution.

The BPF selftest uses per-socket BPF storage to track whether the
avoid transition has already been performed. It waits until a second
subflow is available before marking it avoided, then relies on that
state remaining set across subsequent scheduler rounds without
calling mptcp_subflow_set_avoid() again. The test validates the
avoided-subflow behaviour through the existing data-transfer and
per-address byte-count checks.

Probing an avoided subflow to decide when to clear it (mentioned in
issue 348) is left out on purpose: that's scheduler policy, not core
mechanism, and belongs to whoever writes the actual latency/stability
heuristics on top of this.

Patch 1 adds the flag, the kfunc, the default-scheduler enforcement,
and diag support.
Patch 2 adds the BPF selftest exercising persistence of the avoid state
across scheduler rounds.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

Kalpan Jani (2):
  mptcp: sched: add subflow avoid flag and enforce it in default sched
  selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

---
 include/uapi/linux/mptcp.h                    |  1 +
 net/mptcp/bpf.c                               |  1 +
 net/mptcp/diag.c                              |  2 +
 net/mptcp/protocol.c                          |  4 +-
 net/mptcp/protocol.h                          |  3 +
 net/mptcp/sched.c                             |  6 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 15 ++++
 .../selftests/bpf/progs/mptcp_bpf_avoid.c     | 87 +++++++++++++++++++
 8 files changed, 117 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c

-- 
2.43.0
