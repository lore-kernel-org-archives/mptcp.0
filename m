Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795437477;
	b=1n1vb2MKqYvKbbV6GLkhBcFgQ7DVXXnOJ7XnHp+02D0xexUqeue+0Bszn3z4lecVcOK9
	 23g6LPKTk0p76OgDosuid8Gl3fW+x+tBcQ68FItK30X4N9D9agfeyaGMHzNSvddc2med6
	 4F580H6ZL2bHTeohtbnajAoRDzPy5twCn4dQR4EQURSgFpL3r53VIMB0uPv3oDREyr9Tz
	 3WzzDsPXDlAmCNjIb252AYPdhvZrGG0ZQNSbDqgHwP0pNaQBo19MGnH/2jzHLDsdpR17Q
	 syUHdHY0YJ7z+R6jkxBmQcL1Tfco6kfuDu63pEO5fQQdMmcDNukgc3meM+m2Yw+PhWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437477;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=vKwnvjBopVM5D3VvIO3b93N6ctbJgtgGSPtnoH6xt0Q=;
	b=Qdh942N5WEH/6Egh6wue4LCKJdXVOFCaLR1XQC6lDvknK8XdQXEeEg4GV8wkqlbCjkMk
	 EgPlXNeot3qV2XOEZeCcc8EQvUHFHgzJ7cSkVZ1OHU1djGNKg3UvufwCva5mWpywoGwrq
	 ToXh1c6v7kitC0daV10uTJyYX3HEzILDFd4ryaCv5t4AzkYg6I5gxvJFF2HlRMlCblnRX
	 1Ca+Q0+QUYk4p3Og2RYGzmI21S9gaYyaGTOm+LVEd+2Va4+MFEuCweUT+nvqZYB0xqPaB
	 WvDqukuoDNV8edGK7wTbEI/xFJZGW/pdYee+DFCetdmvzwZbhd/YlWUHut1/K60eznA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCDC606A31F
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 12:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFCDC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795437467; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KMJJOq7SrJSuxQjEGD1toleV/+1iiLNQiKXWYS8K89aS/EnxRkByfbAB7Lt61vL9KR19NfMfLbSFN+kL+/kMixjyLcrxP/08wmlwS4lIOIG7Qk/KyECusCQO9XzZkRuBKvuoPtslp48Wfj9mxlPa9awMv1pNBzfEXa3MgE+IoO8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795437467; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vKwnvjBopVM5D3VvIO3b93N6ctbJgtgGSPtnoH6xt0Q=; 
	b=DGDanj8mdKihNx0ls9jVITAXc6TiYukaRrh6BWDc4g5mSTdPQq/ZS+piJdBumv1eB1tNl5CcUiFcfjIxGpuNfEbSrQRqICt4BxoAW/JSQbA64QwzI4gPlola2v/UzjMaI8mLLRNOlhkTk90U3mJ7zc/I6K4pzo1iuDcJmYppWi0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=PUnRC0aNRnM1dqnO2o3M/hO/Aw26wRJ4m8x5Tu+sP2mJ7tWJFSlMIpUXUPTtPgO31pxW7copbKnjFYsUOW7lE6gwkpWgw3sEkWc80ZU/gIJmqd9af/7rv95MOvUXoBEoEQTzqc9WxjyDqqalZAMfJ7/n2b8E38IC1aYV96Xvsr0=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=vKwnvjBopVM5D3VvIO3b93N6ctbJgtgGSPtnoH6xt0Q=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795437465167935.8450411597562;
	Mon, 23 Nov 2026 04:37:45 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-next v7 0/2] mptcp: add scheduler-owned subflow avoid flag
Date: Mon, 23 Nov 2026 18:07:28 +0530
Message-ID: <20261123123730.3265284-1-kalpan.jani@mpiricsoftware.com>
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

The MPTCP scheduler needs a persistent way for BPF schedulers to
mark a subflow as one that should be avoided across scheduling
rounds.

The existing stale and scheduled states do not provide this
scheduler-owned behaviour.

This series introduces an avoid flag in mptcp_subflow_context,
exposes it to BPF struct_ops schedulers through a kfunc, and
exports its state through MPTCP diagnostics.

BPF schedulers can set the flag and must explicitly check it when
selecting subflows. The flag does not change the behaviour of the
default in-kernel scheduler.

The second patch adds a BPF struct_ops selftest that marks a
subflow as avoided once and verifies that it remains skipped
across subsequent scheduling rounds.

Changes since v6:
- Removed unreachable avoid checks from the default send and
  retransmission subflow pickers.
- Clarified that BPF schedulers must explicitly honour the
  avoid flag.
- Updated the first patch description to reflect BPF scheduler
  ownership.

Kalpan Jani (2):
  mptcp: sched: add subflow avoid flag for BPF schedulers
  selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

 include/uapi/linux/mptcp.h                    |  1 +
 net/mptcp/bpf.c                               |  1 +
 net/mptcp/diag.c                              |  2 +
 net/mptcp/protocol.h                          |  3 +
 net/mptcp/sched.c                             |  6 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 15 ++++
 .../selftests/bpf/progs/mptcp_bpf_avoid.c     | 87 +++++++++++++++++++
 7 files changed, 115 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c

-- 
2.43.0

