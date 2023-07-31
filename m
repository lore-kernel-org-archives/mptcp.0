Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625711C98
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 07:17:45 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so38600145e9.3
        for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787863; x=1691392663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPr2gCh0WwKGZ3vD5F3mcw/cD05Ywt0Q6uWcdKx3iw8=;
        b=ODQWGR3LflWQq2OvtY1YynEp6l9qd94J4wKNyHC1oHlJSpHL0Xo0lx7HnVPh+Maav4
         mdFvIf8q88vjdEfhrWv/mi8K27TOWd10Rfkuz2+tkKycXmM8soU71r2e2LC/cCVW8PZz
         rEwAtYG8tVYRDVtkFAdTT2B1OmQaCWtLnsADAc48NDQAR4KcEelo5MOqIjDh0HTiLMWs
         eTzmivPPY1muLmBnjFmKwT38ltKrocMx7hYMk6cMgxR9cuLiAzwnyvbOrj5d05fgDd6t
         aTA/0Fc49Q2iW1UkOCGVn4PWcKcCz83OlVO72nubL6VbL56RiI98SEglN+i3pXoWKjHs
         Bljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787863; x=1691392663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPr2gCh0WwKGZ3vD5F3mcw/cD05Ywt0Q6uWcdKx3iw8=;
        b=AKmGkOwZUzeKZKYgLAku+NCveE7Vfu0bYgEwzEC/6TUzBzIrGhJRcWmowQ2qoTgsic
         IYf5rz1KRov0lTqhWo9gkc2RuY2D7SO89MzH/p2T/B4Fr3cRHG+YPlMGpBWrlxwg76B8
         CteH/uh7wiEubv3Ff9nwr7YCRKj/RMi1c8ZKlAaLFa+V/XXuWJz0FUx3akPezX8OoKcv
         Ul0XDnIbOWT96Ct8Qqbj6pOYZFkhUh48HBt3KgN06Aw0qyuK9DZTpUBsZN8YQfLI71M2
         TsVdb2+QTIq6jm2dI0v3AzGUxBu5DouPY2A7RaiZCkDK1yUNh4GbBN+8MQXbg2X+t3TT
         rb5w==
X-Gm-Message-State: ABy/qLaAb6I+1WBpv+smkhJNuF5fTWJOrgA2sS8mxxox1AqufU/+VGUP
	ns4VINjOrMeI2x48zH9ZXus=
X-Google-Smtp-Source: APBJJlFUT54AdCuyyb2qFmdAJQLKO+XCQKR52YjLBjQXK2DMkv1v7jl1zW+1BcBKyEgho/gdATMlgQ==
X-Received: by 2002:a05:600c:2242:b0:3fe:179d:d42e with SMTP id a2-20020a05600c224200b003fe179dd42emr3711564wmm.23.1690787863281;
        Mon, 31 Jul 2023 00:17:43 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm13493952wma.14.2023.07.31.00.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:42 -0700 (PDT)
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
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 07/14] sysctl: Add size arg to __register_sysctl_init
Date: Mon, 31 Jul 2023 09:17:21 +0200
Message-Id: <20230731071728.3493794-8-j.granados@samsung.com>
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

This commit adds table_size to __register_sysctl_init in preparation for
the removal of the sentinel elements in the ctl_table arrays (last empty
markers). And though we do *not* remove any sentinels in this commit, we
set things up by calculating the ctl_table array size with ARRAY_SIZE.

We add a table_size argument to __register_sysctl_init and modify the
register_sysctl_init macro to calculate the array size with ARRAY_SIZE.
The original callers do not need to be updated as they will go through
the new macro.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/proc_sysctl.c  | 12 +++---------
 include/linux/sysctl.h |  5 +++--
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 80d3e2f61947..817bc51c58d8 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1433,6 +1433,7 @@ EXPORT_SYMBOL(register_sysctl_sz);
  * 	lifetime use of the sysctl.
  * @table_name: The name of sysctl table, only used for log printing when
  *              registration fails
+ * @table_size: The number of elements in table
  *
  * The sysctl interface is used by userspace to query or modify at runtime
  * a predefined value set on a variable. These variables however have default
@@ -1445,16 +1446,9 @@ EXPORT_SYMBOL(register_sysctl_sz);
  * Context: if your base directory does not exist it will be created for you.
  */
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
-				 const char *table_name)
+				 const char *table_name, size_t table_size)
 {
-	int count = 0;
-	struct ctl_table *entry;
-	struct ctl_table_header t_hdr, *hdr;
-
-	t_hdr.ctl_table = table;
-	list_for_each_table_entry(entry, (&t_hdr))
-		count++;
-	hdr = register_sysctl_sz(path, table, count);
+	struct ctl_table_header *hdr = register_sysctl_sz(path, table, table_size);
 
 	if (unlikely(!hdr)) {
 		pr_err("failed when register_sysctl_sz %s to %s\n", table_name, path);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index b1168ae281c9..09d7429d67c0 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -236,8 +236,9 @@ void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
 extern void __register_sysctl_init(const char *path, struct ctl_table *table,
-				 const char *table_name);
-#define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
+				 const char *table_name, size_t table_size);
+#define register_sysctl_init(path, table)	\
+	__register_sysctl_init(path, table, #table, ARRAY_SIZE(table))
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
-- 
2.30.2

