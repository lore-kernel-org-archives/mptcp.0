Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6C25B08D
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783741473; cv=none; b=Z2JixAjLCgXc8nE92ZKvQLNFT6gefd+YdRf41t3ZQ+0QWdWDp4DyLM1gZGZg+vvGoalCEwLzim1Tfv9lrBEicYsC3RJwB1mn45hA7bYYAoxQL690ftuGW+6qUcT1Vy32ObK+vCW7sFTjzI6hCZMxw1KzNh8T1WCa3MtOg+1xnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783741473; c=relaxed/simple;
	bh=wdItYL6Eab4Rsht9jxTtv6iaz6lXHo+3xmHkjUyKeBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMbdrLa0skJFuhl3yZOkvXTTy6arnC0amTRZJs5AsF+a5skA7yji8aALomF6Oq3X824ISBjIIyqjMtT4EYWYAoEn/WZWtXvkA4qUFPjfrtmxgZ4/VlOm22xXDEiC0aaYzqjI9E9A2iY3cR+RmdzBwY1ajIidIONxh43kq5VoVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGW4fK4y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGW4fK4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7581F000E9;
	Sat, 11 Jul 2026 03:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783741471;
	bh=bTxtdF4uXyGcnO5JKlNt60QZT6NWIqPjT0Z06SUtYVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bGW4fK4yBizKAb6NczqWQVqoNd69mJkXWB02Pc/TuuBNqKMvmQAz6IVoutKSPsCnl
	 0A3RUAFaTil4YXaPsqXqwRwQ4r0SoCPB8VqxGhUVy2YLoWircfzGWX6qrzF1d0Ec/X
	 lsugZZTaYWYwgxSho9u6eFXi9bt/VGl2D81KiUyS6crDMPZZsdE2JXmEQtik/uFRw1
	 i2Nw0vBl/mOme/9yRfT3NmxfdzykgqxJgydONEsSQk/oUaeiMXRL1T8SCy4CCt3GOe
	 IhQLcFw0F2GQfex4kwFoHajisbXjKvRa2epggp7iBvVuC9/oeMIAxSmUFbVqjQ628T
	 /wZItNRX6coqQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 02/14] selftests: mptcp: sockopt: validate bytes_acked against sent bytes
Date: Sat, 11 Jul 2026 11:43:30 +0800
Message-ID: <4ec9589e47698632c083dfc0441c238235d62335.1783740443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcpi_bytes_acked tracks the number of bytes sent and acknowledged,
so it should be compared with the amount of data written (ret2), not
the amount read (ret). This corrects a logical error in the test
validation.

Fixes: b86418beade1 ("selftests: mptcp: sockopt: fix error messages")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 05afe8dd1381..fed6aba2a176 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -685,11 +685,11 @@ static void process_one_client(int fd, int pipefd)
 			       ", diff %" PRId64,
 			       s.last_sample.mptcpi_bytes_received, ret,
 			       s.last_sample.mptcpi_bytes_received - ret);
-		if (s.last_sample.mptcpi_bytes_acked != ret)
+		if (s.last_sample.mptcpi_bytes_acked != ret2)
 			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_acked, ret,
-			       s.last_sample.mptcpi_bytes_acked - ret);
+			       s.last_sample.mptcpi_bytes_acked, ret2,
+			       s.last_sample.mptcpi_bytes_acked - ret2);
 	}
 
 	close(fd);
-- 
2.53.0

