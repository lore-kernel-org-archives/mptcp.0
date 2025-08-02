Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF7E571
	for <mptcp@lists.linux.dev>; Sat,  2 Aug 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754126404; cv=none; b=Z+HlQ8iljr+3LqcOV446QT9NgZ8ogHYoN+Layl5ObgF8drzNW1ousWUZ7z6QH9QSYsh2muShsgUPx54amtHCTfthtJNDMC7CuA+RVAnhL2BHLig8hikGYqIDG6W+W1A6hrWqy3LYRrYx9xNeQPOLoryTccXht+mC/XbgVZCOq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754126404; c=relaxed/simple;
	bh=tCi23GJJjl46aQ5xF7RoEyGByQLA9XjnVlaH8MrX2j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdAihWmRw+p1Tpf3dLHYCJCgiqZqg9Vg1AZLndQlfXcDwG9aEILskeXm0bKxZgwHokd51DRxZ/T3nIiAC38tzZX1wOaSIthRopT/yzbPsbJf08lLWrR/+8qlHf7R05LIhpSOdHYb7rzq/Tdi2Kne8unzwGyTJIthVZ6M5bXCMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTJ3zTr+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTJ3zTr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEE6C4CEEF;
	Sat,  2 Aug 2025 09:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754126403;
	bh=tCi23GJJjl46aQ5xF7RoEyGByQLA9XjnVlaH8MrX2j4=;
	h=From:To:Cc:Subject:Date:From;
	b=PTJ3zTr+eMS9Ei8dtE6+EvLIt9JRV5CpzWhqce4Zs0bnJsLmOoPHnTrl+WxnKcxKe
	 tvQS28R0RfltP0sa+U/02VvuDWZ41KUsesIi+SEwMvLK53MfWanFF+RUeIRX21Hu5P
	 +KUDehnR3dPgTl8f2mpLYSboBT1YzgeAHo4O9xF993zWLYFQLnK+QaNccoaoH9GmWJ
	 qO1IAniagrl0mF2VJsL1O93XFWFlAbsrqzqSTjLPHYOAHrD6fU5g7gszmp3vC16L9h
	 ama1IYgogY4CArF/V1SvKGc/+64JHbTh2A5yXMg2IxjLdb9Qqe7I0KKHvKizdeFYcQ
	 ycUI1aQg/zXRw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] mptcp: add more sockopts
Date: Sat,  2 Aug 2025 17:19:54 +0800
Message-ID: <cover.1754126092.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add sockopt support for IPV6_TCLASS, IP_TTL and IPV6_UNICAST_HOPS.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/568
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/296

Geliang Tang (3):
  mptcp: add IPV6_TCLASS sockopt support
  mptcp: add IP_TTL sockopt support
  mptcp: add IPV6_UNICAST_HOPS sockopt support

 net/mptcp/sockopt.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

-- 
2.48.1

