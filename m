Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83D1311AE
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848746; cv=none; b=EyFeIzfrj0yQBGzezcS9l4O3nGAMfqDVtwDnWbpRjoQOK0uuIrugTyDiGQiYd6fyA1OEETICC1fE8y8+5KVP1bJxw++VxqA6781ZUgmckp+12AHW34MefkNUUoj+SWGXwXorQMW/B8r5wbY3LGblGbRygIGxqORb1FV/s0mP5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848746; c=relaxed/simple;
	bh=XDDN2Ayb9LBIzE7Gsbex2RBDsfP7vJLCt++bv7OxyZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+RmK0ayyD7Ug66jtrJraAA2XJjRBMkMGEE5VIBLrcoMce0x8HzPw3WhKAJJf9WVbtIeiUXK/O+8P1w+zwjYOYtC21JT7sjRIwdT2edd4cLfcJDepaKA9zfqRSNVpgZ9sxB7Gu/aMAG6X390PmDAwwz+f54kgX+89O7sxFk4iW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQUk6fud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQUk6fud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970AFC113CC;
	Thu, 16 May 2024 08:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848746;
	bh=XDDN2Ayb9LBIzE7Gsbex2RBDsfP7vJLCt++bv7OxyZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQUk6fudsQW9/Sp5iNLyEDo/A2KCDlj0wsOZoSGDCELhovq49EF5u+/lUSi8M8sTm
	 2IR9wp1ykPU8kccwHJKaz5irtVhECu2tA+baSm1DVSvmcqhwSeHlZOpxEwvvS9+TKa
	 lYCe/9uwl3gO0qLP5F+Mu0HLCJ6dEvlDwSqtosoX0P1dzgb2PsZ+MLIuGMPkRfI+H6
	 ZIgZkBB1rxBwk8DzalgrF3HAJ8UP5i9YtTmGQ7rnkon488gGQWuamcb1/O8TLmM2LK
	 dvS//W8b2A2QThH+jEHI3xwOIWfXJ19keRIfT1HDf3PNd93xI84gMbwKrUlyBw+jHx
	 kGaOyF3uPbrjQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Thu, 16 May 2024 16:38:57 +0800
Message-ID: <39e56ac121fbc39d81188914da34344e33b65e51.1715848543.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715848543.git.tanggeliang@kylinos.cn>
References: <cover.1715848543.git.tanggeliang@kylinos.cn>
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

