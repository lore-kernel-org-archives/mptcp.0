Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73A440C
	for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754881; cv=none; b=t0LkC3g4eMzp2kIRvNHHp1dAdplJErlKi4NYnvxWsu9QtJhgO06QuVoq4cJhbH/SrH0e+kUW5tr9QYJkWm+DqMeRZKLmfaeHCscCkDm/CH46Nz3KXnD3omZQfZCFS+ajQtE97zdnEXHOMZkiUS4xSLyvoKq2Sr37fNc0m0GxWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754881; c=relaxed/simple;
	bh=0KtavVRG3hlUNjZicNl7ABD032zI5PIuaPRFjowr1nc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YIGE+LhyF1NpIKCf8ZO7uOB4s7A3i0zk+w7zAq6ohx+vgWLhGuealsZtHn+ufr4e5eOmyVcvcd2TdbcCfodg5k71PE6RFgpOc3WRaCBPbLF+qcOgRhXkC2enlkRbHgJfv4tlPdejkvHuIIH0wXWlIS9zGtzQIcqFrHK1HAd/jTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlMZCxnD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlMZCxnD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5c7d087e1so30630365ad.0
        for <mptcp@lists.linux.dev>; Sun, 21 Apr 2024 20:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754878; x=1714359678; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XljG5YRDxxuTbg/PB8CT6pUwK7ZygQaCcZH+FSSuM8=;
        b=MlMZCxnDo6ORiPcqU7m8IwYK9X1k/n7vQUq6BeVUrPh+2TiHWGBA8Gi/o/iuLf7i5Y
         dhppvU2RaROuJh4qK39CyLLsg19lgXqO3hi5Ma6/OTGMAAjpIRWADeSUYrIwGvr/TeGx
         lerirJupUyzoazpuJd+/ec3mBRBAcgHPsdHqZjFqobwC2bFEdHOM0XYztWcI2u+LT6/f
         7S0rqLcp9X6LQzXouM8Z1Yqqag8geKGdlrHSl82vODU6aR0ueTUMer6rXKoxg4Iw9XsC
         DMzYASZsy9/jtJkjivZNT1NrxLRuv+j3d7XHVn7o9/pTXlAt1ilKOikkxmO6Vh7954j0
         Kb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754878; x=1714359678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XljG5YRDxxuTbg/PB8CT6pUwK7ZygQaCcZH+FSSuM8=;
        b=WHZK4PNAR2Cx/r6hRVhpUCm5unIa3vK18gbT4VNL505MZ4rA602AX87yd8SvbAe3sx
         hwytgWCAepz3MAhDZhk05trtKRlE/bA3gwchysgOuSyKRthzUouYlfoPbdwRSYphJwqX
         MoPgIXVc3hRy354S5L1gYw/64K9g9J7wddMFUtJKmryTT0X9p+WTR7pFGkasiBbikM69
         QWKeK/+oiGDME466EfcFFj/8v94yiDr5D6fKpFBEcKZmW6iKgd0EXKHDYLsZhZ2rj5Fr
         A3ixGYWJHXEVMJWJY03xXVzPzSjCxbCL8o4ynCDba/coQUGUDW5C7yiWbGhOc0SHSSYc
         C5Cw==
X-Gm-Message-State: AOJu0YwLFVDBcayNzMkHU7viXheGkOqsFnz9XOO2OhYWsGuX3esCymB+
	YGewO1HFXWLCnJr4Jy6+wPn5keXer/+GBom+pp4sO6vIlsvQxpG6
X-Google-Smtp-Source: AGHT+IFcDVA4AS/+M1qBmfi/G7Sn24v8ZXC4grTDTYRt3A28mIGhXAJhQdX7Heoup0onIKOJeZljEA==
X-Received: by 2002:a17:902:f644:b0:1e8:c995:4135 with SMTP id m4-20020a170902f64400b001e8c9954135mr9985227plg.56.1713754878155;
        Sun, 21 Apr 2024 20:01:18 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm6966009plp.280.2024.04.21.20.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:01:17 -0700 (PDT)
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
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v7 0/7] Implement reset reason mechanism to detect
Date: Mon, 22 Apr 2024 11:01:02 +0800
Message-Id: <20240422030109.12891-1-kerneljasonxing@gmail.com>
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
implemented on our own, such as active reset reasons which can not be
replace by skb drop reason or something like this.

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

v7
Link: https://lore.kernel.org/all/20240417085143.69578-1-kerneljasonxing@gmail.com/
1. get rid of enum casts which could bring potential issues (Eric)
2. use switch-case method to map between reset reason in MPTCP and sk reset
reason (Steven)
3. use switch-case method to map between skb drop reason and sk reset
reason

v6
1. add back casts, or else they are treated as error.

v5
Link: https://lore.kernel.org/all/20240411115630.38420-1-kerneljasonxing@gmail.com/
1. address format issue (like reverse xmas tree) (Eric, Paolo)
2. remove unnecessary casts. (Eric)
3. introduce a helper used in mptcp active reset. See patch 6. (Paolo)

v4
Link: https://lore.kernel.org/all/20240409100934.37725-1-kerneljasonxing@gmail.com/
1. passing 'enum sk_rst_reason' for readability when tracing (Antoine)

v3
Link: https://lore.kernel.org/all/20240404072047.11490-1-kerneljasonxing@gmail.com/
1. rebase (mptcp part) and address what Mat suggested.

v2
Link: https://lore.kernel.org/all/20240403185033.47ebc6a9@kernel.org/
1. rebase against the latest net-next tree


Jason Xing (7):
  net: introduce rstreason to detect why the RST is sent
  rstreason: prepare for passive reset
  rstreason: prepare for active reset
  tcp: support rstreason for passive reset
  mptcp: support rstreason for passive reset
  mptcp: introducing a helper into active reset logic
  rstreason: make it work in trace world

 include/net/request_sock.h |   4 +-
 include/net/rstreason.h    | 144 +++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |   3 +-
 include/trace/events/tcp.h |  26 +++++--
 net/dccp/ipv4.c            |  10 +--
 net/dccp/ipv6.c            |  10 +--
 net/dccp/minisocks.c       |   3 +-
 net/ipv4/tcp.c             |  15 ++--
 net/ipv4/tcp_ipv4.c        |  15 ++--
 net/ipv4/tcp_minisocks.c   |   3 +-
 net/ipv4/tcp_output.c      |   5 +-
 net/ipv4/tcp_timer.c       |   9 ++-
 net/ipv6/tcp_ipv6.c        |  18 +++--
 net/mptcp/protocol.c       |   2 +-
 net/mptcp/protocol.h       |  11 +++
 net/mptcp/subflow.c        |  27 +++++--
 16 files changed, 258 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3

