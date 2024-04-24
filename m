Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A35221
	for <mptcp@lists.linux.dev>; Wed, 24 Apr 2024 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921248; cv=none; b=pAizgasEJR+GRvxAPrmDw8xYEmvEa+t1hTLZSeBgYjDUzVCMZ5MA6dOJ7Rn7YF7JS7Bb8AKukdJPBzaGaoVcMItRDLpANqRz9zpOyPfYO41Y4LC4L22e99jM6KhIAnWJzEST9SKj3l/Xl7fVxBE4i3Ly7UNBjDt5OrlSO/HWIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921248; c=relaxed/simple;
	bh=8tMH3z1r6GffVZ0M3gpuR6SnnvWzB3EU1bkp9G4fla4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZqEXHirHkJO3+Zm8RPBdQOAjyJGizkv+0GeVvUEPwhk/FGwwUm7pxRkl/lPVRtiyzu4Geo5ugij+ip5+xPcfSIupOW+qSXcMdP5EqZ5OOSFZK9T/4MtytkPqTD4sIB/QxLhWTebBnso6FNzNQ+CojNE1CVTBhPCQ+cw2tUcrmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9fpz4IC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9fpz4IC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14957C4AF09;
	Wed, 24 Apr 2024 01:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713921248;
	bh=8tMH3z1r6GffVZ0M3gpuR6SnnvWzB3EU1bkp9G4fla4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9fpz4ICV5cEOJYNtfGIzPEoCkyUc28MkeyTlnqxgUrqLjT4uvtKf6CiUN1j8Chya
	 3NEnpAkE3M1WY0dZ55fgFHoyHTLV93pkPyjE9qUup9taqKEzCp10JdQES1CB74L70k
	 tSEoCYTGJghcuMHDNU2ngOR/QFTrXM2+7HUZQD9s+HqAqADIqA4RdNsmYHf7KT8vj2
	 MjeWs2iCoPyxySh0O8FrQ1zV415piYIs3Pu/bhQQ9p2lzvVtIEZ7Icfa4g67Mm9ABh
	 W4vtv6tGo02UHPGXSPS8D0UyiEvdYY3JpcefFiN78yMFjoxQG2uej8SmL1IBDRpx0A
	 saa/rm1a8x1Tw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 3/4] selftests/bpf: Handle SIGINT when creating netns
Date: Wed, 24 Apr 2024 09:13:53 +0800
Message-Id: <08ce28802953e76b337107f1efd978737c913cc0.1713920939.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713920939.git.tanggeliang@kylinos.cn>
References: <cover.1713920939.git.tanggeliang@kylinos.cn>
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
index 6d94cda6b97a..7409f7c8b1f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -79,11 +79,18 @@ struct mptcp_storage {
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

