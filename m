Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BC2C08CB
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024128; cv=none; b=GjYjAV9sgz6+s7Ydd3ufaaspdfnO2le6FnbswB4S342CxMW/zPULUVSzMn5XGUFxiYkyq8JXSy7Vftw0zjJgfEx2IgBczwXbXyvsBpKBDhYYbupXqvs7SbWcHrMCWcdXohsmbpwNh6eFRn92779u7J4BejVgo5R2vR9H3NZGCs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024128; c=relaxed/simple;
	bh=KC4MGsPWkiBp8BGG77e1H1vx/zbo96/a8rSkzeLjFX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abiNoxS9BoCib5VWtmzLFTKw1/RrCLWSXSenaFHgUQpGDEC9siGSymX3ir19zRvGlbj5gkEMe2y9lTM+X+Gl1+K0ihUsMZtUfbdhYJZ269XzmQTHLhWg1tpCKLgQoR3bMZrsNdWlyb1TtimHCkdAvTDvsdQdGrjDDxGrqgc0amQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVdrSZYz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVdrSZYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD01C116D0;
	Mon,  2 Feb 2026 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770024128;
	bh=KC4MGsPWkiBp8BGG77e1H1vx/zbo96/a8rSkzeLjFX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVdrSZYz7iZ9Jr7oX4TzxGpFG6S+xgZYLGZN14heLBiX2RaCXQ+9COvjR0EkrM/P/
	 1Px2T3FeG8TzhjPawYTsH3LfZCpXeyP+Wr7CaRcsXsGLYUg5fvck+qYJLrmmvHtMCC
	 OhCHlH/QIFrsRk8pkx6qDT41Hz1uSXTk/7ubPkSwGOwKGQBipJYb6OB+5rXcHCSnT7
	 WiJeq3iw77BiGs08sDQ8H9g+G/zegQE6aH1RwchFUf+6d0fRzwrblwK3sIjTl3etmN
	 0Jd3AGdYIXE3nAwmzsK01W53quvZjNTkLLdDKprEymoof0AIHCFxzFuAVlHcZJcVXX
	 4uHbFIY8PXd0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: connect: trigger splice_eof
Date: Mon,  2 Feb 2026 17:21:51 +0800
Message-ID: <467dfcbcd3e11849c507db5360c3a394c3d117a5.1770023932.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770023932.git.tanggeliang@kylinos.cn>
References: <cover.1770023932.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..2aaf3ed11315 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -870,7 +870,7 @@ static int do_sendfile(int infd, int outfd, unsigned int count,
 	while (count > 0) {
 		ssize_t r;
 
-		r = sendfile(outfd, infd, NULL, count);
+		r = sendfile(outfd, infd, NULL, count + 1);
 		if (r < 0) {
 			perror("sendfile");
 			return 3;
-- 
2.51.0

