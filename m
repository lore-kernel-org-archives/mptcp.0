Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C9312837;
	Thu, 29 Jan 2026 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714632; cv=none; b=koWp1GWQgOF6owYWjpDkSkHVVMBTK/BtzzkD88eL/+DI6z+cse4O55pylzPwX/c5Nb4ZJOD4cMiYfyJupAqPWNisJnmcYBthTtv5gIL1berzUW/lFpuAEwQgJZ/V35SOdc+P3I5+mFV61HftURPgSyAxKBKu2SA9Y00RfbDI8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714632; c=relaxed/simple;
	bh=7G4hK+Fx0+WXACikUbIwu/8/ScanNimNyKZLC59bpfE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C0frviw52l7l3U6JO5ipDYALa1R1qJw2WeHY73xD9ql0Ta06jZYYfGKshMwLbxpziPYymciFr7iuSsHy6+OX4VMPUbkeNY+wdGIaJAiBAasM6eM8EFl++gtCErPInwtvqM7mpCFp5KizRRvtbP3fGldiJnv8zE21KnSnBefDLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZsW9XCk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZsW9XCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017C0C4CEF7;
	Thu, 29 Jan 2026 19:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769714631;
	bh=7G4hK+Fx0+WXACikUbIwu/8/ScanNimNyKZLC59bpfE=;
	h=From:Subject:Date:To:Cc:From;
	b=fZsW9XCkX6tEhdoewkmvltyS24bdxh2jDTkZA1P4kTkT5S/y7DWyNNXvcL5Rhru2s
	 cTHASoEBXub55JKsQkXWDkONuBjqWAXvbPhdoejgtnkkZSxcmaf4IS6Ub2to3Za6vY
	 KZ4zrYd9NrrfAyFWsCQtNvQjDFaS0de+sWrqmP41qR7mmjYMDXYoa986F4fOPJDKGY
	 vrUwdZ4sN7IaXeakQmsKIo/GDCfdcFO97ImbQ2ItzntRzEXSkxKN+pTWMd/HL1KfwW
	 ovhS4s7IAhNq0lk1vO0RshJOMdOGxumUpdZ9ZyN7Oj7jS3QY+htQj0muRQCyWzVCuW
	 8Y9OI/8FITB9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/6] mptcp: implement .read_sock and .splice_read
Date: Thu, 29 Jan 2026 20:23:33 +0100
Message-Id: <20260129-net-next-mptcp-splice-v1-0-994cac40daa0@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALWze2kC/zWMMQqAMAwAvyKZDdiggn5FHGqNGtBa2iIF8e8Ww
 eGGG+5uCOyFA/TFDZ4vCXLaLKoswGzarowyZweqqK0UdWg5ZlLEw0XjMLhdDGNL81RrpTvTEOT
 WeV4kfd8B/gTG53kB0sjm1XEAAAA=
X-Change-ID: 20260129-net-next-mptcp-splice-62db4a1a9c52
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Hannes Reinecke <hare@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7G4hK+Fx0+WXACikUbIwu/8/ScanNimNyKZLC59bpfE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKrNx9gr/2cWxSzTcYxenX/UZ59FsG1Ohbep9fO7ep5I
 cHlsK2wo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKlHYwMSwN+zV7+6fdfjzXr
 VxV4VxVEb3jl6LXJMa3ty+IXf3NKFRn+6a1hm7nx3y/PLTNSQ17aH92RpuP+9crO95MPzFojn/4
 kgh8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series is a preparation work for future in-kernel MPTCP sockets
usage. Here, two interfaces are implemented: read_sock and splice_read.
As a result of this series, splice() with MPTCP sockets -- which was
already supported -- is now improved.

- Patches 1-2: .read_sock implementation

- Patches 3-4: .splice_read implementation

- Patches 5-6: validate splice() support with MPTCP sockets.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (6):
      mptcp: add eat_recv_skb helper
      mptcp: implement .read_sock
      tcp: export tcp_splice_state
      mptcp: implement .splice_read
      selftests: mptcp: add splice io mode
      selftests: mptcp: connect: cover splice mode

 include/net/tcp.h                                  |  11 ++
 net/ipv4/tcp.c                                     |  13 +-
 net/mptcp/protocol.c                               | 215 ++++++++++++++++++++-
 tools/testing/selftests/net/mptcp/Makefile         |   1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  63 +++++-
 .../selftests/net/mptcp/mptcp_connect_splice.sh    |   5 +
 6 files changed, 289 insertions(+), 19 deletions(-)
---
base-commit: e75e408dc524ba32b3bd66e89d2ba1e337877bfa
change-id: 20260129-net-next-mptcp-splice-62db4a1a9c52

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

