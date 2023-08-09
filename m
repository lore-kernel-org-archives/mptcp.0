Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E971800E
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 10:50:35 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so106771871fa.3
        for <mptcp@lists.linux.dev>; Wed, 09 Aug 2023 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691578233; x=1692183033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5coRDrjBWUoHZlIcsYrUKshhaoM+GPSlsGMwisO1OVE=;
        b=rOcCjLBIeZiN/uKCqBn+ZnIy9GGjjsq5pNXvUnFAqmrNtJ4AytMROihb81KAsXmJ32
         Y7Yp5fm6fmP2fGjhIdvMngbMnPvBFVwYNsoQDzVYr9FtuJ64uVVnxbwI3PtEVxiTSLPO
         UZASCKd04coZGK/tilWlVhuwtgTUeqXcU5Bf1fIwNtI0/y8hj9Yc45yBrsHKfUpCcHDp
         kFJcIQAdfWb5ym4bbpJbP/lR3gwY0aaag9FOaZ3QviV/VCgx4QfmDZ1aluNctgg7Te0p
         lG6isVbiPFi0/xEfOVe2L4NzccRRq/tSsjLfJrDm7hubbYzVeX52y/inZs+Y2Yo9JzK3
         a3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691578233; x=1692183033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5coRDrjBWUoHZlIcsYrUKshhaoM+GPSlsGMwisO1OVE=;
        b=D+Y2PDS7vARzwNzAG8mSukhtelUF0uMIr57ULrqcnpDPED6jrUHHT1LVk6sYXvgrKp
         ef1UI0kUarOAZuYHBVmHeKjSNTNH5F49CpDG8AUHrtQc88WRCPSiiTf/N+HwKjMUKciv
         yPcxrwMxN4B5yRKdlmuSZ3KFGPJFUZCOT7PHqq+hVGXKcpJsI7LMKN2bOE0nBRf9MB0T
         Tgo7K69hnSHhGvZXtIBt2kvAYT636M3yQ5tLt41rNx4bdWzmUOg7zp20akpS7wZL45IU
         ZVmGKgJOxt4yvKqRZRQhLVKxfzAslwRa0grFW7N8IHIGs0KSqJCkTH49oNelkREpSAe6
         N96A==
X-Gm-Message-State: AOJu0YzHEcP0pZTmnVm8q3yxLP38X6nFO2xGzIvxHVQRRGHt1bg6TQ3j
	8roixye2bmJ1+jKV+5jHbAg=
X-Google-Smtp-Source: AGHT+IHWRnSEDbitoHF/CBryJG+yHfCg7WXA65f2AROxn5cF5vjRFsYuV+TtdLC0fGabCK8Cr1cm6w==
X-Received: by 2002:a2e:2e04:0:b0:2b9:ac48:d7fe with SMTP id u4-20020a2e2e04000000b002b9ac48d7femr1633844lju.38.1691578233520;
        Wed, 09 Aug 2023 03:50:33 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b003fc01495383sm1647099wmo.6.2023.08.09.03.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:50:33 -0700 (PDT)
From: Joel Granados <joel.granados@gmail.com>
X-Google-Original-From: Joel Granados <j.granados@samsung.com>
To: mcgrof@kernel.org
Cc: rds-devel@oss.oracle.com,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>,
	willy@infradead.org,
	Jan Karcher <jaka@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@verge.net.au>,
	Tony Lu <tonylu@linux.alibaba.com>,
	linux-wpan@vger.kernel.org,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	mptcp@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Will Deacon <will@kernel.org>,
	Julian Anastasov <ja@ssi.bg>,
	netfilter-devel@vger.kernel.org,
	Joerg Reuter <jreuter@yaina.de>,
	linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-sctp@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-hams@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	coreteam@netfilter.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	keescook@chromium.org,
	Roopa Prabhu <roopa@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	josh@joshtriplett.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	netdev@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	lvs-devel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	bridge@lists.linux-foundation.org,
	Karsten Graul <kgraul@linux.ibm.com>,
	Mat Martineau <martineau@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3 12/14] vrf: Update to register_net_sysctl_sz
Date: Wed,  9 Aug 2023 12:50:04 +0200
Message-Id: <20230809105006.1198165-13-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809105006.1198165-1-j.granados@samsung.com>
References: <20230809105006.1198165-1-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move from register_net_sysctl to register_net_sysctl_sz and pass the
ARRAY_SIZE of the ctl_table array that was used to create the table
variable. We need to move to the new function in preparation for when we
change SIZE_MAX to ARRAY_SIZE() in the register_net_sysctl macro.
Failing to do so would erroneously allow ARRAY_SIZE() to be called on a
pointer. The actual change from SIZE_MAX to ARRAY_SIZE will take place
in subsequent commits.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/net/vrf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 6043e63b42f9..6801f15ac609 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1979,7 +1979,8 @@ static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
 	/* init the extra1 parameter with the reference to current netns */
 	table[0].extra1 = net;
 
-	nn_vrf->ctl_hdr = register_net_sysctl(net, "net/vrf", table);
+	nn_vrf->ctl_hdr = register_net_sysctl_sz(net, "net/vrf", table,
+						 ARRAY_SIZE(vrf_table));
 	if (!nn_vrf->ctl_hdr) {
 		kfree(table);
 		return -ENOMEM;
-- 
2.30.2

