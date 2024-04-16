Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D2127B5D
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267619; cv=none; b=ie54q6Wpnq5k+lOafWZwXKv/U+8JO0e9M5n8a2V2Tqn/RCfVjLCFyRHz45ibjJz+oDkgi4yQgunlgLZDIc2eZRlVVs2StH+aZcudqUDXbrQVZK0Fe+B1Y6S3jNc6hKX4V8oi55ENnCB1p6tSyR+hwZSb42UZYS+ESQeLKZ/L2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267619; c=relaxed/simple;
	bh=bMHexggEFAP7BIJ8i9M+5aDV6PJGpmiVKntFi3s/umo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OhQeh8HkQgzgwHhIPF3dWjDlgVM4+PppOutFcu8T2yDgnc9XkvMVUph6vU0zq7WhuUzBUbwpLCuBEVoXuueoTZcezUrE/1pKNeHEe8NBy3nmmzwEtsNO9DibFZ3GL98+A2RUA9KixQG11eY3zfJ80gDU8Cus4V1aoC0rA1446rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIkOUeO8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIkOUeO8"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed32341906so3754399b3a.1
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713267617; x=1713872417; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D584Ey7dj7Uc06fGbbWqllzw7nDGrh0wvYItcfpmMYI=;
        b=PIkOUeO8SXPplmSKMroOz27I+Fy6ZrjshBUfl1hB3iLOu1URbkfv+FeNHY3NLJi0aa
         M/8FWRzT7C1JMC6x+VBLtcvPxThAWS7XHXVHPoUezT2OU9X+uID6ohgWOpCrp6+ee7k8
         eGPGKgyGNboaD+g/v6hl+fCJEbiQr3OzPkc7VewU8AXs58hI7pgxcD6huzxr4pIPpFiR
         a3IDX7uprwB8Z3Md83bi2CtcMBeK0ZEgGVKAJ3X8yWiWTfLvt1YArQY/DyDa5PTk7tnQ
         G1Fn+IlzfRCOxq/tBK5Nmkycm2CnIQR5vrhlUnZvR6ZW4mwzJxm2HHboIBKkzPFErhVd
         9Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267617; x=1713872417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D584Ey7dj7Uc06fGbbWqllzw7nDGrh0wvYItcfpmMYI=;
        b=Q5hxw9Kccp2p9NiGnTEFRcbY3cqM7vxZXsmIiSUebbnoCz/OtgDYJ07gMpmo4lUxfi
         ttxWSKljqbHTHBRHjcxoJb8JGC+nJNKVMvFsIhrk7q0WglDZ7Bb2AelksOdHcvAffF24
         sFAVGtQXvet3yeD5seW7voK4gTmRUUYAdbEqeGlFdIqC12LxmA62SjapPednZx/QUU3c
         z7krim2OI2ZNxuujcWYvuBAak3a+s/QsemVs1Eif95hrKPjR0qFG89+6zrTYB5jzBCxb
         I9XoaMpMrWvUQCWR4NpL6tKWYeC0MeRvtPQu7uGA3rHV/eWNn5i+2/Ai211VcGVKe8He
         Ktjg==
X-Gm-Message-State: AOJu0Yx7oqRLSPG29lYBowW/RVOd5Dfw+JNEiH/OHMjYxJ1wDaWziPtz
	W7x+sT3P1mBDPIXfM5fBRPuMoY6d12C6sjwptq1ZQWrt5yXfGjyQ
X-Google-Smtp-Source: AGHT+IGX+zF8CmopMx+clskbHNVd/d/eVMbnT0wtTPnMZAB18froXkCVhjaiAddKDedrmnuhFOth6A==
X-Received: by 2002:a05:6a00:1708:b0:6ec:ec8f:d588 with SMTP id h8-20020a056a00170800b006ecec8fd588mr12861623pfc.16.1713267617432;
        Tue, 16 Apr 2024 04:40:17 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b006e6c16179dbsm8862045pfo.24.2024.04.16.04.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:40:16 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/7] Implement reset reason mechanism to detect
Date: Tue, 16 Apr 2024 19:39:56 +0800
Message-Id: <20240416114003.62110-1-kerneljasonxing@gmail.com>
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
 net/mptcp/protocol.c       |  2 +-
 net/mptcp/protocol.h       | 11 +++++
 net/mptcp/subflow.c        | 27 ++++++++---
 16 files changed, 216 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3

