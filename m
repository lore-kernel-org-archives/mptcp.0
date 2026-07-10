Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7793955FF
	for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673972; cv=none; b=Y62pR7twadrOHL1vrOlG70LNB4K+QqnqfjgLFHyKT6c1KmDzZJyO7glwMbUpdGZu8nPawvl41IKSZZOR7+0fzvoaX3cm3B15qTdyYeuErNJy721Qn/DlWK1qwb7fPqVObhrrS4huo9JwAjr/lEDrwY9pa/80VGeFu0gJp+QtF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673972; c=relaxed/simple;
	bh=gmQFuLF9lzlCjEWNU+AnHKEPuP5eUg6FhsiW1qSxGP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ1a4jL7Fk+WGMQixcDehwX0nPxkZusMkBT/hEtwM0FHVD8J2fijnk3OmnmoM2bn8M+B3IkzM4SDsGeXxNwPbcwJGG98sELVwJnetSacp/HPfqiJ1tESebxQPG6PYWZTB23Tdnr52fygqRDlETJvKvNxz37VA4QdWmVmwF0goF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7Jmh/Sa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7Jmh/Sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052AC1F00A3D;
	Fri, 10 Jul 2026 08:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783673971;
	bh=DmTdwy28o8ZtWle8pHfQ5SfBwAS9OvDLYZe/HQpUarY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7Jmh/SaBRHZf7+RenRAJhrYlpSLsi3Lmesq3+x+Ojih5bSoqa3ViJfN+KOMsGu2O
	 iXb5L09Mvmo2xO04/u16DE6Br/ShKpbmAkS6gDDCVBPQn4Gxyx922IEDEWD4wEFPCR
	 r7qc6qY3J+JOuEYKX10ZOWIFSEmqIkKSMc8b6lguY0T2ZkVAFRhtnE9io+v6UJc0Ty
	 cLklmLiRBB9iWvqLNJA9l+QqzoYm1y+35g7K+MRf+6yRa1/w9b8SG9YaewBjGOpQ74
	 k/KESG5HKLyNy+UDg4VBF01v7dkNVHw4qBceSQHp3lhB+T4QB70hz5IvAm4xbG45Ok
	 XNRWvRa02i/Nw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 05/10] selftests: mptcp: sockopt: set FIONREAD ioctl
Date: Fri, 10 Jul 2026 16:59:08 +0800
Message-ID: <0352c75d470f56b98bbef33e270ac5dd789a91b5.1783673158.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783673158.git.tanggeliang@kylinos.cn>
References: <cover.1783673158.git.tanggeliang@kylinos.cn>
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
index 5b6408f92fd6..0bd5a9c51332 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -20,6 +20,7 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/ioctl.h>
 
 #include <netdb.h>
 #include <netinet/in.h>
@@ -687,6 +688,24 @@ static void process_one_client(int fd, int unixfd)
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

