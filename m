Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06402883F
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478022; cv=none; b=JNzBolRhxCvWFoV1/TMZeTSS4ZiE9FanmkgenzBIJ2z4DwYeLdh67Utrt60o9xxz/Qxj+jv3kq0zmtqT30fmwzx6CvOdzLBFV4SC2DO10Q3Mg8M8FziSLdt31LXMl/ss6Zl6COVqa66k2yVKk3zuk+zhA3Wh9K73wCJ2epUI9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478022; c=relaxed/simple;
	bh=cMjw6s3JZb9vyookluIQsS8ImPnHPQDtUSKqI4Dat8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apGjYIz7UukpzmbFVDEIDk1cmqkx1MYxJ3QVjsu/hKZSLKD5Su8VSX6h7FEH1aQ33DNhMTR22TfQpitpngvpllRjARSxuHZwiXWegQ6YHxa2c7M9yZ7qoPuRDNgi7l7pbPIEC9osGNWT4lrmpZVu2j6iM4zNQzfOV+90pxAaLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDHMHitP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDHMHitP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656C4C4CEF7;
	Mon,  6 Apr 2026 12:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478021;
	bh=cMjw6s3JZb9vyookluIQsS8ImPnHPQDtUSKqI4Dat8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDHMHitPN+w/hrvnY6u5JHM2dvNZBwF9FZxTpH8tQRmsfZJI+ri4R5bdMZGCln4FQ
	 gEJPgrI2sWVR5pxjApUDtNuN6+KuHkUUcplbWG6ONvbK+uuXpmPiKWUocUa579DAa4
	 gHyZ3dXHq7oQCXw221cn/tNg4PpGtaspObG7PDKMj2xm/xLw7aU5z39AgSXz9BfECU
	 pzLfnwPlW4poU+/nm0ref29G+30hgKxsCPRY/jVVzUIBnLtWQfz2aiW6gpdidtKmHJ
	 2xuYf6AhTICFbzEdZWJpS99jbVWGjGlTE20bo1Jx7HMAL9BDTJphZlzHwRDi8uNn5+
	 1vk3U9GE4FRVQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 12/15] selftests: tls: increase nonblocking data size for mptcp
Date: Mon,  6 Apr 2026 20:18:52 +0800
Message-ID: <0697668bc3d6928b80f62445b790317334dfb314.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
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
index 048bb4d3e0d8..8bd5def6f3ec 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1426,6 +1426,9 @@ TEST_F(tls, nonblocking)
 	int flags;
 	int res;
 
+	if (variant->mptcp)
+		data *= 4;
+
 	flags = fcntl(self->fd, F_GETFL, 0);
 	fcntl(self->fd, F_SETFL, flags | O_NONBLOCK);
 	fcntl(self->cfd, F_SETFL, flags | O_NONBLOCK);
-- 
2.51.0

