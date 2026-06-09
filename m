Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC430E0FB
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969059; cv=none; b=LUFzqSxrhCi64E07IK4X9MI3XORClKxhWnA5BP7ZXPSfYBojypVDIVbsHbAnLF7x2Vw4ycCabYxaE1C9czPoYRZoVZOLL77+PgWza2spkLOo/Lf6p3VZjK5Cvvhwh/zFjCVfae6Q7io11B50QPKEmdRcBdH6OEBshJTIEXTYta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969059; c=relaxed/simple;
	bh=vaYh/Yi2WdDOanWChnysIFBA2bQgWvMHXk3OY3+Tf2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnv+XLccl2UK750Q6bxnUhAtd7MZFlJ8wRirxDD1Wq+0FMK6jC59OUiV44/4B6j3JsGq+kKoxqrYqUldu6dErfLNyU0yOGo2EGnVH42gvYWT7hn9J2SRutwC+NiPvBggaxmvBbPgYewpf39xUkd5fAG/5L3RkZ/GONYrMjG8HBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8gomNP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8gomNP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BCC1F00893;
	Tue,  9 Jun 2026 01:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780969058;
	bh=/rnU9T6HJ1icZ2IcvgrSXKrWVGbYCPsTU0xoDLhVApo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R8gomNP2HTfEtDZjCAbN1UUomYjiGcK/5oLWMSnLRLjU4Yj7C5S0KXvNLNVKnA2lF
	 6CfO4ipFdZYLIXaUknb9O1ETIek30QJxL5kB314SSgDFWKaH4tc2kJ8Wg0FcbIc3TC
	 bPRF3zk0/2KqExjLgD8RhmAUUXwH8yw1+X6aXKpknmwIP7rC4YuEmrJEg70OuPXlcy
	 k7EneUssH/NogToStFWe1u096PxCLQ/BX0wj1IVffE8pBZ2wa+tWquPW6Mn3WdzQIM
	 qMUa9Myau9DeBriLS3Wla/c8H7ldsdJJXOEGXon5N9xotZMS+HxyIitGeQPMTM4Mm9
	 TtQRqGJtrdDMQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/2] selftests: mptcp: connect: trigger splice_eof
Date: Tue,  9 Jun 2026 09:37:23 +0800
Message-ID: <de25d827050a2bb1b6c305353b1a5b81e42e5fc1.1780968872.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780968872.git.tanggeliang@kylinos.cn>
References: <cover.1780968872.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Increase the sendfile count by one to ensure the transmission size
exceeds the actual data length. This triggers the splice_eof path
in the kernel, allowing the newly implemented MPTCP splice_eof
interface to be exercised during testing.

The change from 'count' to 'count + 1' forces the sendfile operation
to attempt sending one more byte than available, which activates the
end-of-file handling in the splicing logic and ensures coverage of
the related MPTCP code paths.

Additionally, handle cases where sendfile returns 0 (no more data)
or a value larger than the remaining count (e.g., due to concurrent
file growth). In such cases, break out of the loop to prevent
unsigned integer underflow and potential infinite loop.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..f6a4dd5597df 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -870,12 +870,15 @@ static int do_sendfile(int infd, int outfd, unsigned int count,
 	while (count > 0) {
 		ssize_t r;
 
-		r = sendfile(outfd, infd, NULL, count);
+		r = sendfile(outfd, infd, NULL, count + 1);
 		if (r < 0) {
 			perror("sendfile");
 			return 3;
 		}
 
+		if (r == 0 || r > count)
+			break;
+
 		count -= r;
 	}
 
-- 
2.43.0

