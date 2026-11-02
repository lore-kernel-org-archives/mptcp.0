Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604078;
	b=Sh8sLCYCQSWT1DTUBU8Tgi3HW0xbMS12CSlOCfFXcVh7azl74xVqTsROPtpWWwaHMY18
	 sGaENaEhyWhlr8G8UlnGMOBkttIdJszSZ1hEtY1lgEYdM+D6HBbpMJfNGkRWlYzuHgwLo
	 6vFaJU/89+OG5uLUJtAXi8LJhldgidozJy+vL0B+Rnip8VrpoZ+KDnbEhZmcPtTH0lChO
	 AGT4iSJA3T+Jrp5rIWjAbNY9UZA+/k04C5Mtjt8NI8VMS+tHwcU+JeU+Thnz96eCAv9h5
	 s7urW/nAadaLkHMajC7dSSBrTfVDx5uRURqgh2iSSws2NJ0x4Lr2B5ZycyUYHmrgaIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bK+b/qrfSwKnSjxBPgQ7rRNYPJMfbkszlGWmScXGZ8I=;
	b=rk9pbAKLhZVasyZniQOqKVoH0x0kkbboUk+c880Q6/LEVyBChIAxkmUD7q0b203Um+rf
	 VpGvirz5+eDCnttNabtEtBqpURrs/MkT06RAI/BPpRMFD05oE9LP6kL7wLph8WsZ9wxSN
	 pZKB9RXg39K2nkvvwGJ8WQ8Lydru51AjT5wuvJJWEZiY67zAHJ+cx2iu4UiHKwM8ZeJ/K
	 o2enIA7dd4A8W4qLEnKahWnfgKyYtmvradmSk0WETfIN6/TBzYaEQJN4tpQmnZIxGzZ4l
	 sTeDn8Iqvh5Vi4U1HrqWbsvy5j3wqRi9QPvdRizaHfH1EQ7xQISrv8bh+cigHw4PEpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ew/gqHIq";
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD15606A326
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 07:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD15606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ew/gqHIq
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso913892a12.2
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 23:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604077; x=1794208877; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bK+b/qrfSwKnSjxBPgQ7rRNYPJMfbkszlGWmScXGZ8I=;
        b=ew/gqHIqMEy9+U6W2HR1v7bfbL4akfVvp0pYNUzZEo4KznAqTRPTuWJFtHKhL1MeKa
         I4zvNwxDZE8HTi7Gwh+El3IqN7yS1GryIFLWlyazdK86z6G1oww9on9rWOGFctL6VXCC
         y57BoLPP0X3hl7iyhxaXouZioXy6iLY0ETs+3t5yuF7E9JXSNJEWvpGq8rkmHkKmEy8M
         CB4FicKg7Q75En0A5pVwxUifoE5jXPjK0RsMTsR5esoJsV0DUUBe86fVXH3S9bs0tcRi
         lReLbdAxVan9YFXudHS45Ct8UBNx/3Jj6qGMHkTi55aX65q6Tba8Gokj2NZ/lFEz3RQx
         wSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604077; x=1794208877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bK+b/qrfSwKnSjxBPgQ7rRNYPJMfbkszlGWmScXGZ8I=;
        b=FJy+X6YdF9D1PPJAewk+sVFANwELtftEd1cpkhPCqvXBBQAmrTAouQnyZKPquBjs6B
         LOW3OyfIBtryBbrRNa+lxpZojbEXtId/IVms6AA+FJXdlVuqgyp0BeoWEIp5oWOBqWk8
         Payv+jWfrQH9xNHhuOWk7YGVEqyOHwirN5/zP+9PRRqoIyaDkgBormypLg0dbJuNy3jP
         ipAAhtgoGfUc47gNMoxlQpA4KzdmO+xEUQHgYCfd5Cp0E2GhRG4mYcxDjos2V0uMW/aU
         xFKTJvSgTe3bTXNiIN6mvd6GXlD6TjNKQ6yWSkVQ1oDhCt6bCWzKq2hjncpQQBOCeDY5
         5/cA==
X-Forwarded-Encrypted: i=1; AKwUvBwa1YsRtf51RIbEcE5vNKrHKRH3OXmeasVrIPCbfdgRQ64OfEnZPi22N6q5hgXHwxw78PHQKw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/4YH74S1sSNr7j5nvao3x8Iwap6mz/fsVU+gzJj55UyUltJNg1
	vdx+eTBD51q8v9A1qobNClmdkAOy9PoXHKyxKM8erdQ03NDIgVQB2rd6
