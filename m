Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEA883F
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478019; cv=none; b=MBn2F4FPJe2mXYmf4YqG4lpIiyEGolJbbmaHah2H1k6nN9Z4F5kR5JFwax81TFlCmWXCHnNiDWDRkHTTvKutZfRkNCEWO/8ssq1qXXsSQDDmKuLbv8yRvIznK/8lMesNK19ZkiiCcbUkau4h7oKAqMZqcnE2uPr9QC9nidqvf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478019; c=relaxed/simple;
	bh=fJRguZsPthsi6pvu3nbI6tt5IWEa5y4Jg8LDr2Iak2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwAQqsGo6Ys+8vf2BHWmd25HInd3kMwnbJ1q/9fc6pL0SzIBY0XylOTIMi6hVEH1k3SnDySF1HCulJVk3l7SEEUtYF3pHZPqka2bPYECpmN6PxaHhL9z9YjexH+NuyKVt/8ACAcuBNw2OyDLy9WlsCaemQ4kQoOtyRN1EwCun5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFD5avPP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFD5avPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428F0C19425;
	Mon,  6 Apr 2026 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478019;
	bh=fJRguZsPthsi6pvu3nbI6tt5IWEa5y4Jg8LDr2Iak2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFD5avPPoJc39MIzIj7sxHEqBGK5JPEGtsfdA9XhLex7EMyTqEXHPPLI8pHcTqvto
	 Jhu7zdNYHlIRwNohKOhGrHYxDObgIIReb1yPSmlmOJp+JyjKydGWIAKuXkTYhr/xA0
	 ehZLvmMmEPmWXkuDyfzneoAw7fAKgQjyrfIxIW9GRW9m4M9XDUqOb0xqDl7x7iS3z4
	 MPQ8dZ1OGknU+TAUvAo5ZrbnDDs690AsIzgw0ynepO22domm9R+N50jK3Ijtfm2Qkb
	 WfZi114XvKOl2RX75HJGQzLtfxyRYyehGjJNE11t2sRCeaqLBOG6c+yrR70ZEbSe6S
	 d60IdBffhMyUQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 11/15] selftests: tls: increase pollin timeouts for mptcp
Date: Mon,  6 Apr 2026 20:18:51 +0800
Message-ID: <1d9a010584112cd110ffe4381699e1e3e21b67d1.1775476921.git.tanggeliang@kylinos.cn>
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

MPTCP requires longer timeouts in pollin test due to subflow establishment
delays and slower state transitions. Increase timeout values to prevent
false failures:

 #  RUN           tls.13_sm4_ccm_mptcp.pollin ...
 # tls.c:1411:pollin:Expected poll(&fd, 1, 20) (0) == 1 (1)
 # tls.c:1412:pollin:Expected fd.revents & POLLIN (0) == 1 (1)
 # pollin: Test failed
 #          FAIL  tls.13_sm4_ccm_mptcp.pollin
 not ok 357 tls.13_sm4_ccm_mptcp.pollin

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 0d19e5582d3d..048bb4d3e0d8 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1320,6 +1320,7 @@ TEST_F(tls, bidir)
 
 TEST_F(tls, pollin)
 {
+	int timeout = variant->mptcp ? 100 : 20;
 	char const *test_str = "test_poll";
 	struct pollfd fd = { 0, 0, 0 };
 	char buf[10];
@@ -1329,11 +1330,11 @@ TEST_F(tls, pollin)
 	fd.fd = self->cfd;
 	fd.events = POLLIN;
 
-	EXPECT_EQ(poll(&fd, 1, 20), 1);
+	EXPECT_EQ(poll(&fd, 1, timeout), 1);
 	EXPECT_EQ(fd.revents & POLLIN, 1);
 	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_WAITALL), send_len);
 	/* Test timing out */
-	EXPECT_EQ(poll(&fd, 1, 20), 0);
+	EXPECT_EQ(poll(&fd, 1, timeout), 0);
 }
 
 TEST_F(tls, poll_wait)
-- 
2.51.0

