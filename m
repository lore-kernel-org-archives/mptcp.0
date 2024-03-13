Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92047C13D
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299591; cv=none; b=PsLWcSacAEPtjyB2DSbhrd7bQdps2GLkpGUHv9dzf6vZwFocEkmWtuSrp5bri6tfo9j4qtUovE6bLI5hmpyrgP0GWXT7Y7LVWqwDvlS6LHg9E5p06UDfRX8KzEdlRyWjbf42Dk4C/Wu02HUghUIAnIF/jxIRZsAW8G8kGPSPDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299591; c=relaxed/simple;
	bh=L1mTQoXnGqJDmbiN2KGNUw0UDBsg40/lCVXGakhhPu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KrGYJsg1OUfn4MttE+qZ2DgTgNyMctbKg7vBXBq31Nge6f/Csp1rv0PGwDPJzwhyn8kiTDcVWAc9mFFAoaA4GvZP/hfWttb2z6eAbYMkt3aFw1iWHN5z+EFdggngYZ8dp9G1jyc8FyR/8ee7FhpEeBCe6jfmYRuvWnEAk1KOz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7N3wrmC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7N3wrmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B072C433F1;
	Wed, 13 Mar 2024 03:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710299591;
	bh=L1mTQoXnGqJDmbiN2KGNUw0UDBsg40/lCVXGakhhPu0=;
	h=From:To:Cc:Subject:Date:From;
	b=N7N3wrmCa0XKctV3+NBTLPH96+4hRAxSuK+ud/ia213VzU07WB+z1vA2yCbMTuT+Q
	 7uLshwSX7kYqahbZne35YP20okJOvcreWtb3/xloNMD6z2PlUd+y9JzQCmCRei/atF
	 aWrcMIyziyOZzu5SlQCRVX/4A6pBIQj5C99Plpn4FYasRWg0ixxZ38GzqBDhNq6yvP
	 M+QhEwltVzLMMsgLfR40NWs0ivEf40BqPGr+gbqLtol/DZyZOxdHWKqolFo8KL7qsU
	 Qumli0/6NJQf3rkNdXmKK1rCdQ6vr0pKxFWqik1O55qFURpv+jfxYHApVbcOcdlq8j
	 xbJhrGqTelD/Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] two tc related patches
Date: Wed, 13 Mar 2024 11:13:03 +0800
Message-Id: <cover.1710299501.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two tc related patches.

Geliang Tang (2):
  selftests: mptcp: add tc check for check_tools
  selftests: mptcp: add ms units for tc-netem delay

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 8 ++++----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 6 ++++++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 6 +++---
 4 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.40.1

