Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889E230998
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157166; cv=none; b=vEmjOztHyq2k43ExYbLxrLwbV+43DTfGGCPlf6l+5ykM6mVvNL48+XKOxvxLig0cTt5JhkHyfZX9tc5P1pNEeh1q7iyEsLY9MhAMrU3Iwa0mIdsmzPMYsofi8jgtj5Oiu8+nxZLVH0y/Uz1rjLBt7Bo+/OCHIgPkw8xBOJ9QhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157166; c=relaxed/simple;
	bh=La87yMilvBk53aeE0uYVXlx2Z3/hHXb1zguOywLxoUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPiiCHc1J+Z7HzaAAiqyWHrQ9hakZvwEZAzkOMF934hf+Z5Aa6E+ceUytIaU32ruYr+9NFDA9PmekQNuwHyhGrn67aCa/2ZiY4mkwGLRKSfB+ixj733Q4upFy33vOQkTJN0kr67mSkRXD0vrDZ3a0DYQV/MdukKajNwr+EqVOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBDK783x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBDK783x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797E5C4CECE;
	Thu, 21 Nov 2024 02:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732157166;
	bh=La87yMilvBk53aeE0uYVXlx2Z3/hHXb1zguOywLxoUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBDK783xXDH9g3fK7kag7vrC5nly2JSaCAepfznGrN6J0LuceCilBxQ3gP7Det1OE
	 TDNrN76u8m64t8qr0Lvl5r0drEhZjlj/S06vOyq83HbvuOpfWBT5h2bjw6JjYr5HjU
	 Lrxr/jTYJSJ2FEUja8OpWfK04PNMube8wPtzhavu9dxn4FsKuX0oBYr3ICuiiu6B+W
	 nxvK3zhguL9xr4DTablE6NlogYFzi8tRN66dn02CnDq0YE+uh28IU5oHYwedEkeGbh
	 /diqUQ++8eZAlln8QR7PP8yS3b7Z4j78celMRh2xrBfl1IQdwIu9ubjDs6A3c8Ng7x
	 eYf9n99+xWfzw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: baohua@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/8] Squash to "selftests/bpf: Add bpf_red scheduler & test"
Date: Thu, 21 Nov 2024 10:45:44 +0800
Message-ID: <f25d66b54936172b630cc2c355f91a95bc843cb9.1732153672.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732153672.git.tanggeliang@kylinos.cn>
References: <cover.1732153672.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Split get_subflow() interface into two: get_send() and get_retrans().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
index cc0aab732fc4..acd0b03378f2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -16,9 +16,8 @@ void BPF_PROG(mptcp_sched_red_release, struct mptcp_sock *msk)
 {
 }
 
-SEC("struct_ops")
-int BPF_PROG(bpf_red_get_subflow, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
+static int bpf_red_get_subflow(struct mptcp_sock *msk,
+			       struct mptcp_sched_data *data)
 {
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
 		if (!bpf_mptcp_subflow_ctx_by_pos(data, i))
@@ -30,10 +29,25 @@ int BPF_PROG(bpf_red_get_subflow, struct mptcp_sock *msk,
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC("struct_ops")
+int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
+{
+	return bpf_red_get_subflow(msk, data);
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_red_get_retrans, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
+{
+	return bpf_red_get_subflow(msk, data);
+}
+
+SEC(".struct_ops.link")
 struct mptcp_sched_ops red = {
 	.init		= (void *)mptcp_sched_red_init,
 	.release	= (void *)mptcp_sched_red_release,
-	.get_subflow	= (void *)bpf_red_get_subflow,
+	.get_send	= (void *)bpf_red_get_send,
+	.get_retrans	= (void *)bpf_red_get_retrans,
 	.name		= "bpf_red",
 };
-- 
2.43.0

