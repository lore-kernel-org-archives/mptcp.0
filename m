Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113913;
	b=krM3uCno+SGlE7cVGIBUGiZAVvVxv1iA+w4Rnz6tK2dpl93GGyE5yuasdlWFALWwdp7Q
	 +NF4W3OChZn1nMVI1bMQ7vcYm1NW3VmUl7Py0bEmP7JLbC1wV2U3znts+yGhksePuZnHV
	 1ypt9L9zbnJdgTj+UmUEcJdS5Bt9aAuzaiDALiGNQpuJu3JW8MrqMQ6QGdAamttKDM5hI
	 h4F5TUUtq6PNhF0EvkIzm5NUwA6VXKhaqa0TmsmSlpLORzuTp/9dwH/D99SB1ZZQAZmK5
	 NILk+kUpOKK+EvJUkTQiNpLo/1NKLvBsXMjXZ7Sgw4lQ3ysMdw3/WFK/zmeJsQe2QFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=milo0i9re+RHuON7oLYDAwFnoxQe6QkQnp9iffBjSWQ=;
	b=DyXpwmbYZHWE1P8W2OF0jUNdd5Rt/6T5aDBtxY1x/VHf3xBgDsrdxSSOOmeSpXhzW9Le
	 nksId6LD8CkJAnAH0YalBZgfsNsbq2fwYlEjaZh39ItRNNbnUBIXwobkLrQiRwTOqKwS9
	 pjuNJULsmPYcoRT0SG9SrzxGhzrkXHNnu6ryDZ8T+aXlPNgNhBp+No5+6Zt22kFvxClOH
	 dqJLhzBlGofxycT9NG5+G2IqQPBI1BNvF9ptMTwOC5QOj0MjzQFa596zYMFmTqXHULaWR
	 dpYptKiDz/mUWaxMY9o9H6egHC5A2pmYd+tn5EGOWRWSVTyc/Jt0S2YRX585VlArUIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hbujP9P9;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE6606A326
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 18:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9BE6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hbujP9P9
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso57559c88.1
        for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 10:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795113912; x=1795718712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=milo0i9re+RHuON7oLYDAwFnoxQe6QkQnp9iffBjSWQ=;
        b=hbujP9P9BprFEIO/wCeGK9qG5/qdFaGnJA/w5AWr3jtzwv3S0FUbhVXvqJcaZZGsTz
         vfTJLibFh0Z3lYUIZJ/4akqKMp8/C0rNUSyAesYPBPTe2r5YFgc9wYp32MGarlO4Phph
         ChKRRgAWeQGy5pQi+ZEw7pI9jmUZ6gK3FxqsZPxMqhtuhHbujBezCpRUcIaqh6GKGjLA
         uppA8hdIoTEq2bId34C+al1qzWo0shOfKmLRZcOFKcgEDlDxIWg8f728H+V9F5W7L9OI
         HUvn64DnvgPhiUoMdWzS9Kuc2eVAd5iGENeXGwZw5EBV1h8+KtZDW4rzLAXPQTLLuEMn
         ngfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795113912; x=1795718712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=milo0i9re+RHuON7oLYDAwFnoxQe6QkQnp9iffBjSWQ=;
        b=UKQMCrxdC84W/vHwkXuHt+GORdh9a+VO332dywZVfgoHx0Kn+xBehz7h1mieJPx9wS
         mP8skwHW6U7I3au/ZmOix4MrIeXpKd2p9dPkI3bHvithKm4Q10jpS90LcRHJk9/CixBv
         YR2JQdWCcADhq4b1/26SxV9XMXFYov9g6JQibHUDYQLJ8gXCqt4xrSFgRsL5+293wF6Z
         55HH/V81lbmRmFrWZFOOuWcgFvXoIvPmAoU/3WJN5uep0wGCPfR8nsqf0S7Kl0A0pY5E
         Wnil8nWLZS9eKexIsSjyEQoVnKN6IdUzDMR6WgizhoxytghPg7qN+2qdcPM4nKtjSRQi
         efQA==
