Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA30189F43
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053287; cv=none; b=dJDeszWIhqLNT+jgKZ5myh7fnIYyWznnbbYtP+njBgfj1aWFixDRAEjO+dFGLA6eIhKTQtEYZDlkbQaaGb07sl/0c2sElYC2uCdVhwJ7GQgGLts+Jse9Evgsk/COeIncNhOcj0nnu63H41A46lwnqJsMc1FdC5QdnBZeujp6Hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053287; c=relaxed/simple;
	bh=C8Alr9wHDA1wyvNjYB2Q8LN7wGjGU3z/KZAEUgOKn0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncxohmPJ5Kj1fy6mkokx9kUMbgIcMbkxakwKDE/2Qhyf9tvnKY+sq5XlkNbr5xfDoMxz+2lKCQJbg2NGpUSwFZlPVl7JnlgMp2Yxbb301e5yDbjbPLbF8A6c7ZcxdeQ9QagNKhp342M2hl0YxwGIyt54SBIiQuNGHvJCmrzXiu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LztGG62n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LztGG62n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A341F00898;
	Fri, 29 May 2026 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053286;
	bh=WEViAPywuZzQo7Al26/ts5tn23+npYf3//x6bxmYZBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LztGG62ne8VSCPx1926lv9zYs8IQ7ZprPJVetD26ZTVMOrFYbYmuDhzQMulPA2ram
	 DUId4HEv/HbvwschIOK9kdICj877GKtLgdNn1gZ+L2Zd5l7hO5qe8IEJYwDPCtCShN
	 M5f5QqKMyHFU9CJREY80BeY7Gl4p88qaXPRY5jNzdAmrHqA6slL+GWPJdXl4UwTcXE
	 msTMbnGU/3jROuiYc3ZgX4m/iu71Q86zSto0NdXMOg5RzXYpUkf7izmjfbNeUthMj7
	 zhZDa9mx5K9Y7RP6/U+A6luBhK4sxDNxO2jYyiGcjl7bE/BbBcw4Rzq4cdm/mU3IMT
	 wy8HFEYBPSqeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v22 16/20] selftests: tls: increase nonblocking data size for mptcp
Date: Fri, 29 May 2026 19:13:58 +0800
Message-ID: <54a119fe0f969a2e8024c3ae56e06fca8c6a9c48.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
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
index 5a6c5ee2757f..64aad661a1b4 100644
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

