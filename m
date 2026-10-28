Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166109;
	b=yHY/IdEv+RYQhyiQhNGm9+rgz9vC2huG4fhoSIgvrwohifZWjWzl9txqrw0FIfc9q8Mq
	 m6K8LdkOjRPbQIt/5BSdpYYG9BLbW4VcpSK2SS/+9CctaR2D4kz4sTTFWOMvazy1ySmNE
	 G74hKpZ1v0oWqEcAYA39GWSFI6n5lzCB5YWZwdKEA+BhsqaPQA64YG8ZIgdCD/pKUQEgz
	 QJx5BqrFxB23hCEeYXrrPNeLEKgKKbq89PB2egkqCUVk1aKRsYNq0fDxH7Bmjj3jj3nkz
	 dLsv1yuLqQZMk11e9+Aoj+sklYI4cNBJtaikk2IY/MwPyoGcXywTzxlR3k4Mdhi/lig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GfRibmZuY1ryPhKjA2qHgTRyp+kUteqF+DNioQ1vuMY=;
	b=0V/7xiLzn4LNwLu0WBixKK5KKD3IHB7mbQlDAvF0YC5FltyXiDo1DonkeYIWjTc7Losl
	 nA/8qwh81YgtIKg8aw/1fUHP4t9lhb6TDXe8CHIlOPkIHpkLkEPBwR80YeLLPtDqRzuBu
	 Tr45M/shgDzUqirpPpFcnyeS1xlHjBU7WXJ8O7Rdmf4f1p06vtPpYC4sR/9kQn4qMIByq
	 7X5FSBr5W1h7bivch5AiKq+LJ1gMnthucQr5tD0zZRBHEKLlwdiR+roSOCqXfRe8rsuqR
	 Jk5PDME7XbghJ9Iqp8o7hdjlqz+j9r0DfJFTP6WJ79oTy39SNO7xAllHG+tN3ZlfeRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3iO+BO9;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D2606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 05:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E8D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3iO+BO9
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3550c917fd3so870712eec.0
        for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793166108; x=1793770908; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GfRibmZuY1ryPhKjA2qHgTRyp+kUteqF+DNioQ1vuMY=;
        b=t3iO+BO9u37oyHNPmyLRkBTfWWjdF+gxe5kwNTKCNrLaqrOxpLgPO2v7s+zeM96G/Y
         fJ47WSvEgBYD+5cC7vdMlBQeA6De+sMUPVUAsKxCkr2cXedGzEa97QA6AdELbOJhXxUH
         4Hzb9TSF0J3ufnjAI8CDJyfprGJIMk6aI8jm8s8R7MhddTSxIJcGmxcmrUMSgT37HSD3
         /wemgAjbsNRN9210Z8BTTaRis3avXk+s4D0MU3zowUtoGAd1mV0Xs5oTeoeZxSU1b5Rs
         RIDqWhc1FcrZQH0cUcUiztJSc6o8Q2qjnP6ol0KkYjuRPOZSGfq5HKPPcI6JG6iVmoMP
         vsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166108; x=1793770908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GfRibmZuY1ryPhKjA2qHgTRyp+kUteqF+DNioQ1vuMY=;
        b=Y4oNaPKQr8xnythgjS8usoWhp6fb+3XayZaRbmJoy/xVcsB6dtUxbFo2QKBgRzhYiI
         R+JIS7Abk3fU6y7DDm+AwmbLiyd3CPvoYBhATeGm9detEwU/HirFCBZmR3MR5d4luT03
         wgi/kUzErYSkNHRDY7KyK9dKoO6fINOXMF8Y14BZ+9QtiZZOSF2WQvvgJwEDSonMc6vk
         21R9rfjHfzaD4b2PuwYSNAHMJychEjw3MkT38If1y+tD9dRCfQl5eSSN3DUydmTF9Sc7
         DPAFHKHs8ck1oQJ1cfEl5hlhiZ0OPF5ZfieC3Fj1QjPFGNZog4MNhwLTedvF6xkm0oES
         SU6A==
X-Gm-Message-State: AFq9FYIUO7iJGaybPU8XhhO5zou8mCpLmzYik4PyUxhsoBtGFhX/PAlv
	k4OnqzuRwQlZT2nFjvHCqSWl1Uv044U2uvIesgdFs7dzQcFbbPGXeeSqJkFdZw==
X-Gm-Gg: AYBFou35la+CIYlkWqoTqBQ7q9QPypjQ1q+WKMzEoo7if4jJWBxwopvV6cnN28nKCVa
	YUNFwCh3vXJYQ7Sn4j15kSt3KznWM6uQ8hrgFxdr8Yd3+SkDWM9upRnZpOeuu3A3lNrgOmr4i8S
	GrCeud4BpgmOm3jfh8MozQgbUAPHkvDduE3i9iJZt+N4Vrl9/rR8FIcnjHcwGu2WQBdCYN31EDz
	/VRG5OAjCa32D33UJ9v4E0IvoEpipc55PhZl3nI6lYAZFo+WTubxU9wYM+yzwri9mEWrhGezgJZ
	lzo1UlSV9vU/tKrvwTu+8LuGUhV13bqGzoDejrfOOgwsCQQWhFeSMqWKWWGKQRnBp6LRr4a7P+/
	JqX4O1+EQDPNG7XKUYFHgHa6HlKurLneY2KUbQnqPxgHs4vwM1Sk5HEVFux7wAuxk4WcBzsSCMt
	XXpdqF+mdsPROusixSr4jq1NMonYIBXAZN+hPLBk1nknZbD/rLTMlK3/15BuL6pIv+qRFkm6tiM
	7OCkzjTww05Vj4xKErsYLfLkj3OHLcLmQoNccCh/GSao43n5MI7eziv3a0of9KSDMGG+CDUQDLO
	89DnM1EHR2uZwoKfhtmK3AcdbJLmUObgv9RPOi560QBQmblL5n7IdCLJDsWY+ou1JHlfecummL5
	AzYUbiOQy/P2ovkcXYNfCRfwFNFH/QJOgJCtr4JhgTtNlCnQaAJLD0bFabl3Pv4lGB9lJiepVHg
	==
X-Received: by 2002:a05:693c:881a:20b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-36a202869c9mr2319463eec.5.1793166107874;
        Tue, 27 Oct 2026 22:41:47 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237be80csm5860973eec.2.2026.10.27.22.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:41:47 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v12 0/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Wed, 28 Oct 2026 05:41:37 +0000
Message-Id: <20261028054143.3222998-1-anilkaushikwireless@gmail.com>
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
 Documentation/networking/mptcp.rst            |  19 +
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  10 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  39 ++
 net/mptcp/pm_kernel.c                         | 160 +++++++-
 net/mptcp/protocol.c                          |  78 +++-
 net/mptcp/protocol.h                          |  51 +++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 342 +++++++++++++++++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  53 ++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +-
 15 files changed, 798 insertions(+), 28 deletions(-)

-- 
2.25.1

