Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336853;
	b=ACJgvogGPO8kWay4pnI4tXh/2o1JYvgFVkDke2ucnDgnDQJbpSLmcbKnObTF3DRJqBMs
	 xx1vWE6/mHSf+CTD/AkfCJ9p6c+VnETnG5Vas70g0pCUyB4jQ5Hhm/18ZN63W38Etz2T+
	 OaIgqdAE1cPNQTSG46r7u0ok72lXDOEjEE+wWASc7xwkrrrhOwMhZSeAsI1uIRTuYfbV6
	 I27L6bukxhjnjcpCY6oCd9swV6bOqCmblxnzEI3T7MAtH6M+pMwD0Lf8fvECBrBQkBC8S
	 SgyNtXwjr5Plw+ooSqTkrR2CKI0HMPjqnj7WS8IVs0ev75GVGfNBF8MWvowKxl1eNcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Exif3C5DzsBBqJqdK+vGmrjxiIQ7WOIFuvkh4A/5cmQ=;
	b=mIbJ9B9Tiqn2foiMktP+zHUNs9fWFhRLy0P6HMVQqd6mFqMCDfXfUlCdJFbkAulMudBQ
	 i3P/mfhQUdZglk0p4Sd2WUMM0WhOoTE8XgH0ep+0E9J8mTsR1DKmbeeOOZHAYbuFNOzzm
	 r6aewoeZT+gZv1MJnbRaNXNQaMJRBzreLKKkJvkKizA4XckXLJmKgzZy3B96nRcEsq21r
	 QZF0nv65cuhVRAwjASfiv5XgbEMtZe5spygGVqmSfx1JbWmzKykKB6svZDrka2LKpSyGC
	 u0ak0eKJyBvY0Vmw0BmGvFqHMgBCwbeUzJ+pF8GfwPrXflnvC2VATZAxRpZ4lOULV3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XPB4gwLy;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31436606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 05:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31436606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XPB4gwLy
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a17a332ecso649141eec.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 22:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793336852; x=1793941652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Exif3C5DzsBBqJqdK+vGmrjxiIQ7WOIFuvkh4A/5cmQ=;
        b=XPB4gwLyenUKcF8WVSVcFVIUK7PJ0oFexKxEoPW+tnHuDDBAdjh61erS3zXQuEP6AG
         D5tT18F8qs7C5kPsnP/AZ8S0DEQRM8NAPapVR1w2XHh+DAFqFg8wgsN1V8MJL1H59CfA
         JAcM2ZKTIevDXgXU854J5ce4hmvSM4lcNPhZYyo0kjhoADh3DwF1BaxkUOte0SrZsStM
         s8xn4tVm9nQ157WQ0z6gRh4opSuuCknQcHxd1XiJhlyRpZ2i9Z8baOExfPrP965qZSFZ
         SDeMqnpFoeJi3ltgY5+BrdGu9m/8jNODszflUV6vWYeDl5yD6MDctL35SI7zGqst35nE
         FkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793336852; x=1793941652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Exif3C5DzsBBqJqdK+vGmrjxiIQ7WOIFuvkh4A/5cmQ=;
        b=wYmVlkJSH19G1eauqNNzr1A+h5dPdHrGtLCA31u5eoqKfZEXn9GKyY9MVS7OuckXFd
         DSLqTxW6wYlDmh9yZUUVP5Mkt1tBjBx1omHuLapnp3zgzYTfxXE+3slK9IRWYZ0dnysh
         ZxCN6OMS5RmdElKhKTEXv16pELo+dbIuLTUJeInb6LrUEgj5+zpGF+AY6l2dfM+kligT
         1sP3SEvoQdeGR4NcX4umLqsa3Ng8C/Kg6JmvnaVYBU/YmwMp8thKLpbsgKp/c6Rwqu5L
         QFt4d9mxlq4xMR4u8YjvreZK+igcwoWtKKLtrFVagndw2amBzUvqkqRpNyG1bJlv36qw
         AVPw==
X-Gm-Message-State: AFq9FYLERQ06pt1g/bzrg6ARZ8l+P5igArdqcL/oSUi28udCOSTbwQrk
	fqysgtGOGl+Kci1zc/25EOI9sLcU/+YfISykESSaBZYKAQUQDPcweTrsyQzMbg==
X-Gm-Gg: AYBFou1aWcWBr2N/FTe5b1lgg/1Jm4sA4ljbNlRNdltA8CKuaSsnMvpT9gee5REhmGN
	+kHJJ3rtCrehggZFe/ARyORYr2YAq9PHR6W3eU3Q/AQIM3uAA/pNmPUpJIyNCPEMGlDD3WXAyjz
	m74+5PwJ1p4lwUw8FV6CxCHphTrP16nlTFmfBKNsl4nNvCCi2T3yogwmsbVoOFvURVW/C8XaDsB
	qtuOBzP7d2dFGpzZMkMyhtzmbo9GovOyFCvAApiZXeRuoz3JRQn3yfRKX4iyj3KtGqdENgbYSY+
	0zc7GkUZhD/jYp/++mGgCXBM5cYzRJp6g17KzvmBISP6LgFmcAtSehnGcp7+oh2i8XB8jPoKtMj
	xs8UZGt+aBoGXI6FBceEheUhjK2Jt+C/g3K6NwNLpKwbH7oMXtLcWMVzAV2d7xYefUAMxbPi63k
	4gUHvKWi14ysGPPoMyLIYxM7nbOxz4W4IBEjDij9G/TCNH6VH9d0kYr0sFNhCGSXyasVQFJn4uC
	7JArnuVj4/xRP9RKgH+AEkGftqZEbH899balMbmCHlkBBdjdnvT773bmHEQ+G1/J6G/ly3F0Wvj
	PxtmYgMw7zF2s1Y/lhT1n869CysvFly+fPpdAXgMkVWInAOe2OsB2C56Qz6CeZ3kI5i/knoNzbU
	tKJ3BTg/vKbL20M4VIS91/92qEtDMXlE+0xlj0X+CgXUsXEyQzuuLFZQPkUX0B1m20+j51wgBXQ
	==
X-Received: by 2002:a05:701b:4646:b0:157:cbf6:89c4 with SMTP id a92af1059eb24-1ac5eea3b63mr1687027c88.26.1793336851799;
        Thu, 29 Oct 2026 22:07:31 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm3512702c88.23.2026.10.29.22.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:07:31 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v13 0/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Fri, 30 Oct 2026 05:07:21 +0000
Message-Id: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
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
 Documentation/networking/mptcp.rst            |  21 ++
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  10 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  39 ++
 net/mptcp/pm_kernel.c                         | 160 +++++++-
 net/mptcp/protocol.c                          |  77 +++-
 net/mptcp/protocol.h                          |  51 +++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 350 +++++++++++++++++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  55 ++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +-
 15 files changed, 810 insertions(+), 27 deletions(-)

-- 
2.25.1

