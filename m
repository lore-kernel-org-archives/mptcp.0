Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233DB30C161
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994950; cv=none; b=GZHMImFrDNNDGGMPOt6KoTf4GDrA28NK/DbZvGjIYyLA6m9ZaSpJrPjbWEgkamLW6/LQPf0EYOaD0qNOdCNmXaXifC55EYLvY8tXv/6ahYzYg4oII53sFGvIGBKtkzZY4UfWFifHUdo6LE+A69Xv2XC3bwAS7+hc+Fs0MUAoEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994950; c=relaxed/simple;
	bh=E4+8BQijWHmG1OGtCBIKn3pK+83OfxnFId+oAwj5cYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udE9ke2ig7SNr4ItPMgKRWUfolXiKPQ9U38jPu3KlsaM5kRrxTylD0hNSavhK1RargCIXe0ct90YX4lyAbSWV50MwXb7t2vNQtclZVvPsvvsQe9TzDjrFSzxeV7Z+6FMuozA4IPEkVOz4upQCxnoqwQ0oHgzSexgq0CAzBSpxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm5Woq5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm5Woq5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0EA1F00A3A;
	Tue, 14 Jul 2026 02:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994948;
	bh=1zWGNbmkdou13OHw9YPYspst/mpgnuk5b3F86NnzW4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nm5Woq5fXbWwj9UW0Qyg+DeqkbkbjasQaUzAs8qxjm0pOoLfwZQuYHjCtf3w+D3Cg
	 WcoHGZu+I4es0ETuQq0rMigBmjswEija79XVXdfbxTsMHOWKBhUfozacKq7VAs/co5
	 IYgLBgXc/7W9DkJeyWSuQPumA1DYHraYpRm5ScXLgSvSomP091UE3M2fqCXTL0yo1r
	 C1oWQXwTyzHQYboYlfI0PhvJGSNZ7TPnf4xmTqFQY75ChzkY6ZxIuf5V5ivprlaR+F
	 I8eodvUW568BHIgU2tbtPEgXu25I1QGlUA0KHgP5F0U4MwRy2vup0Hc3TF2H80NXU9
	 NK1+wBVziyDGw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v10 01/13] selftests: mptcp: sockopt: pass cumulative totals to do_getsockopts
Date: Tue, 14 Jul 2026 10:08:46 +0800
Message-ID: <ce699e58cca4b1d659f3b7c6e21c53f3d06c0a39.1783994494.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783994494.git.tanggeliang@kylinos.cn>
References: <cover.1783994494.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

connect_one_server() passes per-chunk ret to do_getsockopts()
instead of cumulative total and original len, causing mismatches
when the echo is fragmented. Fix by passing (total, len) to match
the semantics used in process_one_client().

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..56f2109699aa 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -627,7 +627,7 @@ static void connect_one_server(int fd, int pipefd)
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta <= total);
 
-	do_getsockopts(&s, fd, ret, ret);
+	do_getsockopts(&s, fd, total, len);
 
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
-- 
2.53.0

