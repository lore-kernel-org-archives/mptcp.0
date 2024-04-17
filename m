Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D955D8F6
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343912; cv=none; b=EpGqyK1V4lkcp3217asqrJOBtQMpNkQKGV4Khu4qDK1n/GmhWsF5fb8Dl+IPWY5aLvOOSXPLPW5tzQ5TXUudjkfkV3+LKDjNrNkSMBh2segQfMZIlP0iQR+6zmS3Xlm86iFzXtsJTnkev4bvou7Vii6RnJ8t+xiYHjDv65PzQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343912; c=relaxed/simple;
	bh=NgyKHTOEFBJXVFGLR/rWuf+lbBUP8ErMGBd3Y6OKmbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mVGu63ds1NNDjVHtoq6/nl2kmlruN8QCN/7TtmZHANAyT8GxvXoE/Tyk2hEyeUSzvLkHkcQkY8Z9Wfkb4GPvAZFM4gyjsnUjtsF/gIeEFtGlgmwFZYemeuZP7I7oKfDUMmSCHb4v7dkHGqaG7WqyNJglKqdxioTKw0NaehYnDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxG2fR9Z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxG2fR9Z"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e651a9f3ffso19134835ad.1
        for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343911; x=1713948711; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OvmW+VBePs02RkEsQuZab+/Oqh+Lls5Zc4vbzJd9eTQ=;
        b=MxG2fR9ZFGwyeey8JKzG+kDO2M3VWuK1t9wpoUNQVoK93H2+99p3V3pJ0MiNwzBDRU
         CX0GkDiA9Iy8zlaErW7bJ69w7rgQrbwWMoNcQ1qGQTw5GheI2XgtRQpH4EoNsxfT0MOE
         PTMgeMHUse7zwCXyZyQG/99yiBddQSGz/ugvlaZLBYYp3hQ1ik1U/ESjGWNpvGW47xdw
         BwV5ycHLLnJ0i9l0yMhHx83V3Vvra/Ev5WLggzCgb3PLekc5RrVcbNfoFMPLxwVPH0kV
         hH2f2z4U6HLds2Ci68pzN1QMPno4pWyT856uprGdHeHF607wgQY8tPdVSlqgfF1oNAg7
         xm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343911; x=1713948711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvmW+VBePs02RkEsQuZab+/Oqh+Lls5Zc4vbzJd9eTQ=;
        b=hpruDuLKrHWu8GJRLucZYPm+JQ8V+mLMntpQgG0ZCjwDEcz1XfYrpdArusgSIfk7k+
         uy17WIR4YHxLsvjJmvNWT5LyFrVqZgPx8tcGM3hrOpnB13xH5Up33sgJBlmnj6dVlm7U
         9epiZ+081xmTEuIh1FgsCtAIhNbxNqhgJ9aXLoYJegjnGD466OLjWrfF2BsQ/BJJPLbf
         oIKcMrhxpmiaKbmGdRk0HCj7MpE0hBhfH8W9B6F9BW+rwGjH9qcTkGUlMLp7MfWJbVol
         Dn/221GX0VmzrQxN8aygtw/EZDt0SocdXpKWN9htfl3SaL6E1yi9pGyW3yPlRiv+NSX7
         XJXg==
X-Gm-Message-State: AOJu0Yy2s6m9ybVywagOd+DG6FJobzgyZG3b/I/xigWHVEHvW5xYso/F
	ELiJFUM3j1x93DcAnwCX9n9ucBzVpqlDFlcr/iDzcyg3fk18XtuC
X-Google-Smtp-Source: AGHT+IHuLKY1a7HsVvEY5xQE/35OD+dmhreFwJA/hjEl4umoxJx0PFFkc1WIiYEP/d051p+T0bBgfg==
X-Received: by 2002:a17:902:eb81:b0:1e4:4125:806f with SMTP id q1-20020a170902eb8100b001e44125806fmr17993764plg.11.1713343910743;
        Wed, 17 Apr 2024 01:51:50 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:51:50 -0700 (PDT)
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
Subject: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
Date: Wed, 17 Apr 2024 16:51:36 +0800
Message-Id: <20240417085143.69578-1-kerneljasonxing@gmail.com>
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

