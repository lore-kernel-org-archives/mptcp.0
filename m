Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DC26AE8
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520316; cv=none; b=CxfESQfMgLD3dBDskhA2258e1tIGNf12E2L7vks8TePrl0vUji0LquDoXEaL7pAK05H3OJbCdWBl2xXgmREbav0abOfWiVfTDTtaVM8s4jayvn8Ln8DdqgtCqdvXfPJOPTUg93xQbO0hEq1WLaVmxlrulnSeEeE3hhjlez88nGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520316; c=relaxed/simple;
	bh=EShP/t7qio1zDkaQcH1itMbJhsWxbAhVIc7XYqGGVpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3Ng+wz8IpRb3Dzr5yADsFsVtfTjMI3hPwtFTQQcEp1wdscTvf2jSAfGpF1nqBhJ2Fg7ty+rTPZtHimPGfzkn58qQNky6CqXy7+8gg4MUjsQJrUATePvsdZVYcpN/IC3+g3PzQZ8aEnvSZUXjZw/1ZZclmHddDAnfslEndSsHcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuCyw35m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuCyw35m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9311BC2BD10;
	Fri, 24 May 2024 03:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520315;
	bh=EShP/t7qio1zDkaQcH1itMbJhsWxbAhVIc7XYqGGVpY=;
	h=From:To:Cc:Subject:Date:From;
	b=uuCyw35mY0QC4MviuGtcfrRYJ8FW0XKSA5NXgJ9MeEcds0xFJsetMJq0RPouKSpp/
	 ZL4e8kF5EhBfc8qdbb7C0Cwl1i3QeudUtPXXLp5LxTY5jH7ypd1x8AhnfaFtu3MFIe
	 n1NnQCNU4wuikZFOynbd3SG9+Ui70mzabz78cVc1mRhSZOBbq3RbGhLlhgZJ720jxk
	 gWVxbMcifTXMV8beb14BKBfjz2hVGLuKqb3JS1fzRdZ/GzVYT7B4eJRpj5uCBx7kSo
	 Zy4cIcF49qyIwcjKf778l4ZlhisY4lZJDQeAjmwXNqhThSqADLK/K5Q/4xggs3t+cl
	 YfJferMHYLG9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/4] use helpers in lib.sh and net_helpers.sh
Date: Fri, 24 May 2024 11:11:45 +0800
Message-ID: <cover.1716519897.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This set uses the public helpers defined in net selftests to replace
helpers in mptcp_lib.sh.

v3:
 - address Matt's comments in v2 (thanks, it's very useful.)
 - don't rename ns in diag.sh, but in lib.sh
 - ns in get_counter needs to be renamed too
 - add a ns_name valid check in setup_ns
 - drop $NS_LIST in mptcp_lib_ns_init
 - don't drop mptcp_lib_ns_init, use cleanup_ns in it
 - don't use cleanup_all_ns, still use mptcp_lib_ns_init

v2:
 - only patch 3 updated, mptcp_join.sh, move cleanup_all_ns from
   cleanup_partial to cleanup, setup_ns will delete existing
   namespaces automatically.
 - update commit logs.

Geliang Tang (4):
  selftests: net: rename ns in setup/cleanup_ns
  selftests: mptcp: rename ns to _ns in get_counter
  selftests: mptcp: use setup/cleanup_ns helpers
  selftests: mptcp: use wait_local_port_listen helper

 tools/testing/selftests/net/lib.sh            | 33 +++++++++++-------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 34 +++++--------------
 2 files changed, 29 insertions(+), 38 deletions(-)

-- 
2.43.0

