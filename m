Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125D2D661C
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107125; cv=none; b=e2tkacSTl+XtQzkWt8wxS3DoY/rPzopyBcfqNmPQcRvL3LHXU83ZWcWooAkPL+pZcdQSbtbOEgKHKsee+FyUrvbJDV+O0BH5lDZusyXucZ7BmzpyBy+nNXknzM8ybZQEaaq8R3dRw444dXvHXxMoCWzz9rpz1Bn3wYf+HdIuwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107125; c=relaxed/simple;
	bh=nvKtB6cWQU6jGJyD9lZOP2a7XdO8+ioT4ska3aZ+mZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhT60Hsu+63y+QEf1TC27YrD3tWhMfbOD10Wmbj6z40ZWf1l5mWSG+BcjCR35c++Dqb6h8m1Y4yFpKg1RPdpduM7jQHZzl+lMZ6/C3IgtRYQrwN9giGLi3rYjJeJALSg6ZiEabBXDXQWm9NM/P5gnlwo2JMDGJucJiI9LCcfdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/hD++Sl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/hD++Sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E866C1F000E9;
	Mon, 22 Jun 2026 05:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107124;
	bh=vXRAaj2pbgMW1FkG+K0dYT2Mld1BOclxfeYQJoAoRao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l/hD++SlgE8At+Dy/aEHC1kd34fvIPw8OjajXYfOfm0ooybUGjMZ7J0jXNTCkM9P/
	 1WZiFdW/PJbrJnWcEEt01FSUJzSPVc7vRYyGP1gFvHZAeHKhOZo2F1Nkk6Pvcw79Xo
	 tZwiKgzhyHMNKZ9hdaXX3fbuftp3KEwdTXGeb50hwurLpj8FCMshYuRH2RS2BzR8no
	 03GqcTpdt18Kv4ErlrOvFjKwY+z5YJNTa7vvFIa1QBxce7y1CL1l/VIfCO/BWw20tD
	 keQ5Rk68SPS+UPslexi1sKyRpjVfJiPCX5QutjF/xoDAWDaaNKR88ep1XsBmVaHy23
	 8Wd2TTzBYHQ6w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/7] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Mon, 22 Jun 2026 13:45:05 +0800
Message-ID: <337e8534ddcfb3dd2bcf375bbd637d67ed47aae9.1782106180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782106180.git.tanggeliang@kylinos.cn>
References: <cover.1782106180.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Replace bpf_mptcp_subflow_ctx(msk->first) with a bpf_for_each iteration
over subflows to find the one whose tcp_sock matches msk->first. This
avoids passing an untrusted pointer (msk->first) to a kfunc that
requires trusted/referenced arguments, resolving the verifier error
"R1 must be referenced or trusted".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c       | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index 96b002808ce7..13ecee9833cf 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,13 +20,16 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-
-	subflow = bpf_mptcp_subflow_ctx(msk->first);
-	if (!subflow)
-		return -1;
-
-	mptcp_subflow_set_scheduled(subflow, true);
-	return 0;
+	struct sock *ssk;
+
+	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
+		ssk = bpf_mptcp_subflow_tcp_sock(subflow);
+		if (ssk == msk->first) {
+			mptcp_subflow_set_scheduled(subflow, true);
+			return 0;
+		}
+	}
+	return -1;
 }
 
 SEC(".struct_ops.link")
-- 
2.53.0

