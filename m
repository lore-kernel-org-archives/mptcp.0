Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4513247D
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447181; cv=none; b=t3V4Uul4OHGdtoQjZJCLLT8rO6NHxKXDo+z6zFL9LqeTk3HySRZUSqiw/NiAweHs+wC/6txQ9SkOm5nHVR61XUt3fJfzlXjZCqMfHnHYZLFMKru+Yg8Myu/c4v1dlCIwmpbNDb77mxzF1+uTU71lYhrtpHBm2hV2pm3GvWJZDcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447181; c=relaxed/simple;
	bh=iYR1OrxPk3A1vKJQVSmt7cNExAjBfIB5lBVL9JnMP68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BEWjFVAr2tv3DlYvVSJNhHz8wzULiivIvjMRlE/7fekft3S8uoSVryPkj8DAbSg8X2nsb/eYbI3rHUi2HGSkJCQraoOZSmvQM3JYOMdMyWUH7v1sGXovM0XRUpQH2nMQotgUJeK61Jubvo/3gkz0Is5kXntNjUvGzDaAOFPwWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtM6/dWW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtM6/dWW"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f074520c8cso851004b3a.0
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447177; x=1714051977; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5fDxSBarwXqYnNyE9xgBbxngQ2AUEwn3Wxv/dS4CR0=;
        b=NtM6/dWWeKNiKHPnyN2EMDDzB+0TvNs7lILS85/7Nk/X67BvvdSuObNi/ZkMHKiVKF
         qiARZKcNlC/qNsvMuE4cmhG7W11stK6kqVLWqiAhAYkzDtpf5zzJqR19+h0dXqVFrI7g
         f1xQLeN6NxZ9Z9rJcM3e7dFFrDK44KCMQbKitgWoarxd1zRWm9W2+mTmfJtqxAgo/ZW5
         jhUvHaZhSvIRKRGd8GVnwe8MSlZwY8xe8NFOsR4OiPluAOM9Cyx5e8DPAlr2jQiOcZ87
         Xdcebi4nLd6QDEGIIAPgOBUAnZAuSOw7JfAIRHNdm/F+9EOdq7C2eaBqdNzjIV52Hl8+
         o8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447177; x=1714051977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5fDxSBarwXqYnNyE9xgBbxngQ2AUEwn3Wxv/dS4CR0=;
        b=KKGpmEqh4U6/UF4yJs64SSwK33l1/59TVYpHBSjP69yTh5ls97SutQQKt42LIeFBxS
         HDXWFQahfO0MLKmt4kpVCs9IulC2tDcTqXS6b1effdXAZ8M4S+M2/07FROoiJqYKZAwk
         pxm/HsEqiUDWA0A27ClQc5ZQYRs+WRXIb7JjEv5VghPMlXK6KGQ4ym5bA0wu8rs29Gpn
         Ni08PWlsJKl0v8ZlPycdJxhbg9btU8Q5UCPOwPN+aKotAkpij6QCG7mGPpLQ3mvGBEcs
         Zo6gfXSCaF+RWGLhHYdKmHWE3ztMywoFuiBnVxCZLMeQw+bbGfIcESMDPbmdZblDN0+I
         zoUQ==
X-Gm-Message-State: AOJu0YxeRUMptiOm0EslfZsXLexU7Z3Cn3EsGqNwfB4+o/D5/85m3zB6
	cFA5DvC9ogAWF/DIZi0e5mxWKmeDo3m/cmvBHPm9kJfee7ZSv7fV
X-Google-Smtp-Source: AGHT+IGAk75lhjyuWo4eZLtm2wg4+N/OO1aSFQFnDqUzCdCi4+ZZ0gNj+YggQD2SQ7R1+s/su9165g==
X-Received: by 2002:a05:6a20:748a:b0:1aa:14a1:e5ef with SMTP id p10-20020a056a20748a00b001aa14a1e5efmr4072308pzd.38.1713447177414;
        Thu, 18 Apr 2024 06:32:57 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm1448819pjb.22.2024.04.18.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:32:56 -0700 (PDT)
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
Subject: [PATCH net-next RESEND v6 0/7] Implement reset reason mechanism to detect
Date: Thu, 18 Apr 2024 21:32:41 +0800
Message-Id: <20240418133248.56378-1-kerneljasonxing@gmail.com>
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
2. RESEND because the status of patchwork changed.

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

