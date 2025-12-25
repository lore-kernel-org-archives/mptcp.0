Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A12F4A14
	for <mptcp@lists.linux.dev>; Thu, 25 Dec 2025 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766653234; cv=none; b=iSAsJ9c3Z3t+ATJ7tIaivUSxobHkDi3fB9PWcK9uy46/eSN6TzH+Kz4VXlDhV8PiklhPyeRJoWI33bRHaQfOoLmETQG3oaI28CYs+46xWNymJ/DqDyYwX7phu53bAZ1yswaLOzliW7lKpq9b4RbN0hAH3uQZp5M8ThEwUbbEKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766653234; c=relaxed/simple;
	bh=ZqoA0lPosdXFtRZkcoezkmoBDld9Cm4tvwpRnNUpEcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oS0zxdfMIya9lvXrvxyf0rZ2R4/dGYCS8GHSZbSP6Tb5B1GRpYQVpzCA+QLIITirl2RRaX26aI2aqfoHMfLsMS47Vmtxx8Ocz39d2ANyIy2bb8W9kakw3SprhHTFy1aBUItZ+CfcJfRbDHNW3bu/8oKj5+8gwW9j5655pMsevfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYBCj41l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYBCj41l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148DCC4CEF1;
	Thu, 25 Dec 2025 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766653234;
	bh=ZqoA0lPosdXFtRZkcoezkmoBDld9Cm4tvwpRnNUpEcY=;
	h=From:To:Cc:Subject:Date:From;
	b=AYBCj41l2jjRPZRBA/DOfgXIZqEWWrbQTj3pRSKV63k1EBi5THpANEsyHqhTaQLqS
	 kRYKpyqyRs+3excqwpcxIVnJhIgYnhGeYyPQrfZNfANLAnsGvAEHB91blZgcQaT7Yt
	 sS2pWa3vzuQoxRj+kGMq3uLde1aXkxumFNz5w3YC9YDm6YJPT+iamBs+BywQuWpJdx
	 WF/K153bgRhK7SlwvLWGuRHuvQHlCSdZSzuStzSLLo5LoHU25ZkHDIFzxSnmlHKTiJ
	 PeaimO+9VJj7uXhCqYd7FzMBM27xkG1qT+NSUlB/4sJBuowAl/vS+E4/CrHpVw5PKq
	 s4auAefMICx4Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] implement psock_update_sk_prot
Date: Thu, 25 Dec 2025 16:59:55 +0800
Message-ID: <cover.1766653030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement psock_update_sk_prot, for basic MPTCP BPF SOCKMAP support.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521

Geliang Tang (3):
  mptcp: implement psock_update_sk_prot
  mptcp: allow overridden write_space to be invoked
  selftests/bpf: Update sockmap tests for MPTCP

 net/mptcp/protocol.c                          | 96 +++++++++++++++++++
 net/mptcp/protocol.h                          |  2 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  4 +-
 3 files changed, 99 insertions(+), 3 deletions(-)

-- 
2.51.0

