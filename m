Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B43016E7
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053291; cv=none; b=DbJAVTaEdXYKtfZW8AOeuFtzyqN/UvZQaJL7zl5ey1kP+68NMNcfPmPgL0armnjKfnwLZnJ5JFnH7oYfT7117uOGjc6IiBn7DEuHfpgIXPhQBqm5jScWp/klxC5m3wPmM3AgRx1JlG2rcrsH4rg+tjoS/sxCci82tStOrsrBzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053291; c=relaxed/simple;
	bh=oqContIvSwDjBBUvCDlGJnboNlniQ4AqWa16l/Stl9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CX10lyWx+AgLZgJCuqWJb/1h/FiDPR7w7uXQ7PQB/wUPIgSkB7fnSc24Q/KpuP4bjFzMgeXNk/vEB9l8FPRJxxX03zod0B3U4+n2fezWoTbWsszt0y8v1JsWLK7lEMFX1o/sP5kXLS4gR0ZAZVaFTRzXBOydXxSui4zHKoAcqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iavVt3Ov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iavVt3Ov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E0B1F00898;
	Fri, 29 May 2026 11:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053290;
	bh=jNixIy30UgWwxn53isZSW3yVS4d5nxvceDL4X9ngrNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iavVt3OvBMwv2MJa/5yRnC8C529mgwY1U9YX6k907X+nqaHtoluOuu+ZN0V/VKjK0
	 Wt+XjGZKqWsZyyj1L7iojXID99/3VxSKqx2aYm30bLxZZq7mnkDcvnuXFEY5b/KGPI
	 sXCSoCZIZy0OdNZahjCnUYixo00WQ6vXysNlNXkNrcZ9u1ENaAwJNyIZ0/qzP7x/bw
	 KSROMxUpjYSRj1O9Tagb6DJ/woT9twPjDdoyQ/hkzMLdTnqOs4eLH3W5bolH+rEWTX
	 VuNF3HpiFIHQkUuEuPWysqlOBTi1gfFE0MMUUv0xxnTSj5vhezECa+DYiKhmDWei/G
	 7X9T5Jk0BeYSA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v22 18/20] selftests: tls: set timeout for multi_chunk_sendfile
Date: Fri, 29 May 2026 19:14:00 +0800
Message-ID: <1f8df4b64bc23644c48b25a8a3fc0a4ed8611cb9.1780052851.git.tanggeliang@kylinos.cn>
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