X-Gm-Message-State: APuU4Z8GHz7y6XO+0SRthZtJzxLvsMtUmnQA5QA7WYGyRkwX7YEmEYjC
	pvLYVXTtMc9Cfmpw/v0em27v18vRP6OwWH5YyUYx71bHwCr9VCbZZLzXhJdSmg==
X-Gm-Gg: AZFdTZdq8Xf0bQBO1mnfzBqt4uBN9WjbOhWElxPJs3x5pgG2U/7oBERKfQleh3jK8k/
	9MpNA+XSyw/RIrZtW77Byof0EJk5m0pJpNPRrwQLJrtfp8SNgzodp5zuswWSW9XYbzix53gWyle
	efAfI7u+xDjxMcu9TDXHPYwvSz5FHp6jX5QIpYKJQuyScqz2O9x4fzliiMYI4npc5LHP67BSFwO
	TRj/E9Xvs3ce3y1tHJq3SNr9I4dx7V5sNaRibh2/PuFQAfulKXOjBrriI2zV4nY5bolbE/1TLgl
	j4zeiqdWw9YRSXbm989h6q3kgvXYzCAYTS1l3TZXiL9p/FI5Irqbg4jy5OD1PO17XY+7SABcztR
	FhFXEZ6Qw6K5RvTJ70qn+C63EHQmM/h8IxqvropXdJ4XYFl7JuOSzyzY/Jk2hjuRrFdZUfIfKdY
	lbcYotm9967gxEfHTtbz081wGjNAsiCaG5eDJXG53S/0+BQXl1TgFSWYEKi+drlQ3IJxXfNB2kU
	bgg/oHIO2GhG3NfjT+6sUN8p2yBJQnYGfvbZ2/t8FgUAPE5bF0dDPvI4y7jTdKirvdMmtmJ6h/x
	gKGXs5dgjhHpxn8Jxu/d2wPK5jnlmukT2KF3qhMF8K/XCo/0jkrbv2XXD+YKfFstiGyvrNHIuPg
	QbFpLQ2O0k3BI2ToRGa59CwZ/IlDcrmxl9WaiqL4jcd2/7Kmf06Xqn/C/iqyCAairTaAc1z7m5A
	==
X-Received: by 2002:a05:693c:87d6:20b0:376:40db:faec with SMTP id 5a478bee46e88-3856f65f251mr177305eec.10.1795113911513;
        Thu, 19 Nov 2026 10:45:11 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm542607eec.25.2026.11.19.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 10:45:10 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH iproute2-next 0/2] mptcp: limits: add subflow_retries
Date: Thu, 19 Nov 2026 18:45:05 +0000
Message-Id: <20261119184507.1954726-1-anilkaushikwireless@gmail.com>
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

This adds the new subflow-retries limit of the in-kernel path manager to
"ip mptcp limits", as Matt suggested on the kernel series:

https://lore.kernel.org/mptcp/20261103085244.23064-1-anilkaushikwireless@gmail.com/

Patch 1 adds the new attribute to the copied uapi header. It is only
needed until the iproute2 maintainers update the headers, once the
kernel part is merged.

Patch 2 adds "subflow_retries" to "ip mptcp limits set" and "show", and
to the man page.

Tested in a VM with the kernel series applied: show, set, a partial set
keeping the other limits, JSON output, and the maximum (127 accepted,
128 refused by the kernel).

With this ip, "pm_netlink.sh -i" from the v15 kernel series fails the
"set limits" check, because ip now shows the new limit. I have a fix for
the selftest, which also runs the subflow-retries checks with ip. I can
squash it in the pm_netlink.sh patch of the next version of the series.

I used an LLM to help write and review these patches. I checked and
tested every change myself.

Anil Kaushik (2):
  uapi: mptcp: add MPTCP_PM_ATTR_SUBFLOW_RETRIES
  mptcp: limits: add subflow_retries

 include/uapi/linux/mptcp_pm.h |  1 +
 ip/ipmptcp.c                  | 21 ++++++++++++++++++++-
 man/man8/ip-mptcp.8           | 10 ++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)


base-commit: 87cb3f4198507331b9308689d4a726d17db63dd3
-- 
2.25.1

