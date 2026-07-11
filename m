Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7D255F2C
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741471; cv=none; b=KbSEg5ES4wUyRbMBihmGEaXxpOso0OK8ZFDgDg97RbHi02iutUjLkHJQ1zdWPp+KRK6EZzVHCguUcYwHYZyatEEmgqt+2cfBzFa91+cv6Gv6YNNO9CdrPC7UyfFLAnjkqvtnDbfq+T7BLjpouupt4z3XKEQV57mSM7W3zi2A4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741471; c=relaxed/simple;
	bh=8cTcpANFISVzd/UkTlSvjt6Sffb3tRIft7Hf/f0QSgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDNrRaSEEsM6kHGgPjhwzjzFEA9Ysxi7RxKbSNGIgeqNn9rBrtqUvkIKaF2OESsLUDN93+KPPn4KyB3bZTORRI9je12gwE1btY+WdmMMrUU6T72OTep1BzVBjUVSUR0LT/sz0wcoQkHRkKEaILOtetcV2nwwbYEBi91d3zgdPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6CVxEEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6CVxEEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9331F00A3A;
	Sat, 11 Jul 2026 03:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741470;
	bh=V2En2bUH7kGZxRN5hLT4yY6yPs5AIwn4jjpk0vIxQeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6CVxEEu2kZ2T7cxUd33YNlNErqm8e8MOWDnJVRoYE0PzYg1v9CmRVs95EC08pnuz
	 UlLN1DLl/1cOzn6YMlHjNoqHxZI0bFLyhR21AyFFieecREJ5UP6J6OZ5colKSHXxEE
	 GqLyM9uKSqh8TjRl/uZrIVswXvxOtLhsV6L/AmAoOKbGhqbps1ISwPaqrYJ7IUuMs+
	 xn1+BKRB4bFEpWmqxacAWdtJjnLqDNP6hmh5+TpKgapROAsmPY+g+1GFJQYFj3NoDs
	 A5fGwNAGshycKKuoRz0j8GlMaOjGSk4Qc0YyxHdSgI6dDXgmwCXbpnkZ6h8qdYkzz6
	 d5Ho2D91JMEYw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 01/14] selftests: mptcp: sockopt: reseed RNG after fork
Date: Sat, 11 Jul 2026 11:43:29 +0800
Message-ID: <0b0e71be5930e970b6ec8693854ad79cfd620edf.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

xfork() leaves the child sharing its parent's srand() state, so server
and client processes drive rand() off the same seed. After the recent
consolidation of mptcp_inq.c into mptcp_sockopt.c, mptcp_inq's
per-fork reseed was lost. Restore it: have the child call init_rng()
again so each fork gets an independent seed from /dev/urandom.

This mirrors what the standalone mptcp_inq binary used to do, and
keeps buffer-filling and huge-transfer sizes uncorrelated across the
two processes.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..05afe8dd1381 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -128,6 +128,8 @@ struct so_state {
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+static void init_rng(void);
+
 static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
@@ -799,6 +801,8 @@ static pid_t xfork(void)
 
 	if (p < 0)
 		die_perror("fork");
+	else if (p == 0)
+		init_rng();
 
 	return p;
 }
-- 
2.53.0

