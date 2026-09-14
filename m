Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651041D22E
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377622; cv=pass; b=OtAzh7wiaPFb0yJcfDfrBTsCBF2+/fhPUZjmxxyant+sqprErNF/sJlzVGpXvCGzStpUJvuX5Ifg1bEGqOjcyZgO6krHtL2snts8BIZr0D1zaQmCxyO0/AUOVwFx0N3NI4+P0f1sI6qgxRxZAyK7W+lCF8e7KG27d4bjVpvkUIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377622; c=relaxed/simple;
	bh=WLcHlzi4dotROscyXW1k/lM46+yT7DlR3bclakBEzf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sE++dGfqdih0Jc9EnQmBLWhxJc7qsX0oTdUq0PnRQDDkXk1zhI03j2cslcsfLuD3gtD0jerTZdVyvBD37mlnpMoaM4vcXvcgZaghIgm6Xd2uQVOrPG1b3Fvw9VTOgI3XpjVs00EIfkMYHmpVjUeazNPzrp6PRpLjy3yN/0EuxVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=qAt3WIpT reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.182.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="qAt3WIpT"
ARC-Seal: i=1; a=rsa-sha256; t=1789377614; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PvwicESbqocCGg3vi3J2hsoBnQ7hZUorfY7BPr37tEMnCBghEBaqS7/Aj73KQ3SF3qD1wMZY2gzLwnqSIDCzw7AZBBDXx/7Y4XiA6Co2txrSlAPl3N9+HDlCMfaBlf/XaGbYqQbjGNOLGFBytOp74KI19Fr3hBUAW82TuRrfnuE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789377614; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=R5y6f9hV7nbvOqN0ttHwqEmF41UBHxcGZ8mBpPvZC9Q=; 
	b=luysfLZ9jspTYHOKpN/VRVjV7Bfr7IpLn3HXHfR9pBs/R21QXh3ZIxOiRpA70RoVs6A+D9GPBDQ3m7ipljKM6l71zq8LWRKZ/9XiGGDKM8lajgnyMa9jJi20v6aIfjE9nIOXf7dL2UBNVqvAcJoLpA37ZnFQpBoiGwcfATgfuvk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789377614;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=R5y6f9hV7nbvOqN0ttHwqEmF41UBHxcGZ8mBpPvZC9Q=;
	b=qAt3WIpTd1fs4oN8X+KQBptfwHV2rb8yr5TU7iAyEPPGMgAzORL8VLLxuBMkkMy5
	fmA/1pC3xjtLzOMuCBQSDatyglJ0N/PzKeAzDOOvnziIUJ/O4ByYbiiCje0Ul9dv8Qp
	I2E/vufWwhJ8T1pfAVAWabmkJDvQeu7YLz0DtH+4=
Received: by smtp.zohomail.com with SMTPS id 1789377613670454.14056224787623;
	Mon, 14 Sep 2026 02:20:13 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com
Subject: [PATCH mptcp-next v4 0/2] mptcp: sched: let schedulers mark a subflow to avoid
Date: Mon, 14 Sep 2026 14:49:58 +0530
Message-ID: <20260914092000.1306968-1-kalpan.jani@mpiricsoftware.com>
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
mptcp_subflow_data_available(),
which clears map_valid in the same bitfield from the receive path while
the scheduler can update avoid from BPF context. The avoid accesses use
READ_ONCE()/WRITE_ONCE().

The default in-kernel subflow picker skips avoided subflows for both
send and retransmit operations. Custom schedulers can explicitly
honour the avoid state according to their own scheduling policy.

The avoid state is exposed to BPF struct_ops schedulers through
mptcp_subflow_set_avoid(), and is also exposed through MPTCP diag as
MPTCP_SUBFLOW_FLAG_AVOID. The kfunc is marked __bpf_kfunc so it remains
available for BPF BTF resolution.

The BPF selftest sets the avoid flag once on the first get_send() call
and relies on the state remaining set across subsequent scheduler
rounds. The test uses per-socket BPF storage for the scheduler state
and validates the avoided-subflow behaviour across rounds.

Probing an avoided subflow to decide when to clear it (mentioned in
issue 348) is left out on purpose: that's scheduler policy, not core
mechanism, and belongs to whoever writes the actual latency/stability
heuristics on top of this.

Patch 1 adds the flag, the kfunc, the default-scheduler enforcement,
and diag support.

Patch 2 adds the BPF selftest exercising persistence of the avoid state
across scheduler rounds.

The patches have been reviewed with the concurrency concern raised by
Sashiko addressed, and the resulting patch series passes checkpatch
with no errors. The remaining warning is the standard MAINTAINERS
warning for the newly added selftest file.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

Kalpan Jani (2):
mptcp: sched: add subflow avoid flag and enforce it in default sched
selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

