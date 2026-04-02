Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F8263F5E
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116100; cv=none; b=asCuu/DhSmUCsssvySSAwbNz7MSSi8N3sLNk7747gfkpgUqJXCm3AX1h21PJiEhjuPljRXnPtj2p+cZKK0fJ0NBluTHIkhwRYqBFxfjQ4uOmcY+5meV6DyFspcm9W9cYPlonr8/u7FltmpD91PDKhK19r5buo5T4b+5izbWGx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116100; c=relaxed/simple;
	bh=EvfTd40wLYuAuTYtIwMKsXtjNvkZfSXFg941Fz/UDf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnUYgDCuUrR/YFN94KNwR+bF7CH7GA9CKB8cS6j3toWAOG2uPWgammWcnA3p//Nj9XpL/4fM0rZY1wb9dxv5bUp/Mo0PE+RFwTOAEX4yT2sQxUGX96fMJRtAM2lx56AtCoubJx5UZK1QXrZW5eR8eY2NQg0XL0wgMaAlsOM6Zx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+GLVb68; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+GLVb68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB33C19423;
	Thu,  2 Apr 2026 07:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116099;
	bh=EvfTd40wLYuAuTYtIwMKsXtjNvkZfSXFg941Fz/UDf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+GLVb68mYPU5EOB5FpTTOh8rEezBo7z0FYzWSwjEElnR0aJYHHloU3W2xj4Ls3df
	 fw4pfOsCtGgVsD4/Pjm9uT9b3mALQT2ubdb2jfCJbAyuGN6X7vTAXDSw1GcbBaE44k
	 WP40cOEkJBMMjlAartuZ8SQg+QZ05D9LpZUQ+w8cPIn1zfAFva8nGYZIaBRR3vEqcy
	 L8WRQKCmaeOJK2P51S5MSn0fIWrofRAEO/K2bLHNW6wEIouV448pwR5smm97oiqKUR
	 gdpwYbQdq8jFy/imnW+HN6S2k3aZmAjHVN5VCanGhfeq81+t8UowAO0Js3Y3v0SKGZ
	 OLsV054hQnwcQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 12/15] selftests: tls: increase nonblocking data size for mptcp
Date: Thu,  2 Apr 2026 15:47:47 +0800
Message-ID: <46ad3cae861014200cefd0826138416c10a433fd.1775115102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775115102.git.tanggeliang@kylinos.cn>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Increase the data size in nonblocking tests to accommodate MPTCP's
multi-subflow behavior and ensure sufficient data for testing,
avoiding the following errors:

 #  RUN           tls.12_aria_gcm_mptcp.nonblocking ...
 # tls.c:1534:nonblocking:Expected 0 (0) != eagain (0)
 # nonblocking: Test failed

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 64e999c6e14d..c3227b718160 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1405,6 +1405,9 @@ TEST_F(tls, nonblocking)
 	int flags;
 	int res;
 
+	if (variant->mptcp)
+		data *= 4;
+
 	flags = fcntl(self->fd, F_GETFL, 0);
 	fcntl(self->fd, F_SETFL, flags | O_NONBLOCK);
 	fcntl(self->cfd, F_SETFL, flags | O_NONBLOCK);
-- 
2.51.0

