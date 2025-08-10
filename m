Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B073335C7
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838139; cv=none; b=uxjvXp+lQq+vTmcte0JI+LE2B/bxBIDYib0QvtWHIKdA51Xc0nwjHQ6O4M82sBQvigptgIFlqdBjKS62CoErsqZHvL0mV9GNugutW/lmXypw65Ny+qDOBhrvP8PDh/Ba3ps3hFGOqb4PGrFaQzppk/RDSk4f5Ad8RGl2qeFCOfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838139; c=relaxed/simple;
	bh=DAggvG5/nXXdfQ2N/auw/diBRNldMbE555MHYP5sjwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ell2fydG2bGCe0olNrHOT0Ubmg65hok6MJj6MvGkj6etAV6Od2NJvnm8CApOzGxVGZ7IXb4QWsyg/JAL4AJAtZ5mmQP1vvT+xVhWiNlSL5rSvTCSllmr8As84KeNklc9rR8HPDLS5avzFsTuM9FFl3+qPSlXFKZwh4brCDINvHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1dJnPh3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1dJnPh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BB7C4CEEB;
	Sun, 10 Aug 2025 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754838136;
	bh=DAggvG5/nXXdfQ2N/auw/diBRNldMbE555MHYP5sjwA=;
	h=From:To:Cc:Subject:Date:From;
	b=n1dJnPh3SnwoWgtHGU+suQsKBMn5HXodvMohRdO35mqY51RsgJIS7RTMsetPiY20E
	 kOI0PmOGD+6lSGteVTOvfgyYnJARETHIflzWH+eY8SPwDn1SJIjrApHhU5uB7kqUyU
	 iZJaG4oOpQVpDDzcucRiW7RIOTGe0ROWLQgxW7E9G8psQa8kGn6HX8p2gUiTuBZ9tQ
	 cojErGiZ2hvCVAdgPKXuAX2TGr7jBhe0CpY9FMsNDsmcWy4442TIzlKh40kHnWhqZr
	 2pwLbqgDWr8UgLLWNgPcu9yKiT3awz2lrtFg5fsYMMT20gpc+TG+7IfTA4FHjInr4P
	 L51wBJm+TTk3Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: sockopt: set TCP_INQ on accepted sockets"
Date: Sun, 10 Aug 2025 23:01:30 +0800
Message-ID: <8bd99f42654b94d0a5f1ef22d3ed7cb077f50368.1754837876.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop do_setsockopts_accept.

Depends on: selftests: consolidate TCP_INQ testing into sockopt, v2
Based-on: <cover.1754664106.git.tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index c12c5e0e6766..063ecdafb336 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -979,12 +979,6 @@ static void do_setsockopt_inq(int fd)
 		die_perror("setsockopt(TCP_INQ)");
 }
 
-static void do_setsockopts_accept(int fd)
-{
-	if (inq)
-		do_setsockopt_inq(fd);
-}
-
 static int xaccept(int s)
 {
 	int fd = accept(s, NULL, 0);
@@ -992,7 +986,8 @@ static int xaccept(int s)
 	if (fd < 0)
 		die_perror("accept");
 
-	do_setsockopts_accept(fd);
+	if (inq)
+		do_setsockopt_inq(fd);
 
 	return fd;
 }
-- 
2.48.1

