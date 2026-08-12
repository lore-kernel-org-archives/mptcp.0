Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693623FD96E;
	Wed, 12 Aug 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546570; cv=none; b=uV8Q7fMKTFxokV8A8/NeqTw1Rbw84wtXOynqqy2iliziSETfmH642oQpB3aAkAUdOwwcwpf/8CNgTenxEMlMDY4I2IavLmM1uMX0YzPRYqsuhOJmtFajR259RRdzN2dWWc8pmRqqFxoJbBDwhkTERlH/E3wJpkqZzds0f8x0+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546570; c=relaxed/simple;
	bh=Rnb6ZAP/we5Dfpv1iauF0xj3H8QBRP5MNFuriepJ7a0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ooXmOaWQA3fy4C0KzcdX3xjQeljDmeSZi3Nw1QziDUMs6zMduifChoe0fRUsg5GBNp42YxSzR7gRhmzBoFnRHWTs/mG7+NDoHegT8cb5Mf6vfLiV2FPJvoql8ty4dorcyjF0y/gKnTtGdmGqqiNJcC8Roi+lKroaynOsvA+Z9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDLue4Ne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDLue4Ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519451F00A3A;
	Wed, 12 Aug 2026 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546557;
	bh=PE3ckqAzJuLdyX7hrN6QogEst9yy454JJ106p3AyeTE=;
	h=From:Subject:Date:To:Cc;
	b=WDLue4NeSrHVW1tkDGnCMGXhRN6X7/4ofiJXlUAoYM1LNNRjapvIpdvUvNcrJCw0u
	 Yo2mc5RRZy3p3IYPz0p1Co6ZNlgym1lLEk9tN5AoF6KYHe6lsfkBXALZJQXvSSEd1y
	 U1yYaEnOu3dPN0HnsLtO6JOpLK2flPV2UgDeAgEt4E/TT4h1GR18DcDWNVrd8+F3GL
	 KVArsyfbrrrvcaco9GRQSRBLJILEj+fhALmhiAVsrt+084iaWbMj9vrfBr+6C9n1K/
	 go82qOw8OZUD59I1zegOWrZ/OimhwllbTqgprA4A5MLKw0Y9xPvDnxEbJPwGc2Hgw6
	 7HmkLvezzrzHw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/11] mptcp: misc. features for v7.3
Date: Wed, 12 Aug 2026 16:55:35 +0200
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMQQrCMBBFr1Jm7UASaSpeRVykyVRHaAyZUQqld
 zdWXPzF4/PeCkKVSeDcrVDpzcLP3MAeOoj3kG+EnBqDM86bkzWYSdsWxbloLDizRJwoKA54xNF
 4nyy51A8BWqJUmnjZ8xf4m3D9PfIaHxT1W4dt+wClI/NKigAAAA==
X-Change-ID: 20260810-net-next-mptcp-misc-feat-7-3-b066d1e2d57a
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Tao Cui <cuitao@kylinos.cn>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
 Jiangshan Yi <yijiangshan@kylinos.cn>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2905; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Rnb6ZAP/we5Dfpv1iauF0xj3H8QBRP5MNFuriepJ7a0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOov4ootaeUyEDCxbLy88oBh+We2Wo3m234yD2bfvt
 lwMeN/QUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBFxL0aGX/nTT10J1X0QdF50
 rVVY7fMf5S3f3VZa3DA35dPILHtgyMgwY+nJc7/XapboV+Z9/PFbYEay7NlT1wwV59pfqOqaLGv
 MAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series contains a few independent new features, and small fixes for
net-next:

- Patch 1: Add WARN_ON_ONCE guards around extra_subflows to catch issues
  with this counter, similar to what is done with other PM counters.

- Patches 2-3: Follow-up patches to remove data_ack field from struct
  mptcp_ext -- now unused after recent fixes -- and makes a userspace PM
  helper static.

- Patch 4: Honour tcp_rto_{min_us,max_ms} sysctls for MPTCP-level
  retransmit timers like with DATA_FIN's and fallback timeout.

- Patches 5-6: Add per-event MIB counters for MPTCP_RST_EMPTCP resets to
  help to spot such situations in production.

- Patches 7-9: Small pcap-related improvements in the selftests.

- Patch 10: Fix compiler warning in the selftests.

- Patch 11: Avoid a buffer overflow when misusing the mptcp_diag tool
  from the selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (2):
      mptcp: remove unused data_ack from struct mptcp_ext
      selftests: mptcp: fix const qualifier warnings in strchr usage

Jiangshan Yi (1):
      selftests: mptcp: diag: fix stack buffer overflow in get_subflow_info()

Kalpan Jani (1):
      mptcp: honour configured min/max RTO in retransmit paths

Matthieu Baerts (NGI0) (4):
      mptcp: pm: userspace: make remove_addr_entry static
      selftests: mptcp: connect: test name in pcap file
      selftests: mptcp: simult_flow: test name in pcap file
      selftests: mptcp: pcap: drop most of the payload

Shardul Bankar (2):
      mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
      selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters

Tao Cui (1):
      mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow

 include/net/mptcp.h                                |  4 -
 include/trace/events/mptcp.h                       |  6 +-
 net/mptcp/mib.c                                    |  7 ++
 net/mptcp/mib.h                                    |  7 ++
 net/mptcp/pm.c                                     |  3 +-
 net/mptcp/pm_userspace.c                           |  7 +-
 net/mptcp/protocol.c                               | 23 +++++-
 net/mptcp/protocol.h                               |  5 +-
 net/mptcp/subflow.c                                | 10 +++
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  4 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  8 +-
 tools/testing/selftests/net/mptcp/mptcp_diag.c     |  3 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 95 +++++++++++++++++++++-
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 11 ++-
 14 files changed, 163 insertions(+), 30 deletions(-)
---
base-commit: ac155a26750a595703e7dadff84735456d75a479
change-id: 20260810-net-next-mptcp-misc-feat-7-3-b066d1e2d57a

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

