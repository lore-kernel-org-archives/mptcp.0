Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A694B2D2488
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983396; cv=none; b=eDaIdN8qvdmsVEjnUXPVMA01zB5q+wNOKKUHXyNBNnWCBSTwjoQXQkKlnGzlaBUvJNonoH2xlIgndh2iqbUqKZ8FH3jcF2/hMS2TP7Ve6emgeplqzcZ0Fm/pIEzo5KNDGtxIkSW9bbah+BkEAIbNt8EinDKPM7CcXP2VVhXrfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983396; c=relaxed/simple;
	bh=xMUHk4FZgLtsOetEMgyn6DWs+YyfWTqR6prXUcqlcOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfhyvGkjuhcytXB7+ozjMZr1ovjUbyfStzER9FiTD1RQhbpnUJFqFG7xMAjMiXHhGL61Mxpl2wsLDnGcscRrSbT4rhIaEcjMi+X3oUARDW5kOcamwvvwpe+ZcjU7Cd9ZAFG2EcZed1aZzGjImlORAoRQxDMHvJhx4235hHPuoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSJCUOTP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSJCUOTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E0C1F00A3D;
	Sat, 25 Jul 2026 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784983395;
	bh=kSWWG0CtN1LB0CeT/fpBO+dsBChKgatlHHHME8t5CBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fSJCUOTPkNFBSP3EvXIBs8n2Pr5Hfg9RCv8rPN6CfTn0skFl3CnAYEZeF8bctTop1
	 3DYBb6CuY7F+rz1EltSw8aEbLRVezOssvHEb8pAie1GMrXATEg+MGEyOJW3tsPfhhO
	 NBgLbU1oANUMkSIXBK187tkzEOzaetvteyhjwozXFOlYtY0JIO3S63CK1SPvc1bn9c
	 mIB3jXxy7iRyi2spQa9wbIxS7aTXXEsWyPqr9MYkz9hllMU8sDhmZ2QJiF/Sp5QQL5
	 xARoMsDnAhCSvijpdcNXK5cosYOcVAU95A7d3XqptqgUlyRkF6Jcy+NCe7xjzRLsaZ
	 mQSPEvd+FXF7w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 02/12] selftests: mptcp: sockopt: use exact length in connect_one_server
Date: Sat, 25 Jul 2026 20:42:23 +0800
Message-ID: <3a61c89488070a67017f14031ac74481174c5adb.1784981974.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784981974.git.tanggeliang@kylinos.cn>
References: <cover.1784981974.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the exact remaining length ('len - total') when reading the echoed data
from the socket, instead of the full buffer size.

This silences a false positive -Wstringop-overflow warning from GCC, as the
compiler can now prove that the destination buffer is large enough for the
specified read size.

connect_one_server() passes per-chunk 'ret' to do_getsockopts() instead of
cumulative 'total', causing mismatches when the echo is fragmented. Fix by
passing 'total' to match the semantics used in process_one_client().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 05afe8dd1381..9588a25ac6b2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -609,7 +609,7 @@ static void connect_one_server(int fd, int pipefd)
 
 	total = 0;
 	do {
-		ret = read(fd, buf2 + total, sizeof(buf2) - total);
+		ret = read(fd, buf2 + total, len - total);
 		if (ret < 0)
 			die_perror("read");
 		if (ret == 0) {
@@ -629,7 +629,7 @@ static void connect_one_server(int fd, int pipefd)
 	if (s.tcpi_rcv_delta)
 		assert(s.tcpi_rcv_delta <= total);
 
-	do_getsockopts(&s, fd, ret, ret);
+	do_getsockopts(&s, fd, total, total);
 
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
-- 
2.53.0

