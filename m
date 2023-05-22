Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79014A81
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:24 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso64198365e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773503; x=1687365503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7HypgQP7bOoEOhgZcd+GJ+BZ2UrK8vBlupHsCPMGnE=;
        b=CBZKa5FPOY9w2gA+UiENEfiw3qJ2qYPzjpyJ64dBuxIzfXaHcNtI9IwItOIH0UsMPL
         LEd9sETnrsWbDsvIRtn0fZ4/FL0PB/AXKg0mDIXIW/cxF/j8DJuS0pHkwOU2r2oIXQsj
         HeuHwFCJaCO+ooA1o3TtGakJj33USCPC4sBMBQgUSe3s/9N2+zlyvQtlk7JMPmWiTpUC
         ze4QKsDJHF8hGhszbiE01mCPsYLHxSqPHpgNgawJbd3sKxBCIkC7VQCN4LdgGUJR22s7
         czAz8sZB0+tWUl6keMpst9gqojqboThlh7cJ7xVWR7kPcMl3BjLtMCS2xEYKWXO/oR2g
         t0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773503; x=1687365503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7HypgQP7bOoEOhgZcd+GJ+BZ2UrK8vBlupHsCPMGnE=;
        b=JtjYZtAfV0Or1/M73UP9blK9BcrKSq3Z/v/dsZukG9E7/5L0t5Il+axSWVSxZFif+8
         shkv9zbuP9mXnzFL76t183GbwREBfTVkHcrndZ4jzqEnLxDVZKX7mkh1yahDfd/QwwFT
         Iy/ieE2qGG1fFGAXwcxTKV9TqX7kVjUQBnytjXCzz26NGBsCw4yszsm+cMDqlROZMRit
         2AzAvanZrKVQ8uQRBZ7il4fZmXdYLiG+K3CNoSJgcCX3LGKng/AIU5Ug9dhcUuOZsNQ/
         zIped/68C7bRlL+JUOvs//V5ACa9Tl4oRoN8hYXJjEJoxFQ7dNf8Zn4tVi/T72j2YAjv
         0caA==
X-Gm-Message-State: AC+VfDxHaeJnLzZ4Y9aC++nyizEHtcYt4ivX2SYNDlGWkUCVdKB14x1h
	qGNlwqO8skypoigzUq+Wmpm5VAzM82hVP6esQSVfYQ==
X-Google-Smtp-Source: ACHHUZ46rAmqqnCTAPLXk6RuB3I4swSGdml6lR4hX8IKXc7NA4grUHMsFZK71SSGFjY8/ejtatWQ5Q==
X-Received: by 2002:a7b:c843:0:b0:3f1:979f:a734 with SMTP id c3-20020a7bc843000000b003f1979fa734mr7687987wml.11.1684773503053;
        Mon, 22 May 2023 09:38:23 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:22 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:49 +0200
Subject: [PATCH mptcp-net v2 17/37] selftests: mptcp: sockopt: relax
 expected returned size
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-17-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2803;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=JgIEelh2mwJmC2C2ejafI9D4qMYknERgNXt4vLN2onw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pwZBKs55zVWXjHySR/v64DJIqMsCn3j9zQb
 sA8iSlim/iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 c2stEACvwO/rtggeBDySsrQXhO1BFk2sYMru4DjgQcdI4vgCbPiaVo+YnXn7pEw+pMf4cxqsAAR
 PfCUMrwSLDdn1gl1lxLG49TEB9ZVPc9MIFfi+ePOMyGBvuGQbikhGxWDmEU1myK/PMfVmZ5dgJF
 NYbpUVmwuJZ1ZkjmmXlCIqVUzuPYXNHe0sEhf4+NeSU7BvTt10Dps7NCbCifaErE/eYznhxIOJp
 BmAbAwNlgW02gleziHvVjR6cBL9ddDRa6Jf8NXD3JoJI3hYU5eXS9jALL8NJ1Bap7ErFdw+r2kr
 1nuUWpNgwT13GtMgPF7f1cbyAFfR5zX2+g9h6JHz4tqy47jBX1V1QMDjVA4Ows22suIA6ukm1t+
 Y1Z2lMBZcL5RRyeRKCE758X/jWxSlU1VeH1VygZ95MKSSLQ7gn7UHbzEN0qVwz/Ii9Hdk6emYuA
 jrmKp7msBbXBfF9MEFJw+v5+3dokIL4keKPN4/zIQk4XbIjCTUTgIzPYaLHxM/XeUS1WYqNMWhn
 dSEewaiuRq9mIQ4aeczm1wzeG/VPvrMpdS0VeTn2E4Fk/Nvxmdlc/ZAQtIuG1XoYtv1wSkBbI6d
 CiXlZZG7KeiZZVAnR97Ucg+PTSnp0mMlE5JxDLXMSQZVGxDXTh43LyZxgnlYmEWkSSZBDkxm4Z3
 MFik0sgNtJiGfpA==
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
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ae61f39556ca..7bb42fd4b0a0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -349,13 +349,13 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 			xerror("getsockopt MPTCP_TCPINFO (tries %d, %m)");
 
 		assert(olen <= sizeof(ti));
-		assert(ti.d.size_user == ti.d.size_kernel);
-		assert(ti.d.size_user == sizeof(struct tcp_info));
+		assert(ti.d.size_user > 0);
+		assert(ti.d.size_kernel > 0);
 		assert(ti.d.num_subflows == 1);
 
 		assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
 		olen -= sizeof(struct mptcp_subflow_data);
-		assert(olen == sizeof(struct tcp_info));
+		assert(olen == ti.d.size_user);
 
 		if (ti.ti[0].tcpi_bytes_sent == w &&
 		    ti.ti[0].tcpi_bytes_received == r)
@@ -401,13 +401,13 @@ static void do_getsockopt_subflow_addrs(int fd)
 		die_perror("getsockopt MPTCP_SUBFLOW_ADDRS");
 
 	assert(olen <= sizeof(addrs));
-	assert(addrs.d.size_user == addrs.d.size_kernel);
-	assert(addrs.d.size_user == sizeof(struct mptcp_subflow_addrs));
+	assert(addrs.d.size_user > 0);
+	assert(addrs.d.size_kernel > 0);
 	assert(addrs.d.num_subflows == 1);
 
 	assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
 	olen -= sizeof(struct mptcp_subflow_data);
-	assert(olen == sizeof(struct mptcp_subflow_addrs));
+	assert(olen == addrs.d.size_user);
 
 	llen = sizeof(local);
 	ret = getsockname(fd, (struct sockaddr *)&local, &llen);

-- 
2.39.2

