Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819C33B6E3
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367614; cv=none; b=J8Bm9dyzTV0kyOT85zgzLNHCTxPEMdCqS2ag5N3gdFJcvapXb9ok/JoEnLqL3VOIjdeziYg88E/dWDetQZnmr47usk7cN7JZOKbiWeHAyatYplnN9H26SLILsNQk97i3b2EL/vzt+hoBglWx+OM2NyiLD59nZT3YD2WqE3QV3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367614; c=relaxed/simple;
	bh=C8Alr9wHDA1wyvNjYB2Q8LN7wGjGU3z/KZAEUgOKn0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0BA2EGd3qSprHlBjNkwR+DlxS4rf7ye38J8aDrWqPEkONWbI+ZMGpcBF9YwbtSy9rE8u1st7Wwqr2t5b2HpuspSl3Ydj/Khps/E/peB+Ek9JwO7QYR0MK9INLUn4Hmaaehvj4FOvWIhBiwHW6XZwitzwJPmwqetWGDbk0q2G0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOg3FykK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOg3FykK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD4D1F00893;
	Tue,  2 Jun 2026 02:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367613;
	bh=WEViAPywuZzQo7Al26/ts5tn23+npYf3//x6bxmYZBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZOg3FykKpEkP+rh3+lKvsZEDUPrC7NngEdjKE2PihFOSEJQTiQH4lF7nrg7SyVwtv
	 H4oNrwL5yy6scTY89L2fvynezlsW+Y2QOZ0Hhe9w21ha8jjc3uKS5KBnfUSLzR9C+Y
	 1yl+IDEo2YKosZZnro7+TDhhnKL/hLI5wzNqgq0E9EuLCLZkREZMpG5sDulgM+bae3
	 zyXhKz7K9mhj9iix+cKsT8jldPTdUVEZiLMUH6fKlmdi8Ce/TqH8stC3h6U1pA6JPm
	 0js9nLxF9p1ljz6bdkmItTRCOZw9P37czJzMnYiE/XTeqSAr48qOniF1wQ59oe7kGf
	 DCkbVYj8yyteA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v23 12/16] selftests: tls: increase nonblocking data size for mptcp
Date: Tue,  2 Jun 2026 10:32:53 +0800
Message-ID: <209d458b80fa6d5d6e3fa6000a85a5ccf2032a7c.1780362942.git.tanggeliang@kylinos.cn>
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
2.53.0

