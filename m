Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BB30BF4E
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116094; cv=none; b=K6R8ZVRfmdMzUq/IMOzl0G4+pjEAOxabuAY6D6rUoK9bkkrfwtqdBWmOHndL+9W2VFRYmAF++FMIt1J/ePUwsj/g4ZAnXx3W+XGvpw/LAq/0or+hta7oIOmC2nr8MEGip67LdEGPtHtJnuxizuOCJ3JXdwRYAYB4WB7tMMsmJJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116094; c=relaxed/simple;
	bh=R5QTa+UMnwEotML4wVygilpV5Ox1rdyBp9tddMx9YDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkkii/WG+gX0jXVp1xs08hq5JX5qDyFgtMvEqqxmYkCZnM/SWFwkm2Uh6JV9wOWuof9NROQfy1WxXlaIe2CLxNdX8vcWfUj2tefclwV0ptrMGl1wH/MFqxqtMlfBVjeP0DRZzXIYAMmZ5hAuTTGH10mMH5Bok9BWf1sVHfxRJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBIX2+Pc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBIX2+Pc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56A3C2BC9E;
	Thu,  2 Apr 2026 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116094;
	bh=R5QTa+UMnwEotML4wVygilpV5Ox1rdyBp9tddMx9YDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBIX2+PcWWGAWH66vtXQCOrCXgBboHmbv2MERw0fMvE6jY2Rv5lcJ8wcKeru1nkla
	 5SksnnTi/cymvEL1h5yKXX8LheaX4jS5X8i1QXcuCCKEz1j7L48BezUOi4lHNlbPyd
	 B7/giTEMHSgYKRNcRpVMM3uYF14UuYIlHaqc2BFkyBAQNz3guzlapzfe3C9GCMzkkK
	 ZBjwW31xGtOg9qjKfL6CPqwbHDUUY/iWhKn9MBofY1HUQwydcYw4BYsEIQZj4/gRCb
	 8FxezSEMpDzo4/T/gglt7xvc81ftXGjK6UBohW/946v9IQ12lSLD7Lx+7GAAJi5fwE
	 5T/oSqXUooRcw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 09/15] selftests: mptcp: connect: use espintcp for ulp test
Date: Thu,  2 Apr 2026 15:47:44 +0800
Message-ID: <650a889fff06714d81f2b816e60c20dc4c5594b4.1775115102.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775115102.git.tanggeliang@kylinos.cn>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With KTLS being implemented, "tls" should no longer be used in
sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
name, "espintcp", is set instead in this patch.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..0d4a944c4269 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -289,7 +289,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
 		if (ret != -1)
 			X("setsockopt");
 	}
-- 
2.51.0

