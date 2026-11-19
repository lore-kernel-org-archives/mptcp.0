Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072614;
	b=Ls1jPA6ffRY6ouSYvqrzQsGPc3CxwyVR1L2uc3VoTt7bPPyhn0Z/Ede+spQWpC+xYcxZ
	 HW7FvbMQ/nYIbN0Fo5XFo06/d9CgeDJx5kPHHE8ACDd4uq7j9jbIm/+bSrr+UdMWdEQ8p
	 0FNkaJ5a1bkg92kP1n416DLz97JnAmbdKQlq5Js/uJzkgpOtbY+it/oLK+oIKI0IDJLli
	 9rEsae0n3yaQczzOwGvf+n4FI5TiMFbN9TC5kKb5QczO6Zyjvj10RlpQwkdE1QG0P1Axt
	 PTLe8+Y30n5Xdk+7qwZ0JMmitIZum9w1KD4YvK6wRoZYRXJ1Vr9QHNVpcDSdQiEwACQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=36/82EqcliLLkBXq/Gk0sXygwhD+qbzxdyFBMAKOhkI=;
	b=aCWMF2VTxGcb3P4+dla7svlf1FntbyVhmBXiEF3dFEEfYU1f4/338fTK1NT8szbQUC4o
	 43auV504tRluS1NZhnfXdTxFKefCeZcEK/giFSO2bLjPKEQ/gmYzteOdhdUKCoATLTRmF
	 O8dQCrpfovqMa+DsILKCJKdCCWwfpEcycf9mmFg0yqi0PQtHt+0QRmTVcMtC/56QHBrS2
	 vojdDSRlwh3n20328liJaBrwSphWe99FER9AXudWqHo2QT2ofzPpEQJRe0KED06MdAF8L
	 gVlEMQwFV9Wma0H1d8VanQa01zScQ7hZs9/+FuDqV+8Wx8lc8I2O1Un9vVxKr3YO60Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dWd0QcpS;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3167606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3167606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dWd0QcpS
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b3ad195a96so2028864a91.3
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 23:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795072613; x=1795677413; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=36/82EqcliLLkBXq/Gk0sXygwhD+qbzxdyFBMAKOhkI=;
        b=dWd0QcpSREihIm45d5S6Ujw1m5w7+5cLuAsQ2oAQJXt9LhD4hrvRCsZE5PqSFjjfgT
         iioDmWYYcerFypLkTdybOYnHqT9WIiyUushHRFVvpFZ0fvBGcktv8m2GmDlCDEdjJpRA
         /jYRpDT7YFvORkV1IDuXsgU8NvWBwcGiTrGWOJRCAthfGdIuCM8FFh8NCrOxt9MZaF7S
         qQSr8O4oDil+LSJmW8YsK5WGfQ4jYtCz0LeqhSqmGjmUCerokaWz/yV6DAH9WDijnhQY
         5WGSylk9HKQhIV1Vf7dgoYBLLjZxV+ooo7/AFxJs2sZhpMINFqr0sxGfX7hslyQIMEKC
         lcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072613; x=1795677413;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36/82EqcliLLkBXq/Gk0sXygwhD+qbzxdyFBMAKOhkI=;
        b=uLaTvhwPWkoTzTSfzyusCT8wFCpN5oDCbXSsRtozGUuKXF5DWjFJoVN5bsYeN7qxuB
         qHMOV0y5LmZda1e65H1bF7UYaouy4cUCXllaEjxGjIrzDlK20BUg/cPhFbXLmW+43kzm
         Yrqo5yd9+26hvd+sXqSJhqm6R6Koh/lqN7JRcxfFdNYe8PG3UhPXpMuXZqT8LZUM1I9Y
         uNKx11fFPx4upCWGjJTbLcYwY2D4hCwZ3vVtkDw8GLOA/kZZPQSYNG/PjA5f1c2Oj0sX
         FhoueA70/7S283o4VnFFiAR8yVguPly+B+xdkxytRFSEGbOqgzwJIlr7zA6StRfHQ7Su
         71fg==
