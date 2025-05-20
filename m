Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FF211A16
	for <mptcp@lists.linux.dev>; Tue, 20 May 2025 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730946; cv=none; b=K2Q4S5Ek1WrfJho/u18LnT6KNrlgIkuVjBSCWnOFhv8hSF2YMKncGQx8zmLatS4N9us1Ea5CRNx/h9HDOK2Lxf9yr5FpUoqzH+y2B5/1eN8EwzyNCgtOPGsr5WGev2p5ZEomM1XMMish+Q5qICal5GWVg9Cpo8NyLthDYG2FzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730946; c=relaxed/simple;
	bh=QnJ4ww0jfWyjyPd25EBGqqRdGmym3DTODKNom4iGYEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLZ0bkA2UZLKZMMFPm4wVCaHSzQTk5se6DcBwARr1XAkIOsdjYgcDjsyYYIoQhXMD07bdetNO5WeUGT0keGRBe2/IF0OtgWe6CATz47JN/s+DNRZetOqUlbFUsewUWob6qWhlwznrISfnocZTgZyrT+Y4wZMSM808zQdNzXsiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBKG8oQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBKG8oQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C722AC4CEEF;
	Tue, 20 May 2025 08:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747730945;
	bh=QnJ4ww0jfWyjyPd25EBGqqRdGmym3DTODKNom4iGYEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBKG8oQk0gZOwJwEl7lt7z1nAVnJeiSQ/wBAs4ZpNDzo3RMXKAZHgtLgb4KAHTMZP
	 Acx+ZfKv1W3qJ66Z8/aIU8Wf9qC38aF0OsjPQdG7UquPL1u7A29DsCiN1Et/LTYiML
	 /CnosY2LvZhzxZO3eOvDrq+h7/zgYjA35nZ7oYfkDkOICmUGptaY0e17QJ0UjUpq1O
	 w7Z3g7g/QKPGSfIq0O6qRhjYbTGgSoTNyqyA7l8qWyJITCDBQPzF3Hl8Orb/HJIk4T
	 x7Rs84LJ2AZhTcVETaq/uZXKpjEL94PgwlwIDLC6Nhc3iIhNHUqAlKdtogO5pWuOYX
	 NRN8tu0afRzZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter subtest"
Date: Tue, 20 May 2025 16:48:55 +0800
Message-ID: <3f054bc9184c55420faf7904c8c04bd2d92dab81.1747730598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747730598.git.tanggeliang@kylinos.cn>
References: <cover.1747730598.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Define mptcp_subflow_ctx() using bpf_core_cast as Martin suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 10 ++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 4e901941d5dd..815bbf865ee4 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -39,6 +39,16 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 	return subflow->tcp_sock;
 }
 
+static __always_inline struct mptcp_subflow_context *
+mptcp_subflow_ctx(const struct sock *sk)
+{
+	const struct inet_connection_sock *
+		icsk = bpf_core_cast(sk, struct inet_connection_sock);
+
+	/* Use RCU on icsk_ulp_data only for sock diag code */
+	return bpf_core_cast(icsk->icsk_ulp_data, struct mptcp_subflow_context);
+}
+
 /* ksym */
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
index a1d8f9b20259..88a3100dfdc2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_iters.c
@@ -48,7 +48,7 @@ int iters_subflow(struct bpf_sockopt *ctx)
 		goto out;
 
 	/* only to check the following kfunc works */
-	subflow = bpf_mptcp_subflow_ctx(ssk);
+	subflow = mptcp_subflow_ctx(ssk);
 	if (!subflow || subflow->token != msk->token)
 		goto out;
 
-- 
2.43.0

