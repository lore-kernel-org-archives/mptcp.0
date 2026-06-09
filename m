Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310B264A97
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971604; cv=none; b=jTnMV2xc8XtSU+ehu4H05yBRozJowT/nDWNSR1GIdU6FU5cVGQc4ChkUCb0D1bnR377wltD1hzipGNUjiUlA9P/W29Mh0tQFQ939daZEaHBoLPOqs5vlKlqLdRuPtGDYBpKtZ1jsYjlGw/FWteOR0iU3ROZRQrxd/95bk38R7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971604; c=relaxed/simple;
	bh=4AKlW549wTkILs+MzA7D+Lh+1QdT40vJVxuqHdPXVtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNHHTCB6kdGpdI6YEWnvuuc76GJvM5LaN7IxMBLUTHCSZv/fDikAN5B+imKNdzQfyyPsb17ew3ExaYTpecNuu/LU/fYqaOldS0TGnje6eZ/RFd5yDkljz+pDJ1PWRDjhorU49cVZaJ7Lts5yz3QwyOlC39YYCoYLeUuMtyu2kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy3KK4g4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy3KK4g4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4481F00893;
	Tue,  9 Jun 2026 02:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971603;
	bh=n2yAJSDtTC6LukPE1XvLhTl+hjeJ2GVLRfC8sw2Jlms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cy3KK4g4RXdBGROIX9wpkUseSM6tPe9hVkUd0c/nO88KbfXtBC0bGd6UcH4f4WS/3
	 5OymlY265Qwvr+b1nuVQqm6RDyW1F7ccBaeZCFxaaXHm7J8KP4SbI74TQjzHjMMrGt
	 MFU0Rw7vUlotUBWY47GBG55UgEWuB1RNXR5Sxmfn5rc9oE0tihvtYlA02Dhy6QcMOA
	 RPAce1OnAx0aFb6uYanhSV5+8gROqzSFML7SctdyKa4LO30rd1YJDrdRMbO+weBMi6
	 I0zeCq1YPnLZNWVVlrxBMmHWqt7TOwJBCn8Mc6oBT5+tv4ER+LiTUz+XopdsHQsXCk
	 X865B1cZ14aUg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 18/22] selftests: tls: increase nonblocking data size for mptcp
Date: Tue,  9 Jun 2026 10:18:44 +0800
Message-ID: <669eef0f6fc23483386ec07ebd34c72c07142142.1780970284.git.tanggeliang@kylinos.cn>
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
2.43.0

