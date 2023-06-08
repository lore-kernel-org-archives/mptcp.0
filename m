Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A212B9E
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 13:21:15 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so3907665e9.3
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 06:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686230473; x=1688822473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSwaV8frgP+BsYdMJSEI28hJ+VH7kpitse/TkoXMDpU=;
        b=rilF142TtI9Re4yJ+CLPrruyPWByld4nvPKVBApP6xKp7kfR/KIPO7c/SrdtN47Q2t
         mC5TJOAvOuCUI8WGcjXz9Tm88ijvKDPIbP+3JC/hb/Zy87bgCL3c44YDbMA8WNFW9Kzo
         fE71XZWZ8NBkgj1pFJGWeSfTbDSSEnOIg5QaYpq4ZK+vK/AQ3ZcCSsm5aMcC2PbQUXUW
         0KhA8ueN+rZ+pPOuOo5ym32tsBWQGQjOhBzrC5Uk7i0NWeaudcsFVC5UBH8X22aa5VSA
         6liaOy2NBmOsNouz/JU8m6rLnBcVroho8ZxBWJ2m5NElSDZZpjVZRbkIhfko52Wg4u/8
         OPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686230473; x=1688822473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSwaV8frgP+BsYdMJSEI28hJ+VH7kpitse/TkoXMDpU=;
        b=Vs8jfsU06Sc3IU8fP5tiV02zzn7onTx7+akCezulAMBmrCsw0+McgrNeypwrKYFiNs
         Hd/qFE+1fYUXnH+8Yp4alDH1pgfQu/+WH3zsTt+/kRHNWhU2eGW9XVsUBrvRD/MaShUi
         hi9mKk4jBdMSlS2kfq6J/rTN21RPmtJrVVXsVxPF/TaUio+le7qyfZUdR83jql+/9DVA
         1KPr7CLOETB2RYdovHLG/8OiglbN49H0U50rymZlOCYCKT4YGO7GUUJE5M+nqsqdlu69
         0Lc7ZR3djhwt3YCUvsFhfc5ernSvFseifga+ocCN6rooB9/qprl4EHhm0YZjw3mfIV3m
         yohQ==
X-Gm-Message-State: AC+VfDy3edrRv3q5vEkvLE7t1YECCwijNmmlRW23HWImiDaUaUWOr449
	U14AjzwVl/kzBkW0dprArsuljw==
X-Google-Smtp-Source: ACHHUZ4ENJUz1YdroCW/FRdhUz0xLpU9qz/hy7P4iAZi3MrjLSaexl/UcNwLN69N/+sQbEAHDeFZGA==
X-Received: by 2002:a1c:7c0d:0:b0:3f6:f152:1183 with SMTP id x13-20020a1c7c0d000000b003f6f1521183mr1441901wmc.37.1686230473699;
        Thu, 08 Jun 2023 06:21:13 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003f7f1b3aff1sm5001100wmi.26.2023.06.08.06.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:21:13 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 08 Jun 2023 15:20:51 +0200
Subject: [PATCH net-next 3/4] mptcp: unify pm get_flags_and_ifindex_by_id
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230608-upstream-net-next-20230608-mptcp-unify-pm-interfaces-v1-3-b301717c9ff5@tessares.net>
References: <20230608-upstream-net-next-20230608-mptcp-unify-pm-interfaces-v1-0-b301717c9ff5@tessares.net>
In-Reply-To: <20230608-upstream-net-next-20230608-mptcp-unify-pm-interfaces-v1-0-b301717c9ff5@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Geliang Tang <geliang.tang@suse.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4069;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=5nDr9M7v5Mf80NDixMM7FPrdaFJMIldEDth/6RZgYhg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgdXFgoTtiSJCP9CGOJ/S5Y8wlsdZcfEsuGk0z
 vqPlL1i0HOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZIHVxQAKCRD2t4JPQmmg
 c+sWD/91DLbuH2odrwHtoGbvYHh6JKcUMBF4JZuuj8Kqa91+9NrVaGqdy0inki2k9/vpH46Rvqu
 O0kABJTas7MMPwIYvxVQoY2VBdwNnKh65ADv4UCzElb/jIph6yr0EEQrAOZ8FhnhiQyfP1pLglP
 lsGwBvPrIUJkLMsWt8aaYBHb3Sg+dXN4OehZGULDnl2KbE633yMRr8+hn9hsHf0S0Y5sjIfJLGF
 pokZUAhDySwtRC284Oq/ea5AXYmrmzT7Js0I+dIFk3nTbw7JwMP3aZ8UPeC2dbZL/+WxSbyFQXF
 aXkEUkorTeesliyUHgx13TaEO45kUWECEhxQndDiIN/eXE5OBxn0CeyRXt82OAcwQs/INUQksON
 PbGW1Hnbxnzj6bvVNG+jHKVBs70D/r4watCKjJYRVqeoC++ndJ4HrDJuPdP1HFnbuW3HKUpTYw5
 tKYQarydPhmD2btUaqUQB/aXPyegTC0RGAklanVIB8NLbKuRdcfKYJm1bhV8dKGYaI6F/WvNxnK
 yH765OZy6x667VWlcWdOrWufpAl9aJKSmjIQOxP6PaJNvZYpTnjlZRhQ+Uta5odYgyIYE8xyQ+p
 HHHOdad02GNDw4Fy5hraX1YRnBat/kScnEw9dXLkrT2BZaBLCYxw1WvyjnnFmJHtgOugXCCoUjL
 kXa3DTfQ6B062Lw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang.tang@suse.com>

This patch unifies the three PM get_flags_and_ifindex_by_id() interfaces:

mptcp_pm_nl_get_flags_and_ifindex_by_id() in mptcp/pm_netlink.c for the
in-kernel PM and mptcp_userspace_pm_get_flags_and_ifindex_by_id() in
mptcp/pm_userspace.c for the userspace PM.

They'll be switched in the common PM infterface
mptcp_pm_get_flags_and_ifindex_by_id() in mptcp/pm.c based on whether
mptcp_pm_is_userspace() or not.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm.c           | 14 ++++++++++++++
 net/mptcp/pm_netlink.c   | 27 ++++++++-------------------
 net/mptcp/pm_userspace.c |  3 ---
 net/mptcp/protocol.h     |  2 ++
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5a027a46196c..2d04598dde05 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -419,6 +419,20 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, &skc_local);
 }
 
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
+					 u8 *flags, int *ifindex)
+{
+	*flags = 0;
+	*ifindex = 0;
+
+	if (!id)
+		return 0;
+
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
+	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 315ad669eb3c..e8b32d369f11 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1356,31 +1356,20 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-					 u8 *flags, int *ifindex)
+int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
+					    u8 *flags, int *ifindex)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
 
-	*flags = 0;
-	*ifindex = 0;
-
-	if (id) {
-		if (mptcp_pm_is_userspace(msk))
-			return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk,
-									      id,
-									      flags,
-									      ifindex);
-
-		rcu_read_lock();
-		entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
-		if (entry) {
-			*flags = entry->flags;
-			*ifindex = entry->ifindex;
-		}
-		rcu_read_unlock();
+	rcu_read_lock();
+	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
+	if (entry) {
+		*flags = entry->flags;
+		*ifindex = entry->ifindex;
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..e1df3a4a4f23 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -85,9 +85,6 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_addr_entry *entry, *match = NULL;
 
-	*flags = 0;
-	*ifindex = 0;
-
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (id == entry->addr.id) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8a2e01d10582..607cbd2ccb98 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -822,6 +822,8 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
+int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
+					    u8 *flags, int *ifindex);
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex);

-- 
2.40.1

