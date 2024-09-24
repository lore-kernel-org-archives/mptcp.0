Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5697880C13
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169020; cv=none; b=dUCQb8aFPkHFv8uEBFO7W3eIIM/Lora0ncMxfSuk8VARqLK790G5HJsc7/P9cZOfTWlhjmaU4yTTUL9i96Qpx+qWp9Udh9Zy5cgLxOtP8nUKJ1OCLh8v6Z69sdTr+ESG4D2QO2sKa6Ag11OzKWGyJBZvo0jp2NbDyE5haGmIhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169020; c=relaxed/simple;
	bh=Zb+32JUdCvzFr6YS3HVWxtO3o2fz5/zgF4mbGXoaSRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH98GQN+BiUqmEFKkwsudk8uL+eGQz1XSHLDQeGanry7fmgsg0XIUfJqcI7CNtk7BtFDZ52Dh76o+BkfujinUfIDdkTbGfozrnXm9UG99swK7rFKLV/usIJXuOMb6KDlmwcoVRYXOiXMiNB0WrQywwx/kt/h/sq2SmigyFqKvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc9QR6tG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc9QR6tG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081E8C4CEC5;
	Tue, 24 Sep 2024 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169020;
	bh=Zb+32JUdCvzFr6YS3HVWxtO3o2fz5/zgF4mbGXoaSRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oc9QR6tGwjl6JQpYTU/Idz9M8J8sQUBU7olcuEBSjHbdcvhowfAwjCxEe2hxQBV1Q
	 YIgWXrnCcFLOtGYs5+PmY0O76ebkkTY42VbUTS+3RKRpcXI/4qrq3ihCInJxPJDJq9
	 jNZ+qSEbEJ2s6fDBshGtjDKhj84mxT8S6aKNNlTNm0DhLetcstqA2XezRzCSH6mMg7
	 sJFPdBq0J6U0bAfCXibtDZlCZkIAlbgFA/F14ZTT2d35IgKPKn92tMv9Tjb7uCuJU5
	 Pe84cuYCf5uZX2fGwhfCTsJ07euH8Oiz9FSUZO2Ptgi+wuW47XGIPRCnP1JObMOLIs
	 1Oo98+tMbyY+w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 10/10] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Tue, 24 Sep 2024 17:09:54 +0800
Message-ID: <9fee9ecb81012a155bfb60d25437fe871876ce98.1727168628.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727168628.git.tanggeliang@kylinos.cn>
References: <cover.1727168628.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop mptcp_subflow_active declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..dcab196867fe 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -16,7 +16,6 @@ struct bpf_subflow_send_info {
 	__u64 linger_time;
 };
 
-extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
-- 
2.43.0

