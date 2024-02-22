Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443C28EF
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573263; cv=none; b=WN+4q4ce4spg85mk/NaNl0LI+KB9GHneE1qsr1Ht1SfeAgqurux+yxKZP7YCxjV8ZhR51Oie+cFE/iy+6QDpmWjk8AKHvSUeYz434dRtrIcuHjZIE6MnxN09X3SnR3Uo2d/EIQUv0xiyRgBEaEhXjLpVqqxhbzDWVoRyXTskBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573263; c=relaxed/simple;
	bh=2Ziz4GxdXaBA8SvNT8LKVv/bOei7SGEgH2pOCTqXEJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ME/SG7XFWFLZwfqWOXAXJ+N6Vot20cEvU2VNzTo72Ce1hrsJ5X0/gAa+rFetelXzjMITyVr4YzNkJPY+hYRb4PbjheawdZuogSwKhh2/T5checon27fTg8MXAK73UZEfIDWX6t1yUsckZeWTq7i9eoieZCOh/LxGjvPNBlOEhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ayf4kmd3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ayf4kmd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41F7C43390;
	Thu, 22 Feb 2024 03:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708573262;
	bh=2Ziz4GxdXaBA8SvNT8LKVv/bOei7SGEgH2pOCTqXEJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ayf4kmd37AZcdKeY9ePGZBLiFdl8QF/NaySmonRZCdiN4yxH23ejaepTWc/vuQ9Zn
	 iS9rElseE+KiXp7rzp+RfYhcveO8k7nxOjO7/FGGGjVupuAGdNgjtGXNxABDX4gEg5
	 3FdM9Wftajj2A2au7tbKL1UvC725hibmtBGju/+hrmb7IIwmje5hKvGS3BqUuIZAzR
	 CdTouuy00qdTP5v9hAxgHojyzad9DhO8u/YonIpHtVAwpgiupK3g0Kd3QbzV1X34w4
	 Bkr+uhYwG8Z4QMDwNzvJxo1Sn61Ie8C6aZPDKo96CYb0IQJlCUaPKPhiROtKvs2+V3
	 J54ix0yigo+kg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/4] selftests: mptcp: add local variables rndh
Date: Thu, 22 Feb 2024 11:40:33 +0800
Message-Id: <7745872ec10f1db522ce3b48ee989a1367b94469.1708572320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708572320.git.tanggeliang@kylinos.cn>
References: <cover.1708572320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds local variables rndh in do_transfer() functions both in
mptcp_connect.sh and simult_flows.sh, setting it with ${ns1:4}, not the
global variable rndh. The global one is hidden in the next commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index ea52110c3fbc..b609649311f6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -348,6 +348,7 @@ do_transfer()
 
 	if $capture; then
 		local capuser
+		local rndh="${connector_ns:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 7d8388ecc966..8a4520f29601 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -139,6 +139,7 @@ do_transfer()
 
 	if $capture; then
 		local capuser
+		local rndh="${ns1:4}"
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else
-- 
2.40.1

