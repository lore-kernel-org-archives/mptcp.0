Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B093B7B91
	for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215792; cv=none; b=F7yf4ujnAKU4WHxGJa1yL0v+aUS3NdoBM11Tl+3rKfQpuK7I8pj4xsbVnsuyXegjjETemf3L9E8uYNfAi6GRz0NSUuqPDOqBbiHcikt5qu5GwlN2ST1SrSO7Wy4s+rtaJOaBan+17LppoWCb4TL4NztCcAl98wd6eJL0STxcAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215792; c=relaxed/simple;
	bh=FDmpie23sScGP+OdflWzKGb+2xENXEuu2nCfUaQR7H8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HVD5x8IjLl7FBj4QjMmTvqcEpAwalopu4ru/AlnptqUunhNVIZua9jC9p5G1eRahlPilNT7qPtBfDrkYZEn2PwyCiuAhWAYliT0pW3fZh1DaZMjMTTk7HAmmeZWxERI/KJ+uJqNfCUZrJbVbwAyhiCF+hfyeIB+PCJErStoQAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtQ4Y0Gn; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtQ4Y0Gn"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-41708f6aa5fso2531189fac.2
        for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215787; x=1773820587; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRAOu3vndgNWWBgUC2jVEJ5hsRD9mDPq+B8T4vBDYFI=;
        b=QtQ4Y0Gnpw7YcVt+Y3b3TY0mk32qcKI1ZVi4y8u5RhziC0+Aah1bRkmOBnVSln/N6u
         Sh/gAYqpIFr/Irk7t6WWTFWWCfYjLiOeKN1xU4h7xzLFikMpmyzfKsmr6qfaVCBG0lLu
         5y5kJOlOWkiIpLjUqjwC88HIeoscbYMZjhRHjvAdebUpFqewwxYRvgy2Loh+izh07IoT
         EK8BYicZmGAx8Yeh7bgZS3XWVSd0d/iL6wj2NqzeZ29gNaVD1wB86K1gp/s4aOubocCh
         vgu8SbmAIw9uj5VUnMbBlTHc4B/JRY1R7rJa3kxKo/IzR+Hur0WDCboWdyWjSGLfjg27
         B21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215787; x=1773820587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRAOu3vndgNWWBgUC2jVEJ5hsRD9mDPq+B8T4vBDYFI=;
        b=nyJ/S+3YI7pjq1YToIuF6amzKBCDu1P4ZIRuoWsjxhUqQGAhIqky6F7M6GPBr78Rtt
         Dad6ABgMS4KM5vXVkRUD6u2Uv67CTdaK2gRkc9Hj944EFhwWkwl7QbSEwnzQeVD7DihA
         fb19J4u8VE3YXRTwhlmsCvrxC0UBTgDFR6kQBYIQRgd/N6+W1yV3n7+DEEWbM10Peh0u
         i44xgA9cfUgqAMBJXbpGwrRhlHHlDntSFi9Dp+2NFdnnI+xZvDgElo2Nhh8U9Ktfe/cC
         qlq4ifPoyZ7suGvCnsj5GovvQzKlLgxloWZV9F02Yd81K66PBFCLmtjLXbPTv/GC8aOe
         MvDA==
X-Forwarded-Encrypted: i=1; AJvYcCWwGDSitwEr4xYD2M2+K89NO8ShNSGAPnHfMiprZcUW9QbIMZOb1ugdm457PSoOoiEL1lwexQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxgq5jpgAjynbcb3iwDF7sOXfvCTgjz3jHKdsLruXO25aMnnYBr
	3H1Q5YtUTKHlH5b8VP3nSyKxr194WMYaCJgEoCFUS3j7oG89GeCrCeoY
