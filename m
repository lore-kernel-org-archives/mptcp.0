Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64E1DB133
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926091; cv=none; b=IIyoCsOVwvY+2DsrYdH2l30XvfKk7M4N6mqp7QEp/cNugo32xuHIwhoWLr4u4Qzwkz6Iz6IkuKVW1mzQViCU/Jjx3mlNhVfkYMG1HMtVPpyxnT64qrhAZcEJabs1PDvVmiswNfohENUVD3gApmUhGchwAjiJGfGWjyRF7JyeLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926091; c=relaxed/simple;
	bh=t1SPG2iIKS5C/EbTvsjw4uNELRaAhBHC6m3kjx3dlyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kz27g9ssuMViGZjbxkppklaLJoy7U2rhaNaHOflwmTBsCjIsZWxkOKHQ853PfWflgDUZV5TDvT8BY467DsVRQUfMiFkSJpd9ooVaGqU9qq6IA26NnSGkBftvq2NDl00RJYmL93tuEQy+afhUpeTiPa2UoV6Voh9KC++BJrXFw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dpo+ZNR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dpo+ZNR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7565CC4CEDF;
	Wed, 15 Jan 2025 07:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736926090;
	bh=t1SPG2iIKS5C/EbTvsjw4uNELRaAhBHC6m3kjx3dlyM=;
	h=From:To:Cc:Subject:Date:From;
	b=Dpo+ZNR0Ysn6x9JY1SR4Xt6FG/zdJwKi44QbCijOwJfjah/4WLa+uFRR+/WAtS0jC
	 PkdT49Tn3SAfF4ZEt+l1BbxXYWCDK8ug0z5YKR6tECdk3eDPv5+R85/Pjs+knfSnZO
	 zLx5fN+ejGEyUU8i2HwLO1s+IuZNHj44zsjtHY1x7vwIQ84jnmv8R2P7y75EFxhgVI
	 tI98X/ZaGvH1+5tC09xLFuCvPaq4iiKfOoYNFPqQQOMdJ6/us9Q4HcNiEGfE0zvAoQ
	 E0hTenYW8l/ldWUbLVMa+W6Sj/MESmS+hzaAKOfnwYBjHR8HYcyPEk7+7f6njpXHVK
	 ZW9T/W1ve4DBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] selftests/bpf: Drop cgroup_fd of run_mptcpify
Date: Wed, 15 Jan 2025 15:28:03 +0800
Message-ID: <38e34a835050f35b7f14f7938b20f86a97ac0836.1736926065.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The parameter 'cgroup_fd' of run_mptcpify() is useless, drop it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 1d68bbda3370..258587700187 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -283,7 +283,7 @@ static int verify_mptcpify(int server_fd, int client_fd)
 	return err;
 }
 
-static int run_mptcpify(int cgroup_fd)
+static int run_mptcpify(void)
 {
 	int server_fd, client_fd, err = 0;
 	struct mptcpify *mptcpify_skel;
@@ -336,7 +336,7 @@ static void test_mptcpify(void)
 	if (!ASSERT_OK_PTR(netns, "netns_new"))
 		goto fail;
 
-	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+	ASSERT_OK(run_mptcpify(), "run_mptcpify");
 
 fail:
 	netns_free(netns);
-- 
2.43.0

