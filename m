Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C303339A8
	for <mptcp@lists.linux.dev>; Sun,  9 Feb 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739095342; cv=none; b=EYwqaxrFrxSNOasTrsJ/rnMCAhSV7A6QM8vqeuBlSRHvblcFGEi3BPgJ7IrKWAwLxv3YNoH9CfyGaYJFWM0RMah912f6V0halsNZZKcRiDFidLhloUxheG7xR9i5T7I24EORgJnoPhBLLfSKZc9NYm2oWHpQ8pgeiEj0sKOdpNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739095342; c=relaxed/simple;
	bh=1su1M3eNFxvg6tCEug8h33AMhzMJVn4aAseRa4VGjmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFxhLFNSRzwdY13bngxR7PgskC5KFFcu/MGnfOBlME2DXW4YuNzumV1LJMo0NEh7Wm+37R2XaXt9tdsVjuzeOazBfR4EyxNrwrESQ60jFD0UICeSAg7yFLvvUgw9BpHJoEf2tXHYZPnznXRGypKf3No4P+SlifvWoZhhCvjSJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+63vQe3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+63vQe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFDCC4CEE2;
	Sun,  9 Feb 2025 10:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739095342;
	bh=1su1M3eNFxvg6tCEug8h33AMhzMJVn4aAseRa4VGjmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+63vQe33fgAtYd0vbSfnHsd8LTQzOAl0K9XFbTcayTrR+HGiLNEDE8+uZLtQkvgY
	 ulD5/0Gw4ind622SdHYZX04Zv+HeJEGOSfOYYWstftE15VCrICMydSsDtHJaeMNMNG
	 XSXRxZQWucyxrcrEPaVGb2Fs5NVrIppfr8ozxU5DqU12kKW03g2+jaOZO4qXVLrggw
	 Fxmg+ziygCWoky6y9+/oxztMjBznbvAmkC5Xfmnt6fcmkuPz577PUK8MUgzGKTqE3t
	 KABIY91q+dL0Z9Hw22fIb5LVsBOz/FbdqcnXiHC1xy9QMp94xqVXbx4fKLzQaOyhEs
	 0XypiSQBtjVeg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 4/8] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Sun,  9 Feb 2025 18:02:03 +0800
Message-ID: <7a9c57f54823fe3608af1dc92f1cfff9f8f65417.1739083794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739083793.git.tanggeliang@kylinos.cn>
References: <cover.1739083793.git.tanggeliang@kylinos.cn>
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
index 29be67e2f2ef..b7212101705d 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -20,26 +20,16 @@ SEC("struct_ops")
 int BPF_PROG(bpf_bkup_get_send, struct mptcp_sock *msk,
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
 
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
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

