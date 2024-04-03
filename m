Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176154BF9
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129522; cv=none; b=dDT9wUNBGyzfzoxYBmvafu77s41jvLFMJE9TjXh/4fUzo+rvFqBdNqPZNZmtMa7JpAVyTDFBU1UJ/sVTvH1oZu4WRAM4yzYUA6+pfa5VMDpPjIGH8dOp10pJ2EhftaK78t0KihdvDiRFPzSFiTTzGczQU9iO8toZUxcWSNTftTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129522; c=relaxed/simple;
	bh=IYGqofXTixcqgKsTRQdMNiZ655WhCgAGfO6FimJogF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=osI0P3VQGJZyoQQ3ymCHWwIfFv2Fca6x+VpV6J4OOOeIpPuteIn4Xnw8cBd5JJ+DgpUuOv8USOtkjnvcomcylpeuuOWtnWLUmPwWxJ2wTZJU2gUvvpKXGUxcYMB+FZKvbZFYCpBgwj+AR6EdpN5Ic0t2CfM9MiBdGGuuAJqrU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPOdAdfB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPOdAdfB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6c0098328so5207219b3a.3
        for <mptcp@lists.linux.dev>; Wed, 03 Apr 2024 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712129520; x=1712734320; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pNtMYAEo2tFm50CvZbzCEMtnb8xqmlnnhCu6vPSs0yE=;
        b=KPOdAdfB5VRUivX1Ual+QylewZJsikaWq5jY0n4KbB3xmULDIeFfLQehonmvtreKAR
         9tL3ULKv3DvLfKMRHQYX2PA7+P8RyMOj0ZyQPKwybbfWVxDV2oMlOvykkeJAFdKVEDyI
         KedoCFS48Go6r+NLX0iqI99UijdoGK6FAHCo0alJPdvEk/eXaN5qEF+EQk61s/5Cpg3b
         bVFcuJLRxAHswnl/PITbd1gFpJXkWAadC9aM/mlyxCz6oNVuRu/ARhWJRHhzpGXSlaF1
         KiD7iiDtco1RPGEhXoHcpDMtNDqAbsniFLMDjOLVcxsIbnTXWXgWeAUlW1UHbUPFHYCK
         aLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129520; x=1712734320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNtMYAEo2tFm50CvZbzCEMtnb8xqmlnnhCu6vPSs0yE=;
        b=Yt15oz+ltrye2bqUjZos/KuryIolPscy97k1V4fOfGFEJNfWW7xasRd6WQldPL4PmS
         +TpECn6rINcdF8iEFrA8y7yBQBE63HY5DDXlEZRKYkcaMm526f61o8QApoC4sGWfz1ZH
         jsWeQagUXxlHkNrowz9udgeYuArIMbv/kWlE2x3Y/hHLp4Em0SrEHcgE8JI2j08jSjVO
         AOaTaqHuDwdcemaZiauF18PSP2NsGo3Ott4HiNAIBIIhe3DKeWB/sA1wqYI2j9Ev7RUm
         fq0DGr6oFXqiB8Y3NIS+8y9cocdrh2jMuZ/DgyQngJjE05cr7nT9Bk+cBZctBRBIvh1I
         kHKw==
X-Gm-Message-State: AOJu0YxgBz+wNPXSTLvDvjkB6ZeNwVulLyY29pZVJ0KWyMafrIlobuB6
	xPojkHpn/voihvGNifhnfSpmfKoPdw+0miKHKgy//FqLXPON4PfH
X-Google-Smtp-Source: AGHT+IFjJ4YKli3gCiijcxM+vyWCFeOt2dMZheZQbq9K0r1XuLrzNH4ZMCiXy8XjIrGCQ3X0TtLUAA==
X-Received: by 2002:a05:6a20:121e:b0:1a3:6404:7f0a with SMTP id v30-20020a056a20121e00b001a364047f0amr11815680pzf.50.1712129520346;
        Wed, 03 Apr 2024 00:32:00 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001e03b2f7ab1sm12563067plg.92.2024.04.03.00.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:31:59 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/6]  Implement reset reason mechanism to detect
Date: Wed,  3 Apr 2024 15:31:38 +0800
Message-Id: <20240403073144.35036-1-kerneljasonxing@gmail.com>
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
the rstreason mechnism and the detailed passive part works as an
example, not including the active reset part. In future, we can go
further and refine those NOT_SPECIFIED reasons.

Here are some examples when tracing:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NO_SOCKET

[1]
Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com/

Note:
It's based on top of https://patchwork.kernel.org/project/netdevbpf/list/?series=840182


Jason Xing (6):
  net: introduce rstreason to detect why the RST is sent
  rstreason: prepare for passive reset
  rstreason: prepare for active reset
  tcp: support rstreason for passive reset
  mptcp: support rstreason for passive reset
  rstreason: make it work in trace world

 include/net/request_sock.h |  3 +-
 include/net/rstreason.h    | 93 ++++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |  2 +-
 include/trace/events/tcp.h | 37 +++++++++++++--
 net/dccp/ipv4.c            | 10 ++--
 net/dccp/ipv6.c            | 10 ++--
 net/dccp/minisocks.c       |  3 +-
 net/ipv4/tcp.c             | 15 ++++--
 net/ipv4/tcp_ipv4.c        | 14 +++---
 net/ipv4/tcp_minisocks.c   |  3 +-
 net/ipv4/tcp_output.c      |  4 +-
 net/ipv4/tcp_timer.c       |  9 ++--
 net/ipv6/tcp_ipv6.c        | 17 ++++---
 net/mptcp/protocol.c       |  4 +-
 net/mptcp/subflow.c        | 33 ++++++++++----
 15 files changed, 209 insertions(+), 48 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3

