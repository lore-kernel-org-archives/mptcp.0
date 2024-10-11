Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96B804
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638862; cv=none; b=naoPHZhpTj674vRpsC0n+7sGlhibeoss9uWz6FUStpZu0O3NTMoVT9v77Pbd8se06+Olb6TPwQWcBoq6GW/bSzBOcThHuwKFK1E+YJK6yAfLU84aKja/Q80Sualtq3I9ogSzQ1U37YKliTJn5T0gtgjhQKXTZguAp4ODcSlZBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638862; c=relaxed/simple;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAF/iX6fsoMlwOtplgLo08slRv3CWUXpzTZIUeXvCXEamZ1F1zThU0mM74E8HGSmvqELq/zG2/5yJEYfSO2y8RoBzk5FOAsSrrtzZzFRqCdRJtbmD/+WUSPGrVBHNTsieudaUn1EXffr/ABMtdMABT40NFE02xthaI9PdK2V7GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOn1jhtd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOn1jhtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BACFC4CECC;
	Fri, 11 Oct 2024 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638861;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOn1jhtdfGqUO2fwplNJuoa1R2Bge06iHJbQeFCXK0ri4EIU7QUztnmZSqU9ZncXP
	 bZEvne0nI3MwNlNGombppnpmTRhS9cuc38jBD0Q3SYzmxK6BH5NCZOjheYmBlmXj4P
	 TxG9augyKxWPpmXlr0UjR20nwU/WrWOSsEIuChvOMEGHk24g4MfMlLOWGVNDJwQV5/
	 czmbh7Kkdje6WlEuhCpr0FW5dmMH3YauG9Eekcyj9PJdFHaB8GhPpQmiHnBbxB749J
	 XEONfYqgDkQGpI4/STuglxHdQ5iDF2qNIWTgv9c68xE03BSJQEUk7I98rA3DSnkqHz
	 O7wjWRpPX9G4Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 07/11] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Fri, 11 Oct 2024 17:27:19 +0800
Message-ID: <1a0868a3750d11e7055f8a39103ec0ede4a66918.1728638310.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728638310.git.tanggeliang@kylinos.cn>
References: <cover.1728638310.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index cc0aab732fc4..ce19d604b898 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -20,12 +20,10 @@ SEC("struct_ops")
 int BPF_PROG(bpf_red_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
-			break;
+	struct mptcp_subflow_context *subflow;
 
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, i), true);
-	}
+	bpf_for_each(mptcp_subflow, subflow, msk)
+		mptcp_subflow_set_scheduled(subflow, true);
 
 	return 0;
 }
-- 
2.43.0

