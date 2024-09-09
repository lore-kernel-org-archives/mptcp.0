Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD833FE
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846943; cv=none; b=f7JqmsWdJKJr+ejDLxSybyPTjtNrPfl78mtBlCQ7u0OxwXA4I5B+N92lKzn2v1fSAIeJGELV2C/Pp+W8eg9zzt/zjaR+CGEX8KtI/DdIerjEyF5PvgkMuRT0q9+go5+Ks2RbJFx8Clw6Cf29AkCbdnPFN7sfxa3lGZE9poCZxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846943; c=relaxed/simple;
	bh=KLDZKlNwfB/sc1wiXSYNVZ1g+AAXDi9otFT9GKttFAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3xN5uRF4K5z+CGbyWeBiGhoVtJ7Mkmci+7EAlgXMpU53nYi/ZMHzE4+cjO+x3s2sWwVU3/pzAXxqovd+/vRcW8fUJa8+bSWwCXssVWGx/WCG2jCwctl2j89ezg8dptBofMmQ9ziJEqse9PY0E/42jCdshxYirmCLrpLUcglOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBDtcYKl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBDtcYKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F879C4CEC3;
	Mon,  9 Sep 2024 01:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725846942;
	bh=KLDZKlNwfB/sc1wiXSYNVZ1g+AAXDi9otFT9GKttFAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBDtcYKl6zAe72oXe6/PIpgWXW25fXMgH3KTVZeMekufCPgoPVZQiBRV7yALR9klG
	 6omZvdBClr0PldHxVSRZLIQc5PePBYhEyjkvm2Ociu61l3z4lIz/gkWz0OZdlOOvDj
	 Eu34HmY2BTu1Y/z5MtvivalAdWbYWbRGMZBWL6TvrZLPZmCicpbvB4bhmkLAXqA11K
	 BwBjJ8+DifO6nC3nHsEWKJEhsKRo1i5X7i11Cfcyr6P9SdkiNCJ645WBpQrF9YRimf
	 q2HQe8pcR/NlbAmlgQUloRXQWzsoabTINdSnms1TYrwJV+nbQMs5ooLpwz6JJ6fk/Z
	 RdhAtCnD336CA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/4] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Mon,  9 Sep 2024 09:55:31 +0800
Message-ID: <bc0240881dcbd9400e128cd9e4024a12b86aec9e.1725846806.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725846806.git.tanggeliang@kylinos.cn>
References: <cover.1725846806.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 987692863fde..2476f0a083bc 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -507,11 +507,11 @@ static void send_data_and_verify(char *sched, bool addr1, bool addr2)
 	unsigned int delta_ms;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
-	if (CHECK(server_fd < 0, sched, "start_mptcp_server: %d\n", errno))
+	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
 		return;
 
 	client_fd = connect_to_fd(server_fd, 0);
-	if (CHECK(client_fd < 0, sched, "connect_to_fd: %d\n", errno))
+	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
 		goto fail;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
-- 
2.43.0

