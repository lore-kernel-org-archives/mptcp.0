Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC1A1E4BE
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055433; cv=none; b=bPCXI+eALi+N5Qb7e+Y+bBWGxEIE3wIX36iwtO1S70mvmJJD5gkFP0Qh1MitmHs2FliqTRuDLKyl40dVseg3GbqZ4nhz9IrzYVKtFltRC1GMWm5dUTGRWKxxV84I4ZMCyqNGwxZvgD72PYuqNVamQHqgLn1auVGMe4hUH+DI3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055433; c=relaxed/simple;
	bh=rR8cB3GdeAtwWY2wxHa/hlPSoqCk1UmNABWIpEjw+Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NL+X8OZHZi1mioomAKSCTX7cSbvcDskQPvAS3Zg6Jtiv+puSB68LOGI3uUMBw5mfST6p/KRCmE3pQ6u80p+xbs+aWdb948i3klFzs0SdJMBA2d1KmLnNIqtaxDSxBhE9ZdRuPr1UDQ6hCLfNCQ/0HUysTn1105K8VHJsqzkL6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6a2v/hW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6a2v/hW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EA41F000E9;
	Sun, 26 Jul 2026 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785055431;
	bh=K2LG81smPN4FH7wRZlIZSOdV2CBl57ux3yYAzz07VXQ=;
	h=From:To:Cc:Subject:Date;
	b=E6a2v/hWFZPP9iqHl9J1gfKoEuEt4bXfde9qTREWQg27cMB4V9+gK++3TXoMDOJBg
	 LZRtLYAO6+iXib49x3qizBJzagjcYf+MoxPPqV/3IjwVF3EuHHaNeUH5zYs/4QwQ5C
	 Md+H+blE6I0bhZbrTbWjehjzbTFHmpnkSSoO9aqYMdT26ulAGAhsXnIT7e70uCzDZz
	 r9HuYQtQB4spvBWL1kKk/HqSqbBjMPaPp6vRGEzYUxz6olhr/l5SpiW3BXZ6kM+FHs
	 Rly4auAxeTmmQRnWHrUfh1Vu9VXGMxByTLLiM65OR9WiX+iHy37sU9i4JPp5I/UCUg
	 FxrshyvBtY5nA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/5] Fix socket options used by NVMe over MPTCP
Date: Sun, 26 Jul 2026 16:43:39 +0800
Message-ID: <cover.1785054808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

NVMe over MPTCP relies on SO_LINGER, SO_PRIORITY, SO_REUSEADDR, TCP_SYNCNT,
TCP_NODELAY, IP_TOS, and SO_BINDTODEVICE. This series contains fixes to
make all of them work correctly. Patch 4 is a cleanup needed by patch 5.

v2:
 - Drop "mptcp: don't reset dst when setting default 0 tos"
   and "selftests: mptcp: sockopt: cover LINGER, REUSEADDR,
   PRIORITY, NODELAY, SYNCNT": the 'if (val > 0)' guard
   blocked the legitimate "reset to 0" path, and the test
   only ran val_in=1, missing the SK_CAN_REUSE "any non-zero
   -> 1" normalization.
 - mptcp: bump setsockopt_seq for subflow-only socket options,
   so secondary subflows created via MP_JOIN re-sync
   sk_reuse / sk_reuseport / sk_bound_dev_if from msk.
 - mptcp: copy the subflow's TOS to the msk on accept
   (alongside the existing ssk->rcv_tos copy), so MP_JOIN'd
   subflows inherit the reflected outgoing TOS.
 - mptcp: propagate sk_reuseport to subflows via
   sync_socket_options, so secondary subflows inherit
   SO_REUSEPORT, not just SO_REUSEADDR.
 - mptcp: tighten TCP_SYNCNT bounds check
   ('val < 1 || val > MAX_TCP_SYNCNT'), so out-of-bounds
   values are rejected even when msk has no subflows yet
   (where __mptcp_setsockopt_set_val would otherwise return 0
   without invoking the set_val callback).

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1784985085.git.tanggeliang@kylinos.cn/

Geliang Tang (5):
  mptcp: copy the subflow's tos to the msk on accept
  mptcp: inherit sk_reuse/sk_reuseport on subflow creation
  mptcp: bump setsockopt_seq for subflow-only socket options
  mptcp: handle TCP_MAXSEG getsockopt in common case
  mptcp: add TCP_SYNCNT setsockopt/getsockopt

 net/mptcp/protocol.c |  3 +++
 net/mptcp/sockopt.c  | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.53.0

