Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681897;
	b=26QGjIWDVlGl9jsittl+8tAnNUaLM2b/YV9TvhuZFLIdjkD95518B98mdhW3rrJI+Qbu
	 dmPoUN5bp7K0iJzgWTvUkOYhDoeDogZ9wYhzXIm6LfW6EBkr0Sa0GeinpFOkk3y1ZlT96
	 QKnk7yODATsllgtC2fp+est6QQ4lowbntOrKVOWBVJ5m9sE31/ib/FkKg4rNwKyte5RfZ
	 BMyAXfTf3YD3uQ+GbDPYLZ7EUqyaKPeCh0fs5/LF1q+bCX/EgwY5S/Hzl8CDIIOumQQCK
	 ODnzmhKoDrDypjqKvTlR6AYYEOy3JbIG0TctEdUf2CpHSErVhEpIxj0pdF/KTQiW6Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=apCP3/tu9EKSlTzXxkB0hbwXiE+sTgao6szprAyqSpE=;
	b=yfhZR0+wemAyTqMNkAG78/K6Bg+fneK3trKn7CtrTngYU7GxVBtmmKqGaYlGtRi/WQQN
	 2mfA2niql62ofSiJ+X5EpM/IGfNz7cO4H9Zj+sn3iLc9ROYqsBDlU1JaHtpFuqzORDNAF
	 duVu9nuZzgwUhM7TjRzhmrf76sKFYJI6mVP0bjxATtYoA6yDXn7pceuhGLGWuXSmSFra/
	 fVEVS6lT1wrs27Dkopq0MwRr+hxFQojaRnNPPTgDOWnk59xf5+o4CpoDZgzlOxCW6cSWw
	 kVfYp8YzMukwH5EGNkQMiZ3aK/+vg8d0nNAuZlRVoe18cyuyfp6TafqG6Ya/TwnkMeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FSatcyE4;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5760A3819
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 15:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A5760A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FSatcyE4
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so4466308eec.0
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792681896; x=1793286696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=apCP3/tu9EKSlTzXxkB0hbwXiE+sTgao6szprAyqSpE=;
        b=FSatcyE40t4jvcVNrxyBN3Cph8cDABNyN9Qb79ggfk1zcrG+F2Wkc7ly0m3u/1d0St
         ajbJMJgDKeNjeo1plyny12V5G/zaiYUWd3JgSI7flX3knwUECdmtrtXWuVvgSXBNmyG8
         Bo91BfYiIsXnUONVVJLR0JOltbHhRW20+u28I1rU2BEUY3vq2KHzawxM0TQpYluQd+yp
         nnd6furpNoi9QLiRoKQ/uOpG/NSnavmZUefE0t41MsUQVrf/LXU/I06l8PYlfeY4wFdj
         wakuLMdSQcNOFDZrCcg+v7vuy6JSnO5MGiTEyZXcGANAQkZ3gqb2pSDndsCpPa/UFzGZ
         6P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681896; x=1793286696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=apCP3/tu9EKSlTzXxkB0hbwXiE+sTgao6szprAyqSpE=;
        b=h0dELkn870AlZfv7UvkDrliaCIgQLco1ChL8WT+IZvdOZU0k0i6BNl3IZbYLAacEqL
         iwU5LUP3E032tbY1f3jIIsm9BRHM1IRFRT1JPfm+P4uNWH52Nn94cwp8eI131LMzgm1E
         AL6Qv6QMtdKhK0DkzEzX5TmTqsE2JsEcFYVws7IwNYSPa1eBm+FXvnaC9FyZQTZo/1D8
         CAjrGXbGyaCD7+Zm4FNW59KqocaH/JxNXICnrIC1Mb51tH7+VbDtuKiXTTih4wG5nAHs
         4FfwcTTFZwoAqwgKRYxVpkeVmYz0fTuhq3ic52OEok/Eo3qdnPx9M6tdEtoz/qZGcIh9
         LY1w==
X-Gm-Message-State: AFq9FYJ2jGARDn5GyQlr/iV8MHa6Zplx9l+5d+ZLq4wFrkSWKdgjJr87
	Pjt109MSG1US8mhOK8RAoFiLTOxM7l0UmtdvgMABvgYWLgxniaWiBVv3bsVWFw==
X-Gm-Gg: AYBFou3QLK+r4vMRfbz5kF5FTlDeuzVwWFIRXquORi21ZDvxFU7iSKDPVf92tgrtVBW
	PsVx3T0I5GBTvKPPFzJfwohbX6huU0K8ZGtkzPA/pBPq7XIW+EdMd4UlnyQj+R3y+zl8EjsG8+F
	wfWx2dMpcYkZbok4v1CvQXlXc0TPwptIJWS0WVqNZbNijU5syNu1IseXKOnKhqUhA4LMFjJhp2x
	tessU8AKkNBV7sboBHvKlfj6vWBimMZNeR0w9LCuzTDkEiveSb7Nh1dDqBFMBO/MlsXwzNbbBLR
	dRFezibBTUSpftpOeWSqR66Jkd1f+6oZsXI42mPZAWK9lLIqxKvaemIrL2tRKQTm4wNsaM5Unzg
	xjus+Kxbj4feETQmHCPOgoBAZYlV6QfZMmTcpc5IBBGCeAwi6NkCngTfzPoCUbcTxBHIzmkkHI8
	1fHKqZI3bZ+BaUXQXr1+lKNfJNI7C98y1ixCv4XKl0OPR1w30TvbJ5dd/4JMIlNMnVAsc5MXdIh
	iLt+aTqJg/gH66DUmHpUZKKP9MXaffrXHcWlVvQ7F22NlNQNBdfiuhMf6apcVjbVJhI8LoL+5cR
	TaygNJi/ZrSyMRPe7FV3l9jeGHGx/Wo+D0/8Pw2RamqQgi+2f7MdXwFScXVDmMfAPGmqz+lWOkl
	ZanDCVW1A88nXr606xRfM/hfV/D55dAOw6GAmdAc26tieuEU=
X-Received: by 2002:a05:693c:8345:b0:343:fb75:a5f2 with SMTP id 5a478bee46e88-3674c93b04amr6770964eec.9.1792681895232;
        Thu, 22 Oct 2026 08:11:35 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm36327560eec.26.2026.10.22.08.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:11:34 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v8 0/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Thu, 22 Oct 2026 15:11:24 +0000
Message-Id: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
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
 Documentation/networking/mptcp.rst            |  14 +
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  10 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  39 +++
 net/mptcp/pm_kernel.c                         | 141 +++++++++-
 net/mptcp/protocol.c                          |  36 +++
 net/mptcp/protocol.h                          |  20 ++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 263 +++++++++++++++++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  47 +++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 ++-
 15 files changed, 619 insertions(+), 25 deletions(-)

-- 
2.25.1