X-Gm-Gg: ATEYQzxt9702z952wqSkLZHEJLcayH7EDgnBfitShrlArNIie0lhFAPMX7a0yo9G4iG
	3iUgS7TKunfcsaOhYwb8VsMcHRpNxZB4ujwEa1ZpxF1aPO+9fXwHR47RfIfj2Wch+NBXVxGGMXc
	IKbkUG/Jv4L1cECM1w4fGIhKXC2m/+VSmlUPVSAGvXV9cjaWj/kJnJga/zfFARREacuNReECz2s
	2+gyt85ilrmJ/rs4acvQ1ArdsvEToEPHO5e7wXoMZegF4AEOzg6pR/9oXySdw/bd4z0o/wIMuK9
	ZM95DIAv3rQ9eyzgYKsiU6CrkPB36t3EmLowEiwxcz+5PxZmJw1qsp62IX//mPHCVkM5lM1wgzq
	H9TbrV3hhiFkpVWKBzmKGuIa3kyYuxiQac5VwVVTnNXgOosu6Luq6eDTW/pf1oyUUwOgrqjW/Hl
	2lSszsvlm54Mk2rvcLBpr8N9Z1GnOI0svbR8zgBImzCoz8e46YieGpJroRLsdTMCBYWX1Uk0Ouf
	LK8EUFMYcyEHcwqg/ZicseA0RnFe2zV9QebpxuL1FwILgj/
X-Received: by 2002:a05:6871:8a5:b0:409:6862:aba5 with SMTP id 586e51a60fabf-4177ca9e65dmr1127232fac.25.1773215786910;
        Wed, 11 Mar 2026 00:56:26 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:25 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across receive-memory decisions
Date: Wed, 11 Mar 2026 01:55:53 -0600
Message-Id: <20260311075600.948413-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series keeps sender-visible TCP receive-window accounting tied to the
scaling basis that was in force when the window was advertised.

Problem
-------

`tp->rcv_wnd` is an advertised promise to the sender, but later
receive-memory admission and clamping could reconstruct that promise
through the mutable live `scaling_ratio`. After ratio drift, the stack
could retain or advertise a receive window that no longer matched the
local hard rmem budget.

Fix
---

- store the advertise-time scaling basis alongside `tp->rcv_wnd`
- refresh that pair at the TCP and MPTCP receive-window write sites
- consume the snapshot in receive-memory admission, clamping, and the
  scaled-window quantization path
- preserve the snapshot across `TCP_REPAIR_WINDOW` restore when userspace
  provides it, and fall back safely when legacy userspace cannot
- expose the accounting in tracepoints and cover the ABI/runtime contract
  in selftests

Series layout
-------------

1. track the receive-window snapshot state and helpers
2. refresh the snapshot when TCP advertises or initializes windows
3. use the snapshot in receive-memory admission and clamping
4. extend `TCP_REPAIR_WINDOW` for exact restore plus legacy compatibility
5. refresh the TCP shadow window snapshot in MPTCP
6. expose rmem/backlog state in `rcvbuf_grow` tracepoints
7. cover legacy and extended repair-window layouts in selftests

Testing
-------

- `git diff --check origin/main..HEAD`
- `scripts/checkpatch.pl --strict --show-types` on patches 1-7
- `make -j8 headers`
- `make -j8 net/ipv4/tcp_input.o net/ipv4/tcp_output.o net/ipv4/tcp_minisocks.o net/ipv4/tcp.o`
- `make -j8 C=1 CF='-D__CHECK_ENDIAN__' W=1 net/ipv4/tcp_input.o net/ipv4/tcp_output.o net/ipv4/tcp_minisocks.o net/ipv4/tcp.o`
- `make SPHINXDIRS='networking/net_cachelines' htmldocs`
- `make -j8 vmlinux bzImage modules`
- `make -C tools/testing/selftests/net/tcp_ao -j8`
- `make -C tools/testing/selftests/net/mptcp -j8`
- `packetdrill --dry_run` for `tcp_rcv_toobig.pkt` and
  `tcp_rcv_toobig_default.pkt`
- `virtme-run` guest pass for both packetdrill tests
- feature-enabled guest pass for `restore_ipv4`, `self-connect_ipv4`, and
  `mptcp_sockopt.sh`

Thanks,
Wesley

---
base-commit: 908c344d5cfa0ee6efb3226d22ea661e078ebfa0
-- 
2.43.0

