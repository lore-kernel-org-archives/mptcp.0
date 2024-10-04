Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0520FAA6
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046803; cv=none; b=aU1wTU2K3voDDsHvjZXklLv4CNZ/py9Fj4JBOTejSkWI0gG3FHZnC2+uqHkdzvOERz2WKLwrAQsaGemp9dlJ5WcL3X+4MGifLQZom3/M6bg+Q9RV8ShQcUrZjAPoegxeUxVCX57WTLhDZ7TZpE9ciOYsiOxze7RR68I1U479NTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046803; c=relaxed/simple;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZM7t/LoevZAsVtpxnsosvrZv7i//WqFxuybwujj9IgYCel4nX76NpVnyYlVY7wgJwge8+hcuO4WDS6PWf6zbtjLnSx8K8SM2FUZzTNCPkQrl3o2QAxAGeZgkrPSnW7VJYSkgqdDmiSL7/S+wV59tmFbMtt5hvaiBAqcT0hewXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtRRwcJ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtRRwcJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C0FC4CEC6;
	Fri,  4 Oct 2024 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046803;
	bh=vAGk2SNZxJ2K0XaAAadSTnWA8wtWMYR0tx03ZiqDhLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtRRwcJ7/gz/BhUubWvbsy0ffE/xPXY2AkHEx38KCysv8maDX3pPU6Xn5WEs5epCi
	 /eGNYQAIKob1sKCvmp5QzE1EPuB7uUNFt5fBfAncD4tDw5AWsn5HowLm7a12xPjVKj
	 drBoU0IRrEazJcv7CIXnd5zBJAQCnQTHYTg2LY6cv9Ce5eI4hGNG9ciFjRe4XA5AuI
	 vVniA91KhAANFRyUAyeJ8swjZ2C4CTc1js8xwKaHoWSBnjZVdCJBZ1uUfLhOHf3c+u
	 ZzdmMNzPMpG22pwrQhnJqPgUXkL5gcKtJKA7+L3nMTwqi5/fjJeZABITNnNedTLLq7
	 GcExVF272ugfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/9] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Fri,  4 Oct 2024 20:59:45 +0800
Message-ID: <4a1be29662f76e0222aafa8dc5da3551731644cc.1728046491.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046491.git.tanggeliang@kylinos.cn>
References: <cover.1728046491.git.tanggeliang@kylinos.cn>
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

