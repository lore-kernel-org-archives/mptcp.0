Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695970;
	b=OC4oWGj/3aufYdYebM0hSnD6uKr/ZMsJNpRG5QPL5lvK8xgOQwn3MQY9lz0oBuX37b7y
	 VEU8eWsjIsO4fHMTf4GX5LoMQCoD+kzB1sqrfhjnRNLe+4+MEPqwlOcN6gtUOF/g8rvCq
	 cDsAd3/YyCokYVVtQFurkZp2zMeO7fHFDa7kQhQPGCfr8KAeJiaayVaA7hRP71Ba+UVmu
	 g33lzkIDZ2iVKpDLHiMBAkN7azojNyD4Anv2NB0AyA6QX/M+uIJIiMiiV9S4EE0YA9E/i
	 Pvj6kNcyBSKGroNYK9sbBRhFAcavjir1b0x4zEP/4iEX4u3rHdZGoaPE0vmlLP6uqnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fRFv6eh2LO6m/w8/kxh9pESjCBLK62X+WdPvakA64SQ=;
	b=E2tjv4bxmgwza83WfxFlku2cvatUcAsWnuhwPrbnlo5/QZrKPaNisu/xFFev0PukM1jz
	 EvmP/E3f0xjmyJnFe857hKDTEiE0OzGD7UbAzYeXKn4Jrr/Fl85IllZngeyi1+y4pVewE
	 MzkNF/aPg939/X4CkEqrpQ8hMTCJ560c3MUGTIp6fnpMBbohobRCBcQgnjYUU4HU1wr/X
	 4JS7ZKkMnZM7OpC1JJe1Rl3NzEngeE6+l/PT3HVE/x8Qafkk38gPB3toDYXcdi/MtmFNm
	 Ipz/tQQ3Zw9G8eQMeHYpWExkx3Bmvp9kG90swpjLIAE6pFnii+Qk59qojdK+NHphCSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GIJI35bo;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D291606A324
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 08:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D291606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GIJI35bo
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36c9a93a1abso150808eec.1
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 00:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695969; x=1794300769; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fRFv6eh2LO6m/w8/kxh9pESjCBLK62X+WdPvakA64SQ=;
        b=GIJI35boaX26kUbM6nQdDy2EnqXBOWOXqe4TSABs4ql7PIJ9SI9BIPTDapeiVL5vZB
         PrZKRlOCXaJ20JZ9cca0I6F1TcQTaFEhonmaYxDpmz0I+CaRUI1tOJajJ+Y5PJ/RvNtc
         PDP3TLUYPljw2Yla8cr3bEQiNzzs1WimIz0q1MDClzCev+XVDrcXOUEF2uzZh8rudeZW
         yg7l+svOkIAgOYrE8zhtWH9U40h4hayGr0HTKFhdsQHWhmpMIK5ixBk9RSlQLpeCI+gy
         vwx3SmUTpDNfBMaW9TGGMAnK7v09utUeHoGhPEWtVAWetySF2fSkvxC8NugAUHkCknBX
         Dsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695969; x=1794300769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fRFv6eh2LO6m/w8/kxh9pESjCBLK62X+WdPvakA64SQ=;
        b=t9nlRMnEkx9d4nIQeeH88oGy6g39JPugwsj83ASb5zKnIQfLqGOW2psR6YpysvaqBn
         fe4p+YT2jRR+eNsM4S6eL+Uq2s8H38Ffzij5n83q4aKzXF5SyW93F460qz1oK071xrX0
         XroUPuwbwWSQgeHcSy9WhqxHzvJl1G57F7yKQJgAgMdWUuB0hObdNap1MWh79bFZLuPF
         1V/84ev25UMqIT1mlcMYY1XRFCZfdyLkJgYyG/QTKbXn/HqgQsKPjc+aQjLJx2ATviy3
         VY6hiRsJUR9q/dmme06ednEID2EI/VgSCDIQww+uTxkjZ04T+TSAhOflhd1cG3RThyxD
         xUPg==
X-Gm-Message-State: APuU4Z9OgFhnUeTQ5YqA2dKvKGA5IibuOJWlsgeTkzKqpO8hBytKlp+e
	ti36SIIlw5QRwzQTorZSuXfoXBncuFJ6dXDdRhttnkDX01a25ipdu5hkXK5UAg==
