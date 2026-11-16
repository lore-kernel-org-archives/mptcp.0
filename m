Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870359;
	b=XtQWBobSao/EJuqUnR6FpRktBUbVzJe76I6nkiUSOKzjw7xvh9/lcNz78Y3p4ORXfhXX
	 vCnq4ttRK2MNQ046wcgRvxhzNt2V4wRHNpb3l09S1csejFnqu/d6dLC9aiZ7vb9oqDyew
	 7xyzSrcX0kX3UR+dvy9+CNKdOt32LxIYAXMiXlpO985RaxUIhAYnaOyJyz1rZXVVjacVO
	 ep1xT9wFpEIpYfPieDjU3K3Uk9w3XQBEDsY4bgUVVKrkxoLl0/6NKfabyQlRldqA28XWl
	 zmdCrWJiEhNph1tYrHkC/PzeMHuo8nQOySbnP1/AX4bjuFbs8yzInrRcuX1a6qbOkwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=g/6+wyu9qz354Ltln9/JyzH/JPOQeQrdOSPG0Vge1TE=;
	b=JZ72X/aDoiUcFJ1RD86TOYy9WbsgStr23lYZJ3iWI9VjnFf0JawlFVWnMshpP8Uo0a6T
	 QMv59YBvIheDs+gnZai4wRmgMHs3TTsYRPgf3vFHS6XQdFTvZA0vv7NKVWwB+hmCeCbQv
	 FdmSUJgXIL2vWBy1otrA2k4jFO1erKnni8y/70wkg+zkhCXjjJpMXrUVXluUx+fdKge82
	 U8q8EWZPYM1KLRdFz6fhL9rwGU3AxLx8LN0T58f6nDz6AdNjNZaEderJn16oIrUntylex
	 bL8MueFgV04NBM0x1BBOO6SA2uC7EPZlJDI9EVlEjUsSeeSbgUlARwiCouVjnbBYHRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=czJ67qDQ;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2A606A32A
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 23:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B2A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=czJ67qDQ
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed05b3eaecso28615955ad.1
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 15:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794870358; x=1795475158; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/6+wyu9qz354Ltln9/JyzH/JPOQeQrdOSPG0Vge1TE=;
        b=czJ67qDQNWD2+Eh9sHC643i4TLqiErbASn8G1ZNR8OwVCtDk56gXFJh2W1RNpOd0Es
         B+JQVPXVTvG3MK27dKC+1IRTC0gxF53Ah9LPdS81aBuA7uwyF/lvVqH6/U4mLl4BGDYS
         YKvmwqFmDVUN/cuzz3SEKPjCx5WyrVSbGlsr0q/sQPjiryy1flP8uvz3iqWNKPEB52b8
         CJrnlJM4PF9DjpaRb90ZsN1pcyZHBYoRSiLwwOAzYlTX8RSQMuZ8kCfFZ+bwI7WGlmTF
         11YKwFEaPkWIT4RGExh517PxN9G0gF49B1swg+963g5mnFJZPdi5NLgxlvnsORzM7fuq
         UOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870358; x=1795475158;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/6+wyu9qz354Ltln9/JyzH/JPOQeQrdOSPG0Vge1TE=;
        b=doiaktccGFfUlarhv6Mdps5LWWRosXsgBfWjjYu402MuiA+7CNlg//M9SiMDVoDVj1
         fBcMPg06WtLqidlzyG1TZ+tsPhmfjnmmdHueJ1fw+Vw1s2guudq34YFpTry8zHsoggAP
         4HnpxRlN9o7TZeGXKlQCnrJgHDjoDI7jexhOyIQULq/43gGSyee/+hl9+QSwe/7y2YsL
         RrTGYj7oPHRxlrljnt5EjrbPCKv2+Ss1gILkt/y353id2/dEsTFNrN2dRQ9pfSizQrdT
         iMPi8RJjV5UN5EcD8WTauusNHpzzfCKRIJNC0A3pdR0jpnwWTND65qjWubmPiZfg36JO
         Alxg==
X-Forwarded-Encrypted: i=1; AL+hErGHUCOrwidvduxzKM2N9ZhYuskA1myGot/MOf06XVusrm2r8AwBW99DIDpzFYAkcC6Cx8hhtQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/AXuwUro81C1hGhh/UlyfBC0TYG/hYLwZChioFf0+7DMFEWyP4
	0rAiI4ILBwUqSyvg6gDA2GmeXuPuBOvTZXjCI8C7Eu/L/tQs6uxCd2pz9r3TRj7oo6KFCqorMgj
	NpNXExw==
X-Received: from plbmi14.prod.google.com ([2002:a17:902:fcce:b0:2ef:d548:58a9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3903:b0:2e9:7ff5:5459
 with SMTP id d9443c01a7336-2ee0de0eaaamr116231095ad.15.1794870357672; Mon, 16
 Nov 2026 15:05:57 -0800 (PST)
Date: Mon, 16 Nov 2026 23:05:24 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261116230555.2305867-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/7] tcp: Prevent tcp_collapse() from bloating queue.
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
  v2:
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
 net/core/skbuff.c                             |  26 ++-
 net/ipv4/tcp_input.c                          | 171 +++++++++++++-----
 .../selftests/net/packetdrill/ksft_runner.sh  |   9 +
 .../packetdrill/tcp_rcv_collapse_bloated.pkt  | 135 ++++++++++++++
 5 files changed, 292 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_collapse_bloated.pkt

-- 
2.56.0.679.gc527c65306-goog

