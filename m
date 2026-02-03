Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427321B9FD
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113966; cv=none; b=N/bIyROp2NZG73WTs8eMMuFYQ6gVLc8sKeKaZmN0pRWtNV+mQl+g/7Px90ZEYIKM3A3VKh+i6+FZirwHRkWkAL8AF2nVj6r9OMwmvLMkEPbg2ns/VeifI5/y7jRdyfLs4ZCtwSSlETl3fg6kzgaKePDhThLXMylQAGGpXo9SxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113966; c=relaxed/simple;
	bh=YP9o68zmYp7nXVGJNVZtKDZZz0cV6rTSpFUCjtxKjc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9fyqQmsSFEiRMyaJjRDgcOEe/mzqzvxe5ZNZlDwJEJvatOagpXrCCizP8Bnf7p+mcwX+9maorTPVVbCW3kLHfhSfrOp/dD61bOg8tgB9f4nTSyZtre6N1MqGH3yUXtfXJaAT6HhMgAxEPQHJsryjxo563Ro6eOzAXm87mVpS+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYx7mQ4P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYx7mQ4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75358C19422;
	Tue,  3 Feb 2026 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113965;
	bh=YP9o68zmYp7nXVGJNVZtKDZZz0cV6rTSpFUCjtxKjc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYx7mQ4P64BCC/qHhgyd4lAEl1RPoq3i5UoJFcN55hH8A9xz8uZOSJIs4KcTEdCvN
	 rUqzS6+h+b1tSWsUzNmCdHUAYWvdmbq2bmbX8ryn7PPvIJ/eN9z5ZSSwLJ9hfs+BiY
	 E3IdKAxjTGu+6DH6go7yfoKZBy0Cg6rvhoR80/gQWYsiExLKDlHj9z6Z5W4vrmrmnc
	 eYxYJ7xYROI7IEzBEuikniNGjQiHVNJHqK8qTKxQ4dkM9XsZtCzvPQ/SKZZy4RtymQ
	 TG+y1RNwNHFQ5z1k7Ry5JjI0dd/YjLkBuLid1Jat32JgTzYWJ96Cfev2Cx7QmNZwwe
	 b0OYGSh5RiGow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] selftests: mptcp: connect: trigger splice_eof
Date: Tue,  3 Feb 2026 18:19:09 +0800
Message-ID: <626f90b0c80e0ef7773094a46a7d4e9809fc7d26.1770113743.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770113743.git.tanggeliang@kylinos.cn>
References: <cover.1770113743.git.tanggeliang@kylinos.cn>
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
2.52.0

