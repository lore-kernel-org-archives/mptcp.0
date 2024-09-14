Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8510E9
	for <mptcp@lists.linux.dev>; Sat, 14 Sep 2024 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304383; cv=none; b=m+DphPbs737w9EcN/D7dayjL6kJrSTU8PTEIwcN6GugpmZsunxvuDetiPYFFwY6hypNrDb7dorEwh+4ry6xQrStTt7LrOu0ZDAoKymVscV1ww4Xs6VDPAy4SVWPaUZ1LqYiby0car6rudUityFYPpxB1u/ycJZdnfcFgPWX6D2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304383; c=relaxed/simple;
	bh=8eAH8GdWYHEniV9aWy6BqxIJ30yhNPjm4jN4t5U4nNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhvfQIaT7F1Nz/3zcaAABW6Ff6vW5dYl0I+XrGWmFP5SLf5BMayQWZyy5cusnza42QK13OKjM7iVQMW6Lb5TI54MkCj7LlSdo8cmVlusskh5WDClA7UJGtTSRUI27ArScguixR2YAx+Y9eIA8R+sya/nqsYMWY+Pbkl0NEPkIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCsFQ9bV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCsFQ9bV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFA5C4CEC0;
	Sat, 14 Sep 2024 08:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726304382;
	bh=8eAH8GdWYHEniV9aWy6BqxIJ30yhNPjm4jN4t5U4nNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCsFQ9bVSNeZJf6oxE1DBVh9GaNEDCVVEWWe+R5bpLWCgB7sH+RDlV8Q1BjkyfB+o
	 knY1kke+seKp+fRvCTUrC6qaqWWbJ0Bpw+nSbaDXsF3BgTEJW6M5R1+ZG2MvxD73o/
	 2o+g3GbP8KWtTvZe/D0v4KsmJgdILo1n6xP40LeD7+gddtghPqOHw6OrOhXRxziH1u
	 4sjpTuPtmxuI2Xtcv21oEwejE6vyBpwGQmq1kQc1bwDy/iZFSOhfyEEPJ7BX7sYese
	 uJ9DMJ+zZNL8aHLyEb+QvrTjvQzE/WiiW2aAbU8fpFFrdtuSn6r0Glx4c/vtA7yfAX
	 ziGFX/Qs49J3w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/4] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Sat, 14 Sep 2024 16:59:30 +0800
Message-ID: <0f54ae688bd765cddee573c62657673071f57c5f.1726304196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726304196.git.tanggeliang@kylinos.cn>
References: <cover.1726304196.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update endpoint_init() in sched_init().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f4715b1692df..04146184e45a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -492,7 +492,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
-- 
2.43.0

