Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE635B634
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971610; cv=none; b=Zp5yg0kN1L6l0ayG4KgeufYjYoaTb3CFsz0FT4yeSn68FCs98a6/ka75EXwVyeN69pe04XsSjaCQTV7WsmMfXT8JACkSQOE3tnGg4nL9VrDCNQxtW3rz4tU6nzvXAbOzbwWiHl2yacx4J8Hh3EsBH25c9vSH2spT6hwhA0WIuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971610; c=relaxed/simple;
	bh=3IsquAv4YDxMPBzDcFjkvuRls51Rw/lTNaNmpziy6To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF62fa+O4D/3yRR+Z+5HgipLGFe5+9+jkPr+4H5BvLxoFiNFzfdyhaBdTatjcOCrb8QuiHi/5HGBcHURsdoF+v2mn8kvhzcYpJ2bMZvTkKBeLT1EUX7yALB4Lz0xLoS/r+a2tyCjnC7ySQGrqh6FN2IwChMhMNj4dh7nuuBWKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzOAoJ2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzOAoJ2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AEC1F00893;
	Tue,  9 Jun 2026 02:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971609;
	bh=Gxkqt+h6izqRYrlC/RzMeNRphQ6RNv+N6Om0PZ/RFQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nzOAoJ2yL6tFoC3x16bQoeVGNR5vDKIP5kbSvmrw9GUY5QR86fVH0GhiI/FfCxbp8
	 1ilM27U+gVgFE5t0mEjChFKk8gluFQmTvFX607oiZozsPtFOXJxzQs2RP+L1jn1YGr
	 SN8EBTwTyoMouWLcB7TxbOYd5OnfcsOk6o3757LmCr8h6CI+SJVlPjalicfcR1bJh0
	 H5Hkx7aD3PW+DCxXLv+ZjYZNqKOGu0VG8nwxsof50JhoEB6DMLkY9ICQlqCFBP+EiJ
	 pU63iED72h0no4ML9f6D2mY8jF5qCiokgzp/F5vXdRMYRwURAObv9XJNqljYJh49rh
	 7ZAXbBYEjJdmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 20/22] selftests: tls: set timeout for multi_chunk_sendfile
Date: Tue,  9 Jun 2026 10:18:46 +0800
Message-ID: <0599263dc958f9c7d6b04ebba42a480a4d19fe80.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
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
2.43.0

