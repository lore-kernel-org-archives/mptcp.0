Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D1634D4C9
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083757; cv=none; b=IkpsDe5UM/RXrGuAwqN4xaxQqixMocgj89OgGtua/9xR8Iz/0pn6EFT7qH51l8Gybb9ewMwEuYuRsdum/02XLxjigZcXtQcfA8XWOlU5/kOL/lxQ4B7govu9mA6XythCmAJ1ZCMk6QqTDUAKkTgusmsJ45svlCxEAbvkgm8+ImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083757; c=relaxed/simple;
	bh=g4oMR+jl11rKsLOhhTHRUZTisr4mz0F9TtMDGk80ifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l793AbKJGIqVzf3hXNJUR7V2JNz08Xp4ER2R1ddQxjWDHe5bDFQWlWuMt4fh9H6ko8ionn30eJkB/fVgppJbRjz38iyrJAxqU7/mSAOs9OssgvX+SBH/ziDLwId+IbRUwVcaM75hVwVWA+ch6f7D+75hMmvt3h0+eMpOnGKNqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEHxg3QT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEHxg3QT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD511F00A3A;
	Wed, 15 Jul 2026 02:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083756;
	bh=Fc7W4YnUp/0T1utT9FO9PAk4Vn0+mzs1xgVbV67hKxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oEHxg3QTIE7lCwCaEGVUhRaZXjTb0spAeiiC0tYvnDbvP5BlMnhvLskvQcQqk+AWp
	 +D67WCodhzplzBuh9/vljGuJu/QZmCB2Vt+BOGrC7lutiF1m1cHlsYUQOVyDz0poFL
	 zD61DN7YoffDqDRb1YQ9QpBQfiN9YFyyA6OHZ0huLqrIsYL/s5SzKJGtlVApVPJcuB
	 HQszjnneDvS/22ksuEARhCwbswWdvzxBQqlbVx1N2spgSA1by+RuY1Tg9Q76HqzMJf
	 rnSOJqQd4TA4pYL2qr5lvvMnZjCnNe68nFAdR8znNNBkl06uSl448jQiIdRchV4RxA
	 TPv+t1CkEZtWA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 01/11] selftests: mptcp: sockopt: reseed RNG after fork
Date: Wed, 15 Jul 2026 10:48:47 +0800
Message-ID: <bc062348d67cf2646bd09b6ed0a2b29fd8d43689.1784082850.git.tanggeliang@kylinos.cn>
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

xfork() does not reseed the RNG in the child, so server and client
processes use the same rand() sequence. Restore the per-fork reseed
from mptcp_inq.c by calling init_rng() in the child, ensuring
independent random values for buffer contents and transfer sizes.

These codes are from mptcp_inq.c.

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

