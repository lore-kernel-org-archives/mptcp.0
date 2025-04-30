Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF052F5B
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 05:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992192; cv=none; b=W0vqYqS5yKfNOQNv8Hfa1vaLAQugsyh9xZN3FhpX4UBbGGhiYhMjF9iPb4/oTuOzOZWZAKZH9uSWV2NXoHSin7wzrj2W68Y2GTz4143xrwsLCqGhWONLSgRDaLM+H0E1j5g6BN+uO0WEiU8KS/OT4xTG9hFe2/vAHTQX3mTYqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992192; c=relaxed/simple;
	bh=ZUwIViCdab2KCbflIdSjQBP7qKxM+kKegnnEz9VyX0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5iuQJAPeSuoasCqcgilJEf6ELe9VJc0SmEJFCIj/hKdKcPaC2j9BPN2b0M5vTP20x4Vw8G70ozu4uQdyiZGgGYF4qmfw1vWRsMQI37EzqKi9VtDpETgXRS32D49U0LQKKGWOn38KmJbh5z8JuAnQbfuMs6lfLMH+82dAA97dfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/8RfyKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/8RfyKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FD8C4CEE9;
	Wed, 30 Apr 2025 05:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745992191;
	bh=ZUwIViCdab2KCbflIdSjQBP7qKxM+kKegnnEz9VyX0w=;
	h=From:To:Cc:Subject:Date:From;
	b=H/8RfyKCfOi6hasECVS1wpx4KKmVzbdpa28/8XHdyuyp3TMaUAibzxYPM7hOtax+5
	 AxsTn+JydapTolxq6k9/UzQTWiwq3gnJEN1x0YZuQkvaCDBnsA2Nau2eDPHhxomCtC
	 VTRCjm2SEd3s8u+jRkZBCOTkQ3OX89woo30NevvbKtihl9KfKQr6ytzb/hrcjZtjhg
	 XREHYcFoLea4enrG6i+tnoNvIOPsXWwHWx7gtobsI2YnGIsgr5HEd4rkMaAD+gCTUk
	 f/XbiK3FaZyG4en8xIfyLhhnntFhtR5M6LLTjP2mgxu8wZpAK4nbS/4h3G61EF8q2T
	 4jTtsojuI6qBg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v3 0/2] Add TCP_MAXSEG socket option support
Date: Wed, 30 Apr 2025 13:49:43 +0800
Message-ID: <cover.1745991978.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
 - drop "EXPORT_SYMBOL(tcp_sock_set_maxseg)" as Matt suggested.
 - use mptcp_getsockopt_first_sf_only instead of mptcp_put_int_option.
 - drop selftest
 - add a packetdrill test.

v2:
 - add a new helper tcp_sock_set_maxseg.
 - add maxseg member of struct mptcp_sock.
 - add mptcp_setsockopt_all_subflows helper.
 - invoke mptcp_setsockopt_all_subflows under the msk socket lock.
 - drop mptcp_getsockopt_sol_tcp_maxseg, use mptcp_put_int_option
   instead.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/515

Geliang Tang (2):
  tcp: add tcp_sock_set_maxseg
  mptcp: add TCP_MAXSEG sockopt support

 include/linux/tcp.h  |  1 +
 net/ipv4/tcp.c       | 23 ++++++++++++++---------
 net/mptcp/protocol.h |  1 +
 net/mptcp/sockopt.c  | 25 +++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 9 deletions(-)

-- 
2.43.0

