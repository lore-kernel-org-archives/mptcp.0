Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630FA2D2488
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983395; cv=none; b=RhIXjiluGIODgANnpoW7RqYcA9pjtArV4pKkj89WCmxyW2QLOJJV7ufemE1rY5XAKAjTUmDvjPYhxSxAYQfhkZPUxDTW9iP9+b6928IKLIXlwT3BAuKZKQzYYSNmgxaT6cqU3bM7nYCUDgckivaz93pR+vxd6SRKbTWm5LLRpgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983395; c=relaxed/simple;
	bh=g4oMR+jl11rKsLOhhTHRUZTisr4mz0F9TtMDGk80ifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geWQepNMd5dwDYvQOnVmQ0FvU3/WexNbnzAjHTen3fISbsiLCwvhLWNTCn1oYG0lJYjN2NLGUUHQs/imN1VLtJWLUXG4f64e2SRL7LRgz1ArGzY9scVUm7Im7Jk2P342jwJWThTFeP86fHClelo4aIiVYacjehszWeKCp3HuIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzY4EEPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzY4EEPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D301F00A3A;
	Sat, 25 Jul 2026 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784983394;
	bh=Fc7W4YnUp/0T1utT9FO9PAk4Vn0+mzs1xgVbV67hKxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FzY4EEPmHVw7a+/ohrN0zTP0EB+4ediqMSLsBB7YAkqoBWRJZxzVZ8CJ0F4sgr3Hu
	 Tx9B2PlFWo7Ef7GpuH0WHz4T5gSyTrxscM5bbrcUzgZgkWXcFRYggJBzYjrxfu0fYU
	 yr+n0ouIeYBt+fRIZNLP/G0WcB0CDcfxx4dkyn1N4f/ibRh7cw678pEwGykT0RdM+m
	 1KxnIMH2FvlODpLulbBGqLFcwxH1lBHFlOA+Fq5NE1ZRp5gORIyOirZmoucj5lQwCu
	 lcqXIMKZTGjNgY44MbwdjIrj3FenMmK+uBZTj9Lbkiacagb+bN0H+OOqo6JUH7mqSk
	 SmDGhXpgKK+Aw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 01/12] selftests: mptcp: sockopt: reseed RNG after fork
Date: Sat, 25 Jul 2026 20:42:22 +0800
Message-ID: <7122f016943603cb24c2306e4f436373b86c2299.1784981974.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784981974.git.tanggeliang@kylinos.cn>
References: <cover.1784981974.git.tanggeliang@kylinos.cn>
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

