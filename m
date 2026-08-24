Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C113B38B8
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555390; cv=none; b=SGmYVtNFzAQzYCzYtCKPlbRxDgMpEEaB2ThNfCHM1USfVfWLH49MD5o3lXQJwUu8Wnx4oY7tky0PICblPXBMqOAA1Q55jj+yddMus6FbjpzgrGe864dPmiSsAvB39Av02H1f5rMXZmTsou5hsK4QCmrIjfxuMvuGYP8bUg++TGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555390; c=relaxed/simple;
	bh=WVqJD87qSYYt1aPnKiwq2lKFczxssGBfHl+FidH713w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iP9bXs/WwtcPQO2ke9oWLP0Hjp8Yl7S47gszkmYbJcYfV8Kq7CNyjszef29EjhWWXlVMKkI6HjXk29NqHB1Kqhh8XWhWWbaBqn8qoLrKnUKG6nF8KvzNdcRfmwXVOMeKzw3tmbyYhKJME4Z1ypBT61OQsu7mZtqM/fDOgHpQQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4w/Ag75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4w/Ag75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8621F000E9;
	Mon, 24 Aug 2026 07:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555389;
	bh=rVun5e+FzEZA5OMWBc2W5mKMnNvMTmRdGO9Mf5z5qZE=;
	h=From:To:Cc:Subject:Date;
	b=O4w/Ag759rGo0sd6VkR/LT/8KBF9DmeBbpoaFWYMicnT0vn9bIVlf6LKJLqGTPnmS
	 G6Xb+RxWV51QWx2QuOIGQrE5TAAf5XKTBswuqZvfEViFZOgZrraoVNqJXkHa5e+6kb
	 YfJqLA7dnvx1zn0tKPMI4W/bfiIsli/uxiynhfZj0eukUmGK4/N3CKfXuElT3btfQM
	 mYZYc1ZoeNiVj24hTQGPPk5+0QMjS8HFup1eg0/vFMg9ZkXDkY7tpukcjKHtLkFWyf
	 I0SCSitOjT3gt0cdBY9/ZJdGdnaBrH3XIpWan6yqf+PtQfdOGe4H6YAALtOrrJGHlr
	 ZHwN8iRb+YfHQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/5] implement psock_update_sk_prot
Date: Mon, 24 Aug 2026 15:09:34 +0800
Message-ID: <cover.1787554581.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - Address Mat's comments: implement .read_skb to make the selftests run.
 - Move mptcp_bpf_update_proto() from protocol.c to bpf.c.
 - Include the "implement .splice_eof" patches in this series, as they
   both modify mptcp_prot, mptcp_stream_ops and mptcp_v6_stream_ops.

v3:
 - Address the comments by ai review.
   - use WRITE_ONCE to set sk->sk_write_space.
   - update the selftest, set a new key for client socket.
 - Fix line length warnings.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1773826662.git.tanggeliang@kylinos.cn/

RESEND:
 - rebased.
 - to trigger ai review.

v2:
 - Include mptcp_bpf_update_proto within CONFIG_BPF_SYSCALL to fix the
compilation errors reported by the kernel test robot.
 - Add checks for IS_ENABLED(CONFIG_MPTCP_IPV6).

Implement psock_update_sk_prot, for basic MPTCP BPF SOCKMAP support.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521

Geliang Tang (5):
  mptcp: implement .splice_eof
  selftests: mptcp: connect: trigger splice_eof
  mptcp: implement read_skb for sockmap stream verdict
  mptcp: implement psock_update_sk_prot
  selftests/bpf: Update sockmap tests for MPTCP

 net/mptcp/bpf.c                               | 106 ++++++++++++++++++
 net/mptcp/protocol.c                          |  73 +++++++++++-
 net/mptcp/protocol.h                          |   9 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  42 ++++---
 .../selftests/net/mptcp/mptcp_connect.c       |   5 +-
 5 files changed, 212 insertions(+), 23 deletions(-)

-- 
2.53.0

