Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE328323D
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946876; cv=none; b=O2KMlMO/BHR3ElZ5mSdqMxmc7D/hwugva+XBLipjyW9XAeKQt2dck1vESiEtgY2aw5Zw23COTutpDAy6hzcu9JnWsC68Amun2y5ksTKfvr0TX/iYfar5HNogsLQK9OW06Fau/o50T5LiwakLkpSIUnr5sucE6ujtPWm5wvwQZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946876; c=relaxed/simple;
	bh=RUjHrt/uciwuXOwDYpC9VxjofL1WBAGMH1n8eqnvUXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQM9tnjnEQw3F7ElBHpOo85n8hrnupiJlHo9aP3DCljsudpth120Gct4wFXgtO1m8KDglfpUDdlzcYT4cvFQbgB+brLS5rxm1RIqWX7LSXJ+2gYzoBUXy/NyOu5+0gatCW8asCl+B3rI6Ozi6bWjVZTvkOEhPuT++0SwseJRrVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5RHdhs4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5RHdhs4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58547C4CEEF;
	Thu, 31 Jul 2025 07:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753946876;
	bh=RUjHrt/uciwuXOwDYpC9VxjofL1WBAGMH1n8eqnvUXI=;
	h=From:To:Cc:Subject:Date:From;
	b=K5RHdhs4o7SrYWIAiuaj2+rsmn/kR0lAO4F4bxqZqO6HTHxa4zn7JbgJRZriQFEkJ
	 50qQJjkCwlePw24tEzluOGIbNP6Gsf+S6J5zulw6+tlSTH1qDsCQcuAGMQ4SR7bDXM
	 9sxAP5YRJbpfYYEQt/gXMsTZDn1nggyeXcr4Zqpr5wyxHQxuT9iBxrxDBlmHrK0r84
	 QQawFSMdNwe4pL4S1GHHTqlzCyuqmqn7ByfhomcZ9Uq4xPxN/J8SNFeQFvLqJ1IHoo
	 f6dfNlEdO7bfHNVbiPEL4FZaU4u361SCTufAEOwA8N6iisZBsD5pKC8eLlq9dDAIkI
	 v99kuMYhbcfrg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] mptcp: TCP_MD5SIG support
Date: Thu, 31 Jul 2025 15:27:46 +0800
Message-ID: <cover.1753946671.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - trigger fallback to TCP.
 - check CONFIG_TCP_MD5SIG.
 - update MD5 comment.
 - drop selftests, packetdrill tests will be added later.

This series introduces support for TCP_MD5SIG socket options in MPTCP along
with code improvements:

Patch 1: Refactors TCP_MAXSEG getsockopt handling to improve code
consistency
Patch 2: Adds setsockopt support for TCP_MD5SIG/TCP_MD5SIG_EXT (first
subflow only)

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/575

Geliang Tang (2):
  mptcp: Handle TCP_MAXSEG getsockopt in common case
  mptcp: setsockopt support for TCP_MD5SIG

 net/mptcp/sockopt.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.48.1

