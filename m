Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795428533;
	b=4DMTySxVHhJaivYMyUYFVrRBP3atQVrUXe6CyzTmgdb6faaOaN2z1VozU2qxczTloYuM
	 eydy0umC7y80Tk+82o3dCy0KoXPFsOjNbVR0XgujHpx5MmqAoDYVht9/SGp2IOPBMKC8k
	 92XJbsz/UFC7NtpsVtoD1fUJ2T6ZBrmrvJNg8kywxb6aYfVV7n78580gMvI65qlaoTJia
	 Kb4npNgWYNnZAdcCzXZkOJSGjBqar6GOzGi9FvOCSdVPsMaMuzuUWfcbSpSHmyZ+dQh1m
	 mMtQ4NgA7+CJfiLWwXBzhLLlmNh91xn1skaBlPZhuGQPzFgjFp9X78/KC5VpFBamNEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428533;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=+KTMJKMK/EYu/6HT336dcSQVITScFtdbT0qBbAsCoDM=;
	b=wnhiQQTeSY3wyltc3m/3iQ6IbSIKNcNdSwYLgvqaL5HcFJ6hqpAC//4Z3Ies8mnMf8jh
	 sFqBSV+2elM5u4BH7UAMv325I+je11gR8FO0/jVrMkpqzhM8qQAzagpRvgyrHOySma3pk
	 PAe1S7+0frtTKukf5XbPC5BDd49mWOsyOWsBYk3+SlaBzE7rPoC3mWqxNM54jsTFyRLme
	 lmiNjhMm+9Kmgaz8s4PhPHA44yaqbon4dspJDFWzNN+T2THC5CwwkeuWhvS6mh/nvF69R
	 sMI2w4daVAJpdr8A9k/lCuZG2PHv079yEDX0uxzmenGnmxVosG74bsmEirIOM1EopDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9092606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 10:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9092606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795428525; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e9EWfIXxCYD3thvpuI+iYxEFZZIpyF91gBNKSC1C3AujkQJ/5wIO1ul5e6h2j0qDtOU1Y8x3vKxwOm73qRcCrMkkugjnSPk9RsDI6QILvN/SWbjXOyonnZRm+U25SUb53Tkw6J8fJdp4PQVGNQ+qeHchSrZ6Jkf64dxZfSIixv4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795428525; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+KTMJKMK/EYu/6HT336dcSQVITScFtdbT0qBbAsCoDM=; 
	b=NxOYePYfMj1Nxm4Om9VRpT9dVhGRGvW3H9iiN1I0z6A2KWgVUq14p8hDrPCLwI/O0LlT/eoQbnr0W9DhglJLm9skbhk1z//ouGJctYHWX/0NN/IVzQVHxUYL2PRl0rOxwfwWOzDTUhTY+HhZoEgWKOJspQpYClMoE92zUXg4tpk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=LA/+lODHcmvmDfvhSRPhNyDplgryJrkfzxdraXlNIgAlHMvr/dO73oI9GboJh0K7uVqiGbBldI3qUzWjDjh0cQmsQtua31f5qV1mOEAvxTNN7OIf6rlTZPgUZh/2io675KbX5LFoN9+FLsKUL7YmdHSoo3WV5oo2u7q2YrjB1R8=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=+KTMJKMK/EYu/6HT336dcSQVITScFtdbT0qBbAsCoDM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795428520979753.1921765720887;
	Mon, 23 Nov 2026 02:08:40 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-next v6 0/2] mptcp: add scheduler-owned subflow avoid flag
Date: Mon, 23 Nov 2026 15:38:19 +0530
Message-ID: <20261123100821.2228839-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The MPTCP scheduler currently has no persistent way to mark a
subflow as one that should be avoided across scheduling rounds.
The existing stale and scheduled states do not provide this
scheduler-owned behaviour.

This series introduces an avoid flag in mptcp_subflow_context,
exposes it to BPF struct_ops schedulers through a kfunc, and
exports its state through MPTCP diagnostics.

The default in-kernel subflow picker skips avoided subflows.
Custom schedulers can explicitly inspect and honour the flag.

The second patch adds a BPF struct_ops selftest that marks a
subflow as avoided once and verifies that it remains skipped
across subsequent scheduling rounds.

Changes since v5:
- Rebased the two-patch series onto the current mptcp/export tree.
- No functional changes to the patches.

Kalpan Jani (2):
  mptcp: sched: add subflow avoid flag and enforce it in default sched
  selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

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

