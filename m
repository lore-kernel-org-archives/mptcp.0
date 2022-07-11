Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462E1FB7
	for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 08:12:25 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id bu1so4753711wrb.9
        for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPFKY/bHlsQhtgUJcy9UK+LhK0GjolHXo8PsK9MTO74=;
        b=3dWItNH/NrG2UXqFVsxOXWN+q2qqBj4vzooK3M0fqc0NW7nFtkiqcvWaIp93vV4X5t
         cvuXswhlr6y8zqUrdIAnLYVuT0/bBNWWTBvXhoMuA9ghuCH4JYnL2Co6bcDvoOC4NyNL
         9bCZmbb8jxOvLj1zTcOoMyjoZjIdOAHWBXpO4ssyke6GlXpC73oLnxfit7nnRfO6iB7i
         256ylzPv5rvMS0FCWr1MXcdyFEWc5plJLs5nVT7L83L2EGX4IHqfxBkkHMgW6NlmQk7h
         zCrXXf4WDBzabyhGC8I3ECzVLJqbg7Zl72pFR5tKA6tbrSzAQECZD2fYwxRbLLd9YFX/
         FFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPFKY/bHlsQhtgUJcy9UK+LhK0GjolHXo8PsK9MTO74=;
        b=HWDuuKTGUgy5U1zr97MdXjXFLst3VBt7hSNJyj+v3+Ihu1hAzHPO59FYV2aFcHl632
         e/RQOnkenJ7/vF5K0XAFrhDr9iHiTqMVzUN4PY20Uod2E9ONoGwFaX8o/HHgZ3GFF1ix
         ujB9FpuisofHiKLj2xLc7tgUROr+P2yVLX/5EYQYMY30fNwus0ZebNshlVBX8yao7qw9
         54le0V3OiUUgsxcPBibo6bn18JnB4O9JNvnlc6kl2O2aCccHreqPLUE+h4jVROdm2lAL
         /NkSI2756NjFt8w9vJlEakUDGSdV4OYpsd0zeo/VwQeJY8+M/5CDlqzz8ysjGMrq5kav
         QMoQ==
X-Gm-Message-State: AJIora8GiUQX6uoAZCCE2yfvlzZldmgqOSwEyaEpVL3DbV/9mFTR5jIE
	B9fo4NmDyPtu3+Y/lLoI/0lT6A==
X-Google-Smtp-Source: AGRyM1tyUmKFNUbH8YgWNHHNsuw6XFvycdzRT3nCgIcwAJdtGiyuk4Xct3kq4NBg+aexVIJb1PXCpg==
X-Received: by 2002:adf:e111:0:b0:21d:665e:2fa5 with SMTP id t17-20020adfe111000000b0021d665e2fa5mr16086610wrz.652.1657527144170;
        Mon, 11 Jul 2022 01:12:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b0021d650e4df4sm5159809wru.87.2022.07.11.01.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:12:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v2] bpf: Fix 'dubious one-bit signed bitfield' warnings
Date: Mon, 11 Jul 2022 10:12:00 +0200
Message-Id: <20220711081200.2081262-1-matthieu.baerts@tessares.net>
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

Set them as 'unsigned' to avoid warnings.

[1] https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2643588487

Fixes: 1ade23711971 ("bpf: Inline calls to bpf_loop when callback is known")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    v2: switch from 'bool' to 'unsigned int' (Yonghong Song)

 include/linux/bpf_verifier.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 81b19669efba..2e3bad8640dc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -345,10 +345,10 @@ struct bpf_verifier_state_list {
 };
 
 struct bpf_loop_inline_state {
-	int initialized:1; /* set to true upon first entry */
-	int fit_for_inline:1; /* true if callback function is the same
-			       * at each call and flags are always zero
-			       */
+	unsigned int initialized:1; /* set to true upon first entry */
+	unsigned int fit_for_inline:1; /* true if callback function is the same
+					* at each call and flags are always zero
+					*/
 	u32 callback_subprogno; /* valid when fit_for_inline is true */
 };
 
-- 
2.36.1

