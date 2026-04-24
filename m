Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FC38655C
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027158; cv=none; b=SNN+jcH1LlmJM4UuZauxrXe0CZyQBh7RAAhr9MVTGmNEb1SxACMlhuWL6p6PiYuSqFC3IW0sdCdGJKbVacFqJeBHSDWoUxdOUo1f8nT6Y9LbeHQwCWdgyNmA2v8/hGUR2UFA3E1VyrgemRRofxpmewqEV3y+SIa105HlrByQh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027158; c=relaxed/simple;
	bh=9OeyXWwMDJZIMSpWczfQ/xfjYZU2iuZ3dTfJ7KE8hkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1DUQHxmvsFGd1oF/nlbszGFYeHdI/vHaVZI3f7zBDWI4Ou47pFHo3izeJJ0mjQ3j0Pwew5PbDb18ApU7Cv8XeCtGG5uiqTrXHs1Z7s++Ys7xgwCkD343svX6jG62Qdor5MiXjl5JeDT87XZPuDLu/rxG3ObDBlpLTCfbutpOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIuke2Ry; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIuke2Ry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF41AC2BCB6;
	Fri, 24 Apr 2026 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027158;
	bh=9OeyXWwMDJZIMSpWczfQ/xfjYZU2iuZ3dTfJ7KE8hkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JIuke2Ry+uW1vQe4KiZNo3KddHXL+lvOamFLrwLV15ffE049zawpQF4oKCgEKOptP
	 VYma/BSlEVkair5pTPEf1BEVNBKWN8qEK0OqLJyYoW0g5AzheWblSAa3rijCvxljjF
	 zs4kBGOG3DRnBXSvE9tRc2oypu6FRivauGewrEchcQkzW3xB9YY2WB+8S0jNpILQTu
	 egnEYqlCCF3EQw9I6TrTNxj6zVedWG/T6NL5ZBRyKaXKni9o3mEjaRm7wYXSNhGnI7
	 DgMy0qMgfAOBf1L12XEQn5mKsWPFuTW3PW8YWT7xFt6P6r5cIayLPfIIjeRr20mTuu
	 xD60JjlXt2Fmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 12/15] selftests: tls: increase nonblocking data size for mptcp
Date: Fri, 24 Apr 2026 18:38:36 +0800
Message-ID: <7076cc180745f763d7a2e54d28a550bc8a3e853b.1777026753.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777026753.git.tanggeliang@kylinos.cn>
References: <cover.1777026753.git.tanggeliang@kylinos.cn>
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

