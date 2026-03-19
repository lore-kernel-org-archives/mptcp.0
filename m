Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686F3AD536
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914959; cv=none; b=O75wmeBLpMX+RWNkK8Efwz935wQYPp0fK1LB9zQxwA3ciXe6QkHHXAMvbjrO+hhwVY+kSSgConhc4WnI9axtMjMvMt5qCM4DEiKkJgHtO0dLa32wnIyZh8fV0VhfDFO4z4NyR+IE2Gj2zhdtJFsQolNYxN+9ijiqC4oYn88YEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914959; c=relaxed/simple;
	bh=iPS29msdi7CJmBZYf3L4bmYPtdYtCB01O5NyIXPM0H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvHXFDkad1VUEABkPyaXOjLtXIrLH5eMqQNy3vK7UrAsb5zITzMpSQlO+u4o+g8bhjFkk4a/oYVz0v+QfbvQhg1C2gBEDGO5GHRF7UqN/C7fnnLigYsyUnaqU0+WmsZUvzEx2m/pEKtzuFZC6iszC+2cyKu7pg4sX6jb/bol58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ils2HHcW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ils2HHcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C58C2BCAF;
	Thu, 19 Mar 2026 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914959;
	bh=iPS29msdi7CJmBZYf3L4bmYPtdYtCB01O5NyIXPM0H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ils2HHcW0HA5gMPLSA4Yg4MSmz1f1p5JOJ6DE8CQCbI+X8oyfF4BQgd/QaPXS8XAm
	 cwR/svuvFXUe0+UUTYJbdgdENIiAQo/ZhqP5Isn1cBPTj6aDNaZtB2wUjLS9uVHUBZ
	 qbbtN0HjzaXloIJ5Cx+WHUUSVL4wJksa70W6IYciJaSnPJ9PKVKqMmHEGw47aa5v7R
	 k3RDV2JQW4cNDlbtc5I2ofhhCl3HU8mRdty2bUfMadrQPEIwfftuE0etLGieOolUQ+
	 3O7lTQeOJt+PWUAoL5D2bJ7mAIrPvVHcFnaL69MB3AES+1TGlIiPA0cLbVVEAaEQ8H
	 xlJ1cqhG7tRNA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 12/15] selftests: tls: increase nonblocking data size for MPTCP
Date: Thu, 19 Mar 2026 18:08:45 +0800
Message-ID: <0e41df5ab04cd871955c2468c2c5949c9c6f3280.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Double the data size in nonblocking tests to accommodate MPTCP's
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
index 82631c1b3355..534c4ffd8fd1 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1398,6 +1398,9 @@ TEST_F(tls, nonblocking)
 	int flags;
 	int res;
 
+	if (variant->mptcp)
+		data *= 2;
+
 	flags = fcntl(self->fd, F_GETFL, 0);
 	fcntl(self->fd, F_SETFL, flags | O_NONBLOCK);
 	fcntl(self->cfd, F_SETFL, flags | O_NONBLOCK);
-- 
2.53.0

