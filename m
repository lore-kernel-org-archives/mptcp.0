Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C772DB7AE
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355833; cv=none; b=Wyo2aqfVsR73Oyq3/cJ3giB4osuxtNyY1f58ZVu2sVvmHJdtkqgG38cG6cfFudcNv+IHgzTct76FiYSRHJ8bKZIvLLv2QZxG+5smOFGpnYdDdx+QXc5r7T7E8Zj86wSunE/xgS/jZS4jO4Pz2GGr0iu5YeN1IGZiRNYxpFLnChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355833; c=relaxed/simple;
	bh=kORFGVNN9Zd1G9CO5QmKrhWdpjMlH7oeSEymEXKh0kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTZmIRJzfIp/3OOOh7UnUwr9rqp9DrexYPP4TnHZudWcdMz/QEVgLVkizoVoHH4GlTnS52QBxwGNngg8uEfWu1km/zxit11EoNDdYmOQFC7IuCpChU0neWa48dvw1uXK/7HXA966CFYgI7pZGIspfRUGQKRXaUr3mgT2rHQibFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2n3zja0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2n3zja0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6151F000E9;
	Thu, 21 May 2026 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355832;
	bh=g3qduNCoMfJcMfmRzI8HY6WG1nmo2aYnX3DYxcXj3PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V2n3zja0mAma8a8ARIrytFzuuTQgdhf9UcJfUrNnIIsh/7TFzcy93qFBzhy5DMzc2
	 9EEacfq4b4mSTEIKFrQZtRO4mi4AIdEy6n/lT91JfHAgv48YH8BufzlnXCI74xfFXL
	 SdCI731/EgRzBXrQtPHwpcVo2xCf39HWWLIGnIcXqHXU03iXlJynhJufHMjyNYY9Jg
	 5svIkY38h0TNYdgueCQSOBCfFHczCWJSkSELUep4H+7PfDp6iYYDsz9Q0h7QA9O61Z
	 sI8QzCiAGUp9JNBF7N3c8DPgbC9Rc4Vn55lk/GTsUojrABUPw7GCfoP98gBYDnaKuc
	 tN+ZmVIcX7lhA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 12/15] selftests: tls: increase nonblocking data size for mptcp
Date: Thu, 21 May 2026 17:29:50 +0800
Message-ID: <42544c6dd1e6ca461b7aea168ab18152f600681d.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
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
index 1608711177a2..0a1b0faa3957 100644
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
2.53.0

