Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751E154B8
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:46 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f623adec61so61307335e9.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542604; x=1688134604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47XCLjZwP/igKiwOnLpGF0czl3I4/1icBTsjj7iWJ/o=;
        b=XbfRWXzAGSqTy1SZjOLyFxGJgZXWU1dIuEbNYsX/X2Bkm2UycMh4qP/J9rsP6/YElj
         /Pyi1cSr7cd7lJdHeakBBEW3eGZeleffmF3Vnf8+W9YrETHy0YGLT3bFKoVslJVIeJ2y
         sy3/ONPU3zHRj6xG+knz11TA3WTqwTyluda/epzWGGViqkh5iyR0fHUI8AnHPrEL4A6t
         /3dFFPxeByeDqhxSvVnz9avNoNoRAmPTVQPFc5/dqne6isXBja9jMcBL9HUYjohFMV+u
         8p2BZhZFLYTPP6RcrNTifLv6RKEtAXrlUonLcnAssVRrEoizf1UKPQf2AjTkd6xUPJrK
         rbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542604; x=1688134604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47XCLjZwP/igKiwOnLpGF0czl3I4/1icBTsjj7iWJ/o=;
        b=L3tpdgF7V59VXR/eVCRJJHgXOERR883dbcx7l6yVj+RkbMS3aNqDQGNibvkoVNvw6D
         8tKkTuQ1e4z2JbS6Bk2b88moML3Oy9qWCnBfNeCWeIYfOyW6TrGLe7TUiPEjbSGyrMmK
         piYRPx0znkCPNgD1UMh28X9qx3dMQGs0eISTOMkp7pOU2A1X6TfSQMviK+ImoPzPfCW2
         8TX2s5JvAKNxc1W2t56Y1iTvgR6+HpXgixR7UHrKy+ONQyLGKfxvCRgly7iOkrg8Q5xY
         vPDMAu4bASoXwUDg1AVBfihUACQ4BZ4uwNznjDKmL9RgnatsQNhW0tYfLOeVMPHQ8FVk
         yVgw==
X-Gm-Message-State: AC+VfDxUKTS5OyOdjOxySrFtFTPcZKbO3GCpey3CYhF3V5cXtLBRKr5C
	PG0EcnS2oN0by6YEYRHXQ1dJvIXw9x6DAlo2ml6Go1Xa
X-Google-Smtp-Source: ACHHUZ62IFN/5yWOLIbwTu7yl6psxQXrBHM28a29VQyETnuHXj5fCm5eXI8RN29c5YC1bArsAitChg==
X-Received: by 2002:a05:600c:c3:b0:3f6:3e4:7cc9 with SMTP id u3-20020a05600c00c300b003f603e47cc9mr4121680wmm.40.1685542604362;
        Wed, 31 May 2023 07:16:44 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:44 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:30 +0200
Subject: [PATCH mptcp-net v3 10/32] selftests: mptcp: sockopt: relax
 expected returned size
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-10-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3168;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=TKFUMOATm1EJOX99mWsvUDDcv2YOqsvLTpXOJXpt/gc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bC0Tr9+nyhJmBnN1NDkHcsct0Fqj0DCwOlc
 AVtEXVfNGWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 cwXuD/4nuMwzkqAWyKyYUDr2vI+2NIAjd7LILMCH40BkpTmNIMJdKg0N9zzMZKTI9tkDLU244fo
 d+FKkzQhSvNKg+A7IPpSjBlVv7HmQq7PdL3uNJRToesMRUXdrmbNcORDkNLpr/N0cXKnd9RYuUG
 ybGT3j3FkQlYOPYVoQ15v7HKg9sJN7pzesRUtxySrTMD/iTphayeok2a6yIb19wgKAAllspbDwu
 lDBKHhVSP4n1SkfWlYporpJLUmaO7PAUXKnkj+BttyQq0JJMSBCpNdOxn4c7Q+dX4gWvpsIK40L
 nlgLvALW7LhfXtwLpekkdwiirGt1IB96w1hfBAJsMbHQD6JziHwdHxie47SIeDuQ31SuxGIQ9el
 sO482D4HN3BIRBRDlCtfGpspD60ZOWjzXhmJM49qiDqUq4g8OnF4j9KK5S4O0mqh8tk9fEGRWGd
 yXfVTcWABNqecLiuZj8Z9qYjQcZHaT3cNDiOMZn3UfqmF4bi68+/wP4MgbntVfPXqSouONrWK7z
 xE0GVu5pr7lfrS/XXp7QFWPJwlIa15uQJmcue7EloaHoPwWigGgJ7o08/LKZ0RFiKliG/Ay/czr
 lhk7iNSOEk1Tze89UhVkuEW3dck+mV791ULaWfqV1Th90s+/oLjJE2vNpHoprT/KVecKdu46jTa
 1yKaAz9uJhQxhlw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the getsockopt(SOL_MPTCP) to get info about the MPTCP
connections introduced by commit 55c42fa7fa33 ("mptcp: add MPTCP_INFO
getsockopt") and the following ones.

We cannot guess in advance which sizes the kernel will returned: older
kernel can returned smaller sizes, e.g. recently the tcp_info structure
has been modified in commit 71fc704768f6 ("tcp: add rcv_wnd and
plb_rehash to TCP_INFO") where a new field has been added.

The userspace can also expect a smaller size if it is compiled with old
uAPI kernel headers.

So for these sizes, we can only check if they are above a certain
threshold, 0 for the moment. We can also only compared sizes with the
ones set by the kernel.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v3:
  - size_user: check if it is the min between the user and kernel sizes
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 86a378731e8b..de897f77e174 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -123,6 +123,8 @@ struct so_state {
 	bool pkt_stats_avail;
 };
 
+#define MIN(a, b) (((a) < (b)) ? (a) : (b))
+
 static void die_perror(const char *msg)
 {
 	perror(msg);
@@ -386,13 +388,14 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 			xerror("getsockopt MPTCP_TCPINFO (tries %d, %m)");
 
 		assert(olen <= sizeof(ti));
-		assert(ti.d.size_user == ti.d.size_kernel);
-		assert(ti.d.size_user == sizeof(struct tcp_info));
+		assert(ti.d.size_kernel > 0);
+		assert(ti.d.size_user ==
+		       MIN(ti.d.size_kernel, sizeof(struct tcp_info)));
 		assert(ti.d.num_subflows == 1);
 
 		assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
 		olen -= sizeof(struct mptcp_subflow_data);
-		assert(olen == sizeof(struct tcp_info));
+		assert(olen == ti.d.size_user);
 
 		s->tcp_info = ti.ti[0];
 
@@ -440,13 +443,14 @@ static void do_getsockopt_subflow_addrs(struct so_state *s, int fd)
 		die_perror("getsockopt MPTCP_SUBFLOW_ADDRS");
 
 	assert(olen <= sizeof(addrs));
-	assert(addrs.d.size_user == addrs.d.size_kernel);
-	assert(addrs.d.size_user == sizeof(struct mptcp_subflow_addrs));
+	assert(addrs.d.size_kernel > 0);
+	assert(addrs.d.size_user ==
+	       MIN(addrs.d.size_kernel, sizeof(struct mptcp_subflow_addrs)));
 	assert(addrs.d.num_subflows == 1);
 
 	assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
 	olen -= sizeof(struct mptcp_subflow_data);
-	assert(olen == sizeof(struct mptcp_subflow_addrs));
+	assert(olen == addrs.d.size_user);
 
 	llen = sizeof(local);
 	ret = getsockname(fd, (struct sockaddr *)&local, &llen);

-- 
2.39.2

