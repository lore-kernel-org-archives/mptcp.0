Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A31F1A38D6
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517248; cv=none; b=h4BK8VJ1K6ekAj06UN41hJ/J3YG5OfXdjY7azkrsQQWZy0fdcmfTZzDULic601WTTX/t9vpRgJ8h3eBPHZAvea30B2fg4nYDT17SBzkGk8lLBCFiovEW0L8QrPrnEvsEb3oQY61e8sx8h2thLjfGBJFTz+P2pKL2C0cFExwNe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517248; c=relaxed/simple;
	bh=l4jFlCCeEzs8Y5dd2oZ7tUXWy23a0vggfwsGRAsWjew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vdh/G975JfX1KjFGM0Phqtjknuo+wOUxpyEorWzPtyk+NAMLcH66TWw9XNZnLGzBkzlqt5yK3exU9VGmz3YNEoUwL7y8TuEnIxZJHLsSQrhkniLNFL3dTiloD1coCfScw1Z/sTas+GcX3KmkWHja4eZ2SjWFC9D+ycqaEhz/8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYYYrbKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYYYrbKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E015FC4AF0A;
	Thu,  1 Aug 2024 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517247;
	bh=l4jFlCCeEzs8Y5dd2oZ7tUXWy23a0vggfwsGRAsWjew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYYYrbKCTNQ+sxBGBL7W0TjETh/nG0bc6LA9TZl8aAQ23WOGcEHtc8YxBWOrtClsW
	 ymyJ1F8p0uIwZvATsnD1RsNyFq0aMYLAsuINjUA0rDQKJrOwHOyfYkFIYGjQsC1Lhh
	 RyxEEwyY1CrbQmAwe8pl2dLM2V1dNh8I5M2iiP9vzFH3OOtVwzEhAunQoqXmxNMpkF
	 0+MHeVO9x8sNPzOWgD/nXgVjYoY8N+Na7niSYANKFK3WzAVdFkWnNbZrMTSbglfPI3
	 rq07iLrBRWuLV4IPZZyar6MO3JBMb+SqfGdpY6v2HSsPfWBfKwmwG8+ueXC0+tqgxm
	 1WvV/NGSsQSMQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Thu,  1 Aug 2024 21:00:38 +0800
Message-ID: <04029c9ad203025fe4b97547afa88a2f3b53e60b.1722517019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722517019.git.tanggeliang@kylinos.cn>
References: <cover.1722517019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop CHECK() since sched_init() may fail.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 91bad33b0c72..63722412f847 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -546,7 +546,7 @@ static void test_bpf_sched(struct bpf_object *obj, char *sched,
 		return;
 
 	nstoken = sched_init("subflow", strcat(bpf_sched, sched));
-	if (CHECK(!nstoken, sched, "sched_init: %d\n", errno))
+	if (!nstoken)
 		goto fail;
 
 	send_data_and_verify(sched, addr1, addr2);
-- 
2.43.0