X-Forwarded-Encrypted: i=1; AL+hErEgvmtoYBFIR4xNddQ55UaBFLX1eUADpGooirUwn8DJWYEqyG0khdMIeEoDk/uyE3xD4WfSFw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8XJao3EOQjoWnPoDZf9GU/8SYi8RYlzpjqnTfb8f+YlTF4DdqK
	97u72L9hi2VDNWNFp0XxXK4T0Lu5xk5kb2XU6ZCf8XQOiWWSlqfcQ5dXxfNzfNzlTT3TWtPljgR
	UMhGNvA==
X-Received: from pjbds24.prod.google.com ([2002:a17:90b:8d8:b0:3b3:fff8:e92a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dcb:b0:3b3:af8e:ea98
 with SMTP id 98e67ed59e1d1-3b3d07d3d1cmr4485886a91.37.1795072612860; Wed, 18
 Nov 2026 23:16:52 -0800 (PST)
Date: Thu, 19 Nov 2026 07:15:52 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119071649.374106-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 0/7] tcp: Prevent tcp_collapse() from bloating queue.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is a follow-up for commit 031c403d13e5 ("tcp: do not let
tcp_collapse() drive sk_forward_alloc negative").

The core algorithm in tcp_collapse() is so simple and has not
been changed since commit 1da177e4c3f4 ("Linux-2.6.12-rc2");
finding a collapsible skb and repacking it into up-to-SKB_MAX_ORDER()
skb.

Now that we use 4K MSS and tp->scaling_ratio, the simple algorithm
does not work well, and it could even end up consuming more memory
contrary to the intention.

For example, the scaling ratio of SKB_MAX_ORDER() is 222, but
typically tp->scaling_ratio for 4K MSS flow is 252, and repacking
data rather bloats high-density skb.

Also, once a low-density skb starts collapsing, it drags all the
following skbs into collapsing regardless of the density.

This series changes the algorithm so that it skips high-density
skb and a single low-density skb between high-density skbs, batches
memory accounting at the end, and removes sk_forced_mem_schedule().

This series still keeps linear SKB_MAX_ORDER(0, 0) skbs as the
collapse target, and Eric is working on a follow-up patch to
store the collapsed payload in order-0 page frags instead.

https://lore.kernel.org/netdev/CAL4WiiqekjxZw3EoDYXLc0Phd3i0GStE2ZHWQkH2iAkSM5D8TQ@mail.gmail.com/


Changes:
  v3:
    * Patch 3:
      * Remove fully-overlapping skb in the 2nd loop
      * Skip range on overlapping unmergeable ofo skb
      * Update tcp_collapse() comment
    * Patch 4:
      * Remove redundant kmalloc_size_roundup()
      * Rename helper with skb_ prefix
      * Declare {old,new}_truesize as unsigned int
    * Patch 5:
      * Make TCP_COLLAPSE_MAX_TOTAL_SIZE hard-limit for multiple skbs

  v2: https://lore.kernel.org/netdev/20261116230555.2305867-1-kuniyu@google.com/
    * Patch 1: Describe SYN/FIN behaviour change
    * Patch 3: Describe behavioural change for MPTCP
    * Patch 4: Add compute_skb_truesize() instead of macro
    * Patch 7: Rename test to tcp_rcv_collapse_bloated.pkt

  v1: https://lore.kernel.org/netdev/20261114040101.1043546-1-kuniyu@google.com/



Kuniyuki Iwashima (7):
  tcp: Refactor the first loop in tcp_collapse().
  tcp: Don't collapse high density skb.
  tcp: Stop collapsing if not bloated.
  tcp: Skip collapsing if collapsed skb is less-dense.
  tcp: Allocate all new skb before collapsing.
  tcp: Batch memory accounting in tcp_collapse().
  selftest: packetdrill: Add test for tcp_collapse().

 include/linux/skbuff.h                        |   2 +
 net/core/skbuff.c                             |  27 ++-
 net/ipv4/tcp_input.c                          | 190 +++++++++++++-----
 .../selftests/net/packetdrill/ksft_runner.sh  |   9 +
 .../packetdrill/tcp_rcv_collapse_bloated.pkt  | 135 +++++++++++++
 5 files changed, 311 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_collapse_bloated.pkt

-- 
2.56.1.708.g77570a6a1d-goog

