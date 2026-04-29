Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E333F595
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460919; cv=none; b=sOhUlS6jrlAPoD/MZPuDCxrDP6ywFm7HSeaaTTSutDCNHx91CFyxS2rJmu6YrMoW8cx0qS4IBKJEeM7Ja5chGKuc/yeQXLXJ/jDXZvgwPH7Bq5aN1DdFbom2oR/xEws+lVQLS7+je2i3pj0jkNH1UfrdiooFM+Fq8y+gFGj3TLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460919; c=relaxed/simple;
	bh=9OeyXWwMDJZIMSpWczfQ/xfjYZU2iuZ3dTfJ7KE8hkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmiasFRfacx1m+UjVtJybM8RHi1hEqnJAOLPKrQxITc1C9SueV31leonjsHOl7kmLT+CBb2XAIGPMuhGkDC3V+eI73aNqTWXa7FFGtaYNQ8Bl1tLYynzvYAuzanSDxITb6f4dsHiL/VynqxJY6jKuw1PtmgtSBs3p3r0gTxHpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8TSFIDc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8TSFIDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AEBC2BCB3;
	Wed, 29 Apr 2026 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777460919;
	bh=9OeyXWwMDJZIMSpWczfQ/xfjYZU2iuZ3dTfJ7KE8hkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8TSFIDcHlyg5hwqcEaYHSJAoad5iINvf8L8oyUJVxLiJqbnRd1agremtO4DmQLit
	 IiPf6ejr4BQGILwk5/cKu3tLr7qIXlmpc7hclRJQkKUdDcuIMUmIKGjOvKOoBSnBWe
	 cgUiKSvAfZmoLNRwgegBmNr+d1Q1mDgDu2bPbeacmJY0xO+8BS9pYlyt8MUAsQALUg
	 KE99wGqCUuhNonz2000iacy1KvhZdZuO74pKDdUkuq1PSxW95poUXnn+RMuM9KgWq2
	 bCT3Jwny0eJsls0Vu1dxLcll/ULG8gMIMoxrvmeIy3ZP8TeNspPSJU8bSSiZP9LYaC
	 oXmuPgezkqhpA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v18 12/15] selftests: tls: increase nonblocking data size for mptcp
Date: Wed, 29 Apr 2026 19:08:16 +0800
Message-ID: <5a913371067061a1f1235031dbf72538a55e6e37.1777459066.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777459066.git.tanggeliang@kylinos.cn>
References: <cover.1777459066.git.tanggeliang@kylinos.cn>
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
index 0dc6514c2c3f..bf8ecfdfdd18 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1425,6 +1425,9 @@ TEST_F(tls, nonblocking)
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

