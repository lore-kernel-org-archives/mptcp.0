Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F302F39B5
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850104; cv=none; b=JW31Jcwt7Jic5tQcDx5TWGoXzk+KI1CJt8nThLBQimlN3sM+yKtmt7aGVEZxksgGqTk1Br2VlOI6CBU2Ds4K1g54fBovV1mYX1I45asy7v8Qfx+N03rl9uSnisJ0FGGICdYTUKsejMBWIqsF6DmUiIpZkDdqL2igRjJ3NsFFdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850104; c=relaxed/simple;
	bh=vAHzquK1/9RiobeAb1B1mcpgQOpilNa0CSznpUpptn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ3k3M3n+uD+JUIHtn9DRIG7rmMYir13vVF3Dh8p+G3kHCDhQHjOA4Xfd9WBXHxc9J+yiJp/9oXOXEmxJjd0GWtnwaIL8ZHBELuPrFfQjqy0lVPZ00tqbDyxiQV9AmlyqX76PxRsmveCvGYWT7XIDzPftgYIqi7tOhyDF4Ztc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6w9fU2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6w9fU2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573F01F00A3A;
	Sun, 12 Jul 2026 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850103;
	bh=ezgykU1fYbc26AkgsqIVEMYQH/yT7CapDrWSqxVSm2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m6w9fU2F/BpV2Jxm7pjkzfFvFRITIAMK9X9I+gaSNlVFEjmxpaQGigdfWP9aW4K56
	 9RXTYGD9VdKcFDA4SLzMYo3/ZWBcy168vqAvotgd+COmjqSo/m1HwqgqKhHOKu29ce
	 yAFzHh74Py+xJd4hmgQcpqINnbeRDPBWN5UuSf0exPtiyBJa1pi7+BNc2l9UFq689u
	 mHIVupgmm4slCxk5Ehso0pugHdW340oPZPL0zl4erVlt0S1EUaipwQXZBxJ9xHYLdQ
	 9BuvbFqNEzJkswIeEuOON9xmuqtC8x8Kf14UiIJVncpCbItMCUcedeZioYJEXQQr7r
	 3nohlDebP1Wfw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 10/15] selftests: mptcp: sockopt: set FIONREAD ioctl
Date: Sun, 12 Jul 2026 17:54:16 +0800
Message-ID: <6eeeda460ce7c4cfcc84e51d969f84a76da16379.1783849522.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement FIONREAD ioctl checks to validate available data size, ensuring
synchronization between write and read operations with non-blocking waits.

These codes are from mptcp_inq.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 610e3af040c3..165ff2c884c4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/random.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -690,6 +691,24 @@ static void process_one_client(int fd, int unixfd)
 	if (expect_len > sizeof(buf))
 		xerror("expect len %zu exceeds buffer size", expect_len);
 
+	for (;;) {
+		struct timespec req;
+		unsigned int queued;
+
+		ret = ioctl(fd, FIONREAD, &queued);
+		if (ret < 0)
+			die_perror("FIONREAD");
+		if (queued > expect_len)
+			xerror("FIONREAD returned %u, but only %zu expected\n",
+			       queued, expect_len);
+		if (queued == expect_len)
+			break;
+
+		req.tv_sec = 0;
+		req.tv_nsec = 1000 * 1000ul;
+		nanosleep(&req, NULL);
+	}
+
 	ret = read(fd, buf, sizeof(buf));
 	if (ret < 0)
 		die_perror("read");
-- 
2.53.0

