Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D380630
	for <mptcp@lists.linux.dev>; Tue,  9 Apr 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657408; cv=none; b=camFT80Yf0tgia48sBlp3IeTrjT4kw9Kj7nkaLOxB9Mp+0eJCHlvuN1ynXAlIp+W1b5MM6b3A8xUM7fVkS/c5HzB3Nu4sSbzgZ9o9jxY0Svuhn/ALkuY55S+Xr2SNRn/ECA+f7ZuNJvPeshsGb7cTX8wKTyU5TSCqi2NPEyE/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657408; c=relaxed/simple;
	bh=za5Qe3T81KPoPvfYbaiKVVOcs3g03twc/hkiVAkW01s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWX9KfcvZCxus7FZoYsVrqhKszjM+UKBBMGjgKCnyxzxdkte4jbYUyCkcSlnwALqoxSYb+Kf4t3SiG2oUamaoqOySAYXz1JbvIF5KNwg4wdzfulfO6ot2VtCd6XKq6exeekNScdh7gsX0eeijpgvp0Y1u5vpu2VNBx8qGql7sN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0YkexPb; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0YkexPb"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a7d6bc81c6so3819577eaf.2
        for <mptcp@lists.linux.dev>; Tue, 09 Apr 2024 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657406; x=1713262206; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8mruov800edUKD3s5DsSyAgW1ponzVgToF/35nN5w8E=;
        b=h0YkexPbLC/LFnG4onf3+XJsKrBGCVzk1P8pc18z172QlKrIfazQJiJ8xG180NHhx6
         lf6GvjT/gEUp3SwMho9FFFG6NqUjsAkqU4kQbAktyEDvPAUUGCOjzowsUmtkT5cwYIt8
         reDe/48M5KLRc5hb+AOUyEMR9rpzPycZDS+IuzxgOTnrETnnGWRz95KLRuH+ok2YTCB3
         LVdx7HwBt5ONDY3LrUxFrA4i8cNdn35JDsBst/LK+moabTZJ9Oex5HgJslw+fK9LXwra
         CZOaqhJ3+XoR+1Xd5xYeewG1N7+ITX7Ei+IuGf2/KCtNXaddqt/tgmCihuxg6JFZ7+vo
         X/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657406; x=1713262206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mruov800edUKD3s5DsSyAgW1ponzVgToF/35nN5w8E=;
        b=kUsSYLwWV4Y465agssogmi7Mx1sGjFVoa3neX3q2sy7ldHXqMe91yeFx7FGlDNjyPm
         7nqQ65udOC7/Lb2CMsJ4v/CfZ0Xxe6wBC7f0KH86cxbM5GBTBlXnfozrcUbRZv4+tPii
         vIB3nX0WgmukPsddxsL3LRVchFXBaDHi5c3vTyqTefiD/Pn2EH1VJn+fYETHYDE8QZw+
         oAjnzPyuGD1SYluCXyZs0rGLL2rp4nNYcQibYOsYFCOGBODE35MdKWx18YjXTuvrB4MH
         tAoLihS+SZbkCFSeXlbh7r3gjnsLu97WYxNsPY/coT5sCurG3+mmfRGsYPfPWqLlZf1Q
         /B0g==
X-Gm-Message-State: AOJu0Yx2IxKJg5ep8UduriZn7B+K+E0/S/eIVCUOQPIMwuAeerHbFC0K
	ymB3j8Ag3sAnEVVS/IqeTjBNcNlerMKMBH1WoTHbc7S78gRwOhe4
X-Google-Smtp-Source: AGHT+IEpEcoa0r0grFcu8YL7LH1ud285pJaTKCEQ6oxemBbkGixnvtKjoqeL6jo+fpNygSLBBDJY+g==
X-Received: by 2002:a05:6358:794:b0:186:160e:927a with SMTP id n20-20020a056358079400b00186160e927amr10112593rwj.25.1712657405870;
        Tue, 09 Apr 2024 03:10:05 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.26.66])
        by smtp.gmail.com with ESMTPSA id fn12-20020a056a002fcc00b006e5597994c8sm7959130pfb.5.2024.04.09.03.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:10:05 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/6] Implement reset reason mechanism to detect
Date: Tue,  9 Apr 2024 18:09:28 +0800
Message-Id: <20240409100934.37725-1-kerneljasonxing@gmail.com>
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

v3
Link:
https://lore.kernel.org/all/20240404072047.11490-1-kerneljasonxing@gmail.com/
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
 net/mptcp/subflow.c        | 25 +++++++---
 15 files changed, 202 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3

