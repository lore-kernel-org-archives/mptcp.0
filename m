Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792996623;
	b=kCM4Rwt5irNPLb5FbusNHDWKIN8vtxQBKZpTB/y3Z7gnNNOjnPmlmZMJ0NYErfld1pOJ
	 1LkBa9T7jDZ88th9Cc4RRn+vK9p+CuZdvzGJKCdL3elsqH58HL0Ke2tQK2mW4+8Lag+0L
	 wr9xsmoX/4oXtXJG5A+YiHHDzF4t7CAewPiWxMyYj4EAOzymBcdRF6+F4AjD6TLzZ3Mmc
	 a2lBS6WR6kDb4rQqBhB6AwubLdG38EQWTqFXRC2PbDbPJkhE+Yzi5aTD5KwqgyxQj41x/
	 VjdsaHHrRIiDy2dkKpTKv4oUoB3yzX63B9pl0DgJGit+6EBPjJ2A3qVunC7UAIS8TUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fTOi3cXwECUitV3qoUO6PBHYcNks6df1hlKDWRsdmm4=;
	b=f7GKhzFMUkiLWcVMI879FOR5p4dpP2TNdxv7RINKxyte/ZvH/p1lrNImjjiBXhySdt53
	 h9DUWvqyXFRoYQykpcp4o6DSip9Sc8VZbj/h3MNYeuOMMkRsVafz37711C4sKZq80rwtY
	 4IWOxtDutGNsM95LBUU2W9WNgk24EtgNvXPUmtE9JGmK4aDbOAdVb88BqfY2Mooxw+wLw
	 plS63f3/pDj5Q7leSsXTZ5dv6HiYPIu9Rlnh8WQlZN+UjNglLRQW4JLAL1swjsnmobmrj
	 BZCcmDQLdSEvKtez93Vlx40wxqCV8WiX8gKeCO81JmhB7EF1Ar7QWNlKpoP4FGja4gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EHDoudsK;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5F606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 06:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E5F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EHDoudsK
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso7906353eec.0
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792996622; x=1793601422; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fTOi3cXwECUitV3qoUO6PBHYcNks6df1hlKDWRsdmm4=;
        b=EHDoudsK3UpJsHQnAWSmzC766N7auowftD256RPBpzc370q1wy9S/kq/d21ZVRh+IV
         zh3XsAGoNgXP8nDGet7ufGxhR9XtGaCx78lSnYR/z3b5IAmK403t5yhlRayYrZXpaNj1
         F8WxsDMrdYJ5VyM/urnPr4e1eJkbA+LcxMkN21e7JfE4FxLlbexQWVl0pjAQ5cHknGzr
         k1zqOY8vLqEIfS9PGyND/CdkKR9GUy/Wcw6ahD9HeqQBYaxLKpdm2SeAURvro05Sguw7
         fq9I8WASFdMYbzNuCLzb7gIVd3yBBBdtHb5N280PrQirwXNdEELTPcbleAVTtQqJH6M2
         /rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792996622; x=1793601422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fTOi3cXwECUitV3qoUO6PBHYcNks6df1hlKDWRsdmm4=;
        b=0p8ZATQo515fbxAxvCcz5IsEl+hAyiB8R6TucJH1P9T6deee97QXY5yqW6iuML7Ntu
         6c4ErhGhOGH26uOo55D8T/9qL9+xg+Zxg92n/vXem+kk2MkHQW4ajHaRAQ4IBnQSdMC9
         CIrPx7zEsufgfDetiOAG7ZAlwmN/BWEgscG+7f56pdmWd/s08PjeAaIn6IpANNKKLyY3
         XTES8PuXlgEvQWCAly7a2irowYC8UIVj1ZqmQvPcoAiEDafeRlPuo3ZJQvvXb9Isd92v
         v3LLIgVkiVRmRnBEGVtzAYQ8pjTpTJW5E9GXTQEaGknzsROlU/e05KGIYAvCwys1X/tY
         81FA==
X-Gm-Message-State: AFq9FYLOHaoWMWFz144Er8fJpwOhVTQFGIwsaprsWGEqJ8xpf8R3RPmh
	iyvAHYCk7KL9Va7zQkvBfp7YlJKzmh8BSYWIq4UkTspnQhQ1QGnNqkiJWAk25w==
X-Gm-Gg: AYBFou2ZG9c0kENbOUc1ubPo7Y6qF4yPsBZBlTJBV2JR1ho0Jyn5e62N5swu9mAgI5+
	iWRYByR4v+owWQS1RplPhZPh26V9NNNyM8gKKe0iHmLCt68p4vMpyX8EIXhBj+hmp6RLOWqGTXW
	zbv1VsBtY00mFA6Pl6gaAUsbOUPez2ux+fncYuF/xMOAdy3nuY6NPphcv/wUYbXk2yMJd55Q4nq
	A9/0LRlIHdfIeIDKVWWkV4evacibIQD/17abF+Q1ERTamhoukkr9dkSYMZizizoE7trh8haqmAL
	pRffXfyPO1f5df7toPre/ZEeWfpvFXJUA0FHKCg78GlspgoJJDmCIqkGpJNcAwWNkTsTYya+lfl
	E3BkAp3qaHugD6jbZ3+yOAng+JHkrWNP9MzvjsqX4WWm2WBPQE/qdQOA3f05OYh6uuvbhBKbJyh
	Dv3Ny4/86MoOPhCQUwXlG9BLdU3J1HeIQqw94CYPT698EZXm8wdMv0ShiNFgeNB9yPsL45dFdY0
	NZXTQjJxA1MW/MoYVQ/9rrVE7jOlR+uXDymNaRXXPn1vNOfs495TZ6vUKPEMHHBAEVZANprZrSb
	+OaVPBUmTNMVWwWTPMLIRqlMxZe4PKMLkVs397ezzJQSWjIwESGRjddQBBCqJQ31V4O8WM5ffoJ
	u3uiaQtjuweQ5hYHyxRbdhp6U
