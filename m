Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A934D4C9
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083759; cv=none; b=TSj5Co5XmgTzekAhmmzpQnyHCmneH6fY+uNmpAYwCeDFwuGkO3ByqPYBtNx6hG/uqgMQlZgD7hbsSCeEPsMmxWWS+gdjx6Pk/kA8fqG3E6boc/Qr/M9Zpo4q72ZuLOb4ABMOfVXt5RZ+4ovgP0coFF/TwnvqVhrz0uU/+JC1DCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083759; c=relaxed/simple;
	bh=xMUHk4FZgLtsOetEMgyn6DWs+YyfWTqR6prXUcqlcOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B++miM55kymwO4/KmhYb6QQSA8lNhen1raQr0Utf75IAwMTtD7/Rv7jQPlvxP29qPbTeI5xhxv3Uhz7XXyDhtWKOXoWdFYCV+qiGtGUxKam93FYVVCsU8u0u+KC8vo2akRKTXkSC7TUzkZhplxsXTSUe27zTsb945y80XN+eI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN63E3ss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN63E3ss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EBF1F000E9;
	Wed, 15 Jul 2026 02:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083758;
	bh=kSWWG0CtN1LB0CeT/fpBO+dsBChKgatlHHHME8t5CBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mN63E3ssB4Ih9utHK7AnvMnighEe7dKA7evjRuhCQYbEiFSqO7WN9pFgUKSCywy5h
	 cz6+7mWgiLKsxdmnkf1ueN/IVVW/ycopiR0jQefIP8nB9BwcvgZyKubp+jIHVzEvtB
	 L+eYs64z45CNdy5eBCwYjGebNo8gtX4YlDTxwY8NlEa5a9qaHjDEfv94fMhQQUBBPO
	 SAYH6kYwuRP3he2aIl+h2TRGHkFId0r9+ZdDgTAftAtPNAMr7ElDodlAUka7b4o7B7
	 hC81rhL0y8WYbFBbE+RkOc00Jd/yEbqojhYSfg6w/2YUO2zRExN5rOHYFGDm13b/ij
	 JyojW6uI6+lSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 02/11] selftests: mptcp: sockopt: use exact length in connect_one_server
Date: Wed, 15 Jul 2026 10:48:48 +0800
Message-ID: <455eaeb56a92ec67cd54eacd4730f9a4ff5ba54a.1784082850.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784082850.git.tanggeliang@kylinos.cn>
References: <cover.1784082850.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the exact remaining length ('len - total') when reading the echoed data
from the socket, instead of the full buffer size.

This silences a false positive -Wstringop-overflow warning from GCC, as the
compiler can now prove that the destination buffer is large enough for the
specified read size.

connect_one_server() passes per-chunk 'ret' to do_getsockopts() instead of
cumulative 'total', causing mismatches when the echo is fragmented. Fix by
passing 'total' to match the semantics used in process_one_client().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 05afe8dd1381..9588a25ac6b2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -609,7 +609,7 @@ static void connect_one_server(int fd, int pipefd)
 
 	total = 0;
 	do {
-		ret = read(fd, buf2 + total, sizeof(buf2) - total);
+		ret = read(fd, buf2 + total, len - total);
 		if (ret < 0)
 			die_perror("read");
 		if (ret == 0) {
@@ -629,7 +629,7 @@ static void connect_one_server(int fd, int pipefd)
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta <= total);
 
-	do_getsockopts(&s, fd, ret, ret);
+	do_getsockopts(&s, fd, total, total);
 
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
-- 
2.53.0

