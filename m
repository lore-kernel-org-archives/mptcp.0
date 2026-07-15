Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B693433E7A
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110325; cv=pass; b=UnioPjRk1R+z7kA9MgRr8ywuctIMqH1VDpZvjoaLWl+oWxAfusgffzDho8oix+RUO5ImnpI5gRwgxOaKspi+kNGhRq52GCQKyfZYyqgF8U4GJrUPCeCVKlUfqaw8cdVePCU+h+fuhWyPWKuHbpFJPj3NsqBg1KKn1G3WaNXDpd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110325; c=relaxed/simple;
	bh=P/gAkw6ll+apph4iD8P6/SXA9u2iBro0y5O7IINAIs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GobisFW9jlLELcABA3QIESwQuePim/I+qsBjGM9fx4SGMnKECu24P5Xom3SH3e/EIbg0UcPr+X8+e3Y1VJHK0+LGlaM0fNNeoCQhgDSBFNKUPJ/QbcP/YLNY65jVuF+6BXPPJ+sqzEx5hpwgRgwhBKvJCfbUHZs6QFv9LyMjaNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=bD+DDUtg reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="bD+DDUtg"
ARC-Seal: i=1; a=rsa-sha256; t=1784110319; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bDcO8dc8xHMRhxr+q/Uj16NodWVrdUsgIHQUVg8mG61uep+bRJUFdjC/1FAF/U6ofbMDti6wYHI7NJAdyQR+tdb1nwuUOthvxZrCNytVmlgtjHEx6oJNvWbByBgDmJmVBGNXeQp+MlJ2nLNhziis5nCGEegFL2ljv8ojrlcTXY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784110319; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vbjelcF2tY6kSEn6h5PXKBnYqC7hbVulTocK4ALO7g0=; 
	b=ifVumDMTB6RsEUG+7pXhXyy40UFd1z/4oLzLRHL2HFTB7d6q96TQlKg/cJLRcVNEoG2321zT6X0gwnD2dkOqDQbE/tqNgah4NygTUbMIEO0t+lbwmqChO6z4D6Hp+qwYUt1P5aO5V9ErBPsZL3b2KUOK2TZkLqHRO3fZRf/UY8g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784110318;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vbjelcF2tY6kSEn6h5PXKBnYqC7hbVulTocK4ALO7g0=;
	b=bD+DDUtgx5mi6gjqh9gX2KYQJSwARrbaLDilkxg9qom+u0OgoHnYOy87mwizcxzD
	+Mt3QeA6IAymWbBRufuOAichYKg9wojxPE/o1r+JzskLOl2h1LiivXoAGnYIvV0asuq
	/8urUFVy54S3OXktXDSiFJGhAMEvXBVBflXJd8iA=
Received: by mx.zohomail.com with SMTPS id 1784110316744221.19938043824754;
	Wed, 15 Jul 2026 03:11:56 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	akshit@mpiricsoftware.com
Subject: [PATCH mptcp-next 0/2] mptcp: sched: let schedulers mark a subflow to avoid
Date: Wed, 15 Jul 2026 15:41:46 +0530
Message-ID: <20260715101148.2601045-1-kalpan.jani@mpiricsoftware.com>
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
net.mptcp.stale_loss_cnt retransmission intervals without progress. That
bit is owned by the core and tightly coupled to the RTO: it is cleared as
soon as a packet is acked on the subflow, in mptcp_subflow_active(). A
packet scheduler therefore cannot repurpose it to bench a subflow for its
own reasons (too high latency, too unstable) and keep it benched: the core
would clear it on the next ack, unrelated to the scheduler's intent.

Add a separate, scheduler-owned "avoid" flag on the subflow context, set
and cleared only through mptcp_subflow_set_avoid(), exposed to BPF
struct_ops schedulers as a kfunc (same registration and filter as
mptcp_subflow_set_scheduled(), so only schedulers can call it). The flag is
scheduler-local state: the scheduler sets it to remember a subflow should
be skipped and consults it when picking a subflow to send on. It lives in
the struct_group(reset) block, so it is cleared on subflow reset and a
re-established path is re-evaluated. The core send and retransmit paths are
left unchanged.

This is the "manage a new bit" option from issue #349, kept independent of
the RTO-driven stale bit as that issue requests. Regular probing of an
avoided subflow (#348) and any core-side consumption of the flag are left
for follow-up.

Patch 1 adds the flag, the setter and the kfunc. Patch 2 adds a BPF
struct_ops scheduler selftest that marks all but the first subflow avoided,
reads the flag back, and schedules only a non-avoided subflow; the existing
harness confirms the avoided path carries no data, exercising the kfunc
round-trip from eBPF.

Tested with the mptcp-upstream-virtme-docker CI (auto-normal and auto-btf):
all selftests, packetdrill and BPF tests pass, including the new avoid
subtest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

Kalpan Jani (2):
  mptcp: sched: add subflow avoid flag and kfunc
  selftests: mptcp: bpf: exercise the subflow avoid flag

 net/mptcp/bpf.c                               |  1 +
 net/mptcp/protocol.h                          |  3 ++
 net/mptcp/sched.c                             |  6 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 15 ++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h |  2 +
 .../selftests/bpf/progs/mptcp_bpf_avoid.c     | 49 +++++++++++++++++++
 6 files changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c


base-commit: 490b4823cb98b233af2b7562bddc90ecb5dfbf4e
-- 
2.43.0