X-Received: by 2002:a05:7300:f497:b0:369:f3b8:2c48 with SMTP id 5a478bee46e88-369f3b8473bmr6364776eec.34.1792996621133;
        Sun, 25 Oct 2026 23:37:01 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71a4sm21191609eec.8.2026.10.25.23.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:37:00 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v10 0/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Mon, 26 Oct 2026 06:36:51 +0000
Message-Id: <20261026063657.2955783-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
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

A subflow closed after an error is never re-created, even once the path
is back (#440).

When TCP gives up on an established subflow we created, after a
retransmission or keepalive timeout, the in-kernel PM now creates a new
one to the same addresses. Its SYN retries space out the attempts.
Their number is set by a new limit, subflow-retries, like TCP_SYNCNT:
the maximum, 127, by default, about 4 hours, and 0 disables it.

Patch 1 fixes a selftest tool issue seen with the new test. Patches 2
and 3 add the new limit, patch 4 the retry, patches 5 and 6 the
selftests.

I used an LLM to help write and review the code, the tests and the
commit messages of this series. I checked and tested every change
myself.

Known issue: in about 1 run in 20, more often on debug kernels, the
first new test fails. Once the path is back, the re-created subflow
joins, but the server resets it right away with an MP_RST, after
DSSNotMatching, and the PAWS counters are high on both sides. It looks
like an existing issue on the receive path, triggered by the two-way
transfer with losses rather than by the retry itself, but I have not
found the cause yet: it does not show up with tcpdump or tracepoints
running. Any hint is welcome.

Changes in v10, after the Sashiko review of v9: when the close timeout
expires, the connection is kept if a re-created subflow connected in the
meantime, since an active join does not stop the timer; the re-created
subflows still connecting are closed once the msk is no longer
established and no other subflow is left; a new test lets the path come
back before the close timeout; and the patches are rebased on the
current export branch, without the Assisted-by tag, removed upstream.

Changes in v9, after the Sashiko reviews of v8 and more checks: every
timeout is retried, whatever ICMP error TCP reports for it, and only
resets, local aborts and MPTCP protocol errors are excluded; if no other
subflow can send data, the close timeout still applies, the new subflow
no longer keeps the connection open for all its SYN retries; the
re-created subflows closed with the msk have their data in the msk
backlog cleaned, since they can get established in between; the doc says
this is a single connection attempt, ended by an ICMP error, and that 0
disables it; the close test blocks both paths, and its server reads all
the data first; the tests read the counters before blocking a path; and
a new test checks the close timeout with only one subflow.

Changes in v8, after the Sashiko reviews of v7 and Matthieu's comments:
the default number of SYN retries is the maximum, 127; the re-created
subflows still connecting are closed before the write shutdown
disconnects them; the doc is more precise; and a separate test closes
the connection while a subflow is being re-created.

Changes in v7, after the netdev Sashiko reviews of v5 and v6, and
Abdul's tests: only a path error, a retransmission or keepalive
timeout, makes the PM re-create a subflow, not a reset, so a peer
cannot make it loop; the flags are bools under the msk socket lock;
mptcp.rst documents tcp_retries2 and the keepalive needed by a subflow
that only receives data; and small fixes in the tests.

Changes in v6, after the Sashiko reviews (netdev Sashiko on v4, which
also applied to v5, and sashiko.dev on v5): only subflows that were
established are re-created, so the PM still moves on to the next
endpoints as before; removed remote addresses and the local ID 0 are
handled too; the policy checks the maximum value, so the parse_limit()
patch is gone; and the test uses the net/lib.sh helpers. Details in
each patch.

v9: https://lore.kernel.org/mptcp/20261025134909.2794368-1-anilkaushikwireless@gmail.com/
v8: https://lore.kernel.org/mptcp/20261022151130.2285198-1-anilkaushikwireless@gmail.com/
v7: https://lore.kernel.org/mptcp/20261020031711.1896660-1-anilkaushikwireless@gmail.com/
v6: https://lore.kernel.org/mptcp/20261018041748.1655711-1-anilkaushikwireless@gmail.com/
v5: https://lore.kernel.org/mptcp/20261016160926.1155262-1-anilkaushikwireless@gmail.com/
v4: https://lore.kernel.org/mptcp/20261016055010.980819-1-anilkaushikwireless@gmail.com/
v3: https://lore.kernel.org/mptcp/20261014143349.768138-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/mptcp/20261013025653.523755-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/mptcp/20261012171740.464517-1-anilkaushikwireless@gmail.com/

Anil Kaushik (6):
  selftests: mptcp: connect: retry write() on EAGAIN
  netlink: specs: mptcp: add the subflow-retries attribute
  mptcp: pm: in-kernel: add the subflow-retries limit
  mptcp: pm: in-kernel: retry subflows closed after an error
  selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
  selftests: mptcp: join: validate subflow retry after link failure

 Documentation/netlink/specs/mptcp_pm.yaml     |  13 +
 Documentation/networking/mptcp.rst            |  18 +
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  10 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  39 ++
 net/mptcp/pm_kernel.c                         | 141 ++++++-
 net/mptcp/protocol.c                          | 108 ++++-
 net/mptcp/protocol.h                          |  20 +
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 399 +++++++++++++++++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  48 ++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +-
 15 files changed, 826 insertions(+), 31 deletions(-)

-- 
2.25.1

