Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67729993E
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024123; cv=none; b=FDntMbBwVx6akQmuwX1oT7lOyl8NsuJdsLUhS04yHyR8/KEEGValJg6dicCyMM0G3A0tk96+W3Vm9XrVvGaEaMlUbeRsD9HwFeNPNY7ST/3+Kw2YGiYzpWxOjbDVccotth9JXtF1NkpX7aRDjFWniDG+dB68KjEqybggHVJ6lfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024123; c=relaxed/simple;
	bh=VY+MRoTg9P8ojdpM1psujOCPtyQbDFhRhxShUjpb1aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmmdKFOOyD0+XndPF3LBQPObEVtwXcExHQI5nKSaawPnDZxKv9SEI5FIOdBzN53xdngKp4RT4LkaFXuOMAbxtv7yiNsKgm5kK8XuhE/SIlWCYMDwIIzvRBHhNHUa0UiN8vZ5zWaxM0acQr1hQTWCtRU4vpOA0gj6ED+ts+iTzjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/Q1IgjF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/Q1IgjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A17C116C6;
	Mon,  2 Feb 2026 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770024123;
	bh=VY+MRoTg9P8ojdpM1psujOCPtyQbDFhRhxShUjpb1aQ=;
	h=From:To:Cc:Subject:Date:From;
	b=I/Q1IgjF5vXzyVSYfuyd3panGIWwQxrARK1ApWJa4H1BHdWKunU5nsDYY+Sgmd3VY
	 97qkBa0curW3w9zuYM7AQzscPNaq/J5v8dGxdZxNVr8gcYOYKmQlar0TEJj3hyXDxP
	 4C3+eJEWngcKvkKYVvR7tzbwHmspkxmAEAiL+LA0h1lMa7xiWtXs8hjDEa9wSWhT3Y
	 jfhsitIwgRvD5BtPvjpCdKxoyOG4pbWe5lyMYnk8mjZ3cSFTiFn1x1PQxvAx0Oo0s7
	 nVoFxI+EbqP6CAjlCMigzKvQOPekWvDX8WcWKdEh6m3jSoK4f0UTX35XM3HQ5Ynykh
	 aISRRw0FhPhvA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] implement .splice_eof
Date: Mon,  2 Feb 2026 17:21:48 +0800
Message-ID: <cover.1770023932.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This set implements .splice_eof for MPTCP and tests it.

Geliang Tang (3):
  tcp: export do_tcp_splice_eof
  mptcp: implement .splice_eof
  selftests: mptcp: connect: trigger splice_eof

 include/net/tcp.h                                |  1 +
 net/ipv4/tcp.c                                   |  8 ++++++--
 net/mptcp/protocol.c                             | 16 ++++++++++++++++
 .../testing/selftests/net/mptcp/mptcp_connect.c  |  2 +-
 4 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.51.0

