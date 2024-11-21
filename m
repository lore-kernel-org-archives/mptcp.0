Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF431292CE
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157173; cv=none; b=J5KQ//8AGzPmkjhSVutckOnK5eJ20rCOlmaqVRXbcg0i7CupIxSzhLLbjLvd2q96M2KveXLO2MwtmWtwnG5ZnnGNYN1tuA7yufr39OSLqy8gc4kSV7Ybg+ltxaYBy/WORwa8T7CSm6ROmEJhhP4ncqrPsp79rvMJZufurI7Lelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157173; c=relaxed/simple;
	bh=5uEXXgeIwPZVlEiJnHGp+xETFVnXEEebqDugI0rqlBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdNPErZ23Z/ENbM5jPuoPLJCHQDR0GigY+2LAU7f9opk94K62Ozr9RgeePzxJotvYNNahWndGJdQD3z8GE1uDZlka78ivrwawMrCjcjDelWwUm4PlaO/dxYKYerCWJXTvYBX1OLDf+IPTtcAuiB6TCC7+M4H6dDMJLVq7w6z89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkWQsF8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkWQsF8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7856C4CECD;
	Thu, 21 Nov 2024 02:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732157172;
	bh=5uEXXgeIwPZVlEiJnHGp+xETFVnXEEebqDugI0rqlBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkWQsF8XGjDdsAYwPCuYE/MX5ey/MYYxcaqzPvkKvqqTd7HWT2M8WHOfEUTrJ3wqp
	 MKPbIKmwLEYl0da4os0Lb85DeRAlE33NAqSW1N73In2Oaq8t49A4RAK8pGL+qSIUo2
	 6fZ0EwTdtru9NqGTYNZiZBvZw4LPrZZPxfnkqbGRqNZ7QJS0f5M7UsMRCB6eOrQTCp
	 wweS1jSDzbff/8s8NCGJk7BIgVvvaCrUvkOs6XLqB7XlOLgBv85DxcSj+Pf7KaG3MO
	 fpbVNFhVBhbzcd9Xi4E5BpR/VmgvT9ed/OsmPsWvN9JYNGErE1ey2obv+khHeyg0mU
	 +qMxq003mU8Iw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: baohua@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 8/8] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Thu, 21 Nov 2024 10:45:47 +0800
Message-ID: <3cfad7412c5d2fc439614357519855887a638ec6.1732153672.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732153672.git.tanggeliang@kylinos.cn>
References: <cover.1732153672.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Set BPF_F_SLEEPABLE flags for bpf_burst_get_retrans.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 1d68bbda3370..d7a640dce7da 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -726,12 +726,22 @@ static void test_red(void)
 static void test_burst(void)
 {
 	struct mptcp_bpf_burst *skel;
+	int err;
 
-	skel = mptcp_bpf_burst__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "open_and_load: burst"))
+	skel = mptcp_bpf_burst__open();
+	if (!ASSERT_OK_PTR(skel, "open: burst"))
 		return;
 
+	err = bpf_program__set_flags(skel->progs.bpf_burst_get_retrans,
+				     BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "set sleepable flags"))
+		goto skel_destroy;
+
+	if (!ASSERT_OK(mptcp_bpf_burst__load(skel), "load: burst"))
+		goto skel_destroy;
+
 	test_bpf_sched(skel->obj, "burst", WITH_DATA, WITH_DATA);
+skel_destroy:
 	mptcp_bpf_burst__destroy(skel);
 }
 
-- 
2.43.0

