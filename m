Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8B57334
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613136; cv=none; b=RXojKiVfGP4/bUrZz1NeKhYbhkWGENWfHKL1a4vco89QS4a2AlAZa+gg+KYRQCBBnlCVpk173noSf5N6wl3ofTUUr8+4Q8nwbi9xI0G8ehKHg7Ey0uV4X6cww/xlqljtiaQADQNocwS6idAdK/gMA4HLp3rghgp4Wd1vEaAp8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613136; c=relaxed/simple;
	bh=Gn7fBcuGTiTV+o6VdKj0oMVrHvrg3D4b9BIki/KefXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QARswxN1ztX5Lw/TyV0Adpq0bAuMVo3On+7+4aWrcreL40QqOqWJPeZNjS6/UCerWnCr/F0fb3KPP5HxaDvMHBQxMoXzrvt3wNiRW0U9PXevu+ohShfn3mR0wm//G/qY88tmmFnB9wwJVqkHKUGjKKeiNTeKjO8veEBjJ+2bg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzPS+UjA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzPS+UjA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6961C433F1;
	Thu, 28 Mar 2024 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711613135;
	bh=Gn7fBcuGTiTV+o6VdKj0oMVrHvrg3D4b9BIki/KefXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzPS+UjATCCICYlquYaFVe+Dtg2+wKPoyaf70HI2k1xG3voAVlJvfC55ugI5QP/kz
	 PRiUVEu09DibIkuROgHWAkSypCxQxr4LsNM6sUzh70FY2tFhbmiaZffNJFPZmQXnr9
	 lWx5oiiG0Wa45OxX0yQziCUzHvTNQYdstZ3fw59zDobjeywD7+CtPh0ZRrxritzvD6
	 F4iyFuwpFG5m65k17vwSlvlNVE/Q6iwt8/rKSN4PZQIA+NIlnQk0bMUyRamfOIZWe9
	 IAw7HQ0IQfuj+k3hHPyj4h0jIKa0gykyDLABUiyyCudWgJgJVvzRUPfiMcYiIWqeIQ
	 fC23DFQ6r7bNg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 14/14] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Thu, 28 Mar 2024 16:05:01 +0800
Message-Id: <57bb3890826a2d90d5e7028a7fbc555e8adbd070.1711612876.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711612876.git.tanggeliang@kylinos.cn>
References: <cover.1711612876.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 118b4698e1f7..a950a69b9491 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -467,10 +467,6 @@ static void send_data(int lfd, int fd, char *msg)
 	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
 }
 
-#define ADDR_1	"10.0.1.1"
-#define ADDR_2	"10.0.1.2"
-#define PORT_1	10001
-
 static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
-- 
2.40.1

