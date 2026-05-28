Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16403AE191
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960472; cv=none; b=ZEN5fSyqV/v3g+Ieq7d/5ogyeNOqrE76y66MGSYpeHfTUt53r4Xq6Hb6vGAZLxl2nBnr/DceNF+E2RH4LHlBD+6h5i/ovtlmARSrz3qVkq81TgQxtcLcDdamCIkBTwScRQpCPNejrDHa7l+AcFgV3gznwg5gJLpjGT2rYTzA0YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960472; c=relaxed/simple;
	bh=oqContIvSwDjBBUvCDlGJnboNlniQ4AqWa16l/Stl9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaETOrlqSvm5fX+sqWbktLNHC5xabOUZ6ctcjHX/jay++xjgcXajVj6Qkh/SEUOj9JALN22fWm6I2aYcODDdiG7DMBIuJGkHiAP/o6OTs+Zn2AWjZZjrHFDLZSfcGPF1dpURh+88+kNAjNBuQkT1RGWIQT/1aJo0hPsDrkQGrdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NF3cl75d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF3cl75d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643221F00A3A;
	Thu, 28 May 2026 09:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960469;
	bh=jNixIy30UgWwxn53isZSW3yVS4d5nxvceDL4X9ngrNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NF3cl75dKT7TwwR3V68KEn0mUmPUetmSNiFT5bu2d6BAkfJuUdwldgB2mvzBMN1/+
	 8Vj8l1Z2Ppy5JIxhx7x4tBHJSyRq0gWEkgYSOJb5SifS7APm6z6ll7p6lYH00HXwK9
	 TNJYBCe2Daj20H4vSJijsjJ7oN7baHxeWzmuD6H7+F348lNN58vzdwdcaU+ta/e/k4
	 ITs92hrYyFNgSfmD59vNSYzFE39BLUn4wDNIPOU9avq/d6p4V90dzIDOlFMVeaj/3Q
	 zhXEx2oCbsyIGX1yjgU+xwVoevNLJjiAQ49OBQ4NkAqtMIzIifckdkhDeRWCQYM8mb
	 Wg9ROXH32lZQA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 16/18] selftests: tls: set timeout for multi_chunk_sendfile
Date: Thu, 28 May 2026 17:27:07 +0800
Message-ID: <1b1d2b622b0361bfc1aab7755e515fa39e30e983.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
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

