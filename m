Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560861;
	b=YDgPEv+n6PQjAq0W+9cB0TQ1oEeDPyTZbBkonw9zplqHXykQLJNsUgQKZNcXDFqfbzuE
	 osh/colv7wgXSCPs5TNNQ5quUWMtUgM2q/qKS00v9jeje87bLkKjBaipBdLMkPTrhstEW
	 TSEMQbyKiIn6XrDRhlMzxBaFKPvUp6zDV9w3IunRXqXgxnBHnkqzETvskxf5PiJcc8Flt
	 gt/VnFB1jdbbbezxmy7mFMa6oYMr2r3mgoHc/GDEoLA5eaQEHfeNsOI3Wr1UyrYXYzQLp
	 9LHqhCE77DOCyDiMRn9gzaK5BwuOjYikq3immFhaethcHqGqoHZQQny0zGAH///0vFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iAeiSOPaaWkQBppOUsktRtMkprnZmaPxcUrEefFlWVc=;
	b=AD54XbiMllak9eRNWmimuY6UwSIs3yWX/JeawuFGc0j6BeAs/Fi7nSEp/SG99j87HaC0
	 Q1dY/vR9Trwa4vqy+FoYfcgPLxnc+Eeh8J+VQwLb5Oyx3hDNqKHhi9MgZTLiYfQSkg/MB
	 +YJRBx2MNNG8jyldz/eh+2nWf+yh5KxLvdaLSI2TuWY4YGMr7JzrGlU08Ored3kJyX2RI
	 xBc0faeCu31BmygAykV6an6uo0xtSugG9EEIqWXRYpSczTGd+6ntkqpzVikqTsD4VAwuf
	 N4//o/n4jrfv5VhH3ZPewsx8gb52fC1zTuZ32yojo3AB3G+0ZvY9p1Vmxj/eV2by4xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LZkKvxBr;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE8606A326
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 19:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CAE8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LZkKvxBr
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1005863a91.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 11:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560861; x=1794165661; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAeiSOPaaWkQBppOUsktRtMkprnZmaPxcUrEefFlWVc=;
        b=LZkKvxBr+hcmqkU3QcmSXcINTRRgP0M82XZlycc541EeCjHc8uNHTB8xQtIti4NuM5
         F7J0sz7CDCZC2lmD7d33z9i17c10KgK1AX9x0Q4gJTqCRSa5UxZx5PvifNhOH/z9WK+t
         Qt9swlzW5CGAfmnZI48aSlTAVz1X0YRnDOKKns/8YJf6Keb441/7Wr+dH6aRg0wx1nlq
         mSebd8DwEdR/5xPaGksry6d+DIVNesndVmZV8cDI6c4T4MeKuXnWdnUH8FV57TPXpubp
         hT79ukCE6GimXSL+q8gtx9QjpH+JO/XQv5fQrfqD0QKd8YeTz5Wt/aTh6MOnfk7ZBG0o
         DqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560861; x=1794165661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAeiSOPaaWkQBppOUsktRtMkprnZmaPxcUrEefFlWVc=;
        b=Mk8RU+Wu2abykz3w9Z7uEi6lVNzyZVVXzQzXAMpMv+51W+igfSKLCxMlvNRcguXoGh
         hwNDPNBaRj7n3ZGzDeWrksSngpz6UzT5LPnYVEOgMJ7JSIeapkNwCD1ePDM8uD52e283
         vqx/2T49Rs+uzSVrj2LXrzdAyvSVEGNtX29zfhlycdibwRbhuqxccW8AOt0Tp36oK0JH
         bEdq97dxKXQEUyy36vdxXWVxTptk+cEX1+Ed4Ua+QBSM39vA41vNk3qeSe2lQdGc8k2j
         3NsM4+8fCjdUiv12obqbdxGEc5n8RS29Ox/Fx5l05SUQ0cszoHWOlff4Te3BAbo5OdtQ
         xM+w==
X-Forwarded-Encrypted: i=1; AKwUvBzCDgD6VufKqkIru3TyVCX/Cs9sVcUaRP0+yZKh+SHFbX4WLyeUZfz3sb8wAs/RNBvAxeoz2Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z884P9VuhpDbjRq4QNck2CE/xLRYL1b2SuBXsF063ZJWIibIpEi
	HFb5ltXXjfrEYJFu3DrQuD7jrWDkfCMKNYtedDMgvDVuHiCncDwlhvyn
X-Gm-Gg: AYBFou2qvgSUVTgNtC/uDt0RqXYOFbJF/ppmwL+W4/ae0atOF2M9nfOfU2POLBCvOn2
	mXSbrC6tvawCOFeD87HneIN5EBercp2UK4Pqo/XfG1aOjDMiY+ma3Go9cfiMFPen5GtM5vkp51x
	6u+DqU56RqY/y1jIBi6NBIiXSXoaxlgvo4t4yUZENJ39iuFAmUov2x4DniAMmbwTPYZc0xOJnou
	20wcedMgct4cmZ2QtBDNv4nZaISVgDC01xZs9hnquADidcwexAdn/163sLwu2toIzT+fEWPa/a2
	AqSgUQzsjW78q6EvpeU+OYMVhUCMnCq9mfPEO8+O6TqJUNAphYbKO+yWR8AFXVGdqFDlPbkxdJs
	0yQ2ixh1asiUGyL5dn88rxo79n51JV3ZqaA2udKBb3MgwK4In2aazVKPHfQq0ryP3YqPar5c9zm
	0etwaxQwqxiTnPjh+YZav5TROiCNf8rDkXuPr8iGJGDqJU4n8SVMTJrJjejX7VmuyduR1sbR6pO
	wcPjbare8dV24DOqZEedePdnhO8DUxczDRR6jaQkHy5nerrSoW2aWf/oSYqqNKyWHkJv2st1wGf
	EUFqLuGVtIZan7HGUXbf0lSxS579KvPS9NQ6NU4akNBXO6zFuxfs3BXu/QQM+CtiMMlgNzjaI/r
	4uJ85+/dyexAXKXkD+gbjT5PKS/BjMGpam6EuZLvf5sS7mK4z9qab0KbTtLjYWpGdqjpIuiNPIg
	==
X-Received: by 2002:a17:90b:4a02:b0:3a7:9e3d:b3 with SMTP id 98e67ed59e1d1-3ae8987e31dmr6107376a91.66.1793560860808;
        Sun, 01 Nov 2026 11:21:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845984absm11157692a91.10.2026.11.01.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:00 -0800 (PST)
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
Subject: [PATCH bpf 00/15] bpf, sockmap: Fixes for verdicts, redirects, corks and recvmsg()
Date: Sun,  1 Nov 2026 19:20:42 +0000
Message-ID: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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
 include/net/tcp.h                 |  6 +++
 net/core/filter.c                 | 17 ++-----
 net/core/skmsg.c                  | 13 ++++-
 net/core/sock_map.c               |  9 ++++
 net/core/stream.c                 |  6 ++-
 net/ipv4/tcp_bpf.c                | 85 +++++++++++++++++++++++++++----
 net/mptcp/protocol.c              |  6 ---
 9 files changed, 133 insertions(+), 32 deletions(-)


base-commit: 5b96632457e4ccae88ecb751cf48176b2e3629a7
-- 
2.55.0

