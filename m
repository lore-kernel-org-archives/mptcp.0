Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC4373BEE
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850094; cv=none; b=jXyY5Z9a5tAsQ3QRHxU/sLJNwNqINMTaE838PeUrdoSMc3/vLkVhO6176hiUkLAIXAACBStJPevddQIk6EM3PLpIaluMvFrgHXVvgnMuD4qDXwU1nOdcAgmuIq6a20nv3/Ug6jo2Am0fEOcCPaBFv8Pn3JPSOku979DH4/4JUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850094; c=relaxed/simple;
	bh=r/iZBjr9j4falp+c+F8ZiqsszqQHQ2ZM1C1E1ek5gFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKYAQMgugDx56UofYYeBeEkEBHNx114mgZb7dd3AN4S+7zmxchjb5fVGTONuS8WjnvIEfByYfqRkhLXDVJg3//uFQx1R+Bc4IH87kobuVCDNjO3hLpFbFrOUj6k2E+hlPA2TKTo2InzpxB3mX3JUntPPQoYnNpS6GXhpZDUQQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciR2sf4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciR2sf4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3C61F00A3A;
	Sun, 12 Jul 2026 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850093;
	bh=vN9QUt0K3Ohrp+2UiVzxxGuyjGPwnF946W0GNQhwUY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ciR2sf4T+ccF8DJGc7ZT9CwohV7JereUwFkQxqFSgFTLrPIF7YTMGgNBdFvBHZzky
	 6eT1JeRcQ+nbCS/0Hr/hZMsbhZJ2P5fhbgkDoOu+sHJ9J6yuFZNt767irXhpzVCCNa
	 ahamg/vJqD5B0aGXCO3pYUDwFTzUsroMZQUjD7RbRYQhrPkt4gnZN5um8ifRgwtwng
	 GghKrGeMeumQ+vRRvoHAKK9BCAT1XLAwLSRx0nknKUJ1unZSbT8Ob4zcOLIdnT1pcu
	 D689/BJVDxehD0uxoRTn4jtMfmKHIvQ2nay+Tqh1nb4quSeUTvEQuoGt5vS0rxx/Pc
	 NFJJGYWKPJirw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v8 01/15] selftests: mptcp: sockopt: validate bytes_acked against sent bytes
Date: Sun, 12 Jul 2026 17:54:07 +0800
Message-ID: <ec96d11a8710b9b8cff8b04b1835f078573c81a9.1783849522.git.tanggeliang@kylinos.cn>
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

mptcpi_bytes_acked tracks the number of bytes sent and acknowledged,
so it should be compared with the amount of data written (ret2), not
the amount read (ret). This corrects a logical error in the test
validation.

Fixes: b86418beade1 ("selftests: mptcp: sockopt: fix error messages")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..d4ad03ed64ef 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -683,11 +683,11 @@ static void process_one_client(int fd, int pipefd)
 			       ", diff %" PRId64,
 			       s.last_sample.mptcpi_bytes_received, ret,
 			       s.last_sample.mptcpi_bytes_received - ret);
-		if (s.last_sample.mptcpi_bytes_acked != ret)
+		if (s.last_sample.mptcpi_bytes_acked != ret2)
 			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
 			       ", diff %" PRId64,
-			       s.last_sample.mptcpi_bytes_acked, ret,
-			       s.last_sample.mptcpi_bytes_acked - ret);
+			       s.last_sample.mptcpi_bytes_acked, ret2,
+			       s.last_sample.mptcpi_bytes_acked - ret2);
 	}
 
 	close(fd);
-- 
2.53.0

