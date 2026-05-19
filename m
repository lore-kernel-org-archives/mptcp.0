Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4F495526
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185635; cv=none; b=p2LkCTl0XwCXY4zD12CCmm+AUjKJOC9iejs09NRvmOrA+WeNDWElfh8MJss3yF5NYQ9bwgNfF6uHHRbBaRXc2IEZGOEpF1jZnGCx+XdVHRuF4UJ6XCW7Hgj/6LdaHgXwWvUW1CvgidE5CXAN9sLnJbt2TktKm7Cxrk1YqKZcDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185635; c=relaxed/simple;
	bh=x/iDSCseEEC+8cf/rFs4/Ivs7dHgLu23+X9ga8fFU10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hT6uTNbYVZ44kjCO2nvb1PzenEgWUf7Bq22ltSv1p5o8LHwfloHcLb6KUBkZYeettSMLj5nEa4RYoWJVsVrpDT0vhH9Iz96V6n6wVD8mVaHVEoz8hiyK5dwvqTthq+Hnj9Mg3KRELfs9MRdt6Ki5OL2k3YkBX6CFDvVGlwF+AHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu4TJo4+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu4TJo4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8687C2BCB3;
	Tue, 19 May 2026 10:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779185635;
	bh=x/iDSCseEEC+8cf/rFs4/Ivs7dHgLu23+X9ga8fFU10=;
	h=From:To:Cc:Subject:Date:From;
	b=Pu4TJo4+kPejoHRh/9qj9uObC29xQzR0/a8GaJqYv+Ay1y3AX9+UfkD0N8YppcxrY
	 Wh54VEBlNLBT7uwxB58wuj1CLw7vNPvw5I8fIgGapYO90nzCQR9ZIXqFn3HxwxErLA
	 F8rdxfh/+MJRGw7kU9oA5/5s0mqDHV1O7An4vqeKSYbdGuJMvC7qWTfVmLpSPnGcfl
	 idI/I2OLueZGweQY6Co/FOrccVje1HBFuDvv2vWdfCWoP6/73QINvDafs08pxd1+xr
	 RyuTJpTkz806mFTsD6RPoWCRaH8rhqiuiUVj0RheYpJ71P3udPf1V1LF/KVjUe0YTB
	 B8lZylMD27rtA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net] selftests: mptcp: sockopt: set EXIT trap earlier
Date: Tue, 19 May 2026 18:13:48 +0800
Message-ID: <b681d1061e68faeb0d4fd68c23c09852d90385da.1779185611.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Set the EXIT trap for cleanup immediately after creating temporary file
variables, before init and make_file, to ensure cleanup runs on any
failure or interruption during the early setup phase.

Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ab8bce06b262..e850a87429b6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -355,10 +355,10 @@ sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
 cout=$(mktemp)
+trap cleanup EXIT
 init
 make_file "$cin" "client" 1
 make_file "$sin" "server" 1
-trap cleanup EXIT
 mptcp_lib_subtests_last_ts_reset
 
 run_tests $ns1 $ns2 10.0.1.1
-- 
2.53.0

