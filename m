Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B243F0A7
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060965; cv=none; b=c2CzvlXNVdY0U/Y2ABVdZrBnR0RPzRtcqC9NJvcaGx8qUxog7viqeLxoz88qpznu+tLvA4n0n+/3vXEua6QuMYtsVX4BG1fO6kh/rGT9WQHSpOON1oObkk1aFfGpYkt/sRtURHRuAHzzgZpGjiE19/W19up/Yjthhu4J0BfRX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060965; c=relaxed/simple;
	bh=xMuNVGGJxz4qHX0nhzZfiWXDTnZUzr3l7igokVitEpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rz/WvdO4ziqtoZBsLctSnziviQL0LmJFONSC3q2yHpSxQnOT5gW5CWOlVYzugCz7njCaeUgYm4WT4JPP8WSIdoDQbCtYm5gFDEoHxmdf/llhLKUfOQvfcr7ySVTUe/ooBwVMNg9MI9aRnLd7nVhvc5ggohsJk7U8gOl/XG78dUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayBmY8vg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayBmY8vg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91AC1F000C4;
	Thu, 15 Oct 2026 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060963;
	bh=UmiRyVhzHJ49oOIRixuRDncBN9p2BBR5NHbGWKHlk7U=;
	h=From:To:Cc:Subject:Date;
	b=ayBmY8vgb4m6AkiNJN85V+3HrnssWvHhNSBdUNjba9ZecySNY2rXkeQcutsafkRz4
	 AmzrkGXRxb06kvEASQ1v33QdzMc3qc1Mokty6fz9gTIIC6DnuLPB5D2++JmpyoH9oY
	 +bPk7mbyaDbEWH5FofeSmdiKMAbPjsg6CRivxl5KdsA6D3/TUPEgxuy9UymNN26jJN
	 knJnx8qqQXU4Z9DVEkXePDlwvn+Qjq8+qOUgOD3R1uHqrB47qen5Gm04Yc+Qq3xNAd
	 +QveADrAFfK9n90V9r2X8UVuXRMvoHd+ZhWfpomNygEV8EL7C19rzQKvTo/v2KO759
	 6IHD/qZF1OqRw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] add distinct lockdep class for MPTCP sockets
Date: Thu, 15 Oct 2026 18:42:35 +0800
Message-ID: <cover.1792060837.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_nvme.sh selftest reports lockdep "possible recursive locking"
warnings when running NVMe over MPTCP. The issue occurs because MPTCP
sockets and their subflows share the same k-sk_lock-AF_INET lockdep class,
causing lockdep to flag false warnings in paths that hold the MPTCP socket
lock and then lock a subflow (setsockopt, connect, bind, worker send-ack).

This series fixes the issue by giving MPTCP sockets their own distinct
lockdep class (sk_lock-AF_INET-MPTCP for IPv4, sk_lock-AF_INET6-MPTCP for
IPv6), similar to how nvme-tcp handles it. This approach is more efficient
than reclassifying each subflow individually, properly supports IPv6, and
follows existing kernel patterns.

A KUnit test is included to verify the fix works correctly.

Geliang Tang (2):
  mptcp: give MPTCP sockets a distinct lockdep class
  mptcp: kunit: add sockopt test for subflow socket locking

 net/mptcp/Makefile       |  4 +++-
 net/mptcp/protocol.c     | 37 +++++++++++++++++++++++++++++++++++++
 net/mptcp/sockopt_test.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/sockopt_test.c

-- 
2.55.0

