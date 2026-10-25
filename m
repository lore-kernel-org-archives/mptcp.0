Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936155;
	b=JWfQZwGtZrs/ELEkT9a1LemsUNZLNrG45FCI+mEPzCklM7cYwQ3jtdfuPzHjJ+w8pD47
	 wIfoz05+3HVDzOfmlbkqzIN/wBsJzwcpkdjlVpXbdvrXgH5mtqX3YMEMjzBLMUfK0Jccm
	 YiintpqzsLum7QmvPnjrko//t2OVcONryklct+usZDoLo2q5G66yEntPaaYiruGz1De/k
	 rAUs4byoYRYAFRlwIgFoZfYoOK+pMrK8ml2cputpRjZVTDnXNtdqVUCUipEiXwZC7J3aP
	 elNMwKEphpYadjaTrHDDrcqejCtXfXOds2WzXtu/9164nT/Erc9nGbV4RnkUohPL/kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dWe0XdAVq9yPeL5Q+8sXT5JahhzCV//o/+i9a/tAiYw=;
	b=ANBSdkAYb+A7pxggUIFR0tFuSUwROkLbUS5e6LtVTLozWtsvJktGXmGzyHAL7ZTqQt35
	 mb4rQn4F3scWBtrPddUMgoafHSoA+n5iQT2cWhG3uCMAxWvYQzG32YfaUgomFyigYnPZI
	 Vt9FNrTawmXYrpcUFVPf+qQWLnEi6tIleIY7FCvHSYNg5vUq3No0CNSZGlyb6cWfS41K0
	 icPS3WgvyCbof93fZOzWQqFAYeSmQDBH4AgZOA3RWNkAPXo2TS1mPoaMxIdpTXKjM+swH
	 5TAYyQdmB5Ao5jYwZuVmFAORyzCiVEj5waPWlsHmyvQMSaqlWVFxOMcrXz7BLjAPGNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VunvNWYb;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBBE606A31D
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 13:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FBBE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VunvNWYb
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36661f953e4so4246292eec.1
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792936154; x=1793540954; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWe0XdAVq9yPeL5Q+8sXT5JahhzCV//o/+i9a/tAiYw=;
        b=VunvNWYbUuFIPm26hwRqL6wDqeKOr561vngJPl9V47u0YrVfl035TqVuDqwRomrZ/I
         99c3uCDb/fBScrtFfdA+tzeA86E0UYdckcRRWZ7iFCBYhEXjeWFueqs3QwRSQ58x/z8o
         a85QUZR7rWC8fUEB9i1lvQXJdUDBV7HeoGY65xhg875qg+w7yVBzVt2bcIJlcHxvb325
         obZcerbjztyGwAfjv7IPy+22Kt0aELZL2wHR4V5uld2qeuBWbasH6rjoKYIvd85OkMUt
         kHZ4h79oHhp0Rx26iWKHsFAiJ9n23Cj+AZCZBxTSakE5hEwqUuniCAUQLI3K5D6Y3ibP
         CdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792936154; x=1793540954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWe0XdAVq9yPeL5Q+8sXT5JahhzCV//o/+i9a/tAiYw=;
        b=NR8TDxlKYULkBOkjUqob8sIn8DUnqk4fqTlw3xmrrsE8z1jY5zgOo7pHPwlCvwvEVi
         9c6uGThTp307EIN6Lvl/tNHaQkzqjnWwUK4y9jTNaYssqsUg54SjMT1L8qm0ozzTaaKv
         dJjvTxpzBGB+gty/cwdzn4idCy6zU92mmUAI/SHD6bUp69b+C+Xn1ap5mp1oQnXzGbwX
         jN8MTZx36Zk4FD2TFJhH+EfUx31UqO5ygn5QkNOQvV8OQ+08sq7treoU/QRopjV6cE4f
         5CXoWBUc/Ll/JDLbHchnt2N+zqxLpG7hv4DjtOhGZHMUe7m/CA04ZqMZU6eiH26+zJjW
         AnyQ==
X-Gm-Message-State: AFq9FYLZvYsMHVr7Vrj2iux6eUwkLeBya6DJWB+KW6YX2KwurM3KVBmz
	qFEQGB8//UUrGRgv+0BK1tis+tI7M8D138dfv1m8wFmBmKwGszvvaOdSOz7I5g==
X-Gm-Gg: AYBFou3pLBqBB6u2SUL8EfLppQbyfg4lvqysqhbcH21o5Z9u+d70m39ebYnxIPRFrVK
	MHP90EsbLtNQ4vy/h5MD4CC2scFXSJaSn7IS8bmELU9s+lmDEWKOO7OKBJt46+YALaB6LIT7XIa
	Akd++P55Ot+3KylOcGfl3FpomgyCT7nsnA862pdRKxP9IaEzGLNcDjUAU//kGCCQRQ0HlG4b2xs
	XDb3baUDL1zngw0VKwQCZHNZXwM0jxnIVF/k8XVj1HX1fb0/cPRSmh2/6gHT8kIZhkVi3hX4RTf
	+2TiU5jEQNrH77wK2295BF3RRXV490eOTwYixYNHikFkidErsWPpsMiUpwGeB6PkA5lO/mOvaGI
	IFaEXSn0uW/t80amT2vQNnMTmiuaWq0LCxs1aEQ11tCcW1X/6wezoRSYj/KA/rMV/VWCYggBmzM
	6s9xV5NSXdZu3IbsdCyi4PyFI3GoF6RxLyP7ltcC9RMf09MEYnXDfxuUjcO0zAQBef+3l8FOrkZ
	TpGTxhRF06lOC+0UeHxBYyfkYIByfFx6PHRU4/ct6bDjYgRwvrsVWadrqGKM10PFDvS0vPptDe2
	4bG54YU0AgIwfOhtpt8LN+Ht8q6/2eCv32J2DTyRn5WzsfrXTC75PUMppDEzF+h5ssLy8bM/PQ/
	u96q176aA3IN07l57bsC5Ri5SMI3UxxqR4PTfsqVuNq3Q0Q==
X-Received: by 2002:a05:7300:a21b:b0:34e:e7f4:cc78 with SMTP id 5a478bee46e88-369e8318a73mr6666554eec.5.1792936153275;
        Sun, 25 Oct 2026 06:49:13 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a002a486csm1188159eec.22.2026.10.25.06.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:49:12 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v9 0/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Sun, 25 Oct 2026 13:49:03 +0000
Message-Id: <20261025134909.2794368-1-anilkaushikwireless@gmail.com>
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
 net/mptcp/pm.c                                |  39 +++
 net/mptcp/pm_kernel.c                         | 141 +++++++-
 net/mptcp/protocol.c                          |  77 +++-
 net/mptcp/protocol.h                          |  20 ++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 328 +++++++++++++++++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  48 ++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +-
 15 files changed, 728 insertions(+), 27 deletions(-)

-- 
2.25.1

