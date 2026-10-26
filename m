Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019231;
	b=St9QTHu11bO17i2vFmNK+F2GBs/POa8bPU4ETJjTpErJKbLdm0uzWu1yEcmV6obr8tNM
	 5/LeC4swZ6lJt2zoi4+anhGt+CrrfNXC0tQ5j1/iw75qalZtKEyPmtklDK5hKa8rXOLqv
	 fXkzIGaWCT42dyLqi9ZqTeFLbVSlgUTAgyGooOMsCKHs1OJFbTUMstd/AKrxuv02jr18x
	 iKWaUU1AxgF2Tild41KNNP8yKjHstL72oPpXcHdA7ELKz5ZgFqnyJLcaD4HoTRsPLQORH
	 d1gboQhRcf8QeRQ8sJr439qdloj+IxVKX8L9P+tecgZ0rkmB30CuQxytkkd4puW3qnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=E0njs3XuDXo9ko2WsQq5fVHJ/QY/gDv5xpYPk9SHFW0=;
	b=DRhIC0l1EWVTPco3+RbHwVZ5oFOHm9jq2US8zU4EhbDzzNRfwm/v+cMUyg4K7M33ZDVz
	 DYdY9xLz//9qO0OvW7Mo8eO8KCMbfevByOl8UFHZdBI+Q+UeAFC33LoJ0Xzc6aiCweyOq
	 tNafWO0bccFzU2HIe/0JqEP6kLnUoEeOojOvHXy00TSukCiyneUB1mYZM5IcWTyRl0NBP
	 19jwLttnuWsH2RacXvMdsFwJipKvVoRSpG4bY9E7VjoS1vuaJtSulB7gRcGq9/sadqHTw
	 Wqglih4+Y1WneQc5Wt4Uyw527adWpJGiLNZG2zVgNw5XhTOvUS1D9/BN3INn3EnC2Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RQHzIi8G;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF1606A31B
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EFF1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RQHzIi8G
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3282db206d3so5823786eec.0
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 05:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793019230; x=1793624030; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0njs3XuDXo9ko2WsQq5fVHJ/QY/gDv5xpYPk9SHFW0=;
        b=RQHzIi8G4YmHd0i0o+RrC+Chij7HBvFGwtzfYI2jWv2naVDgm2PnzDgtCBKdQ7/F5h
         xl/+UBC1aveRViEi/hlPhZS2ehI7kMDgKSSjZdl++Q912h4xKFJyQWkwVRMKM/5SP6GA
         SxkmMfHI6BlThFyWHc1ZvKr1ypRFrrm3H/TX9CD/J3rwU3tOsiOCet5MRanDBh5gtkBK
         2pu7F5N8gU0HaHLFBcW2aAvM1YLbP4X5M0RqkQNBwVOpKde2RSUXvAcqWVqMw7IzVIEI
         R26MaqwN8vUJZTfNOYzE46E8LV7Y/Ecri6PZovOnxNyfCzOI//PrkEKq0AOjz17HdvWg
         O9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793019230; x=1793624030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0njs3XuDXo9ko2WsQq5fVHJ/QY/gDv5xpYPk9SHFW0=;
        b=gUtiSdTTNGV9obqBWp1ACxAnSr+rYt2pczbfXuozEUvNV6Y7tebFSbvJJOS4Kyvpuz
         5ASsmvuanQdig3fdeqFMRgZnG8igbC118BZVN52SK8pTJzQq5PnKaLaLfSP33zj9ZPYc
         2JjY3uL3pQh3rFvQlWI8WsJYwPtTr9CQnbnHtJRvDlmIwygkOAoWLW3Q4raY1hTavMFf
         pRLmHIeLeHCpTQvDLwgkoBtTHVjRMb2SE7Ipxp8x2qOZwS6Zlt4+jz7zDOuvdzK6YEXY
         xpD7syLjNi47YeOMg6/RVkRqoOpOQODO+dG55W8UH+HDy4cFgYnq2Hn6X83htxQbPySw
         EbaQ==
X-Gm-Message-State: AFq9FYI08f9oYvckPCoBwofakPLdJ0Kr4Ak1k9lfrfWhSqEYUZApF33y
	Rd1Dl/mtzx0S3TDC00BNkgrDHmqcBZ5NI9BK6eYbO6izjhFknB9dDUTcwV/MTA==
X-Gm-Gg: AYBFou0orfUQjVAsCc4efyqsLUk+bsX52rV8n8g7ATUyQTnC3mZwUhUd3aA2gNQJTiv
	sPbg8ceeaALi4rXyingDGvSeg9vWtIu5R9gCtApt4HG/KeFsVm1adaLRedAzHlC93KdWurH3Nwr
	wlt3csPQnRL3z2PyfwMAqh7RPxCP8xAvgHMxlZJbgMZ+xi0EJ2oBephIO6K/ZujtTdRG8wDNxCX
	Kw5gKrJnt8gjgk3BNeIA/brlJWMEjS4J8Fx3/WYEZVbcyLQ+VRcNOgn2ch7qOtwpvwox4F5R8D6
	+sYPRAtB39E46M0s6PlphHJvgyB5uTJkYDYopnLXHgspnCRJ9AFXiDmAwjIlxIUk7BWECoq8K7i
	zOdFcDfjjhxplkhxq4fPMSYIfYZj6fnHz+AadAi7jwLuvJq5Ig46lOk2KSR87Onduhk2ypcYz2U
	kZKhir113aqSeZhjVHrB7m7cZEyEPqiJ23tKngHgpFlQR3QHcfimvOfZYfgRhKu7x63rCm5CsvE
	qZkksYi48QjKNVhi9Owq+5QqE1ftvl0pTZCP80zWLqjbjNrbVrKE7bldLjCHKILJ0NEC7uD2G+i
	T7xHfgEjdFbbKzAPSVr7Bm8/7YWH7BZnNL6io0UvscNAWxI+zRkMtw2aV+MMYnMKzTV7Ej/6XZU
	cBtbfgYiVclrSw7jpfpEBcJ+H
X-Received: by 2002:a05:7301:488a:b0:368:72f0:353a with SMTP id 5a478bee46e88-369e8624c4fmr10033536eec.38.1793019229787;
        Mon, 26 Oct 2026 05:53:49 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f4164886sm18377923eec.7.2026.10.26.05.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:53:49 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v11 0/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Mon, 26 Oct 2026 12:53:39 +0000
Message-Id: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
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

Known issue: in about 1 run in 20, more often on debug kernels, the
first new test fails. Once the path is back, the re-created subflow
joins, but the server resets it right away with an MP_RST, after
DSSNotMatching, and the PAWS counters are high on both sides. It looks
like an existing issue on the receive path, triggered by the two-way
transfer with losses rather than by the retry itself, but I have not
found the cause yet: it does not show up with tcpdump or tracepoints
running. Any hint is welcome.

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
 Documentation/networking/mptcp.rst            |  18 +
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  10 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  39 ++
 net/mptcp/pm_kernel.c                         | 164 ++++++++-
 net/mptcp/protocol.c                          |  68 +++-
 net/mptcp/protocol.h                          |  42 +++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 335 +++++++++++++++++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  48 ++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +-
 15 files changed, 770 insertions(+), 28 deletions(-)

-- 
2.25.1

