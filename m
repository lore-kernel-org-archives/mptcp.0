Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928614A81
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:20 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f475366514so43355185e9.2
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773499; x=1687365499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmkb+a8MP3d+VPMUmmoagfKb9YIEvkcYO3Q4y2P9JTs=;
        b=pDkt346aT/BB+CGnK2Afy/ADVyRFP0R2zY2VmHPT7rj2X6qfQ2UiH1RPPADakpXDSS
         liEhkJ/017kUnchZwM3eA9dGgE7D5vd0iqSlYD6qJ33kEKQSEtK6muTx/w7l1FyFik4l
         kHq9fFzvrBUg5BlAwLznmwdRX9yETpkwfSOStlhATItDGNFU+9YafN1aNW8Ryk8nqa6P
         mOW0ZJZzQtVW1ISBXZaBSsSr3O/dF6autg1NarS0uXtuOc+hop6NnSkztfxLKqyvHU8V
         nFqegy0iOxcUOSj+L7LldMvKfHN+NP+dF10cSiDLfPP5j0P9JUOvYvTCdFnqgBu7dDeT
         +h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773499; x=1687365499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmkb+a8MP3d+VPMUmmoagfKb9YIEvkcYO3Q4y2P9JTs=;
        b=MqOjemyDq5jpVn5HqS0lT7elXvzifyY1dJmOa9RGgVEeLYuk+PVzIe07hEaKZhqINz
         mvFnmsW1w2OrALc+FP/u8mlHBwYC0gc5pl6CphSitxA1hqH/H5SV+hK9mGwd//fzEhgk
         Ep6teI6aijVk7J+4h++pT3E0kCLNFiztf1FQClwM0N0gy13MuSdu3zokKTMScXqU4kDf
         O2BOCzSbfaR6Bm45Ztxk6LWjYBdX8+xpSQBuhs11xjtNAa7bdPkxxcMxKQP2YXQ5JHr0
         p4e4QYUPpsM73w7YwMtsXq6c29P0UC6B7lZ7LgZ8Mp/g9aV0wmfXKCzhbwcoE/kGwOu6
         su6g==
X-Gm-Message-State: AC+VfDzJ7yYZ1PiI2GVww5uS24IKXiI0js5l8isi1r9BWs8X9BrD9GQn
	QY88TtmlGMwmePEdNJmHKEg6IsnGfG6QWxbY345n/A==
X-Google-Smtp-Source: ACHHUZ4R3yPz/27/meCV8nJbEVazLxSGtzh/uGKtJikCNaLFdq+gTJL1ghYGK4AZVIeosiQyfknHMg==
X-Received: by 2002:a1c:6a03:0:b0:3f6:580:b091 with SMTP id f3-20020a1c6a03000000b003f60580b091mr2132495wmc.16.1684773498959;
        Mon, 22 May 2023 09:38:18 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:18 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:43 +0200
Subject: [PATCH mptcp-net v2 11/37] selftests: mptcp: connect: skip
 disconnect tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-11-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=GItYauKucmJKHykmdwTzcJw8s50WdElhbpicSZP2sIo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pwzum057NsOwd3OeS/5AjAJRMKHQ8V91yUa
 VfKcap+cPqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 c2KREACf08mTU9Yed5N+zBcdmNNrcSLhwI7PTi2sp7scAv/gDkMaVAYPh6RtWBFL+CDgQdL3XlP
 pkwk8ryr2Pbl673NNB6LDuZ9EwHdM9GACUn9CTA+9f+Ha3b4D5Ag8A5FnooI7R9uAAOuCobT8P2
 yDV9A5sTt8nQ/hmsTn5SkdJJp/ECvm2lb5B4HJGjz6qJP07NB996qdB7qSyflQQpaTN53f70MYu
 cgU/U0eW58ikHIfCXUV5gqZ8j62q/sv5Te1FMvlUy+acJM5kexjLq0R7lwuYmN5LbM5aD+z0VBc
 eBQCDBCqtcolWCsgZHc48aXmWACTHjfbygL8VdjB79cEmcqWd1SBVEJJ8vjxtbry1k+tCSgbqwm
 G+C/JTL2wB6ztRjDQWZKCv2BabSoIe90N8raAH0161rql1PjAvxMZsaSC253YCsznMFu4LYWYd9
 cT4xdGdpDORcchin9/7Z9pSzr6IbmY0FnH+jYH4rYMJmHJuU3clqgg9f94GdRTp00TS/5mSYipW
 gjcygybYlnyWlawOfV7ZcWwp5iNuDkDe49okYj0XrAYOjjDq0lqLDF1YuJEyebLucozscAXM3aX
 Gz46/E/txpA6Md6ErqISlwMx2IAL41KHZDMAOksHQriZy2vBUdx816krvZMLFu0HtPCHBtlpQUP
 K8FOmrh9kzJSotw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the full support of disconnections from the userspace
introduced by commit b29fcfb54cd7 ("mptcp: full disconnect
implementation").

It is possible to look for "mptcp_pm_data_reset" in kallsyms because a
preparation patch added it to ease the introduction of the mentioned
feature.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c6fcae6b2562..1b2327d569a5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -797,6 +797,11 @@ run_tests_disconnect()
 	local old_cin=$cin
 	local old_sin=$sin
 
+	if ! mptcp_lib_kallsyms_has "mptcp_pm_data_reset$"; then
+		echo "INFO: Full disconnect not supported: SKIP"
+		return
+	fi
+
 	cat $cin $cin $cin > "$cin".disconnect
 
 	# force do_transfer to cope with the multiple tranmissions

-- 
2.39.2

