Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04122045AD
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367618; cv=none; b=scmCAx+l6NYI7Ykiu2pvGtXScxnHUXpY/2DsemsykwvxSjmQlSFa/c+y807N/fBCpHdzLRqYpHrT+m8Bsi+2ADsTUqLVJUWm9z9hFZKaLoXn98bn200bOsbXWsjmWn2wOrNqJwhlYE3V6ahcRGLiDJiUpwc0O86Y1ZJznGw01EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367618; c=relaxed/simple;
	bh=oqContIvSwDjBBUvCDlGJnboNlniQ4AqWa16l/Stl9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKY4cOW5yMA9aOuy1ZrY9rR4b83/mHzVwlUTuQw45MVQ0YnTK4O0DR0FI+oga/HZmVnOubt4jwpn5GnK9OHpQFEXSSkf9cNgAzllyI0G34H5wXFwYwG5aLnNVSqQLkHXahlw1kcTvopjGPR3o6yGELJAJB7Vn5nIID4GXjrtm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed4oFoKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed4oFoKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF271F00893;
	Tue,  2 Jun 2026 02:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367617;
	bh=jNixIy30UgWwxn53isZSW3yVS4d5nxvceDL4X9ngrNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ed4oFoKWOESoyW7fZBxG5fyynmgqlM93ahGpeJHDv2z1XMfD16zUlwTJJLfigzGIL
	 hhs+Q10/rdPlngTf8rk77zisDNGoMVLbS07lUgXshljxy1SKXBJwPy2RWoD9N+gZHE
	 QQ3/wW9Ejih3LSVkI5pVCpJMfQ8+xE5ze4u6aHWkqiShpwKDt0znPXCtyBfzuAKifl
	 imyz25BeNLHshqNKCqlt1fXu6A4yAbTD11x0n988rsatS+eojEkxWFMLrA73Pt/PaO
	 pG3B0KOcHl6mKF2YH0HGLlQG0NJiOwd8CLuupRe4dZLMkLjvC4XWhxEDwwqxd2r/oU
	 RguNFELHumCOQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v23 14/16] selftests: tls: set timeout for multi_chunk_sendfile
Date: Tue,  2 Jun 2026 10:32:55 +0800
Message-ID: <160f75478206467e0237da501ca0fbede80e9bac.1780362942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780362942.git.tanggeliang@kylinos.cn>
References: <cover.1780362942.git.tanggeliang@kylinos.cn>
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

