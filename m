Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25493B8127
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100401; cv=none; b=ITCr6vEemKMSks/z26qNiG2tq4h/WbcTCCwQaQykxbbYGSuFfpKsx/w2oE0ix3vduNeDsXWxE0KaQkXTFNKPyENWvFBCcwb1S5u+aCR2VA3ACRZL7n3Rb7SKctSHhs9RgBkJoUDV5luhE4LUujhzuhV0YHXktwsRpEKQsxhxWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100401; c=relaxed/simple;
	bh=JxT3qeiSHuBS12KtGnTPLFRzVxKd0fvCXwqrRkI3nnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl6sFd9djfR8wcS0VHVl1psv5NI9N2zEORBz1QChXOJkV22fIP+P4oAwR78RokGfJNbgwouhyX3j0vyXR3xTAaV8SZzZTOSS3RygPXmOEcXML2fLEI1NPJBAllwJMqZU5v320R2dm8oTqtGq+wdNgal3VNplmwkxGi3Kra6DYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8wZ2LaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8wZ2LaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7974C1F000E9;
	Sun, 30 Aug 2026 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100400;
	bh=xNNDwMcimuhvgxiiYj/oGzahS6NB1VtBfCB7+LyvfjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P8wZ2LaDLC+ricM5UiIwkqidyKu/7Kx3/JjeYA/Z9NZ571fUs6NFcJ0ROLeT6nDIw
	 WdRF5X+jHaPNEg+3BBKhE/OX6VAmIW26bI9M6KkEC9JD5EHrFvyxqlh60Cd9Kpwc1a
	 X9wF8C9zQQ2p0ek7V3G06OYU+/Nn00cgl9H2n7aCPci4tE3Kis7C5MBezL1IVKS6l8
	 CsE3cpSnq+fVhsMFAC1agjWm5Kkduts/nQ2go3y5IiON6vllRjHZg6QIM6/2WLqd/y
	 ESDx+iaZiGn1ehN1wE5KytbbgtygJHrGnzzCgdAcFTllzN7GCpnOESsOc700rS7V9C
	 Epev2M1K27yiQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 10/10] selftests: mptcp: sockopt: check app_limited
Date: Sun, 30 Aug 2026 22:32:53 +0800
Message-ID: <2cf932de3dc6c68cc8dc562b95657f1134a439be.1788099847.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788099847.git.tanggeliang@kylinos.cn>
References: <cover.1788099847.git.tanggeliang@kylinos.cn>
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

