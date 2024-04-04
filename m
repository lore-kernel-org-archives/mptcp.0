Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0E55C13
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215265; cv=none; b=nQuNgzS0cvF/7AM2gi7F1x27iySkp0uMOn+pJ6N9c78/eElXl9mykkNx2lGW2ciR9yDNDzDRJYV8diHH281GAoAdZkYNAMMwfRriSWxAqUiJ8Ka5zcisfYx4gTU67Pe79CZf1VEQaG/QJ+YWmTsyqBEvWeaoHgZE/IH6Gb6hLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215265; c=relaxed/simple;
	bh=bS2zUaRfTRngCpa6lT7u2GS1mxMYCc/jRy3dQP9i9QY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNABBAkIi3hQfWGR+mJECv2X5xB9ADH1322k1eovcD/4/sn8fuhZ0Sisdi+1WfF/oWsO96JIw/b+ZdijXBllVWrRSVnE33LU/tZSNRHRv2O37NmlRHZ+tUsX/4yn5Upkwye4U65OIKqy8iOA3LVzvu2v8gwpxuhUnB1ijAvPRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtnmO599; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtnmO599"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2a2d5f0b7so4837265ad.1
        for <mptcp@lists.linux.dev>; Thu, 04 Apr 2024 00:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712215263; x=1712820063; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P23QQ7cM+n1GuwzWV0zi1THXETPvgkpLzdRS02BkbFM=;
        b=WtnmO599mP/CsYzbGtEwTjMjUt0w9kIgmR8xa/Ka+dV+jwtAKIeAmzPpWwkBNccUDj
         2jKO1GF9Ou1zvoUmdkmazlFweJeAtS0RFDj0P9cjoqdmgpF8BCcElZ2n117mboD/PJnV
         kOw23y3hUBslZF+phJ9GiTU0N+7Rt+Cdvkx8ho96h1gmMUVLfy970VqNON0YeVkRib9H
         r9V/LCKy6PvSVlmkoN5qG+dnoTKLz4yMHpAFUE720frzFwVRXxItFd1T/aiVYpnBY3hw
         ZlsS2RoIkWAFrximE1unZPmeLoZ8WuXHiqzbevAQnuCmEmEo2GPMkeu9nG96VBdsebvv
         1Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215263; x=1712820063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P23QQ7cM+n1GuwzWV0zi1THXETPvgkpLzdRS02BkbFM=;
        b=hRtacUdjf437lCznXaaiLjDrerzcl8hMKJuB6C3lWsy7LESqVpczW6cf8TXWBK4Ro+
         T3XoAVcJaUlx2zHaDcFkSACXppmAlaoYUWwXvZUwUOs/gLyyWW2AIUVtU7UXoMZeNggf
         C/rRH8hyf2C9xdevN+lp7KIrWfOvVMNbWoVhPDRf38X/YJMtjbK5zEE8baiJKkJ2kVDy
         OQ4ppLUHzphj1kgaKTxlzQpQbgw0UrO66vm5fOpCu3dWRSzdhuGUKWYeACvvGJiXGaN5
         Bg4vBe7BeXiiNeiYXRWX/HrNs3pIQCIAHmbg2GsVA+ABHh655ijZilCG08EIKZlneAT0
         /2fw==
X-Gm-Message-State: AOJu0YxgDr1PIXgwsWtr2apfoYXcsqzdMe6qCkmL7VV/biwkoLzfX4yn
	7vjx7x7jHUz9LZ8i3MS2VkGJTisxRt2oStPfSuMNazwJnKFcIXWe
X-Google-Smtp-Source: AGHT+IE1ue1dKzRgFAhN0ulqPUkC+kC5R4oawWdu+topbNZgL9btF7YGFh21dE6Fm/01R9LURLAINA==
X-Received: by 2002:a17:903:22c4:b0:1e2:9d65:2534 with SMTP id y4-20020a17090322c400b001e29d652534mr1523352plg.42.1712215263038;
        Thu, 04 Apr 2024 00:21:03 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001db5b39635dsm14606399plp.277.2024.04.04.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:21:02 -0700 (PDT)
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
Subject: [PATCH net-next 0/6] Implement reset reason mechanism to detect
Date: Thu,  4 Apr 2024 15:20:41 +0800
Message-Id: <20240404072047.11490-1-kerneljasonxing@gmail.com>
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
 net/mptcp/subflow.c        | 33 ++++++++++----
 15 files changed, 209 insertions(+), 48 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3

