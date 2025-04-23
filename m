Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD7238C0A
	for <mptcp@lists.linux.dev>; Wed, 23 Apr 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401250; cv=none; b=OOjsQmrC13tCKtEEhA7mj7AyS600cef/XYRci8NrREl+qjdSkNl1yrDNiLXbHUDT34Tqpn4z/YJVQAIABVIb5jRwReD7G2KraP9CYzheApA6tZJz/KHlx8kBYQJfoyxJmXP7Ky5y7rNEQdRyNke9cQU4ln721r9jzYOCt4KNr8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401250; c=relaxed/simple;
	bh=K/xry1N7SYoFLRePnt9h/63Mf1lAIq4CEJhziYnO5g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXI6hHpGuRlfqUVwnICwL8WDJxsAL7sg1lklxDMJ4sOOUFWnvhuP2u0VoCK48VXbjYIkdNSC3FEnnEz/9H9rDIf2nGmwl+D6pCOMar9C84F8Ex9ccoXcGZcL8vFccoc93lYG0Jnwx1hGMxaWW97sRhU1Wz8LsF4cvgHa/QIeMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU6tlCoC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU6tlCoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA6AC4CEE2;
	Wed, 23 Apr 2025 09:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745401249;
	bh=K/xry1N7SYoFLRePnt9h/63Mf1lAIq4CEJhziYnO5g8=;
	h=From:To:Cc:Subject:Date:From;
	b=XU6tlCoCD7hA1Bt1xC+YWoBU/Xqp0kxnymqAYJDu8sNmeClnjeX1j6t9sI0QcsTN3
	 czMi14X/xt/OgEnK86Hlr4RzgER5ruQ2oXnjikW0j12jc7RBH2QxLpHyYoyyfPzIpX
	 7W7fgJE+gOVQfmgWWaf108558FWB6lTBV6Bl8Emq9jafv06csJ5l4Am89dJpkGLayW
	 /+kjnMt+kRvot78DlIqWALM8dqHZ72mgL1azYY65ZGHTCGK8uGzdAIp/2iDSPIgWnW
	 QCaoT5OOsm21myqAGU+MRHukfszASmtNsRbJzRNg20grCgWnqLusFzg/aIlZFTXoGc
	 BdVgmRNSsNkEg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] Add TCP_MAXSEG socket option support
Date: Wed, 23 Apr 2025 17:40:39 +0800
Message-ID: <cover.1745401025.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - add a new helper tcp_sock_set_maxseg.
 - add maxseg member of struct mptcp_sock.
 - add mptcp_setsockopt_all_subflows helper.
 - invoke mptcp_setsockopt_all_subflows under the msk socket lock.
 - drop mptcp_getsockopt_sol_tcp_maxseg, use mptcp_put_int_option
   instead.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/515

Geliang Tang (3):
  tcp: add tcp_sock_set_maxseg
  mptcp: add TCP_MAXSEG sockopt support
  selftests: mptcp: sockopt: add TCP_MAXSEG sockopt tests

 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                | 24 ++++++++++++-------
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/sockopt.c                           | 24 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.c       | 22 +++++++++++++++++
 5 files changed, 63 insertions(+), 9 deletions(-)

-- 
2.43.0

