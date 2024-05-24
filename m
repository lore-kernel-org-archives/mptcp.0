Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D201CD06
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533341; cv=none; b=gfRpOu8PafHg+8bRQte4gF4NJQ17m9jTdOQevhtXD5i8VeQEcsxLA6k6+GyDPJ0b5TldcvaaROv1Ne+71Rw6eNeButzed1DowroexlW4TWm9NAmtd7IUx1KqirbQ4D4PuFb/YU9+b6IOddIB6Jsd026Sexkc6R7MFZPSNECO/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533341; c=relaxed/simple;
	bh=xFf/9OcLSnvOLHOBUSK28gRUqyoqkz6qJxnJ+6Zac6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozERDiTB+g6IawQ9wGuAu7x47O59yDyGTBb6UssgSMB39OoDnizTj2CTfwdJhnW591tiTNA5OzFw/nVrBa7PZ2Rl1IbuQtKPndJMk+jDHcN0Jol2wxfqcuGZw1PSTJzqBPgfLTI0ohsdroD/shu6BLra+Kp9CcZlm1JqkxcgE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmFN03/k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmFN03/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8F7C2BBFC;
	Fri, 24 May 2024 06:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716533340;
	bh=xFf/9OcLSnvOLHOBUSK28gRUqyoqkz6qJxnJ+6Zac6U=;
	h=From:To:Cc:Subject:Date:From;
	b=CmFN03/kLinUblYvza/CAe7dW38VeHtOPjWveIQaSbPDKemEXeXV3ft7EpTOH5sz4
	 PDuRNbdL70pcdYxhFc8kzwPswOwBsqvdN5fBAGEfdOv7P2bPFQfiK7UfsHCW85Be1w
	 X4gqvkOaKdT4hN2IL/4+lLOvcYfRVh6fjDh26QaGi+UPc952ORJ11z3euwS9FcfzCH
	 8yJs/mHaqeVbu7/wdkgBMK2ClwRi4LmOyhlfZOm0WBjg+KmCSbBi45EVM8A+Jl19hU
	 ZXifF3FP+MM637wFpyxkvkzFXcesjQsTUxssJFx5D8mT/Fi/HTtC+XD6j79N3hZxRV
	 DKDdI2hxP7GAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/6] use helpers in lib.sh and net_helpers.sh
Date: Fri, 24 May 2024 14:48:45 +0800
Message-ID: <cover.1716533107.git.tanggeliang@kylinos.cn>
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

v4:
 - two more fixes added
 - exit when setup_ns fails in mptcp_lib_ns_init

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

Geliang Tang (6):
  selftests: net: rename ns in setup/cleanup_ns
  selftests: mptcp: rename ns to _ns in get_counter
  selftests: mptcp: use setup/cleanup_ns helpers
  selftests: mptcp: diag: trap cleanup after ns_init
  selftests: mptcp: join: print title after init_partial
  selftests: mptcp: use wait_local_port_listen helper

 tools/testing/selftests/net/lib.sh            | 33 ++++++++++-------
 tools/testing/selftests/net/mptcp/diag.sh     |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  4 +-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 37 ++++++-------------
 4 files changed, 35 insertions(+), 41 deletions(-)

-- 
2.43.0

