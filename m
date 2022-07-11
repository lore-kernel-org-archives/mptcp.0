Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848F7A
	for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 13:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1BFC34115;
	Mon, 11 Jul 2022 13:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657544861;
	bh=KSVdsk0NC94AFJ7bwZTkH/uOWzU/O4IXdwEJf7+JQRM=;
	h=From:To:Cc:Subject:Date:From;
	b=LwtVCWnFJ5qNCmvJ3MuDYWA0XulRjmnaTSBRNLMBGbyRHArvy0eTmKpPJsTky61CB
	 WPKNH2IzcClJ8JfJ/yYwEnUFIErWoDpWNSXUPTGUdES3+ZZvgAlN+O2RtCBBRJ3F0o
	 FYUh2d1+MoMqpdNKw0F+b+vFD+CgVJntB62C2KftadQU5dH0J3sOkru8F4WngeDhrk
	 uIpRmvHjLnQNhkuYE8zDQsjhx7UgJDloIRXJMhB3F/JGOHSEW6nIDeI/0dQnW8eWiC
	 yKT8wTEr9bOHgMdFaaMqGmr+csxxLhNfBorSFZQ4tJn9hiFE6GjLY8QuM6u190R5IC
	 swvAO72IDnwMQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Geliang Tang <geliang.tang@suse.com>,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next] mptcp: Add struct mptcp_sock definition when CONFIG_MPTCP is disabled
Date: Mon, 11 Jul 2022 15:07:31 +0200
Message-Id: <20220711130731.3231188-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.35.3
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/net/mptcp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index ac9cf7271d46..25741a52c666 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -59,6 +59,10 @@ struct mptcp_addr_info {
 	};
 };
 
+#if !IS_ENABLED(CONFIG_MPTCP)
+struct mptcp_sock { };
+#endif
+
 struct mptcp_out_options {
 #if IS_ENABLED(CONFIG_MPTCP)
 	u16 suboptions;
-- 
2.35.3

