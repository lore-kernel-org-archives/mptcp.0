Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1BEBC
	for <mptcp@lists.linux.dev>; Sun, 10 Jul 2022 08:35:30 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so1430880wmb.3
        for <mptcp@lists.linux.dev>; Sun, 10 Jul 2022 01:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orIIFdtRbt6cm/l/3AlelKzIyuzEuMYVC6VdEiG/HhE=;
        b=xw92GhKX4WJO8whQD7utDC8+8bFUEokf6yXN1jTy1b8fK7xUW6SB6d3+HjS0DvXLln
         bu2CcR2YFRaQZFjV19f90BQSnxs/vaoHsaybo7j3aeVfpytGIIkW/Xvu6uexB8PrE/Ge
         XpYOfxY7hQT9u0RvKILf+GBEYrXwvGdduWd9tyDOcEztbS14h6uOF50qQmRSixwuhmaQ
         jGpgJfWQZidxD74rkU11R6urlWEKy51jhcyDMa0ZO0DyHjFSy7mzxI64jEn52drPB0kz
         7Ydd2tQlZibBTDjy+AbGQ3K1FhRIf5cOSzCjwF5S/q3gOwoMi+NmYGtAUf7DVfmfKZL3
         PDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orIIFdtRbt6cm/l/3AlelKzIyuzEuMYVC6VdEiG/HhE=;
        b=l2dDJqrXAzLkEaFWhWuq9NbtREOyPcuuZ/+ZRsw4YgOmAQ1+KmTlvY3Vy3q65ZIJu3
         IOAKNf1VkxyUUNHiqQWwfMSYss10YgsDMi/BzuSsPhfr7nvc6BhNgTjWMaC5SObIWJDq
         VLbI8+qWNYUNE8PGV6ZdIIU0Pw2cJsdwpUfV/jbMwaUnowYvZejMCGxkENBqRYECsVp/
         GjNDJ103XTIjLH8qcidWXyabE5VWoJTXuQUAxfwW49TIIBmxGXawuU5suGUZtIbqMik9
         QRi8vXgYKF5mWSAFdGOFq3/ArzMN+Epw5+SP9jxLjoNEukl+Z7q6mD6yRzytA5+UrVyq
         JHrA==
X-Gm-Message-State: AJIora+kmIH0wzLSlXKMdBmg7lyKxZJdBPprkd7pEtPp3S6YYJlcwri3
	VYNv7l8VUyJx8930kORlSnpo8w==
X-Google-Smtp-Source: AGRyM1tfaaudoS0WgFrUsnxUfK8M9lLdROl46O50ihd3Xfy0Amv5OvYdh8xbcdjuftlmcbSlpL7aYw==
X-Received: by 2002:a05:600c:4e54:b0:3a0:4e07:ce with SMTP id e20-20020a05600c4e5400b003a04e0700cemr9652537wmq.37.1657442128721;
        Sun, 10 Jul 2022 01:35:28 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id b17-20020adff911000000b0021d819c8f6dsm3120944wrr.39.2022.07.10.01.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 01:35:28 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: fix 'dubious one-bit signed bitfield' warnings
Date: Sun, 10 Jul 2022 10:35:23 +0200
Message-Id: <20220710083523.1620722-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our CI[1] reported these warnings when using Sparse:

  $ touch net/mptcp/bpf.c
  $ make C=1 net/mptcp/bpf.o
  net/mptcp/bpf.c: note: in included file:
  include/linux/bpf_verifier.h:348:26: error: dubious one-bit signed bitfield
  include/linux/bpf_verifier.h:349:29: error: dubious one-bit signed bitfield

These two fields from the new 'bpf_loop_inline_state' structure are used
as booleans. Instead of declaring two 'unsigned int', we can declare
them as 'bool'.

While at it, also set 'state->initialized' to 'true' instead of '1' to
make it clearer it is linked to a 'bool' type.

[1] https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2643588487

Fixes: 1ade23711971 ("bpf: Inline calls to bpf_loop when callback is known")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/linux/bpf_verifier.h | 8 ++++----
 kernel/bpf/verifier.c        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 81b19669efba..2ac424641cc3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -345,10 +345,10 @@ struct bpf_verifier_state_list {
 };
 
 struct bpf_loop_inline_state {
-	int initialized:1; /* set to true upon first entry */
-	int fit_for_inline:1; /* true if callback function is the same
-			       * at each call and flags are always zero
-			       */
+	bool initialized; /* set to true upon first entry */
+	bool fit_for_inline; /* true if callback function is the same
+			      * at each call and flags are always zero
+			      */
 	u32 callback_subprogno; /* valid when fit_for_inline is true */
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 328cfab3af60..4fa49d852a59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7144,7 +7144,7 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
 
 	if (!state->initialized) {
-		state->initialized = 1;
+		state->initialized = true;
 		state->fit_for_inline = loop_flag_is_zero(env);
 		state->callback_subprogno = subprogno;
 		return;
-- 
2.36.1

