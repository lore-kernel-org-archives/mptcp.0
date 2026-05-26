Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D03D88EB
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788830; cv=none; b=NViioxDF2F0/d2m4PLZ66fIXH9vSUP4r1o/sakWWqeOVDg6rz+EWOU8ZqvQJgY8MvhP0mYmJBw2xE242PbnvAJBe1AMM8xMOCpsU3gMnGim/b3zDIdqHsh/5M/U/7JAVOc6yfPdPq2uI6g1vZV6ybnXxR8078YyF4jO0ki/FC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788830; c=relaxed/simple;
	bh=7CD16pridWv1NecT/Ev0tMgZ5GXOyfNZJyXS5YTEZFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCMhL+ufSmhI3wSEvpyL2S6S/YwxMGLdxhWWyiilDmzT4Uwk8quLP5aydxrOMPnwtl65r5gpQeIcHhMDskr7q12Y0ZmpghrBNeHWUFPAQIz94cAWUeyx/ir5d5jFmwJxmmLhtj1IfEW2bLmMD7tWJnS1yo//Yvv13++yNqowmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSXgVFDj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSXgVFDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6295A1F000E9;
	Tue, 26 May 2026 09:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788828;
	bh=DFPx1IVI7+zedMbOSoBM+L88CDux7VgKX6pYRLcly9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JSXgVFDjMijI9VIZmL3DEy0poVTbvhSExvIh7b1xL7Had8+8VCWTRTm1Y9vbHG72W
	 rtcv+NG9IT/EPP09ZgZdgw0sIWRU54ILGTr07lUFLaie1yHhhWiIf0qNf4w2tpH4lM
	 mwtERIrUtiYpXU2+QC3vgc9E01+qtIHiqakF0DjewIGNoGXkpYKp603KGnBFfOO1Bl
	 5n9V+7v85u8HOl3VlnB9JqO9n9v4ieLYtlC89ymU+zXdKDoaBwTssIqatHIJ/t/8Fk
	 s1eNX77vjsqhdpo8M/W0giTqhEJkhoUoTFc92e0zW416+97e3KXI41EWiK5p+2KZU6
	 5u0jArpHL9aaA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v20 12/15] selftests: tls: increase nonblocking data size for mptcp
Date: Tue, 26 May 2026 17:46:30 +0800
Message-ID: <4687af4ca3f624fae2b758a45c659f61069187ce.1779788090.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
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
index 95875e979ea7..1d2a5661785f 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1468,6 +1468,9 @@ TEST_F(tls, nonblocking)
 	int flags;
 	int res;
 
+	if (variant->mptcp)
+		data *= 4;
+
 	flags = fcntl(self->fd, F_GETFL, 0);
 	fcntl(self->fd, F_SETFL, flags | O_NONBLOCK);
 	fcntl(self->cfd, F_SETFL, flags | O_NONBLOCK);
-- 
2.53.0

