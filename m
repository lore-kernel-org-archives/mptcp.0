Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793517657;
	b=S9gSff5AkznvCEzTztHclg482Dd1G8LEbCFxIAY5qXpf2q6jYxRd7xtqyqopK5e07Xtr
	 3Q1HGFnV0XMlnPXlDqOyWY83YgAg7/A1Z67Ac4G7kVbJjry13tHMKiYHu4EfmmVSfWwrT
	 BWuJsYBXCa4Baqr2rRfIOgHNgCl76kbCcLTgdVq/cN1/U2we3RsT7IVPuTdjYbTSq8RxP
	 7FwpDRiGv1vLdyIxXI7RlI9U3HiDSUSVXJqdCfST7gNhXru/9fXgiTd/gd/trcqnm/wRp
	 fUs1GeK7FOa6wfODPctrBkMXEfaCwla9Aop4KB2b4DNfG0nnCDcaoWlaffXfYIiTIHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793517657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Fq1DiZsqqdhqSkEVMpp2MoQweIFZi3FShrVbz/klhc8=;
	b=tSifi5LXe5//AFcAaoOiWC/DwlxhjWWhCKw2fWR47k3uTuH9xff/5JmpOlxjMaqNdxGt
	 PMash2f+nh0BxN2JBdUIkW3zW4ZffFlHzdf02zHwn8Bbg+tJuE+aNEl1FZ/IzjP2TDXSI
	 Fp8vUKwqi9nlmEPQdjZXa1qpNS4YQ1jaVLAqm9M/AeJsOP0hgWWevtf/o7C3T0sm4y+BT
	 XSK4bfMLFFNAQ2tQv3+YRL1U+AZq9u7Yo31a60IrP64ErClBb8yMscV59mVdm7fEYhVHb
	 AIBYsvL6T1GqED9DzOhneKac7hANqdBP12i0c0eX826wlY02WjbtAbMaVsrFbmb6+CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OKd3GeiA;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41DE606A325
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 07:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F41DE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OKd3GeiA
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2761c69fbso2432784c88.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 00:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793517656; x=1794122456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fq1DiZsqqdhqSkEVMpp2MoQweIFZi3FShrVbz/klhc8=;
        b=OKd3GeiAVPf0MYL7rupWWyAtyAPsNS0RiudUuMpWBW4V6Aa7EqITP6SFBy49h+oZhK
         DshQHDXXfQxgVYOtAekJYGg+kq2/6GTPQi6raOd+z6rgEsb55WcHZO+6IMTyeGX5mf2z
         zJzphLgJe2cXjXl9zoI70BR+sqT4K9UMxBTARPKXOJBo1w7I1DC79GHGQDmikPCsdhWE
         CjAh2aAnRgupNTEPgw/7CnD4BdjYjaSjGmni1nF8nUTL05lX0CMblvMnr8i1w+eVhygT
         HVXiLL1cWOLdU6gtLzHlBuHHTwAr94WVVuBfdP/r4t+rdwBw2jQV3rhvZm+9iCo5FLeM
         TU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793517656; x=1794122456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fq1DiZsqqdhqSkEVMpp2MoQweIFZi3FShrVbz/klhc8=;
        b=rdzMGzD0PGVFsCl9iPbEyIO7L8tauaOMrT2vEYkYka9MGQD3QVi2PkEGw/a9nnIyvM
         xnAvmJj3iisEGg+k36qY1VTyE6bngT8Be1vF0MnDBCs9jJYVH8ceouPxsGBft/4rAn4X
         DJe8XR+MToPL5dayJriKTZ6dRadtLXtayo6E11pTPUP9MERmUHCeUj07YPYSpIfQDW1T
         LazSNlYaCqjlZZOV1ZEGpnYK22L9aaxA6Uu7cwERLFjFI2W0N7BoBgzFi7Aqe2D9Wy5R
         HJIyWjnfGFHnA/j368nmwzwnsQQv+Ayiye4ijT5N54seDT6soMGdt6mATUN3pQ2eN7/G
         JPaA==
X-Gm-Message-State: AFq9FYIOBdK+6OKNBxOqczmpe9Xxt4vKUKrnrYO6TPHCh572FMLbCtr0
	EuvU+Z7vL1zdQDDCeZa8AM1JOWZVK8lqjF69BpzhoGNlU8w398RsE/cvJWzKmw==
