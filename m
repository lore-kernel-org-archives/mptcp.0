Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9733EB7F0
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459655; cv=none; b=TSX+Qd32IAiDg41w6ZggkELQlxVVfasb/gaIqLDuydnZr9BkUm4cbHIO6MxJDx6RcRVwusuSc3B4J1XYoBHqYPa4mDlq13XjuqFkLU4SDDA4dkWeYa6E27kTCUde0jufxbdplHybGUzzE0TQTVhxc7gNR8kgrueQRW6tciAzL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459655; c=relaxed/simple;
	bh=EoSZLrxJrEfv4uRyfcT0i/5aFTWIAohjf1lCqM6vMV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzcQdaMU2EUmiXK+95z/EGNbivFblfMXWIXkk4FlG8cUbbesFwkn3CD37igJo9/8R/q/Vn2gdkCIBnO1kVDGdDpwz2w1W/MCuOQG3u+id1ux/eThHcjPDymA2eJfm43YyoJ34WHx2oEF8CRXFymq0KnffEYn+Mdjwbeb1WnIaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPUP6lOl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPUP6lOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7772AC19425;
	Wed, 29 Apr 2026 10:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777459655;
	bh=EoSZLrxJrEfv4uRyfcT0i/5aFTWIAohjf1lCqM6vMV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gPUP6lOlpYxsKj6cYjqDG7FjpOFFm9GpmWAmFSZ1+qxAaHsCJdDw60pSv4f7fOONe
	 +Vrug5sJQLoBNt0KFLe4Arqhr1ldcPNSxLZEIH8dogVgTKCjHF/6/KoV4L5MYQjBb2
	 qsG2HYbjCzEziwv9J8OLAQVf/RYJ8+pxEMxrf5Y6FkKeCKszcZpmO42PI+Ewk0+7aE
	 a++JIDNePXDJpQ9KGvl2ZR1dPJTR1ziys+KWF9YN2M7UuIH7NyvQX/HPvGK/vMBAFG
	 iuNxKLGOUkRi4iQVEVuZ8nCyvvOd6xalzCBTXFZ6DAjDClmfQXTOYFrt1cPScUz5Zx
	 U0uy0OK3bQj+w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v18 09/15] selftests: mptcp: connect: use espintcp for ulp test
Date: Wed, 29 Apr 2026 18:44:57 +0800
Message-ID: <fb9bc2d625108add672540f5851b27a3566eec77.1777459066.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777459066.git.tanggeliang@kylinos.cn>
References: <cover.1777459066.git.tanggeliang@kylinos.cn>
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

