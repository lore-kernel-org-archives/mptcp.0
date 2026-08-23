Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB223ABBF
	for <mptcp@lists.linux.dev>; Sun, 23 Aug 2026 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787446963; cv=none; b=J4cEZK8SZThFg0V09gcVJfFIfT2SLrqBO4/WdxMx1/YZgTNyO5PsYzW65RL/+Okc3NcV+pMfL64DRfwNOifapN8M1bty8eACVi/u/gFOwYOcTL97KDp+hAFvLMegu8eTkkR5nGr+qXoWbYVipLkncGNYtyAr5NMN20M+Sd1oREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787446963; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szO5yKVgk6OlbZtcG9rVZlGbJ0rx3PcZ80bRDiSLPVVGkkj82Wpc2Hvv1GkWL4AdsZvGtq7CLsv3eztRjr9SoFP4tn5kGJVMAbEWOaLSttR7IN7eYxbUsNvBV0iGX+XtQAJ0YZ7VUpAquWLkBMiGuekgVbPpDpzUsI9AyIMLCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU01Y5VN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU01Y5VN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE711F000E9;
	Sun, 23 Aug 2026 01:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787446940;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RU01Y5VNjX5S4XwsGprD+ZxbpNKz/qMmEl6feq1sk3UfLc5jDUxiOWU1jYeGwoUWP
	 PKXsadoRL7GSZsrMghJlVWU9UpmVbkeAaEoT4y9C+gZx70WVaDqgejh0mjL8jlw3gF
	 r2B+fP0TDRA3UYSFFyFI+eZcXmP8s2pV+IrIcJGM8LCQm/ZGehEZ59kRttMuimbgs3
	 oRMmgESGCBHYcKpXHFSCUvKov//kH44VLCr2CXibPy8AbcofJAucWqavf86b7G/BdU
	 OgDDzHs8Zw2+zFCuKovOYz6DQJmh9/tg7dLSdUpiVkq4UnKKuPOovmfmoSNdVOBxNt
	 +YDMExNzHo9mg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 7/7] selftests: mptcp: sockopt: check app_limited
Date: Sun, 23 Aug 2026 09:01:37 +0800
Message-ID: <39b2a50221fdd8aea820d7b5ad9359cc40dff108.1787446274.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787446274.git.tanggeliang@kylinos.cn>
References: <cover.1787446274.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

connect_one_server() in mptcp_sockopt exchanges only a few packets between
the client and server, then closes the socket. After such a small transfer
the application has nothing further to send, so the connection is, by
definition, application-limited.

Extend the TCP_INFO readback at the end of the function to assert
s.tcp_info.tcpi_delivery_rate_app_limited == 1.

Without the preceding commit, mptcp_sendmsg() never updates the per-subflow
app-limited state, and this field stays at 0 - the assertion would fail.
With it in place, the value is forced to 1, turning this into a regression
guard for the subflow-side application-limited accounting.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index d68515b7903b..8d712bdb4325 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -640,6 +640,7 @@ static void connect_one_server(int fd, int pipefd)
 		total += 1; /* sequence advances due to FIN */
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);
 	close(fd);
 }
 
-- 
2.53.0