X-Gm-Gg: AYBFou1woFFLs4kXwhTuLLaZr5jZXdG5tHuiSY62I7q94sXvh66rTMiPcZ3jIdyweI7
	RIUsUn7iCpDbzIhD5UVsPajfV1eL8uC0dvkbJd43KSUnT2GGffrQwBJ9tAbOFxP0lK82CM80m3F
	P4JyH+ViQFIxxAIkxJQDSi418++9GRVcIxybiW9v5xswP/x9cN1pWepL8qVZoxcFHHa4/YkH98G
	lfOKGMHA/P17b4rShc1Pnkj8zTtpw1J9O8SEW1sUNuqruNT1c9+/7cIEXIsSJUndMuVu4eBC3Fq
	noQYzApQiXtixjW0lT+SvW+J+kOKfvlli2tqAutJzD/bLTq2E0NN00N1C3Nv7Ve8iZzfIkbwz3q
	+YsqJIDkyGiteh0c7wMi/D8j0xAB28ORK3UgKmPWE4Ex/cxNnwzWw0K8s2mXcoHC44JpkKzfPkg
	HdMwPapMJkNcqwvz3hkZj+vKpW4INiCwbF62GC4jnnvs6+WzBC/z0tWQ7MYAGdPBNYXAW/PtaTh
	vm2Uw2inlLhXOQGmx9fWKW+gSe3ERMqwC7Nt9SQfXw+2OQujdNpJSgna1agYu+RD7FRoVG5i79Y
	qu67WGhhXEEm/nt5kvDtPEaW3qw3M/aAZ8fph+CPylHAPhuK3dRKXZ4EQ3a2EZMxDRbE2QXXFob
	93il6OdVr89DIPqknGlbjR1hxwEtyz/kd1cSHj9Bv5vrjrLM2Wokg0x4X/Z6QMwbOBo5LaEHckg
	==
X-Received: by 2002:a05:7022:f517:b0:193:9aa3:4758 with SMTP id a92af1059eb24-1ac55968b07mr9936357c88.4.1793517655602;
        Sun, 01 Nov 2026 00:20:55 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm29851495c88.6.2026.11.01.00.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:20:55 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v14 0/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Sun,  1 Nov 2026 07:20:45 +0000
Message-Id: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
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

Patch 1 fixes a selftest tool issue seen with the new test. Patches 2
and 3 add the new limit, patch 4 the retry, patches 5 and 6 the
selftests.

I used an LLM to help write and review the code, the tests and the
commit messages of this series. I checked and tested every change
myself.

Limit: as documented, the new subflow is a single connection attempt, so
an ICMP error received during the outage ends it at its first SYN. The
retry then mostly helps when the path drops the packets silently. Such
errors could be handled as soft ones for these SYNs later, if useful.

Known issue: in about 1 run in 20, more often on debug kernels, the
first new test fails. Once the path is back, the re-created subflow
joins, but the server resets it right away with an MP_RST, after
DSSNotMatching, and the PAWS counters are high on both sides. It looks
like an existing issue on the receive path, triggered by the two-way
transfer with losses rather than by the retry itself, but I have not
found the cause yet: it does not show up with tcpdump or tracepoints
running. Any hint is welcome.

Changes in v14, after the netdev Sashiko review of v13: the slot of a
closed additional subflow is kept for the new one, so a join from the
peer cannot take it in between; the join counters are checked before the
transfer is killed, since that can send MP_RST, counted with -C; if the
new subflow cannot be created, the PM tries the next endpoints, with a
new test; and the commit message and mptcp.rst wording is fixed. Patch 2
still only adds the attribute, which the next patch uses, as asked on
v4.

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

Anil Kaushik (6):
  selftests: mptcp: connect: retry write() on EAGAIN
  netlink: specs: mptcp: add the subflow-retries attribute
  mptcp: pm: in-kernel: add the subflow-retries limit
  mptcp: pm: in-kernel: retry subflows closed after an error
  selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
  selftests: mptcp: join: validate subflow retry after link failure

 Documentation/netlink/specs/mptcp_pm.yaml     |  13 +
 Documentation/networking/mptcp.rst            |  23 +
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  10 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  50 +++
 net/mptcp/pm_kernel.c                         | 183 +++++++-
 net/mptcp/protocol.c                          |  77 +++-
 net/mptcp/protocol.h                          |  52 +++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 407 +++++++++++++++++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  55 ++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +-
 15 files changed, 904 insertions(+), 27 deletions(-)

-- 
2.25.1

