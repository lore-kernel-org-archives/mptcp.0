Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5B3D994
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755477; cv=none; b=g9Wmh0jhKbT5diV0i6TJpYznFYPQFZ/tTOrNZu7cJxq1/jo5XIqoE5KGuaRdzGWHlwWZzwBBCDy0KR+72EeDmmIZ1pvgPwlfKAxWJsabczMGVQLLZB2lsl/TBMbl/wnOeXs1pWQMBpnJZCMFpdYIMMZZ3jC/NDrtSa28yUPu7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755477; c=relaxed/simple;
	bh=XDDN2Ayb9LBIzE7Gsbex2RBDsfP7vJLCt++bv7OxyZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxL+9I7YY7Qs2ocESDpm6daSs4CyVUHUNbwQJfVHUmttzcdoAzOk1xvWuPGnu9i2Cj4Yyb/U3v83LYp16hvFLYqK8vX9DS1KuAeZ6e3aFrCA5C6DZ3J+GrShH3j8/GIJ6N1c1hJeMk5K5+lR2xp0+q+KIFiWDwR+6aZRRaqTyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL+Xr/+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL+Xr/+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4FDC2BD11;
	Wed, 15 May 2024 06:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715755477;
	bh=XDDN2Ayb9LBIzE7Gsbex2RBDsfP7vJLCt++bv7OxyZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QL+Xr/+lPn8A8tFILmnM3Cvayw1rS2yQhUqr1N7JrexyaClSeoK3XmrNQL6A7Dcjr
	 ISXckT//iu5dlP2JL47H2qB+BhZUyfi5KS1wkj301sRv/fTmgSU6IFeJR9W09jTUYM
	 IjUSi3MfJTkYkskdCJ4QIUFLSf4Ktge1Iyl7zN0Oai6FEmH80pACTMnQyklBn1jGDr
	 JS3ShGlx6G6Or1JtaR4oZvRX4AGA34wJtblE+k3bjk59lND5skyI/Vii24ZrJMct/3
	 uB/EVPfuJid7sZ8tjXc9m/JPuQtAXnvoMiB3IJlqe43pdo2QATYeh2HfcFa3s5Hg9F
	 9s4KoHPKLZ0wA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Wed, 15 May 2024 14:44:23 +0800
Message-ID: <d50bb4210c8a8001f013eedd4b1563e9e9670ff6.1715755275.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715755275.git.tanggeliang@kylinos.cn>
References: <cover.1715755275.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

create_netns() is updated in "bpf-next add netns helpers" series,
sched_init() needs to be updated too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a4863328d2c7..1b2ffc5211ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -439,7 +439,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
 
-	nstoken = create_netns();
+	nstoken = create_netns(NS_TEST);
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-- 
2.43.0