X-Gm-Gg: AYBFou2BhDvvuFh9B/ZBIHBTvtviw4+3WP3O0RX7fzT3rVICdopczBBrJMhtecdwYQ7
	pPY0QHAgH+Mi5roijdtOiwTIE9x3rfjL1BEp6WIRPRqQFKWzJ9LoLtqRxv5kjiJ9vyFGg4noWom
	k1UceeKMMiTYuNZkZBmiSTiZTt5P7zkiCw70lPhcvcn0nGBTkI/b75z9FZhsauGVrP9YmjFGgYE
	Uig7/pa3EzQlol+QV/SQ6z82MT1F4uK0qumF815UgiMAjUqDHGv8JeNHKNTuuAXFSAbCwE4Lfue
	CdkPKiOCOjN8e7HOg0A9gCYmx+VmnBD2YuLM8Zm/pKqeOI3ALR6zHYpmV2Q9n8GMy9+4FEmtEuJ
	WWVSbtPqjf7hwRSPT2rqLWGkamhvQuWiFgvUNAVVQrAjyBcl9i7wfE0WP6MO4TAMF+T+/435PVU
	dD1AHrFwnUPGuGFww/3yvxpyWf0SmA/PA6tt5MKQATjRAITYT1T8Wk+vDEnrKAEyjAuIpd27m+e
	KXZrHpwK4bJ/VoFRKu7oPaA1IDYTt0pFXHrq0P00vPoyuk8oV2Mef7vCsxXq9alwvU6J93ZzoPc
	Trf9vKhWztMTm6D3dqdY5gWq1+2M075j32ohBtEKOpmAw0N+T/NM3u49WE/X9Mr4KQieMheTKCd
	1/L9m77LkcX0LztRQ8bRxfMwjii1IylWyGgdo58OlakprfaxH5stHFzy88g4A+KaVJgpdMzV5SQ
	==
X-Received: by 2002:a05:7301:5408:b0:36a:1446:4852 with SMTP id 5a478bee46e88-36a30008540mr23028695eec.5.1793695968719;
        Tue, 03 Nov 2026 00:52:48 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm53065635eec.25.2026.11.03.00.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:52:48 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v15 0/7] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Tue,  3 Nov 2026 08:52:37 +0000
Message-Id: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
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
one to the same addresses, while another subflow can still send data.
Its SYN retries space out the attempts. Their number is set by a new
limit, subflow-retries, like TCP_SYNCNT: the maximum, 127, by default,
about 4 hours, and 0 disables it.

Patch 1 fixes a selftest tool issue seen with the new test. Patch 2
checks the existing limits with the netlink policy. Patches 3 and 4 add
the new limit, patch 5 the retry, patches 6 and 7 the selftests.

I used an LLM to help write and review the code, the tests and the
commit messages of this series. I checked and tested every change
myself.

Limit: as documented, the new subflow is a single connection attempt, so
an ICMP error received during the outage ends it at its first SYN. The
retry then mostly helps when the path drops the packets silently. Such
errors could be handled as soft ones for these SYNs later, if useful.
The peer must also have room for the new subflow: if it only receives
data, it can still count the old one, and with its subflows limit
reached, it rejects the new one, which is not retried.

Known issue: in about 1 run in 20, more often on debug kernels, the
first new test fails. Once the path is back, the re-created subflow
joins, but the server resets it right away with an MP_RST, after
DSSNotMatching, and the PAWS counters are high on both sides. It looks
like an existing issue on the receive path, triggered by the two-way
transfer with losses rather than by the retry itself, but I have not
found the cause yet: it does not show up with tcpdump or tracepoints
running. Any hint is welcome.

Changes in v15: new patch 2, so all the limits are checked with the
netlink policy, as Matthieu asked on v7, which I had missed; and the
first two new tests only lower tcp_retries2 while a path is blocked,
and the first one restores it on errors (netdev Sashiko); no export for
the new getter; and the doc says a peer that only receives data can
reject the new subflow.

