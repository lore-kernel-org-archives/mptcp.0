Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA215534D
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170128; cv=none; b=jEkBHD2e0/pqWd+V4x/jsZKVHOFQwOwfESIO4gkfVfkw3idbfH1rtzxKOvPXraqiZbGHn4Fq8ULJM6mlcVdcCXUfNgoqj/LYogl+VKh6gFU5wZiXTAr8VHXU5Ad9HS1qKIycBTxvd/h+3MRxw3khFl5nhqsTDROWtkmi7X+i6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170128; c=relaxed/simple;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDk84vUC4AapLmHqRuG33n8BhWYUIteA4yLhP20ihA7J3j+jVBI82eB8AK4SEM33h4j1dR3ip9rnMjxTl3yuDNenlckloG8MqarfVa9MbKm4O8XZeI0o+B0l9zatIpg1v+va399EiHQgXoGO9DESorvUHwCx9J8+MEwBPikctSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xnim8PpY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xnim8PpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25F8C4CEC4;
	Tue, 24 Sep 2024 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727170128;
	bh=+Ns9vcAYflyNwdX3DkGpNegQAHdxvHGggo6htLg093M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xnim8PpYhh6QcSTDMTH0wav9usIKCjKj/QIcgoa9PhuzR/zrPA8BNbXuMX0ZSJBG3
	 FQFDodWR21yU+MpfpUZ3hReOijSuR+lg+GFJvwrATGAxurJFj846JSeWngQdqnBTLp
	 Go0AONkZcsJEcepJ9WR3C6GNh5KNIj6nALv9kt2vSr8UKC3uewl71NVCqGnMCy2RVM
	 uIn0hweNVufz/iDMs8KC+XLzQT0AEZ9emB642lbdAcS8pVaJ6BUwcQ8NUZTqDGvFeM
	 ajfGHTAwMuZ3toZwqqowle7jMGEJnDEjA8ssEW1N47MEggYEVZ0Dt2CjwZRBntsFPk
	 jxq92qMJrm2/A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/8] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Tue, 24 Sep 2024 17:28:32 +0800
Message-ID: <db6580a85f10d6dd95d53ffcefb0082b9d9de9fb.1727169534.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727169534.git.tanggeliang@kylinos.cn>
References: <cover.1727169534.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 296f0318d843..70c3a69d4a47 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -20,26 +20,16 @@ SEC("struct_ops")
 int BPF_PROG(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	int nr = -1;
-
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		struct mptcp_subflow_context *subflow;
-
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
+	struct mptcp_subflow_context *subflow;
 
+	bpf_for_each(mptcp_subflow, subflow, msk) {
 		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup) ||
 		    !BPF_CORE_READ_BITFIELD_PROBED(subflow, request_bkup)) {
-			nr = i;
+			mptcp_subflow_set_scheduled(subflow, true);
 			break;
 		}
 	}
 
-	if (nr != -1) {
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, nr), true);
-		return -1;
-	}
 	return 0;
 }
 
-- 
2.43.0

