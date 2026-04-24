Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7438B7A6
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027152; cv=none; b=fuAIN08tPSpvz0l3Dbz3P4jGdRDe28x3OW3+gcpkSSvT369Y+t7QVWugCIGAGWwnBgMidxPNeT6nNKqj6aWf803b1aht4cpKEPfq7YHUE5u8JGE7W9bX/CjK94MUe7CdfdjU0wJWrS0cw5cjDxSvTCIQ1A0BMTgAbwrcwgt7/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027152; c=relaxed/simple;
	bh=EoSZLrxJrEfv4uRyfcT0i/5aFTWIAohjf1lCqM6vMV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfSHR8QspVBchp/ffBYTDBWlfekViu2u7ZBzB82gCXeqCZ+XAlJB9ie5DBfcmXCrNB3kOz7vkrv8Mydrz8L59H6PQmqIR81Q0CaXoQIsbe0gF+K0D8paqP4s2E2FY2lSOlbS/uflLmqg0AJDrmT9w7/J77CAm4pnc+mFRLe8Xsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3pFCTC1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3pFCTC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAB6C2BCB4;
	Fri, 24 Apr 2026 10:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027151;
	bh=EoSZLrxJrEfv4uRyfcT0i/5aFTWIAohjf1lCqM6vMV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3pFCTC1fHNDDGz22Ung3VyIyUwJ2aC4Qq9ccsctJbfEoUhhSE+UoERIFpYT2cVAd
	 t5RVW97GZ5LL4IbUPYVMihY6oQAowPr9Qy9AWSShFD1iUXUkaUnOjkkloBfApMQehu
	 bzIa6Mj6D6G2GJn+/2LVkTUdIGc+Iavf1TQ8NEVxJgxR+OGpF7yBDl0Mt0fIbF0/fk
	 7Tzh8w+p+ROSegBhBGLyaI/9JVNYzMe44GtfRhTXLwt62ZOmdynxc9NQWMRCIGHoxK
	 eLC62KsS1oD1E6SU7a6AEyheYKSpMeo6AtMhC2Q0dxwokTZj9sUNahRNzsl4cz52h6
	 6/HT3uG5KlWrA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 09/15] selftests: mptcp: connect: use espintcp for ulp test
Date: Fri, 24 Apr 2026 18:38:33 +0800
Message-ID: <a60227cc08f145b9568349834d177d21daa44d90.1777026753.git.tanggeliang@kylinos.cn>
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

With KTLS being implemented, "tls" should no longer be used in
sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
name, "espintcp", is set instead in this patch.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..299a7a02d6f5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -285,11 +285,11 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 	if (buflen > 0) {
 		if (strcmp(buf, "mptcp") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
 		if (ret != -1)
 			X("setsockopt");
 	}
-- 
2.53.0

