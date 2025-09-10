Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F0311595
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494636; cv=none; b=eVgSAzJxsHxZbK9FeLFyueMU9qim6V8ZU0/+O8rWD5LuKVD41oE1tNcchOf9S8369zy02A/MTdjVVyuhwJOY1hQ8PChXxh3idUxSTGnBmfmUDlS4zT68lw4dckOcNSSj98Wj07ZD6KWXVDyNyMOlDt+B5VvZCbYqmpGYB0J2G9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494636; c=relaxed/simple;
	bh=wcEaEqIrH/Czf4DgAmYoxr3Tgw/CT+DhVSlXgbAAGT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gsIIy9y7Tre7RsxsYXhyCRH0JwFdk/bV1YuXJoPGbWhWiU4s6WnFaVKuHEM1ApIXz6SspQIJEzIB1vMzTXTdiYNm2B2Du9YihyvSl981KommXk3ip2hTygApz3GXF4Q38YkCWhpXFh1TotcYswbO/fXjz33eQKGfSeBGYifOEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvhWswIa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvhWswIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4EFC4CEFA;
	Wed, 10 Sep 2025 08:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757494635;
	bh=wcEaEqIrH/Czf4DgAmYoxr3Tgw/CT+DhVSlXgbAAGT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GvhWswIaVlhDJCozW5rbg2fT8QcZPCeinlnN97Qn9wXocZ3Fl9/6lrBpglyHSJXWd
	 dQFIv52iDIjAlYPYbTk5TvOf+4dCatFFSvtVr0ElGUgepBxUgZmB8/oVISNOHf4R35
	 FPZWyMsy6icaIDUDfqBbzwbiHZtUAGIVjLZ9Iw8F1T4kNmCelJV2TGifT14crfLeP0
	 /qg8kh/8sgRRcEsb6MiptOpzmqW+6fOeY2bW4BFDBMUEq7id4aM0bf6giwGWTQ1uIv
	 hF1tcuEg0sqAYrWb3Axx+s2bU7fdUF8REJtn6ztjfemRnXG/ASMsg4i5xdgBxPQBt7
	 E6NqJJZeX6zQw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 10 Sep 2025 10:55:48 +0200
Subject: [PATCH mptcp-net v3 2/5] selftests: mptcp: connect: catch IO
 errors on listen side
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-sft-mptcp-disc-err-v3-2-6799fa467d77@kernel.org>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
In-Reply-To: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wcEaEqIrH/Czf4DgAmYoxr3Tgw/CT+DhVSlXgbAAGT8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIO2qZ+ffk83KVoHt9Ms5mr3PyNd5a/ns37zPBBS9RCx
 WLhyCqRjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImIyjMyXDqw+FXtidCQla3h
 y/4q3V8YEsT+pdjsPF/Mx3D9vtuNaxgZNkyTOGvz9phfgYP0Oqej515pxmzXuLj+wnHxurbnXSt
 z+QA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

IO errors were correctly printed to stderr, and propagated up to the
main loop for the server side, but the returned value was ignored. As a
consequence, the program for the listener side was no longer exiting
with an error code in case of IO issues.

Because of that, some issues might not have been seen. But very likely,
most issues either had an effect on the client side, or the file
transfer was not the expected one, e.g. the connection got reset before
the end. Still, it is better to fix this.

The main consequence of this issue is the error that was reported by the
selftests: the received and sent files were different, and the MIB
counters were not printed. Also, when such errors happened during the
'disconnect' tests, the program tried to continue until the timeout.

Now when an IO error is detected, the program exits directly with an
error.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: close some FDs in case of errors (Geliang).
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4f07ac9fa207cb08a934582b98d688d0b9512f97..1408698df0999730d9a9a4ad6a6362a4ab122d54 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1093,6 +1093,7 @@ int main_loop_s(int listensock)
 	struct pollfd polls;
 	socklen_t salen;
 	int remotesock;
+	int err = 0;
 	int fd = 0;
 
 again:
@@ -1125,7 +1126,7 @@ int main_loop_s(int listensock)
 		SOCK_TEST_TCPULP(remotesock, 0);
 
 		memset(&winfo, 0, sizeof(winfo));
-		copyfd_io(fd, remotesock, 1, true, &winfo);
+		err = copyfd_io(fd, remotesock, 1, true, &winfo);
 	} else {
 		perror("accept");
 		return 1;
@@ -1134,10 +1135,10 @@ int main_loop_s(int listensock)
 	if (cfg_input)
 		close(fd);
 
-	if (--cfg_repeat > 0)
+	if (!err && --cfg_repeat > 0)
 		goto again;
 
-	return 0;
+	return err;
 }
 
 static void init_rng(void)

-- 
2.51.0

