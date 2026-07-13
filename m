Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93671314B9A
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913156; cv=none; b=CZhXojQK+/5v353x4RGaoUdxfDLLS94l8QDWXWzu2M0SMbETLTjnoWhR0WHF9IYr0m2aPg+f0+BqwTQIsJSceiP3tn/fZzI3Eu+awZmr4MqvF7D7JXr7L4UrEMbf/vD8sOLpoCqRSaBj6Z3H1LJ5eEcm+IKDSDu8NMEDc0OkLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913156; c=relaxed/simple;
	bh=uLZWDFpgUmEb3Q9tFYiKlW2M6/MEJLDpsrb162F+xhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpIFPzFDdNVh7rzx5aCfcl5mGsqEuSfyF4Ft0XSW9o3Ut9Rzmg3iPX13a1kC5K7xL448ZpP0T/QcB7NpbXE+jOG7+AiUzbd2Y0FU/hWuA+5XxSLAjBHS299HlP4CtFp1PoU9O7sc9QWLQnDZ2DrifKW9SdYr0OKO1/XMc0sVgPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2hXZ903; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2hXZ903"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5E31F000E9;
	Mon, 13 Jul 2026 03:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913155;
	bh=FRlD9u3xqfH6T9iE1IaEdI6IpP3KHKBxM4iClCQMrVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R2hXZ903YgjPkJObQY5yxiEJKJp1N7UvayB/2zwMupWlOh7QOZYC0P1JKcC6VH/1F
	 PFiWzNbiiuMIPEA3gNmc9RFgPaEG9HHbV8Os7LnABAb33SogQl1nGgiZMPMrS0GSoS
	 rS9WKRtnJ7ww2UTciW5jIB4wflhpTEeyO54Mqw/UyR2/T1nLZH4rZaWzRCkDzoHm3K
	 z45ReehOKBy+iEEj59ANS/iqQ89RTUElCHydIs8l09Gn/gDSGUeY2Q54d5GiYBO+MH
	 30Po0hYvpMd+k1edWhAbGzvHZxQbhyM2J6ENiD7WoH0UY2t8ZRFF2vJU4iX0tb6tNl
	 EUhXEcdKOl6+Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 04/12] selftests: mptcp: sockopt: reseed RNG after fork
Date: Mon, 13 Jul 2026 11:25:28 +0800
Message-ID: <f4e20edd4ab727bb24575dcadb71ae8efa1d3f49.1783913010.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913010.git.tanggeliang@kylinos.cn>
References: <cover.1783913010.git.tanggeliang@kylinos.cn>
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
index 9442ed5239f1..8781dfd50ba0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -129,6 +129,8 @@ struct so_state {
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+static void init_rng(void);
+
 static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
@@ -803,6 +805,8 @@ static pid_t xfork(void)
 
 	if (p < 0)
 		die_perror("fork");
+	else if (p == 0)
+		init_rng();
 
 	return p;
 }
-- 
2.53.0

