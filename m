Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304E2207A
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948377; cv=none; b=m5h44PIRkfD4EiAcauU+vXAmOY711mjje7dCYsV72zj8fAb3wBszJAM7EN+VlCu+FW1tHdv6TnRLD2mxoNcdiNPXAx+3aDSsa6R5+VaryP7qnfUAEC78VCsdHBO68pHctYbQXcRj5SdQxw6t5Fx+hnFgUYLrND1Ubq5bC0lfnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948377; c=relaxed/simple;
	bh=g/RFvGsYBmo4RSbWo9lMIqqOLlqVRpcPLjjcw8/OC3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uog1ilb3swwcUMasj+J9nFZedXU2T11G8sMbcbBe8pksO1yceLros92b7gw9J/wFu9W6cKu/7DlF/T8Ijy5+49B/PXntX8ez4uFUcVJ0+ricFZb5vFq/G/eDooHxmVGH3tWAiy3teCjJlc6QT7aFj5jVeNV6mJBUNqouC61g7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxLsAx6Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxLsAx6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567BFC4CEDC;
	Mon, 23 Dec 2024 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734948377;
	bh=g/RFvGsYBmo4RSbWo9lMIqqOLlqVRpcPLjjcw8/OC3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxLsAx6ZIjEj7B2JlF6R6/q2RDojw0iGmlaIhFaGI/WaNZ5EMMMrqOj7UekcnezOT
	 KKH3bAom/zeeWCMskT0q8w8AFze+Q9Q3neiKyQY+xl/2evXt4qI5ywHVeTRgagdmTQ
	 KUtA/wgpVUo/e23g5vz2qQrHs67QVdR+DBYIEkQmjlYnpjIZp488hz0o8hLlQQj+zG
	 5LTg+i5jcVExNBwB6VfPYGNICpDtzkTYza8nI3zygEnzGWZgiXI7bYKwdRF7y6+QMC
	 cksCWxSzRmvPvdnri4Y+mR7NcSZWTxUvdB3Hrnzpj6Ip9YCXQCMBjCIJD2PPvrKqsx
	 m/FWfJM7saevQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 07/10] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Mon, 23 Dec 2024 18:05:49 +0800
Message-ID: <f21863b8068b6c10818f2503af17be47aa7b6dc1.1734947922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 29be67e2f2ef..789701f5da6f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -17,29 +17,18 @@ void BPF_PROG(mptcp_sched_bkup_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_bkup_get_send, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
+int BPF_PROG(bpf_bkup_get_send, struct mptcp_sock *msk)
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
2.45.2

