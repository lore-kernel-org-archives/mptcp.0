Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8DB149DE0
	for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836614; cv=none; b=oE0ra3IQ3D61j5TC814XpFG8nfJZDILRz6BU9ZCjWIpIPbY/ZudbLhCNWEGg2tXR8ogkrDAJ0y7MFSJzcNctCcA8vDFlVNxdav2lIduQVW1L/kptivzIwk+tj3v4otMCyOa/p2XblrmCwj1Tya3eOelat9MRcw8xFM61gzhkT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836614; c=relaxed/simple;
	bh=9mRq1p0pLgTGNhGIfitgSlfJ4UQXvmP0XrYiJcBiVkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GdifbBmM2UMILB3+oycuSVgSyTh2KSZtMZKspmgGAuYVBefvENDl7rCRLDZTVgZWZyxRqIm32TQzEWJ9pIiLw+NB0W/fbzgasXFVV7/QPsQkRj0aMEokd5Xp2CPA0fUHIKLPvqmfQ4Z59w8LI4RY3TwuiwDvs0UuTkSx4kucLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh1MD9l1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh1MD9l1"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e2178b2cf2so68494895ad.0
        for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836612; x=1713441412; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1QVAQ8Ec97dFYaKzfWqsOpGEEdRtavRl4tq3a62nwo=;
        b=Nh1MD9l1CFc17nv+O5tJtajtUZPX79ZqtfwQkVP/2SnoHZY57gtcq35BDdiu58g4Sl
         fLFiD/ox9SapVfIWBsQZ+x81qSE/g2D2Y7GUW+V25+O3OKCBK1BOdLwInI1kfLe2X4zT
         I5jCiAw1+NthNkniBw8u2TzU86+n2X+JzFWw7f44orC2F4RPewcPyd/KHsjUUHHd6Dhn
         pbSRHgoKFknXM5SPT4DxYU8NE/qqlWUNXahOcVk+np4dfPFNcgoeB/ZMePSFmPpX9Vmy
         P8z40Z85AAQizG/n9I6gPOdJQNeHj0mbVw/xJfBEuNVLMIvp7iRGJ5lzDnoypUTJ2t5H
         jT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836612; x=1713441412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1QVAQ8Ec97dFYaKzfWqsOpGEEdRtavRl4tq3a62nwo=;
        b=Oa4LjnzlkW+lzRLBQ0fuN3PXSe7uHB/fAanYzhAJ3aAIKn5lYc7WsfOBZ2VI4vLzSj
         j2Gi7nE4vCaVjGu75lA5smmIsh+6mwvcXIfwmnWeJsD8mo0rdkzAZcZnIckdGg6X9UjW
         7lvPhGplZN6KOJQQpmBWhxpOhp9CIZIDeqNYGe/R7hIpkE/+6OpRKlujTJ8L7N6q/o6m
         vaZXTC29Qd0qu56r8lVejTqXWpqT/fMuJO1v5lPDGIHiftXE5+8jFqaUBe5qXMPnR4A8
         QqCv3NFnnuLuDteOv383BPOyPyYh/FjEYUA6WndIDSSBf2LhRxuswcTtecvypiMsHerC
         FDTA==
X-Gm-Message-State: AOJu0YyhRrnqzsXx86a+UnfE7aBorPUvrpt9ckFaz19dol/vcDot0pDG
	HFKAHy95VL8OD7vOi8HFamunD9fUgzt4t+2okWUXnjcV+CXLmZ0U
X-Google-Smtp-Source: AGHT+IH7EHxErU1/GAHQNHNYxxKUfqFIAATsiMAKO+hD+43q0YrVlOqg3mBc9euZ1O6+qvJ7p3u3vQ==
X-Received: by 2002:a17:902:e884:b0:1e5:10e5:b66e with SMTP id w4-20020a170902e88400b001e510e5b66emr4219563plg.27.1712836612326;
        Thu, 11 Apr 2024 04:56:52 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e5cb00b001e20587b552sm1011840plf.163.2024.04.11.04.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:56:51 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 0/6] Implement reset reason mechanism to detect
Date: Thu, 11 Apr 2024 19:56:24 +0800
Message-Id: <20240411115630.38420-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In production, there are so many cases about why the RST skb is sent but
we don't have a very convenient/fast method to detect the exact underlying
reasons.

RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
and active kind (like tcp_send_active_reset()). The former can be traced
carefully 1) in TCP, with the help of drop reasons, which is based on
Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
RFC 8684. The latter is relatively independent, which should be
implemented on our own.

In this series, I focus on the fundamental implement mostly about how
the rstreason mechnism works and give the detailed passive part as an
example, not including the active reset part. In future, we can go
further and refine those NOT_SPECIFIED reasons.

Here are some examples when tracing:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NO_SOCKET

[1]
Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com/

v4
Link: https://lore.kernel.org/all/20240409100934.37725-1-kerneljasonxing@gmail.com/
1. passing 'enum sk_rst_reason' for readability when tracing (Antoine)

v3
Link: https://lore.kernel.org/all/20240404072047.11490-1-kerneljasonxing@gmail.com/
1. rebase (mptcp part) and address what Mat suggested.

v2
Link: https://lore.kernel.org/all/20240403185033.47ebc6a9@kernel.org/
1. rebase against the latest net-next tree


Jason Xing (6):
  net: introduce rstreason to detect why the RST is sent
  rstreason: prepare for passive reset
  rstreason: prepare for active reset
  tcp: support rstreason for passive reset
  mptcp: support rstreason for passive reset
  rstreason: make it work in trace world

 include/net/request_sock.h |  4 +-
 include/net/rstreason.h    | 93 ++++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |  3 +-
 include/trace/events/tcp.h | 37 +++++++++++++--
 net/dccp/ipv4.c            | 10 ++--
 net/dccp/ipv6.c            | 10 ++--
 net/dccp/minisocks.c       |  3 +-
 net/ipv4/tcp.c             | 15 ++++--
 net/ipv4/tcp_ipv4.c        | 14 +++---
 net/ipv4/tcp_minisocks.c   |  3 +-
 net/ipv4/tcp_output.c      |  5 +-
 net/ipv4/tcp_timer.c       |  9 ++--
 net/ipv6/tcp_ipv6.c        | 17 ++++---
 net/mptcp/protocol.c       |  4 +-
 net/mptcp/subflow.c        | 27 ++++++++---
 15 files changed, 207 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3

