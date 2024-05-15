Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32563A8D0
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755475; cv=none; b=XUr2IZfo4nvZnJ8Q7Nh41qvKh1fKD0rAcJ2Y+N93ok/hBaxX6G0MTB80a7KPQG6xyzio26eOH8FPRTYFOXIhynt7BAWMOCP+Pnxg5IwH8XmS8EPuSHM4qQ8YiLc0lrOEtFlML7+17y0l9AGgvDhNTMwiAI+abSLzFWRGXKvV1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755475; c=relaxed/simple;
	bh=udG9vWPF00neKQVSuqKavYO999fBQVr3vJjG/gBGAtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU/cyk5NQJCGVGGcvNnPOp1JyF4hUSvlcMEXPPKG6hMvrJDC4FNDjgcIJ9utw6jVvcDkQxB8eUl1aLDOdrbIa6IdNn61jQkxwMfeb4W83e9V9daLf2uomAd0i57tRuJypNq7iq5rj+VtjWWt2OE/xjOwBv5JuN+ANTVp7EMa2Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlTo/HJl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlTo/HJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564F2C116B1;
	Wed, 15 May 2024 06:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715755475;
	bh=udG9vWPF00neKQVSuqKavYO999fBQVr3vJjG/gBGAtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MlTo/HJlIyYNiEQrJCMxz+wOnut7mAcuVZeDvKcR7KBP7P/ccNkCBkHSlxGQFaBR0
	 54wEGnrwIPPG2yLYSY3Kvjc71iy+5YdszHyWFG1J64NfrsQJOLL7trFsnC9c53A2QT
	 a7AmJrxx4vO5zUDxT2Z6lqMl70QZxrFy8qiAt7T9giyLuaa8blRXcKGIqLtQJxp6Bz
	 cAMu4QEG40xAC7CtKbfjZG53mOpJLDQbSvpD/xMo9EbhsTzNa2dB+f/xSnS4uBLrF8
	 00959hedGWNmIZKEhd3zFXZB39zYE8+y7ImvQs6oRYBpmdoYp1h3weL5zNxDA0QFzv
	 JJkqka6hawClA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Wed, 15 May 2024 14:44:22 +0800
Message-ID: <ad8cad2011533bcdf084d599afc25ca50bccc653.1715755275.git.tanggeliang@kylinos.cn>
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
test_subflow() needs to be updated too.

That means v3 of "selftests/bpf: new MPTCP subflow subtest" cannot be sent
to bpf-next at the moment until this "bpf-next add netns helpers" series is
accepted.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c7f61fd9e7a5..a4863328d2c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -418,7 +418,7 @@ static void test_subflow(void)
 	if (!ASSERT_OK(err, "prog_attach"))
 		goto skel_destroy;
 
-	nstoken = create_netns();
+	nstoken = create_netns(NS_TEST);
 	if (!ASSERT_OK_PTR(nstoken, "create_netns: mptcp_subflow"))
 		goto skel_destroy;
 
-- 
2.43.0

