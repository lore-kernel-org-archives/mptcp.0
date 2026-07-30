Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C63380FEB
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381337; cv=none; b=JJ5wDE46Zwbb5MYD9LTrm6rYyGIQmgKKfwaXak4Y7hvFtRUGWWnIk8469T6MuPn7VHaZOKE6qEcWkVMmSAgGp6ITrYJKPFwLsDf6sfDTN2RtZx9TYVFaku9Av/w7FWMxIUdyMvyQTp3QVqzDOjucFQQj3KyPTspi1wR0vofq1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381337; c=relaxed/simple;
	bh=+7WgKNSlrugYDiZ5+80t0H5Hlr3KXOlbLNCsPwqHfYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oz5hq+5Nh9AVBlUDu3GYuxl2S/YoLvOpIZTDKVZ8/dmphsZz5eV68hQ++tlySVOSp/hldCBCKduiAyewUbFgmjBJioP4mpnFwujNxxb6Uua6LdWynA0W6TF+54a1dsk1enWFMaIzyW0RlDhC15eW1U/CLLTrosuDDrL8PlWHAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRfjLvIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRfjLvIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D83D1F000E9;
	Thu, 30 Jul 2026 03:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785381335;
	bh=xLhJCXWMpWarH0jIkywBa5ypIEKygvKthsKGETUyyZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TRfjLvIjqflGTtcnD+ZnvNlolyE2CsnKFnpH9HGITuhcW/+eck2lll2lrrqfiYK/9
	 l7iWtco1ooIrxGbZAweJ34KnNhKt67owCFTAeGg3BCzkqzvLjDbhmTT37BNZl/Fdzu
	 BlOaeQfl5LED4pZc3SJLg8omvvWkV+82xcllJr4cIz6irv2ztNM/2Ra/WjMnn92lVS
	 9WtYT8J69VJe2+E0fGz5HvxT5x8odDl2Ny0q05EGt1r2Jk0+7f5qVoNA0SNfCMmYLT
	 Lcz5Vi94LnQCIK+bcCzfK8Dr3pPLvenwN4A4QY4q9WIxiHQH0gB/ZcEDTDR44cbVyA
	 5+vkYnQ1w0TVA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 02/12] selftests: mptcp: sockopt: use exact length in connect_one_server
Date: Thu, 30 Jul 2026 11:15:13 +0800
Message-ID: <6ec4570fb7b73f92905ef38beb414a4a7709e0a4.1785380422.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785380422.git.tanggeliang@kylinos.cn>
References: <cover.1785380422.git.tanggeliang@kylinos.cn>
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
index 6c3d896d4a1b..469384823dc6 100644
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

