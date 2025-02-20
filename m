Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A91D8A0B
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020265; cv=none; b=OZZdOxyytM441sf6sJvDmpjKsOftEXxQiMlDqNPGdG4v7k08Eq2YxP85s645rR4a3NDS/L8fVewfjIINKyNwiC7LzGZJP8VI54zlUx/JdKBPMczQ9lEWco3acBtzOQNtYQ+FnKMU4jPKxtP7ezw3hJH4ElGg9dyd1jgQj+jnhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020265; c=relaxed/simple;
	bh=CSgaIKuH2iv+hZflFk8QF6oobcfESTuAQGBWGQ2OUdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxglCkoqyNYrTZcNL+NYmoiScZAZcZNbbp0hG/wAxZmE7yTEfV8emXVZcwawv0ArNPtDf1GjiYhjfI5qEDmAnhk+HNzfnuRSzuRnOHejjEMZDPDY0bkYHpY/77MBJtRE0mXONWVcI4WnfLAjTsquc86qXmFhqSghrzP8kXDspHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVrzCtrU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVrzCtrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56876C4CEE8;
	Thu, 20 Feb 2025 02:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020265;
	bh=CSgaIKuH2iv+hZflFk8QF6oobcfESTuAQGBWGQ2OUdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVrzCtrUGvXvZLlt87RpogTVTnoozLF+9nxxZbjCXgj4dONsDTHqr5hO1tkGCxneR
	 9He5BMiQds+3RC0H1aeBlyWzkq4ZdRESQ/xuQWnWrbG7m46Eh54yEL1L2yvylngqIp
	 fw3GDrcu0VEJYIOfItQNhJbOmAy7CUQeZ7TBEX8H3+CH6xo0K0QEtSmALU9pBbQrZG
	 pI+ztevXRrvr3iq3gPA0kVF+TDyJTPNbp8hZbj5IozL4n4+lUrwnIe41yOyWNb9rFI
	 rUlNC/vupxei5wWHn6onkMmiVJuhlr+Eym9bkZs8/zDzVdSyDxW7ALfo9zmJPEH2WQ
	 Eol73A8ET68YQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/9] mptcp: pm: add struct mptcp_pm_param
Date: Thu, 20 Feb 2025 10:57:26 +0800
Message-ID: <2f68d8851458f6f5acfd9a6ea549f3b73029d4bc.1740019794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740019794.git.tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Generally, in the path manager interfaces, the local address is defined
as an mptcp_pm_addr_entry type address, while the remote address is
defined as an mptcp_addr_info type one:

    (struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

In order to make these interfaces more flexible and extensible, a struct
mptcp_pm_param is defined here to pass parameters. "entry" can be used
as the local address entry, and "addr" can be used as the remote address.

Also add a new helper mptcp_pm_param_set_contexts() to set a struct
mptcp_pm_param type parameter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  | 13 +++++++++++++
 net/mptcp/pm.c       | 10 ++++++++++
 net/mptcp/protocol.h | 11 +++--------
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 72d6e6597add..a41d6c74760f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -121,6 +121,19 @@ struct mptcp_sched_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+struct mptcp_pm_addr_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+	u8			flags;
+	int			ifindex;
+	struct socket		*lsk;
+};
+
+struct mptcp_pm_param {
+	struct mptcp_pm_addr_entry	entry;
+	struct mptcp_addr_info		addr;
+};
+
 #ifdef CONFIG_MPTCP
 void mptcp_init(void);
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 94620ab172b7..6a504c870e1a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -401,6 +401,16 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	return ret;
 }
 
+void mptcp_pm_param_set_contexts(struct mptcp_pm_param *param,
+				 const struct mptcp_pm_addr_entry *entry,
+				 const struct mptcp_addr_info *addr)
+{
+	if (entry)
+		param->entry = *entry;
+	if (addr)
+		param->addr = *addr;
+}
+
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	struct mptcp_pm_addr_entry skc_local;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ef1d43406f9b..dbcf4b84e0f0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -246,14 +246,6 @@ struct mptcp_pm_local {
 	int			ifindex;
 };
 
-struct mptcp_pm_addr_entry {
-	struct list_head	list;
-	struct mptcp_addr_info	addr;
-	u8			flags;
-	int			ifindex;
-	struct socket		*lsk;
-};
-
 struct mptcp_data_frag {
 	struct list_head list;
 	u64 data_seq;
@@ -1125,6 +1117,9 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      bool *drop_other_suboptions);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
+void mptcp_pm_param_set_contexts(struct mptcp_pm_param *param,
+				 const struct mptcp_pm_addr_entry *entry,
+				 const struct mptcp_addr_info *addr);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 			     struct mptcp_pm_addr_entry *skc);
-- 
2.43.0

