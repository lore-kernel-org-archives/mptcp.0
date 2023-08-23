Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3EA939
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 07:24:30 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so8288499e87.1
        for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 00:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692775468; x=1693380268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqALlOGxkqWLp7QsNDng1dKla6oJzZP+TsYhQ5UK3Jk=;
        b=1mDgEA2EmoZjWYy4JTLRceF9KtFcsz61CJymGV6691SJuyH3BTHQYqAv7jDybqU87i
         ZAYd4Cl1KcB+pxcFFbYeN5N8/MB3dkK27O5x+4yyvrVDG+1bwGlmbYkcHEoShanMF/1l
         dVhBdciD1F5lauJy58fa15eC+igpOXoI/K8+/vvZ8AN4AJsW1PB3htA2OTmBQ98Wr18/
         tUNIoH5GSTNEOernLJEqRYcYZL4v8nxLXrRffMjiSsYRzZjt/e6TSvqqlDBMM65L+ChU
         1ywDAWqHhAgnex/SyQxCaW66qOCWc/U3hQv9chkWYO53ErGfFLJGZsX2kucsrteT38eN
         y1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775468; x=1693380268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqALlOGxkqWLp7QsNDng1dKla6oJzZP+TsYhQ5UK3Jk=;
        b=gQM2iSwZZnph3XA4uuIVm5YSZuBBWF6K60H2bwaggPUWRH72HrjynU9hKo/IixbBYS
         fuv2FJYM/1QFCQMfc3EESasGpcrlFy2Lz6C4Ut6KMWEXjEMJqVN7kXGDiRP1I2Mg3aeS
         527DveAjJWBV7HFIGnFeU8tNqc1TYilnkxFh3dxq2Tu4V7E+LZF641m01Qjd7H/W13V3
         QKBgoMGTvqBhbfaRIrWo35jubo+Id6K3Uc8vVLeoRRNm6WkcmZt7bbd/DMajKJgxjZfs
         FojvoEUWlbjacSFY4UmgaNcHZfhLG/e1l2h3njvqOahfMwD2xmSSxHm9n5p8aUxYv8fv
         E16A==
X-Gm-Message-State: AOJu0YznVXBKvJJ64PI8xmDBwopN+BtwRkK1TKkRhg1gSSItMtVP8cub
	D0wMmjRj9NBU1/VZ4Fyh/D6X+7MH4zib37uYvG3Axw==
X-Google-Smtp-Source: AGHT+IEwr84qm9yaaMBxqazzqnNDqbHNSVaV8l16ViTFku2wPS4JJNmQQctEoDNhnkU9txqJJNcuDg==
X-Received: by 2002:a05:6512:2512:b0:4fe:af1:c3ae with SMTP id be18-20020a056512251200b004fe0af1c3aemr8942846lfb.15.1692775468200;
        Wed, 23 Aug 2023 00:24:28 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d594a000000b003140f47224csm17975418wri.15.2023.08.23.00.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:24:27 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 23 Aug 2023 09:24:08 +0200
Subject: [PATCH iproute2 3/3] ss: mptcp: print missing info counters
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-3-fcaf00a03511@tessares.net>
References: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-fcaf00a03511@tessares.net>
In-Reply-To: <20230823-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-fcaf00a03511@tessares.net>
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>, Andrea Claudi <aclaudi@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=/OFZjX2EyDXdp6wHxgIF2qZHWHzH+QXRp45KKKVz1AA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk5bQlgR2MWecvXklalSonBevXFc0vsQ6Yh8U7J
 ewtBvsg7FOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZOW0JQAKCRD2t4JPQmmg
 cwOlEACGG6bmf2dREneYhBZAZG88tAMo8rJvJr8EDgDZC+wjbSfQEdz0eXkHZAPPTx7VcZ8JXwD
 MJktNDAcDTXZhzNeItnl2WFN0XHOyzZJh8avJOTJUDi8Gm32gZmD4ikXI/fGMhlgYzwpsmV7YGW
 cvALM8eIKIIhQQpBB/OyongsV6/XI/6mr5MtMkMkZ/B3XHSCFNtmEhBfdgbSBalAxUph3fv38ri
 3kdL7vY3ujXVNmK5A7eJyGSGg3c309B6QeQeopG3R5XtRGpxGlwftNe7uuWKPJu0YsqCD78robW
 VbXnbbpYEiFbwVOdpyM1QXSg3HdB62xfgpZIZFeaN3R9ZsjBMTf4djtXAFZd2CxQ4CglpiIb7u9
 NNafGCZbFUEMu1lFWHNWsRoXwheezaAbsDEJ8oSu9IA30iA1/m62VywCiqujZEcX33htnpKOp3+
 yGM8QoTPMAxxe0P2w6Av1EtDEa1ynhvPY5dvscxMxMa1HC9bdsqhwAz9XYOfd4yPhwIQdgeeZA8
 PFYLrXk+2pLv5JszIdITOkYpXNRoIVTsdeHJRjE7lHm8fdx7q75CPUn3b8hTZXKmsnGTmFsam5L
 4BEjaG/mYWBNbNgLFM5SmJzj0qdtojVWn6esNt8M54wk6ZKK04jmz0Ak4RNeaXDztOELycGeAQ0
 Ba0DnVYpYPWTdFg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These new counters have been added in different kernel versions:

- v5.12: local_addr_used, local_addr_max

- v5.13: csum_enabled

- v6.5: retransmits, bytes_retrans, bytes_sent, bytes_received,
  bytes_acked

It is interesting to display them if they are available.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/415
Acked-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Andrea Claudi <aclaudi@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 misc/ss.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/misc/ss.c b/misc/ss.c
index d1779b1d..9a6188bb 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3255,6 +3255,22 @@ static void mptcp_stats_print(struct mptcp_info *s)
 		out(" snd_una:%llu", s->mptcpi_snd_una);
 	if (s->mptcpi_rcv_nxt)
 		out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
+	if (s->mptcpi_local_addr_used)
+		out(" local_addr_used:%u", s->mptcpi_local_addr_used);
+	if (s->mptcpi_local_addr_max)
+		out(" local_addr_max:%u", s->mptcpi_local_addr_max);
+	if (s->mptcpi_csum_enabled)
+		out(" csum_enabled:%u", s->mptcpi_csum_enabled);
+	if (s->mptcpi_retransmits)
+		out(" retransmits:%u", s->mptcpi_retransmits);
+	if (s->mptcpi_bytes_retrans)
+		out(" bytes_retrans:%llu", s->mptcpi_bytes_retrans);
+	if (s->mptcpi_bytes_sent)
+		out(" bytes_sent:%llu", s->mptcpi_bytes_sent);
+	if (s->mptcpi_bytes_received)
+		out(" bytes_received:%llu", s->mptcpi_bytes_received);
+	if (s->mptcpi_bytes_acked)
+		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
 }
 
 static void mptcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,

-- 
2.40.1

