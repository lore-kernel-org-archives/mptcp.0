Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747201;
	b=VwQtzZryV4hS7GqXPfPK0ecdhjGXMm6PEQ9k+HN87/UbNIN7RFXuIWBNhHwzdNp0ADxt
	 tSW8MzyFQwGl/ISO6/0WHTKpkK3zONCm74+Eh/pWpSyWvgmwaXqMhsvPi+LdrOuz1Jt0q
	 BgL37KsyVfqcCBoKjzh6VdJcqa6mTib/Y5W8MGfK3uFtCaTtb6jnOvnAtO9/4/+31Z31+
	 Eb8jyEUDknDMcBUs84lDMvXTtqZooibJg5xYDpId454LgdKdiJ3Xrv0sZ19IMS7IJ+ZMq
	 z10a9ws6aNyS89/AEZa5ustLdH8tH38HyHTbrR4nNhQ4XN+Y4lDBh/v2ycFthfUn0sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747201;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3nh+Y6KkjL4bYSxNfgwpS8s6v8SyETePRUHlOEPb59g=;
	b=FeNyNzIUnY3tE+IEi7YSUL6MohyAnDG5O1+i8EY4wFhI7Mxz+gLfpqet6OxUrB4AEf9Y
	 ROYCX2zuYJBvTXBCgCbPz4jeVm82jHFSHXcmb6XWyoNoQdqsurxxb9b5jfNnNuUoqW4aM
	 GRbMWbDYkrgbZgJn/oECFUUqhholpUtUcinIXbTqnqZHgO01gArO9Kbt8NwBkvevWYg59
	 +mEIkTA6FCmlqSR7p+IWG2ewLcX+/iRRFKkRAz413yfiyrvVpTukdskBkvqQLl9ZsCsCt
	 AuWSB/ao7YLQ/FIhEH4aHJU0qDxhulsiuJZSqERKx2mDdjbi0EITtOnHUbT2en/eW/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MonlE/2j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D8606A31F
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MonlE/2j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F191F01825;
	Fri, 23 Oct 2026 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747201;
	bh=3nh+Y6KkjL4bYSxNfgwpS8s6v8SyETePRUHlOEPb59g=;
	h=From:To:Cc:Subject:Date;
	b=MonlE/2jbexC4m7ADqxuO9JnItvZzK1etmMV/WwOl8Cugu+bc2wTfEQ6Ebth2UGe5
	 JQvrk5t6GDHxY2GaDgTvenH/ojSI7PpvR5T/TZc1iGDtfd74SMHKc6nHR06fG9lyn3
	 +bvoq8L+2tt+9iyDNTii1lfELBZwJbxZutiKRZEKz87CRNKMc9uYXgZG6GPnHYYeC6
	 eOM2lMAnEGrHvu5N6r3cEuv7YDb8JZFmAtMv913MQHaaZ26UVeLSVTH2f94ZDQIj6l
	 MlQm6E45CHlOY881XG0SR+q04L7r5Br/jjKDkA+ysJq5hfB0953pp9PEClRKSJYySC
	 o9Qnolf1+BcgA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] Add MPTCP support for NBD
Date: Fri, 23 Oct 2026 17:19:54 +0800
Message-ID: <cover.1792746800.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
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

From: Geliang Tang <tanggeliang@kylinos.cn>

This series adds MPTCP (Multipath TCP) support to NBD (Network Block
Device) and includes comprehensive tests.

MPTCP can aggregate bandwidth from multiple network interfaces, providing
significant performance improvements in multi-NIC scenarios. Our tests
with 4 virtual NICs (each limited to 1000 Mbit/s / 125 MB/s) show ~4x
bandwidth improvement: TCP achieves ~110 MiB/s while MPTCP achieves
~400 MiB/s for both read and write operations.

The first patch adds MPTCP socket support to the kernel NBD driver by
allowing MPTCP sockets in nbd_get_socket().

The second patch adds a comprehensive test script (mptcp_nbd.sh) that
validates NBD over both TCP and MPTCP.

Geliang Tang (2):
  nbd: allow MPTCP sockets
  selftests: mptcp: add mptcp nbd tests

 drivers/block/nbd.c                           |   4 +-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  13 +
 .../testing/selftests/net/mptcp/mptcp_nbd.sh  | 309 ++++++++++++++++++
 5 files changed, 327 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nbd.sh

-- 
2.55.0

