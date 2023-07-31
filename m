Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D5246B0
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 07:17:35 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-31765aee31bso3760642f8f.1
        for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787854; x=1691392654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF1J0XzJl2jEuCsHx7nkNs1OdRX43SORnh/9oIIv32k=;
        b=oqsIryt2GxpgDCAITNIaXCxHDdR3cVtpe2f7ZX5yNWH+iIKTDyP9HWjuJrFs2+sMti
         nz/dszslpzNl5CmOVyIxo9flstqLOG9Lkm0NZCdBEnmTU+I1vw89cMQ0SF9WwdKUoM4I
         XcWmm1bGPvIhG5CX3epdf8PQz1b9WroQTsn7rnMMDg3nS9g5zr+JNBzD7ERJU2+AinRX
         MHXofl3ANcJEAvB+CVk869XpKrsp2b0FvWFR9bdzEstXBE+7GTB2bqaK0C1x6sILTPh1
         c3jM3t7rPPIdEypAnu4qsrcw5JUJFj3cl1pq/Q4VBS9yMtigqyYg0I4nF13M1FXKdD6i
         UhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787854; x=1691392654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF1J0XzJl2jEuCsHx7nkNs1OdRX43SORnh/9oIIv32k=;
        b=lus6oUE4yD9R2rF0dW0A31/QQI3G1bU15bSCI1XnO7LcYnoHa1SQWzKZXOFJy8Y7Pa
         /fxV91PS296TME70LtEx6SCl9yWe2KSAr7VQBRQpmFADJHn3942Yl7Li3QHTGM3FPE7s
         2hu+cMMwPQri/4du5E2TYqkVeEv8Tr+9G1nJNE8TKwH9f+LJ7qHCQfjZxCQtQvje16S5
         l7UWwONXd8NZneZNktOE3vP5KMA/YioCo7lflw7hS3hBmiyoUnTvFOKJ53Sy4JxAnp3c
         59wNFvYdwNK0iS1kRRQTNc8kIb/kOZRHNsFBmYhxaN3Ut4tINm47/G0S5sDemfKMLxED
         LYfw==
X-Gm-Message-State: ABy/qLakM5FNWEOdlgDaov8dHWRkmUbN+QmVvSr5wFIbxp8MdDRBz3Oh
	EcKSH2IgVisSttiJYEgtIj4=
X-Google-Smtp-Source: APBJJlH/snPYxm7GXwa1Rggof5k5STEqlwm0FtiAchadIGMCtE1ufLHfEJ1/mE1z3ZZ7UCj5VHH5Tw==
X-Received: by 2002:a5d:60cb:0:b0:316:f3f3:a1db with SMTP id x11-20020a5d60cb000000b00316f3f3a1dbmr5784721wrt.32.1690787853763;
        Mon, 31 Jul 2023 00:17:33 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id m14-20020adffa0e000000b003177e9b2e64sm11978068wrr.90.2023.07.31.00.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:33 -0700 (PDT)
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
Subject: [PATCH v2 02/14] sysctl: Use ctl_table_header in list_for_each_table_entry
Date: Mon, 31 Jul 2023 09:17:16 +0200
Message-Id: <20230731071728.3493794-3-j.granados@samsung.com>
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

We replace the ctl_table with the ctl_table_header pointer in
list_for_each_table_entry which is the macro responsible for traversing
the ctl_table arrays. This is a preparation commit that will make it
easier to add the ctl_table array size (that will be added to
ctl_table_header in subsequent commits) to the already existing loop
logic based on empty ctl_table elements (so called sentinels).

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 94d71446da39..884460b0385b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -19,8 +19,8 @@
 #include <linux/kmemleak.h>
 #include "internal.h"
 
-#define list_for_each_table_entry(entry, table) \
-	for ((entry) = (table); (entry)->procname; (entry)++)
+#define list_for_each_table_entry(entry, header) \
+	for ((entry) = (header->ctl_table); (entry)->procname; (entry)++)
 
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
@@ -204,7 +204,7 @@ static void init_header(struct ctl_table_header *head,
 	if (node) {
 		struct ctl_table *entry;
 
-		list_for_each_table_entry(entry, table) {
+		list_for_each_table_entry(entry, head) {
 			node->header = head;
 			node++;
 		}
@@ -215,7 +215,7 @@ static void erase_header(struct ctl_table_header *head)
 {
 	struct ctl_table *entry;
 
-	list_for_each_table_entry(entry, head->ctl_table)
+	list_for_each_table_entry(entry, head)
 		erase_entry(head, entry);
 }
 
@@ -242,7 +242,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	err = insert_links(header);
 	if (err)
 		goto fail_links;
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		err = insert_entry(header, entry);
 		if (err)
 			goto fail;
@@ -1129,7 +1129,7 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 {
 	struct ctl_table *entry;
 	int err = 0;
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		if ((entry->proc_handler == proc_dostring) ||
 		    (entry->proc_handler == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||
@@ -1169,7 +1169,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 
 	name_bytes = 0;
 	nr_entries = 0;
-	list_for_each_table_entry(entry, head->ctl_table) {
+	list_for_each_table_entry(entry, head) {
 		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
 	}
@@ -1188,7 +1188,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 	link_name = (char *)&link_table[nr_entries + 1];
 	link = link_table;
 
-	list_for_each_table_entry(entry, head->ctl_table) {
+	list_for_each_table_entry(entry, head) {
 		int len = strlen(entry->procname) + 1;
 		memcpy(link_name, entry->procname, len);
 		link->procname = link_name;
@@ -1211,7 +1211,7 @@ static bool get_links(struct ctl_dir *dir,
 	struct ctl_table *entry, *link;
 
 	/* Are there links available for every entry in table? */
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		const char *procname = entry->procname;
 		link = find_entry(&tmp_head, dir, procname, strlen(procname));
 		if (!link)
@@ -1224,7 +1224,7 @@ static bool get_links(struct ctl_dir *dir,
 	}
 
 	/* The checks passed.  Increase the registration count on the links */
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		const char *procname = entry->procname;
 		link = find_entry(&tmp_head, dir, procname, strlen(procname));
 		tmp_head->nreg++;
@@ -1356,12 +1356,14 @@ struct ctl_table_header *__register_sysctl_table(
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
+	struct ctl_table_header h_tmp;
 	struct ctl_dir *dir;
 	struct ctl_table *entry;
 	struct ctl_node *node;
 	int nr_entries = 0;
 
-	list_for_each_table_entry(entry, table)
+	h_tmp.ctl_table = table;
+	list_for_each_table_entry(entry, (&h_tmp))
 		nr_entries++;
 
 	header = kzalloc(sizeof(struct ctl_table_header) +
@@ -1471,7 +1473,7 @@ static void put_links(struct ctl_table_header *header)
 	if (IS_ERR(core_parent))
 		return;
 
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		struct ctl_table_header *link_head;
 		struct ctl_table *link;
 		const char *name = entry->procname;
-- 
2.30.2

