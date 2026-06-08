Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76633AC0CD
	for <mptcp@lists.linux.dev>; Mon,  8 Jun 2026 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910137; cv=none; b=nbcqQC0R538VhDPSTeXTQCHwsp4fqOofMzpk2K/Z72fH/kVj63WOkt6JY5Y2gVbBcHhx8xSG0F1MuHseIOquTbxzbQEoNDKRCNZn+YXNjNms99Ra/udYC8TAFmS6bIHafr2K0pO3u/m/eWn8T+nJy8uVxF9Vgb9WitLZ3BX3yH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910137; c=relaxed/simple;
	bh=mgvEuIWlBts6Hcx7SGMwotvJ4fiDwlYq8LdEP0KaA9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgfDBMLZ7MRkpo7guHRuZu7FHmyCbN7GkSuAKMyPj5ea6HKU1iDkmEMtwnYCr1XkU5jRNSN9MPfTSZUQbJ1Bo+cmZoKAWnyGLg+XLGu8yBDY8ujo/Nb1AX9aavkKUrS3LV7yve86Vb9WeJUxD4pUhJFZv/KUJUh1qVPTE9bYAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSSpmC7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSSpmC7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C20E1F00893;
	Mon,  8 Jun 2026 09:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780910136;
	bh=xvscQjNsJhJZhocSo+zLo0oD+zPnGsM+dqM1mt8uuS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cSSpmC7Q4QWtRTvHxkId0uhXXLtq6rc05GAAnxQbXITL3GggAlk2lU+H1trN5s17T
	 UC0dWWtGVJ3OynOJpggEoJbGYB8bkv+5OuhCHBIkRYMLiauSn2CqaN2VUOmaG361Zy
	 DyB51NHeI8df5Phv0F640N7SbpEYKBm8c4yqgoFGAbwhH8i8VM40cEEfCsoWV3Cc7Z
	 mWjfghzbUEcFdD2SR0AO8BJbfCQtFHXQpJbhD8y9UZKzXMbrMpaRJdkeBpzf0VVO8b
	 /UI6kZzTi3swvNk/entl9FsgixtgJ/v3MOKudJqFKKsFBpU4TYqPPT/LOjxH00CGy1
	 htc8gQMdGL0qw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] selftests: mptcp: connect: trigger splice_eof
Date: Mon,  8 Jun 2026 17:15:21 +0800
Message-ID: <58c1d20bb60fd83e6b999f306d4ca4070b22d3a4.1780909894.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780909894.git.tanggeliang@kylinos.cn>
References: <cover.1780909894.git.tanggeliang@kylinos.cn>
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
2.43.0

