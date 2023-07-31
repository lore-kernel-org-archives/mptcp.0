Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B33D525F
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 07:17:37 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso54625271fa.2
        for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 00:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787855; x=1691392655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akvTsUNH5BR7B9r/hWx35oPtJ0e++GeR0ZkfT+4F3fU=;
        b=ZKQeQX5TR6QzJyvC+jY3QinjsFbGR63r2icZC6hzaVo+s0UZo1N65kjwkZmKHZrkKE
         sSYOktpPLbGgM7aqBZ0b1rqN2BxrDUJEH2hSAwmCepD/Rnl20eMrMex+h6LkhwAlRRxP
         4VAezr+wMiqBBh/ks6rfYJ6F6OceClwfqnKIoljP8I2C/BrMALnLZe0aI9bB7s+wQLhQ
         ENxpNvWIYFyncIGwwtoPq84D6YspqNt05jaf84ECX5PKzi8xKkI+be3IbzdkaH1oKEeO
         oldlnFQnhBVNJ8w02YtPED3gSrPaCnL/RBpOScGa/8v4QhijcBrs6CpRh28yzNB0FWOB
         JOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787855; x=1691392655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akvTsUNH5BR7B9r/hWx35oPtJ0e++GeR0ZkfT+4F3fU=;
        b=fJ24K2wuBNWVeJQje8u4nqwZkW9ft8xA6sD3ucrVM+ImR660PYW1jwdAnQrv5960lQ
         L4FipJwmDty3WB4wG/X6y+Nm2Pgh35CRxmm5j/4ZESbE5K5mcoe9jJerTsJdVNb+KPbT
         mnHR/Xc0TSYFQ1sD57sWF9WZ/NpiTb0Qc2GR9s6Zn5zDPj1rnPhIKgv/F8CXn+RvnNxO
         RkOyEbdWavtdXJ7Wf2Dz3wdsLtoDMGqAGVTbLitvM6rmG+bSSEtn5w46R8a2peKgYiFg
         Xcuh5rBSRjUUInfIS+7l1zs+vHv/acXnT9cMX1yM9HVtEmbMyGh/BOQUYSJWVUzZcM0K
         RSXQ==
X-Gm-Message-State: ABy/qLaZ4R40hdx3qn0cE0cAvZSfroxLKrCvBx0GWCA7uKLRwWRFpTZR
	0VQbxdtgAKwMGaIie8nHDNk=
X-Google-Smtp-Source: APBJJlFF4kKT7juN18QvvJPucpMXcrmLWnn3HtokESNRx9okAVLCBri/cLwdzx5mg4xeb7fvNIXGsQ==
X-Received: by 2002:a2e:7218:0:b0:2b9:b4eb:c39c with SMTP id n24-20020a2e7218000000b002b9b4ebc39cmr5234236ljc.8.1690787855231;
        Mon, 31 Jul 2023 00:17:35 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id n5-20020a7bc5c5000000b003fbe4cecc3bsm13472652wmk.16.2023.07.31.00.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:34 -0700 (PDT)
From: Joel Granados <joel.granados@gmail.com>
X-Google-Original-From: Joel Granados <j.granados@samsung.com>
To: mcgrof@kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Kees Cook <keescook@chromium.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	mptcp@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	coreteam@netfilter.org,
	Jan Karcher <jaka@linux.ibm.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Will Deacon <will@kernel.org>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	bridge@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	Joerg Reuter <jreuter@yaina.de>,
	Julian Anastasov <ja@ssi.bg>,
	David Ahern <dsahern@kernel.org>,
	netfilter-devel@vger.kernel.org,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	linux-wpan@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	Karsten Graul <kgraul@linux.ibm.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-sctp@vger.kernel.org,
	Tony Lu <tonylu@linux.alibaba.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Florian Westphal <fw@strlen.de>,
	willy@infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-rdma@vger.kernel.org,
	Roopa Prabhu <roopa@nvidia.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Simon Horman <horms@verge.net.au>,
	Mat Martineau <martineau@kernel.org>,
	josh@joshtriplett.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-hams@vger.kernel.org,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	netdev@vger.kernel.org,
	rds-devel@oss.oracle.com,
	Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 03/14] sysctl: Add ctl_table_size to ctl_table_header
Date: Mon, 31 Jul 2023 09:17:17 +0200
Message-Id: <20230731071728.3493794-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731071728.3493794-1-j.granados@samsung.com>
References: <20230731071728.3493794-1-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new ctl_table_size element will hold the size of the ctl_table
arrays contained in the ctl_table_header. This value should eventually
be passed by the callers to the sysctl register infrastructure. And
while this commit introduces the variable, it does not set nor use it
because that requires case by case considerations for each caller.

It provides two important things: (1) A place to put the
result of the ctl_table array calculation when it gets introduced for
each caller. And (2) the size that will be used as the additional
stopping criteria in the list_for_each_table_entry macro (to be added
when all the callers are migrated)

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/linux/sysctl.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 59d451f455bf..33252ad58ebe 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -159,12 +159,22 @@ struct ctl_node {
 	struct ctl_table_header *header;
 };
 
-/* struct ctl_table_header is used to maintain dynamic lists of
-   struct ctl_table trees. */
+/**
+ * struct ctl_table_header - maintains dynamic lists of struct ctl_table trees
+ * @ctl_table: pointer to the first element in ctl_table array
+ * @ctl_table_size: number of elements pointed by @ctl_table
+ * @used: The entry will never be touched when equal to 0.
+ * @count: Upped every time something is added to @inodes and downed every time
+ *         something is removed from inodes
+ * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
+ * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_sysctl ->d_compare()"
+ *
+ */
 struct ctl_table_header {
 	union {
 		struct {
 			struct ctl_table *ctl_table;
+			int ctl_table_size;
 			int used;
 			int count;
 			int nreg;
-- 
2.30.2

