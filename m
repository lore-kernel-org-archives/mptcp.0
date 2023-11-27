Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D831739
	for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBX7omkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D239BC433C7;
	Mon, 27 Nov 2023 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701101812;
	bh=QI8deKgZLIwsN+61V/wIKxI7cbndjn5y2Ew3ho/exuE=;
	h=From:Date:Subject:To:Cc:From;
	b=QBX7omkHz0a/3Lv50hIvCu9cM1oyhZqi0BPfYoB8ML2CDQovoWlc0wurEMH7O0lue
	 +pC68DtgTMrRkqJt8UM+6bCipC6R08hkZFMTU5AcHyMS7Ldxpvf5oc4mwxGH6etRgV
	 8nj8glHvxsU97O13h9hmCSfxcWlZemoNmhQwggXY8v5ryTWLgUz9LRmkSqJD8peNO5
	 ftr7iuI9Wnv94cSovSRbegG8AoJT1F2j24Rvv72V5edkUJPCkqhqna7Iq5QHkeS87j
	 g5+UqIBuh0yo6kx06oMYgAc0ehJh15tL7fftiswRVc40gUPnEdfKKZQz1fRB6P5AnR
	 mJqILXemC+ovA==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Mon, 27 Nov 2023 17:16:23 +0100
Subject: [PATCH mptcp-net] mptcp: fill in missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-mptcp-module-desc-v1-1-d2209921bf9e@kernel.org>
X-B4-Tracking: v=1; b=H4sIANbAZGUC/yWMWwqAIBAArxL73YLak64SfYSutVAmWhFEd0/qc
 2BmbogUmCJ02Q2BTo68uQQyz0DPo5sI2SQGJVQhpWpw9bv2uG7mWAgNRY22KSshtLKmrSF1PpD
 l63v28OuOdhie5wUxXQxTbgAAAA==
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QI8deKgZLIwsN+61V/wIKxI7cbndjn5y2Ew3ho/exuE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlZMDzCzzPjGmFTstRW6xQKEOEPcH6vxr63rY+l
 HdGfrRtK82JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZWTA8wAKCRD2t4JPQmmg
 c+NcD/9c1iuo6+6GUmhdF6z8IaONtSmgtsoz7eRnF9Fr9Q4Zj7VXKO2yOvDkMTblqstrcqfZeoN
 zdi83HdjdIjGi8khA51c6BHddZFM2XEqpDB6VT6ErIb7FtB0R3Cv2li3Y9V4AFjnFpTWUsYN+UI
 AhwRisAoyB9mFKPV0h/NCJ1FwCbgNKmhcQY87ST2kp+ZcN8xJNhQWYTeUBr2KAzMxUdfooPXli+
 YS9VoMpBmOmELaGPUbSl+M+d/8RncSJA+vPEubeba2INXebeUaBcCkka0X0fL5joxJ6qgXbZwPq
 fsImsQ94WO9fEHNpK+1HYyWVnw9O2bIeCmFZX+3oiWTFND/U4pi9StSDvd8czwdJSInehnS6yxX
 HU1phCYKKOgrKLbUtmLaHupdifbTWGTwPp4pX3gMF8oKaShfzMMnBjtMd8e//rQKD66x0138cyX
 9Arp1KxdY+uBnDJIV8sJzJeYlbglWCyx2eOsae2HdS7MDkJ6v2UHtvoq+uFtoZptJT2ltViW4ry
 5Z1Leui1ajIQvzAajqU8hIbqV9cDJV8LUbhR0QST/UQ4fssmZ63elUBkdjv9JSj9jYHGa4qI1dl
 Hg32YlBkyxZY9pzLx9ZqfxS3hBF9A3uCzmpw5MLe3ZeIGZOA9V9BE4MeMjocR0xiFPOOpNcvqEA
 fCoCFIkiqQNBUMQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

W=1 builds warn on missing MODULE_DESCRIPTION, add them here in MPTCP.

Only two were missing: two modules with different KUint tests for MPTCP.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/crypto_test.c | 1 +
 net/mptcp/token_test.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/crypto_test.c b/net/mptcp/crypto_test.c
index 017248dea038..220414e5c850 100644
--- a/net/mptcp/crypto_test.c
+++ b/net/mptcp/crypto_test.c
@@ -70,3 +70,4 @@ static struct kunit_suite mptcp_crypto_suite = {
 kunit_test_suite(mptcp_crypto_suite);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for MPTCP Crypto");
diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index 0758865ab658..bfff53e668da 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -143,3 +143,4 @@ static struct kunit_suite mptcp_token_suite = {
 kunit_test_suite(mptcp_token_suite);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for MPTCP Token");

---
base-commit: e7a5909d8593c93796bd85913fda617a08dfce7b
change-id: 20231127-mptcp-module-desc-f74500c2fd86

Best regards,
-- 
Matthieu Baerts <matttbe@kernel.org>

