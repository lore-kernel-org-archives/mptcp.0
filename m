Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943C4A923
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 04:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797685; cv=none; b=R5tlgmcHKzjVTKzBYJGnhXlQh1E98b0/usziGolL4I78LGpv3bRfidwoKiUdQUxeXWbVogvPsPxQFUSbz9j3f7uwvlVNaEDnfP/LctPUqmgc2JfebZW09fq/DtLly795e2tiQS18SAHsZHcgUGc5z/XbysFtYEJb3RHw8bEWWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797685; c=relaxed/simple;
	bh=84fXeDK2G++UAFMzoReGrvk1kvOjoUOCpZB2wpd8Za8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0WfD8SG1mMIGMO4LqyCU75J0BQr/guVB2S6oqsk3f9d9OLFIYWKeSuM56ZMNtNvjT5NhRnCsxPXFYHzhmioj8m1Ih6aYx0Avg8E3STcMKWeBRvAap0l2rvkIB/K0h7BI8+6iS2g/IkOEnCAqTTZXHKkxO2jNN++cFq0ip/9KVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWUSjSUW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWUSjSUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2291C433C7;
	Tue, 13 Feb 2024 04:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707797685;
	bh=84fXeDK2G++UAFMzoReGrvk1kvOjoUOCpZB2wpd8Za8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWUSjSUWyjEbKm0DBo063kAaQ14zKWsmHwQGr2E9H2Om4v6Otupv94JsBoIl0GZ0o
	 efg7EjP65qdhXM7jhfFImcNGAbn0fUo3g7yoyvmNQkvmwDevoRJRIEpctPRHb51Y9F
	 N54QuElUpYiwE3DD4Eg2aT07bRS6hyj6keWDab1A+08T6pc6P8qSfNSB9b3/TkOg34
	 P4wKOmov8piH2mqga1oeIFBZylfN6XdC3itQhjKztKTmxKYd2v5z8syhx50u1QWKpx
	 7dQIRGmC98W5GB0LPaO3xOajov3qKXAvnRycz3OzIQhEoGnCqglPeEUTNQO7xZXlI/
	 dkO+x+N4g2aIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 5/5] selftests: mptcp: diag: change timeout_poll to 30
Date: Tue, 13 Feb 2024 12:14:28 +0800
Message-Id: <874a6cca73e30babfaa5f6036a929314bf1a689c.1707797566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707797566.git.tanggeliang@kylinos.cn>
References: <cover.1707797566.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In most scripts timeout_poll is defined to 30, but in diag.sh,
it's 100. To maintain consistency with other scripts, this patch
changes it to 30.

Fixes: 5888a61cb4e0 ("selftests: mptcp: launch mptcp_connect with timeout")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 04fcb8a077c9..3505c98be127 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -8,7 +8,7 @@ rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
 ksft_skip=4
 test_cnt=1
-timeout_poll=100
+timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
 
-- 
2.40.1

