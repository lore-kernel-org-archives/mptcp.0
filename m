Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76839EADB
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531115; cv=none; b=F59zZBS9gRMVvBlOcqi7LmZqsU/1xDJHVDrOeB7/eOPgD/MqBWm+L8pjcwYdpVB4RsdHp9vurprlmwb7/MNBjclp2WR2hye9Xy/CvKMlHyiPNrknNnOqIeKb8+ckHPBFoHUdtCVtbhkFAYHGpIAfVDAmG2LTe6El/mTalKyryVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531115; c=relaxed/simple;
	bh=poG6wBb+oVkCAGI3z1yMmoIYYdbrdC1VVS8hgWv2Uv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB3wkCkZAvFgRD3RYFdqab0JiTRpcE+o48Llo5SPL2nMDNffgkos3HFIoKE0KZEBkI3Itj3LB+toG5Ll664zh28OBx/mk3xqsNJ9MWisbORLIYb6OvAaun7CxMhpIOixtGnBr4ITUTgKy5lmkBKemv6QRS9gC5RxxUW8MD/FZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHSIihmD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHSIihmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C5BC4CEC6;
	Thu, 10 Oct 2024 03:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728531115;
	bh=poG6wBb+oVkCAGI3z1yMmoIYYdbrdC1VVS8hgWv2Uv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHSIihmDr8UQE7t0CVtV8Cp7EnporQ4gecWrV4wYSyuO/iRX13FfClYqOACKGvsQY
	 Xu4ZLh2y8C0n2Ub2M8vDdTGK7bdzAj0QaDwDIFh0yDxU4CVr3rfX3L3D8TMNFv874b
	 8z2ACj1e8WlR/BwGAbKYBa/SgfgOww/s1T4kJjAzJ5PMcWgW4CziQ+MYdd3YT16VZC
	 4f+d7Jeclj/acS8IxNiguK6CSOv1fGWLM632cBwb7HA4KR7eMnvCPhnVj+1TfFlvIU
	 NP3DwacLeKRNG8wvfnSM/KrHevTuC7aiSg5tI7FnV7ceoVwOdyGtCEJpOdrlkkKoO+
	 7J63T4RpdfRuw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/1] selftests/bpf: Use make/remove netns helpers in mptcp
Date: Thu, 10 Oct 2024 11:31:45 +0800
Message-ID: <af42ab81074d8a56f5fac8bcb4637400777f5ad5.1728530836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728530836.git.tanggeliang@kylinos.cn>
References: <cover.1728530836.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

New netns selftest helpers make_netns() and remove_netns() are added in
network_helpers.c, let's use them in mptcp selftests too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index acd79be134cd..7f70f8ec76aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -82,12 +82,19 @@ struct mptcp_storage {
 
 static struct nstoken *create_netns(void)
 {
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+	struct nstoken *nstoken = NULL;
+
+	if (make_netns(NS_TEST))
+		goto fail;
+
+	nstoken = open_netns(NS_TEST);
+	if (!nstoken) {
+		log_err("open netns %s failed", NS_TEST);
+		remove_netns(NS_TEST);
+	}
 
-	return open_netns(NS_TEST);
 fail:
-	return NULL;
+	return nstoken;
 }
 
 static void cleanup_netns(struct nstoken *nstoken)
@@ -95,7 +102,7 @@ static void cleanup_netns(struct nstoken *nstoken)
 	if (nstoken)
 		close_netns(nstoken);
 
-	SYS_NOFAIL("ip netns del %s", NS_TEST);
+	remove_netns(NS_TEST);
 }
 
 static int start_mptcp_server(int family, const char *addr_str, __u16 port,
-- 
2.43.0