X-Gm-Gg: AYBFou01r3Yi9SL93HDmbMox4N2gVSVhGn685f4oI5Rq4VIt3JSidMoY96nzsGvS7Jx
	tzpkPHkb7OnxkO5E8+uXlDpWEsBLhbkSJM0KYJkOfb/nNzv4hCaUJKcTkyyv3YUSXdcLraDvkkD
	XIc9g07vKei89tLmuqfp1bfEsfTI5kMlHRyhWBj/9qjQArazADnBz0/5da5rm3c2/Tqvw8zNZSi
	FgchS3XX2Kc2mhQO5f9WRHEbcVQ9E+mZeDnW8bJaE9+Tv7Q1O/V9X1Gr+78G8HvQ0GbHoBo1786
	kUX9K60OJ5rKJygEBgXq4qSxe7I05TqSV2b5v0ezP+LAYEyMXjK5f+/P5lGoKBAtfkfbXLBCJ20
	9ERZgpv0RkxsLbLMTeaTqeMGUQB3XTtG5Du+xcjBIlzl0MiHNQ1p+qEfdSam1dvGkU7wpcs4YOa
	UnMc2iPCaWWvRhyI/k6zpqGLjDn/RQ9Gn6gxG63j60aqcyJQbOXIy2arGLa+GjuVjsijk+eKhNV
	Juu2tC3wDa3qBtu6fOp8g9zlXQVJPSL5uIJMZoPx4e4QJBNnJmwNXY0WjZ5PDB/MfxKJeulmWs9
	B1sh3HfYF3m5B3GqBa38NoEm25MWPVRJrW7VPng2GSbh/e8RdWSa9cQom/bRylrpgeJwA7YU193
	HyiIvFC/cI7+aha13GI/tfUnKmxfQ0C0SUC0FeKMA6jxCcgJHinpGAHp6bs/Srsn58CcQrHaRw1
	Y=
X-Received: by 2002:a17:90b:3148:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3ae897364c0mr7170464a91.22.1793604077199;
        Sun, 01 Nov 2026 23:21:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm17483813a91.8.2026.11.01.23.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 00/15] bpf, sockmap: Fixes for verdicts, redirects, corks and recvmsg()
Date: Mon,  2 Nov 2026 07:20:57 +0000
Message-ID: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

These patches fix bugs in sockmap:

  patches  area
  -------  ----------------------------------------------------------------
  01       recvmsg() after a fault
  02-04    the verdict of an sk_msg prog and the return value of sendmsg()
  05       the backlog of a stopped psock
  06       TCP listeners
  07-08    the target of an egress redirect
  09       the TCP state in recvmsg()
  10-14    corks and the redirect target
  15       bpf_msg_push_data() and bpf_msg_pop_data()

8 of the patches are from Chris Mason and Josef Bacik.

Patch 08 changes net/core/stream.c. Patch 09 moves tcp_can_send_ack() from
net/mptcp/protocol.c to include/net/tcp.h. Patches 10 and 15 change the
sk_msg helpers in net/core/filter.c.

v1 -> v2:
- Patch 03: end the verdict after a failed push too if apply_bytes is 0.
  Another sender can use up apply_bytes during the push (CI bot)
- Patch 04: correct the Fixes tag (CI bot)
- Rebase on the bpf tree

v1: https://lore.kernel.org/bpf/20261101192057.2296489-1-alexei.starovoitov@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (7):
  bpf, sockmap: Don't let an SK_PASS verdict cover the next message
  bpf, sockmap: Subtract all dropped bytes from the return value
  net: Leave sk_stream_wait_memory() once the socket is dead
  bpf, sockmap: Clear the redirect target before the sk_msg prog runs
  bpf, sockmap: Check that the redirected message is the cork
  bpf, sockmap: Keep the rest of the cork after a redirect
  bpf, sockmap: Clear the end mark of elements added by push and pop

Chris Mason (5):
  bpf, sockmap: Give no progs to a TCP listener
  bpf, sockmap: Check the target of an egress redirect before each send
  bpf, sockmap: Check the TCP state in recvmsg()
  bpf, sockmap: Reset the copy position when corking
  bpf, sockmap: Don't copy 0 bytes into a full cork

Josef Bacik (3):
  bpf, sockmap: Write sg.start when recvmsg() faults
  bpf, sockmap: Don't let an SK_DROP verdict stick
  bpf, sockmap: Clear the resume state of a stopped psock

 Documentation/bpf/map_sockmap.rst |  4 +-
 include/linux/skmsg.h             | 19 +++++++
 include/net/tcp.h                 |  6 ++
 net/core/filter.c                 | 17 +-----
 net/core/skmsg.c                  | 13 ++++-
 net/core/sock_map.c               |  9 +++
 net/core/stream.c                 |  6 +-
 net/ipv4/tcp_bpf.c                | 93 ++++++++++++++++++++++++++++---
 net/mptcp/protocol.c              |  6 --
 9 files changed, 141 insertions(+), 32 deletions(-)


base-commit: 5e96760b25fdedbbf9312827f1f237d6b18b03e8
-- 
2.55.0

