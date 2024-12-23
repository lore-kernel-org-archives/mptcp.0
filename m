Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75738385
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942639; cv=none; b=VUocqEXuTogtVqwSDmOQbNKiWOn/2MjlO+fiJruJmVK5uNzZtbVJlyIALf6KpSIR3T/zNVNeHA27NhRrQgfDJgkvtv2vYXSMDnsdLwRmm135QnZ0IXGdjdUxWj1a/RyOpdtP6E4w5pyFPRB6L7eZE1OxtW0vq+OWyTJa7ywSnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942639; c=relaxed/simple;
	bh=DOV5jlc/2tbtZAr0I6BJys/FNUb2KWhy4UROIn3RVIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey8Z4bKovn6EqrXrlg232IKE3O8Y+CAslwME9nkZsqWmM35H3UXxErGzPm8DQgBt9N8+rKsqXEN0gD0kMJIJ7JoKjzoAmLWKe+MKfrlxlIcbQawBdgAPcIGF3A8sFZO+cMFJN6Ob573ovSIKxuX5SyKrIiKwNkoIjPAuL02wiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjzmSZRe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjzmSZRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB773C4CEDC;
	Mon, 23 Dec 2024 08:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734942639;
	bh=DOV5jlc/2tbtZAr0I6BJys/FNUb2KWhy4UROIn3RVIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjzmSZRenNxZcNiepeo7sS42H99u/oQqwiJBrX1gsfG5spDDu8M0FIBZspJwdK2U0
	 fVQG6dXjO8Nmgj1/ur998F3HGu+SZaHEe4P0T7YF3yucxDyXBVxzjxyzJAETDQsXVk
	 jX9FH8WW8iGMTUmxlOdQTocc6Q2fs+naxL253NZE95EcMaDY/XUy0clyVwe4k8wm0N
	 2TAYL0nTnQQAjec8J4KFR9RFrwkawkOcFw4HD5Q1U63jdt23BU5dAq8N4R8GnaG47C
	 WLg/5SN5yp1vargRnsVdd8R8eQd6pzF5SbdlmIfzL0n4GU9TtEcB5VxngDJjndrfQI
	 s11zDXuIrJLYQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 9/9] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Mon, 23 Dec 2024 16:30:15 +0800
Message-ID: <f0ef9fc99f082bd78c03e1435f1f6c2fe7790f63.1734942318.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
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
2.45.2

