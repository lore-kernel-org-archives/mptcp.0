Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5D1FAA
	for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182183; cv=none; b=etdR7LNjoHF5a1Ei5y9ws1NXgakB5/MrgSv4w3hTRReYLyjUqvrHtUeKe5vnDUpJ80fSSSFLdNj5EAbuVsGBHFoU7yLohvXTjwNEu4QvTtHc1eL7gbyj4CmIeHnK08QRYeMfdRtQGJxQCM21zQvcmGOaVCJ8hGStVWt+VDsHV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182183; c=relaxed/simple;
	bh=Hc8xVr98N62IvQNngfXlT1YA+ksTnniKSgja7hZQ0sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUiS+pwC2IazwPbXAzow0Vll0JXWsD9fGsNR60LM3IgyC0dktFcTxJKbjOZtd/T5SRfw5uKHOPEKAdMDk5PAjlvG9dcLEjTfZleB4kda9mtGnhiNv75NJTtw9XEfpLCXEvbVn++gzD6v9a+WEsdSOM3Ychzprw8qMWY/p4En6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvFtW3hr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvFtW3hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75AFC4CEED;
	Mon, 17 Mar 2025 03:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742182182;
	bh=Hc8xVr98N62IvQNngfXlT1YA+ksTnniKSgja7hZQ0sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvFtW3hrHw2gFTsAnMakDSRb6JsHM3beXR7YKDWaLLX/lRTIsqsulKuy0scgDLfwb
	 L0Pv9EEqp+JYR196QnpDF+XJujW+ZmiQe1DBgZuXD74XceYazil5x+G/w3aifouRyk
	 C40yOgkVgwpPJ67jJ3MOaI7/6GUJdHmYXEyruC4tEftstPOkkJeMyTx7VPVr6diJ5Y
	 mOVUePWKBO8q07joaKyu9kDiQrvgFvMZqD6C3oNRLWNJiK/FppSFHzedKXmM6tAXWz
	 nCJjeQAoKhVqHRFeFhVtW+NJ0gcNvt0tLDBb7mg7Z6Al1VxsDOwRYmNir566Tp5CHZ
	 spGmzCRkXNIyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 3/3] Squash to "mptcp: pm: add rm_addr_received() interface"
Date: Mon, 17 Mar 2025 11:29:29 +0800
Message-ID: <9bebb11d7b981b9b130a3921ea1764c33fb5fdfc.1742181977.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742181977.git.tanggeliang@kylinos.cn>
References: <cover.1742181977.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Shouldn't return here, should give a chance to call
__mptcp_pm_kernel_worker().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 788fbe31a40f..5ef989abb4c0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -934,7 +934,7 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		spin_unlock_bh(&msk->pm.lock);
 		pm->ops->rm_addr_received(msk);
-		return;
+		spin_lock_bh(&msk->pm.lock);
 	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
-- 
2.43.0