Changes in v14, after the netdev Sashiko review of v13: the slot of a
closed additional subflow is kept for the new one, so a join from the
peer cannot take it in between; the join counters are checked before the
transfer is killed, since that can send MP_RST, counted with -C; if the
new subflow cannot be created, the PM tries the next endpoints, with a
new test; and the commit message and mptcp.rst wording is fixed. The
netlink spec patch still only adds the attribute, which the next patch
uses, as asked on v4.

Changes in v13, after the sashiko.dev and netdev Sashiko reviews of v12:
all the re-created subflows not fully established are closed again when
no other subflow can send data, not only the ones still connecting,
since one waiting for the 4th ACK could keep the connection open
forever; to fix the race reported on v11 instead, __mptcp_close_ssk()
checks fully_established again under the ssk lock, and keeps a subflow
that got fully established in between, so the change cleaning the msk
backlog without MPTCP_CF_PUSH is gone; the commit message and the doc
say that a re-created subflow keeps its place in the subflows limit, so
an endpoint not used yet is only tried if the limit allows one more
subflow; and the tests wait for the netlink events before stopping the
listener, plus small test and wording fixes. If trying an endpoint not
used yet first is preferred, I can change it.

Changes in v12, after the netdev Sashiko review of v11: when no other
subflow can send data, only the re-created subflows still connecting are
closed, a joined one is fully established soon; a subflow in CLOSE_WAIT
no longer keeps them open either; the doc says the initial subflow is
not re-created if the peer does not accept joins to its initial address;
small test fixes; and the patches are rebased on the current export
branch.

Changes in v11, after the Sashiko review of v10: a subflow is only
re-created while another subflow can send data, so the close timeout
works as before, and all the code re-arming or stopping it is gone; the
re-created subflows not established yet are closed from the worker, or
when the MPTCP socket is shut down or closed, never while iterating on
the subflows; the path-back test is gone, and the third test checks the
only subflow is not re-created.

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

v14: https://lore.kernel.org/mptcp/20261101072051.3853492-1-anilkaushikwireless@gmail.com/
v13: https://lore.kernel.org/mptcp/20261030050727.3534304-1-anilkaushikwireless@gmail.com/
v12: https://lore.kernel.org/mptcp/20261028054143.3222998-1-anilkaushikwireless@gmail.com/
v11: https://lore.kernel.org/mptcp/20261026125345.3019372-1-anilkaushikwireless@gmail.com/
v10: https://lore.kernel.org/mptcp/20261026063657.2955783-1-anilkaushikwireless@gmail.com/
v9: https://lore.kernel.org/mptcp/20261025134909.2794368-1-anilkaushikwireless@gmail.com/
v8: https://lore.kernel.org/mptcp/20261022151130.2285198-1-anilkaushikwireless@gmail.com/
v7: https://lore.kernel.org/mptcp/20261020031711.1896660-1-anilkaushikwireless@gmail.com/
v6: https://lore.kernel.org/mptcp/20261018041748.1655711-1-anilkaushikwireless@gmail.com/
v5: https://lore.kernel.org/mptcp/20261016160926.1155262-1-anilkaushikwireless@gmail.com/
v4: https://lore.kernel.org/mptcp/20261016055010.980819-1-anilkaushikwireless@gmail.com/
v3: https://lore.kernel.org/mptcp/20261014143349.768138-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/mptcp/20261013025653.523755-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/mptcp/20261012171740.464517-1-anilkaushikwireless@gmail.com/

Anil Kaushik (7):
  selftests: mptcp: connect: retry write() on EAGAIN
  mptcp: pm: in-kernel: check the limits with the netlink policy
  netlink: specs: mptcp: add the subflow-retries attribute
  mptcp: pm: in-kernel: add the subflow-retries limit
  mptcp: pm: in-kernel: retry subflows closed after an error
  selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
  selftests: mptcp: join: validate subflow retry after link failure

 Documentation/netlink/specs/mptcp_pm.yaml     |  17 +
 Documentation/networking/mptcp.rst            |  26 ++
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  18 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  50 +++
 net/mptcp/pm_kernel.c                         | 218 +++++++--
 net/mptcp/protocol.c                          |  77 +++-
 net/mptcp/protocol.h                          |  52 +++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 420 +++++++++++++++++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  55 ++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +-
 15 files changed, 932 insertions(+), 62 deletions(-)

-- 
2.25.1

