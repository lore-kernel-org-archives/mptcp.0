Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7817FFC
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 10:50:28 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3159d5e409dso452720f8f.0
        for <mptcp@lists.linux.dev>; Wed, 09 Aug 2023 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691578227; x=1692183027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FA2Np0axnCcM7zYYQ9J3PNsrfsw3IGeC9vgEKu3nCGU=;
        b=rEyYCnfsy3v2ug/uuoFLOJFvx97QjFH3Ja4HZMdP4ywagN1Opk8E+zw15eNChpRGwe
         NQPtx3FXl6/MJAxf65uU0/tZ91owLPW0nUcSngIU7L7MJI5+ofN10W6SiJdOJzKrwCrk
         dn7hPAPLn54iejr9Gj6f9FzWJEM8tLVE/rLuH7GPZukjcTv6ydi6aVxcw4vbbc60hWhD
         XTwHq2EX8pi1TNUg77QYUmZ1R7SP1UzNhZk2I2tB+gFKeBvKXjkWHmIc2ShCnYm9kZYv
         vxhwgV34w5SpV2tB4e6z8ifiW7cxLXpVQhl7MDJ7US8VK0w5BAzOH4LOZmkDHGVXubwR
         QqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691578227; x=1692183027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA2Np0axnCcM7zYYQ9J3PNsrfsw3IGeC9vgEKu3nCGU=;
        b=KLBFrMEklGAa9vjKlefTcjMNTY0dc6MIszeFCl0dbrzU/d8gs2Y92vH4fjsKWh4FwC
         xsLOYVQwFMNT7STH0HGAEIDmX02nbMrLkaJDDaZQCrrKUOUVtT5cE2VLpBH+8aIjcN5w
         eG4K9yuv6sX97JDwUv/Azk5mluosO3lzNoNUdnprqh0k34U/Z0fKTha3MPgNqwhef3tK
         avFcQ72cGFwXtAgsnJIFcV1FMBMJBynkPubvIWw4FcMmNASt3MXPYpIK2O5Q667b/wAt
         QPh8+EhA2VwJsFwLXUOd+cSTjP8aB9kEgfUZ5dkrZpwKCFwpUPY9ggI0KzHm3mEoXe5v
         hS1g==
X-Gm-Message-State: AOJu0YzJEJmLySVni5OzmxaXuZHFCednoHz6KHiqpAp3N7wDDC1DpZna
	Id/Ao7ttRolaBa6HRBgpujM=
X-Google-Smtp-Source: AGHT+IGVOiuqd9gPz2ysaQveRBO+7QiucnjN07+zJsP9fuLpr3wX6feLhaMGnrMi+X/MzzFIFKFKUA==
X-Received: by 2002:adf:ebc7:0:b0:313:e2e3:d431 with SMTP id v7-20020adfebc7000000b00313e2e3d431mr8793934wrn.12.1691578226789;
        Wed, 09 Aug 2023 03:50:26 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4009000000b00317a04131c5sm16412452wrp.57.2023.08.09.03.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:50:26 -0700 (PDT)
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
Subject: [PATCH v3 09/14] ax.25: Update to register_net_sysctl_sz
Date: Wed,  9 Aug 2023 12:50:01 +0200
Message-Id: <20230809105006.1198165-10-j.granados@samsung.com>
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
pointer. We hold off the SIZE_MAX to ARRAY_SIZE change until we have
migrated all the relevant net sysctl registering functions to
register_net_sysctl_sz in subsequent commits.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/ax25/sysctl_net_ax25.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index 2154d004d3dc..db66e11e7fe8 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -159,7 +159,8 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 		table[k].data = &ax25_dev->values[k];
 
 	snprintf(path, sizeof(path), "net/ax25/%s", ax25_dev->dev->name);
-	ax25_dev->sysheader = register_net_sysctl(&init_net, path, table);
+	ax25_dev->sysheader = register_net_sysctl_sz(&init_net, path, table,
+						     ARRAY_SIZE(ax25_param_table));
 	if (!ax25_dev->sysheader) {
 		kfree(table);
 		return -ENOMEM;
-- 
2.30.2

