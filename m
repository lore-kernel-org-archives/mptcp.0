Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B152248A5
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227983; cv=none; b=VV3Y91bLp91Qon3Lhm2Sra0eIPvnenTutXg3+kVGHtJk1UyS9XWx/agg22yScJ+t29Ag2vlRNYXPh09JokiFrOPzTuF9X3h8aVI2vCKZbe80gAplqfTEnrMVJ/4/vmwMw/WabOhch18royf7d3wA5KVbaWZKVIcnA9gGyHJQ4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227983; c=relaxed/simple;
	bh=D3yvGoiC3nFkDJ6o73gOE8DjBHarCI9ID9btOMyqLBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcR85xPvW+C6WE9ajoOO2/UooylTb5CvqjgnlPMp2eWy98Rb9CPjgDCW4R/VIorpx6bXHcq32B7rZN0XY1bpM+T6qIIr4ul//apIXg/GsA0H7y0xSMAIrJfdKxopZNv8MTrQRf6SlEFtVcdjKguqZOaYX40RlYW7mc1QmLwanec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdvJCALL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdvJCALL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B893C4CEF7;
	Fri,  3 Apr 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227983;
	bh=D3yvGoiC3nFkDJ6o73gOE8DjBHarCI9ID9btOMyqLBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MdvJCALLYOe5hplQsIv1lli/V5XXjus4a3n0DgTRrovgyyATYVUW5RY2oOBIVJc4v
	 2oWZnw3EjgFiVNf0GzgBhlzmwFv/EgpP20m8sVFHQCawAr/VR3hSt9+mr+NPwEozQT
	 VhhxoV9upnMUr8vS+Mq8tqTyQPc/yEbyk/Vi9Ui3pfJ8UNk1n7he1CAuxLRw7/MpB7
	 AILP8MKnKuI7sR10eBNOgdbYRV8wYAwXaTN6HI66hGXPkzLR5QEZ2BaLkYqtko/wi2
	 i2H7YFHJ4/WpMC0pEPhC7B14XX5wGZeFbjigxg0W/gQ8ujcSc6vd6KLfi1XkEHbMI+
	 59Q/9S3/nZovQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 12/16] selftests: tls: increase pollin timeouts for mptcp
Date: Fri,  3 Apr 2026 22:51:30 +0800
Message-ID: <3675594158c60cbbbf07ab769be58d29731d0797.1775227717.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
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
index 21f73a9867ea..55d5942b9ecd 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1301,6 +1301,7 @@ TEST_F(tls, bidir)
 
 TEST_F(tls, pollin)
 {
+	int timeout = variant->mptcp ? 100 : 20;
 	char const *test_str = "test_poll";
 	struct pollfd fd = { 0, 0, 0 };
 	char buf[10];
@@ -1310,11 +1311,11 @@ TEST_F(tls, pollin)
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

