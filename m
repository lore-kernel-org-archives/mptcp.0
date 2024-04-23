Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3045BE1
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856908; cv=none; b=J2pzBjk9q4M5xB8ZqwJbjiVBklgw2xoSMC9xothYzYEVwMd+VhPSsLybxaFNrwK21dXKIjmka3fawmpJV1/JDxkmTrrebJnP3gnNyxOSPKi3GoSG04xX7LLfcPpyO5WAP4l6JFDFzzfgz+qj9mTnMKA/2qR9pVqq51gWiYDdWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856908; c=relaxed/simple;
	bh=YBeJMqd38yCDTXGSQCFQ1Z3M0MpdfWLJDuf5kSVsHrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LfrwylIvvRyM/fKgwZ85SnCXUvWdrskzlPs1jcggadaducFUgBqc39Q5CYWDvLxHM2C1mbhskPHZBeztNKob+VgyDFFC29WOqH+MfoJu3q2BoxmwhvUvEmjxlHXo8AgLKwvO/tuMRXuHyC0B8fs0E/Ue8x9U6Fd/cCUHzDB36D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/tSoX4g; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/tSoX4g"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3c9300c65so45275685ad.0
        for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 00:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856905; x=1714461705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWErk60OMZvREVtFAcJcEocSc4JBIDxVWbO7tBYd61Q=;
        b=A/tSoX4geBs7i9D/mZwVtuyxTPK+OTcpl2y+LkQ7Dg2Z9NTwu9+G8DlAtBbRjKYthO
         rE+ax0lwc56tc9rMHGgmd7+25CrpqUqiu08044WD+KGy1F6k2SCML4mQwQiyHfF1/rxn
         /on2THWmvhVGZQ/BkrSBzaVeYVVXOimXiWBWD5sGu0BYKMrGNjoXEkaNfYh0cf+A2e9e
         W+ED89Kr66LsoWY8WyAbjvbv+7v/zTDB8agZdiZYgot4XSzG6h6Ys9bX/Jbr5GBVA/OG
         Sht66wn8bpq63Lb6Wd2eieOqvGr/vTllmyDVABFitUCFvgzYgZ9WUVMxO5HtTraQAZEy
         slUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856905; x=1714461705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWErk60OMZvREVtFAcJcEocSc4JBIDxVWbO7tBYd61Q=;
        b=EtNmoCsEDkkvfT1lmiX2nmzXprfPBm8wTRw24tsE+whcE4czNO62ADtYjkKH+5aykj
         ItAWsv1rWQ1C2eq9K8jTlU2TcM9t+AUMsL3N2nPDHPFSwRxknRVyPCLxftBWeeX7TxMw
         W+jqcISvv12ckO2KKBVuWZub3mv8ZB2FJ/dwH8BqHVefPzgFuXJHm8ATj9QC+d6MQQdh
         k+RtH7wsEKrnOwQQoyN4H/EAmFjkS3PS7qDp10A01W8ZrSIBDrUEEYHA6wBuNCiZXaOZ
         FU1Di9XtKnIGvyyfV0liWDl5tJUmYvImgg+Dq0ih3W6+F2LJa37/grGSs9bd//kN0WCq
         E1Vw==
X-Gm-Message-State: AOJu0YwzzB2PvOSfJDQCzZadwMD3scueEq87DNr9hOCnwprS29W4KYI6
	Wp3z0201mR3MpYFOy/YdKOKbhR0s/xv8K8TeQbyBaoZ9sUGpNmMh
X-Google-Smtp-Source: AGHT+IFquDDTD40LicZS6AbgVpC1YZJ7/c/75vwmyLpn7BIYRsyKqh69oy58mVxb79glOZMWs7ZkLg==
X-Received: by 2002:a17:902:b68b:b0:1e9:6609:37d4 with SMTP id c11-20020a170902b68b00b001e9660937d4mr6536313pls.9.1713856905568;
        Tue, 23 Apr 2024 00:21:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001e0c956f0dcsm9330114pla.213.2024.04.23.00.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:21:44 -0700 (PDT)
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
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v8 0/7] Implement reset reason mechanism to detect
Date: Tue, 23 Apr 2024 15:21:30 +0800
Message-Id: <20240423072137.65168-1-kerneljasonxing@gmail.com>
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

v8
Link: https://lore.kernel.org/all/20240422030109.12891-1-kerneljasonxing@gmail.com/
1. put sk reset reasons into more natural order (Matt)
2. adjust those helper position (Matt)
3. rename two convert function (Matt)
4. make the kdoc format correct (Simon)

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
 include/net/rstreason.h    | 121 +++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |   3 +-
 include/trace/events/tcp.h |  26 ++++++--
 net/dccp/ipv4.c            |  10 +--
 net/dccp/ipv6.c            |  10 +--
 net/dccp/minisocks.c       |   3 +-
 net/ipv4/tcp.c             |  15 +++--
 net/ipv4/tcp_ipv4.c        |  17 ++++--
 net/ipv4/tcp_minisocks.c   |   3 +-
 net/ipv4/tcp_output.c      |   5 +-
 net/ipv4/tcp_timer.c       |   9 ++-
 net/ipv6/tcp_ipv6.c        |  20 +++---
 net/mptcp/protocol.c       |   2 +-
 net/mptcp/protocol.h       |  39 ++++++++++++
 net/mptcp/subflow.c        |  27 ++++++---
 16 files changed, 267 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3

