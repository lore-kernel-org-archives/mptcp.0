Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557D535CF
	for <mptcp@lists.linux.dev>; Mon,  8 Apr 2024 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572026; cv=none; b=nwYgMWEFKvDFNuxr/eDPvJyZlZ+Av6cUK/7U895EvQnuOAYHTHP/fsxFfgMkcWcxnDN07DzejQZlLtesKXY8f1aN6WVkKDv/NYusE9V6TDsKyS7IN2f59vlox54oC1d4ViwCn+j8S89yhHI4/An3FXH/CgpbFdeehW1w688/o88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572026; c=relaxed/simple;
	bh=zl2nXRT/LMtrPeqXAuWkUD4Fho/ITH+xADgeYk181Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urkhBV0I1IDwjQgvI0i1jnCB+DXxvtf+PwjwDgZLaZIas8C6HxQ/JV9B8nXNwcHgJx3Pl8u3BFY2AOSpQdf5V2bl+VOORuJHC1sir1rT02W9mqrhtp/FfKUstTjnEcqJk7OVIcQ85nI0H0bGwcX8Hcm8NyhMoiPyfLJxfCPueYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUlZDA1p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUlZDA1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FC2C433C7;
	Mon,  8 Apr 2024 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712572026;
	bh=zl2nXRT/LMtrPeqXAuWkUD4Fho/ITH+xADgeYk181Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUlZDA1pffuvZCBElCcFi6fWEruk9NhRNZCWj4AWecYTC2NhNoAAXJQCApxCyrOL5
	 XKo7ZpuHMy8Y6RWZYNG5dArqC1Mci0C9DXD89ybGZf2BpiqYFCDnyHt/emfouLQ0/c
	 0bZtpalDHazn/6oLBAPdYDfJ/b8BfRN+Nh3W2iZUYYUxfAxZdfSsF2+6aJ2wR91ZVd
	 nX7Ag/BwY9RILH73Xn5R8ZVsGrCA5JXY9yro7Mf0HsPiQa22RXp/sLFS0XILtRu7hb
	 mtpt/i3g75f1D9iFIchn9dB4/iTtLDAKdoJ9WTvVENgFNzAXnhtR5CrS13RwGZL0Bt
	 WnN0kUjWUnZeA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 4/5] selftests/bpf: Handle SIGINT when creating netns
Date: Mon,  8 Apr 2024 18:26:51 +0800
Message-Id: <b669d09a90c2d6550f32b777c1cac234bda50998.1712571740.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712571740.git.tanggeliang@kylinos.cn>
References: <cover.1712571740.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's necessary to delete netns during the MPTCP bpf tests interrupt,
otherwise the next tests run will fail due to unable to create netns.

This patch adds a new SIGINT handle sig_int, and deletes NS_TEST in it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 8e44ac8420e3..e7e256a233db 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -76,11 +76,18 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static void sig_int(int sig)
+{
+	signal(sig, SIG_IGN);
+	SYS_NOFAIL("ip netns del %s", NS_TEST);
+}
+
 static struct nstoken *create_netns(void)
 {
 	SYS(fail, "ip netns add %s", NS_TEST);
 	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
 
+	signal(SIGINT, sig_int);
 	return open_netns(NS_TEST);
 fail:
 	return NULL;
-- 
2.40.1

