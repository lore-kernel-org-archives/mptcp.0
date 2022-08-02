Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B907F
	for <mptcp@lists.linux.dev>; Tue,  2 Aug 2022 16:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0066C433D6;
	Tue,  2 Aug 2022 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659458013;
	bh=9N3wE1euIFQpNs8jo/gYfxXQBUH++c2IQ5TbhgHXCeU=;
	h=From:To:Cc:Subject:Date:From;
	b=oDPTBe+MceWArUC00FMqjt3yf/4oQkZhvb1YWY03qMiusvGtDBiFVXL39EghG2UWP
	 jplRn+/rOIR44M06Z4PG7eOyUUdibVnak9B0n+EO2h6a7D9pvm0fcixrkHA4y8h8/Y
	 LnUL4XGCoA4gFuxeoVZO2csg6WOBpluAJXjx7C0dX5hGxod/cwJISPbTe0/cOBjLuI
	 CPJEgduvrOZ5Oy8gq9/ZtrzKZ/Bw1La7EEKYJcQK121vqbV9JspbX8n9pgbp+hnBzJ
	 DZn1u/FMj1ExMP5GQU4p6IIRKgrjddGGkt8SLCvrWwwv0azQ54xu9Sqf34O/Wp2Z1p
	 AG9PmEWixq7jA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Martin KaFai Lau <kafai@fb.com>,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	mptcp@lists.linux.dev
Subject: [PATCHv2 bpf-next] mptcp: Add struct mptcp_sock definition when CONFIG_MPTCP is disabled
Date: Tue,  2 Aug 2022 18:33:24 +0200
Message-Id: <20220802163324.1873044-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The btf_sock_ids array needs struct mptcp_sock BTF ID for
the bpf_skc_to_mptcp_sock helper.

When CONFIG_MPTCP is disabled, the 'struct mptcp_sock' is not
defined and resolve_btfids will complain with:

  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol mptcp_sock

Adding empty difinition for struct mptcp_sock when CONFIG_MPTCP
is disabled.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/net/mptcp.h | 4 ++++
 1 file changed, 4 insertions(+)

v2 changes:
  - moved the new empty struct declaration next to the inline
    bpf_mptcp_sock_from_subflow function [Mat]

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index ac9cf7271d46..412479ebf5ad 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -291,4 +291,8 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
 static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk) { return NULL; }
 #endif
 
+#if !IS_ENABLED(CONFIG_MPTCP)
+struct mptcp_sock { };
+#endif
+
 #endif /* __NET_MPTCP_H */
-- 
2.37.1

