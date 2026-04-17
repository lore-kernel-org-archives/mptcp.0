Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22230AAD8
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469714; cv=none; b=ZiiCUd89q9f9v9Z1FCZOgLCy1z+MOpPrsz0tvO8ixAPrgAKvDZ+NxNjL+iIj01MhmyB05nOj7GOnVjbNraxMB+7JSCN7B/TLF8Ak50XtF7tl5RjBL+FGKz7uqIAegdO8zC7geOz0pOHGNWLoRt0UdN/d8U36RkY9LqVHD/VUtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469714; c=relaxed/simple;
	bh=J0NJGf88lWcWV1rrjAAaDmhfdWlaoFxKlanO6HSL9Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngH2GukemQHZyfZrxWmtgLWYND6q983oUoy3AqalBB5K+9OgAwGGBuQ2KYM3eVf4apuFjsV2ls+6vebIX5eTkpTxrCdxP4dZUw8pglSlFmi78oVB1E27xGY5nyBlVenkQ4hxgYAooifr0UnWln3BpGf4belX3yg+e+eK0hsFgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boHqck7T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boHqck7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76581C2BCB5;
	Fri, 17 Apr 2026 23:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776469714;
	bh=J0NJGf88lWcWV1rrjAAaDmhfdWlaoFxKlanO6HSL9Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=boHqck7T0V6jrVNIrzKwh2Pu+C+jPlIFzk+k7nvjX+xszc8QnhPEgiue2XEAC2qK5
	 YPF4OdOE8dIkLE9bedHRvBmwiZy3dAAxFcvs0XF59MCazl5FtzVxq2ynEFl/w79igN
	 b28CyaIxvigD6utsssrSUOp3pZhnL6flcI7wX16WNA9yH+3JqMgoyuj7RjDYKJ04py
	 4qZqmS9bePu68L8JajkPbJWV2eOpzGr50hJ3FMFKZAVXY+XfYm8DvUQvYqTuhOWNW8
	 XpO+FvcO1nI2oW0QGjKBpR+HwE0rG2IEz59ik3I+nBCo6BkR0NDRlftfmCB2TDiCwY
	 u+GaUMhwiqYvg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 09/15] selftests: mptcp: connect: use espintcp for ulp test
Date: Sat, 18 Apr 2026 07:47:48 +0800
Message-ID: <c9a366f3b916e8ee077d60eaa07c507861c75822.1776469069.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776469068.git.tanggeliang@kylinos.cn>
References: <cover.1776469068.git.tanggeliang@kylinos.cn>
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
2.51.0

