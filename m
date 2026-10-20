Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466237;
	b=xPAiKw5PPQiix6WxTAoDC1MngnQtKC0UiGJX/hIV6vmv7VZZR8MxF84dxsfcGrAvydb/
	 eRVrxKCqX7CNJMgpQHVpyXF4wjacN0tSqDzn1lxKn9k9F0cQvlk5DxrtBc9ZG+UYcdCFF
	 nNiFUo6Wc73FrqgN2qpSjwkyHunbGxw+/tFG7Ei7ZHv+GMaDOVVob/hbIM0SoWNFriHP4
	 pcIYcW1yn+fYv3iKdKsTbaP2rlGPKogsCnzn9QzEax2JnjT8rjsXA4BXY5p+BFZbb7lAV
	 R7xtTr/XtKM0anZQWlG1s58g5tniokDc+ZH1EcO/2eo+ujyE2msnvCYA85E/g+NjY5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=yltS0NnsgmHbD5LEulZnn9SZHM6CmLfgfkPDRVFCckE=;
	b=TNrhm4e564m4bZwycfepmDp1lNq9KJ66kQk3/yuExV5YWNIgx4pCL4KhWTbnbEgtdWXK
	 cb2qBy8uER0alIMLq2MuiAMyJT5HGWjCuHG5ojKzLaLMgmJ8tzPNP72mxWF4CXLnXe6ZZ
	 pi67fGaA8zZ4nlvgz8yeNOKdDVvLn6Q+54cRLA/AA25YIjZKWbtXBd7YZyk7pepaKQr8x
	 r+uQiIZ09dS9sLDqlm5ZiXr8/VoVU+9o9tBKeSdjXoGNCPODuvU7F08AdeVf6ns5Q1Yj+
	 qOZMVoStDpPOlcVLT+X3tck/A/yvP1KEQA0SKLVLH0UQ9yBLklytMOJG+B6pdCSQPlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhCVP4l0;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F9606A31A
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 03:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qhCVP4l0
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-353804b591eso5304391eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 20:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792466236; x=1793071036; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yltS0NnsgmHbD5LEulZnn9SZHM6CmLfgfkPDRVFCckE=;
        b=qhCVP4l0JZr9y3KbEYuWEcd/QNCChL81iHQevqqNOeWTN2QSEUPHRwuUbXeDxcgBDU
         DOqN+2L+4QVADKMCu+84CVH/A8a51ugqm+2LEH3F7iCypoBEFOsBJY9ifyNykWlbZQI1
         9fpBUu0wAXIAU3AD/COEHqLNeBI9+uY21SLUzh41AeadCeYLZI44D83L5R+oGpbbDhQO
         NNBxjXNqSyv6yPYvbzOHPFAk4d2Dec663a3vy85uCfSl85l2hVpKGG1z6hQEEQy642A7
         GqL9A0MynWsxQxfOFGceO/GheLrphR19scsw8kZixA5aLSzNAQUJM/h2WOGG+B3rmz8u
         oqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466236; x=1793071036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yltS0NnsgmHbD5LEulZnn9SZHM6CmLfgfkPDRVFCckE=;
        b=s7fLLZ9ohPcxietHSQQWJsfAbfUOD0/Xiqls98BwNGwUiFkAAAhE9kMX7KDl/TXwsU
         EMbqafgtfWwAAjQorFkdAk226YShW2W8uuBJM9NCcwDHK/dK/fBNT0VegUYBjgonFlpC
         788+MwobMue25oy23QzKSxiAU2CUis/tBtWpCvoxI/aAL6CalpjtdgiF2x2AbSqp71S/
         D644e+B7elNmkrvnLElCcZ/qdt3Qtr4DW/ugKIXAX3ADgPbSyLiJdmlHA8j3ZDnjiYli
         h85ZEsaXvHzkRwvrHq00+7AkdiPTgBuFWMZbx5IRDOoT1fEdPQCkp5RR3V2J2AwnyIsX
         tMFQ==
X-Gm-Message-State: AFq9FYIA/B0BvM3WTWANwPLSiW5Vx+cem6JI+n0WaSyuZVs/sOTmWVvU
	rGbnw0sRXtt8R5VrLunUV5ZABxxBuUUfjKCBDMbaBkiU6MZIygxgiEyNBsd84A==
X-Gm-Gg: AYBFou2dNGohgdN/D4cE+8VNxer8LAq6QtjhESr1rhE0kHrkkw25krpdTgFjuWv2tj6
	OlnKHgExFNhboeHRHXvhi4Kwsv/R8pCCoNMk/Y7NMivLlRYd+o8a+o1FcZQu/DWLNHEN9Pmqn/1
	7/e53KVZ7VsjUGTIn64b6ZOaE8lURT3aAah4V0PAryiwQwxuQnRU+98U0eEiP0OXiGem1463fRT
	8Va+DjEEYwj67HpU1/b86Pvb23RpRFWUrnAcanbbaNlY3zeJfl7/y+l9PivMtz78gXouNzW4cH6
	0JNiswHM2zGfXb8A53uGIjV5Xyu4ik8FFYYSlRbJQsGNHcL+eQb0+LGZNMLq/sCVXnv7zc58Ixi
	Q4/1Jl94dNKA+dSla2oh3Lco7VZkn5gKnJG4kBBr7Dm/xnPsPTpK1fqR0eTh8RTlS4SK/6AIi18
	kAy6hMQwydKkx3tf4+jgeWmMvhrZnm8C+7pLw0I9TgGkOrBtfF4os5k6UY/mjsaHefSCPXAkfUY
	NcphgGT84Seqvg5uJP2dfXd40/k51K6XxIHZ/MDjfH1yiTQWnOpSglLC3a8vgNlZGJXDyAmqzqc
	+w803L9ftEEECm/GjXsf8D4Dd8K9LCyKhhN5bVEhHek=
X-Received: by 2002:a05:7301:711:b0:353:7e33:664c with SMTP id 5a478bee46e88-361a2846408mr14080871eec.37.1792466236123;
        Mon, 19 Oct 2026 20:17:16 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm38473608eec.21.2026.10.19.20.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:17:15 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v7 0/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Tue, 20 Oct 2026 03:17:05 +0000
Message-Id: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
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
15 by default, about 20 minutes, 0 disables it.

Patch 1 fixes a selftest tool issue seen with the new test. Patches 2
and 3 add the new limit, patch 4 the retry, patches 5 and 6 the
selftests.

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

 Documentation/netlink/specs/mptcp_pm.yaml     |  13 ++
 Documentation/networking/mptcp.rst            |  11 ++
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  10 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  39 ++++
 net/mptcp/pm_kernel.c                         | 141 +++++++++++++-
 net/mptcp/protocol.c                          |  27 +++
 net/mptcp/protocol.h                          |  20 ++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 178 +++++++++++++++++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  47 ++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +++-
 15 files changed, 526 insertions(+), 21 deletions(-)

-- 
2.25.1

