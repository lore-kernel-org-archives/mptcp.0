Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB13BADB5
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622687; cv=none; b=OdwD5VvFQ2MGsDr45GTpB874QQ+p2YOw7vUEqB+T/usIUgrFM38jrE4CxqYQZyZL1vykYzO0k0aWT0XHfBDJW5db2Mc0e8s/0FyQWh1sAoZUe4aknHUTyxA1sxvZVfghWHMt1V9nDIiYh2c/oZ+zkTCfbwVyevXrd73rLnhIub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622687; c=relaxed/simple;
	bh=oqContIvSwDjBBUvCDlGJnboNlniQ4AqWa16l/Stl9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSo1XEJ9Nw+qjWCbrNtINLxIuRgiU5x4pWpZuHbd8U+PJo/Iknr32IeEQ+JrDnNxfXEQdaP13H3ksMXSgPXxotoQiihvorjhuh5iCQ+LJHc2SeXGPHNIPuD/8hF3wUwz4GHre9RUg8Sfg9l/tqOSpmtiVwxvJizIGqj+xVvAS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f37ef4gy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f37ef4gy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9091F0089A;
	Fri,  5 Jun 2026 01:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622679;
	bh=jNixIy30UgWwxn53isZSW3yVS4d5nxvceDL4X9ngrNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f37ef4gyDo+B4fxnSvZdFbwzJz7GJ8bpOJIc1AdgSU5buznGMMC4UCwr6bOtzw6OV
	 lBLHoKNSQYoJAbVBwYNuK83NerOdCjJWEfe1lRWgm6gqp1T2gVXAKVK65q2cBxoiml
	 B+ZiY7/aQJhbsxG9mrbmrIFzey0vZmQVibuCigV+vQVGSeivQpp5EgX4ebfF7ff1os
	 nsAIOcGcD/w77qmJbUN3cqM9NAmrBfniVyB9qPwgnVzDHdKTc/4exP36xpKMzin3N/
	 pIKxCcNZvlBW2/IiZdXf5ihH5NAgZvTal4lznrmwUMc/Jms22AksuETRlnUz8lqjS+
	 YScNGEzhe61LQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC mptcp-next v24 16/18] selftests: tls: set timeout for multi_chunk_sendfile
Date: Fri,  5 Jun 2026 09:22:56 +0800
Message-ID: <cc31a55db4500b08fe4089fd0c07ab5beca6d850.1780621326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The multi_chunk_sendfile test can time out with the default 30-second
limit when run on certain configurations (e.g., MPTCP). Add a 240-second
timeout using TEST_F_TIMEOUT to prevent failure:

 # multi_chunk_sendfile: Test terminated by timeout 30
 #          FAIL  tls.13_chacha_mptcp.multi_chunk_sendfile
 not ok 204 tls.13_chacha_mptcp.multi_chunk_sendfile

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 4ae7505846f9..6f51da27ef1e 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -536,7 +536,7 @@ static void chunked_sendfile(struct __test_metadata *_metadata,
 	close(fd);
 }
 
-TEST_F(tls, multi_chunk_sendfile)
+TEST_F_TIMEOUT(tls, multi_chunk_sendfile, 240)
 {
 	chunked_sendfile(_metadata, self, 4096, 4096);
 	chunked_sendfile(_metadata, self, 4096, 0);
-- 
2.53.0

