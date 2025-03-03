Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCE1EFF93
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012412; cv=none; b=e7H/7fwTEFlP+XBZsAcUi+OY1OmvM++O9hPvRKxU6gM+VlmUwFzXOf3C7Qzb7bSJrPoyD6dpk1SxKfchMBm/NEd0ZuD/Oay5F6A/bSi1AG/rKFYYl/rkCMrngbzb9Cx5Mo0imx6z23WDNJVBkHkGG4yBL5n5Dfxj1OJg5cyEkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012412; c=relaxed/simple;
	bh=RpBb9ePyKioYHWLxRaI3WUmO6Wox56jALowrXqRacRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kpDcSfHfz4P8efSER1A3sSAJQiAMHsByP522pGnfywR3DrcZ0qAbIs6tyNQncqigfJl7kMg5ptT3zckik0BQ7DsIWSPXCLeOOCnluZpM+3dxOfHcGUlbQy1IEwswkxoemFJGlqQL0UfnG1Z7olcBPoqWdHa2sPGR0EJRjjr7wic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erqBXXU5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erqBXXU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B42CC4CEEB;
	Mon,  3 Mar 2025 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741012411;
	bh=RpBb9ePyKioYHWLxRaI3WUmO6Wox56jALowrXqRacRM=;
	h=From:Date:Subject:To:Cc:From;
	b=erqBXXU5wvRy4DDLd2MJDSQlKj+xwhT7grmcRpf/hp9cbnDNqivJUjzRGV+MD22cF
	 OGhOtGAR5v5R+n3sURvrBOebx4SfBnIChNHCGurt2tgDp6+ctzq48yMDQTHaQxpM89
	 pEuMu0rjY15en8qGJzvbbLyQeQZjc35+nd1ohFBgecekKtWpw+B1qY7h8hYcr82ylZ
	 xy4Z05sLykn7a0PeBAotElu6IToyfXSxo3/+pzXDpSfWqtLaoessVvjZH3ysweKrzw
	 55ZJoRX5LWVbhcpSZVyC5M1oRtZg23cB7uHYaCzfZnflmUxQKuOLN6NqyQnUuxReTn
	 1fGFzyFfLV9pw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Mar 2025 15:33:14 +0100
Subject: [PATCH mptcp-next] mptcp: pm: split netlink and in-kernel init
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-mptcp-pm-split-init-nl-kernel-v1-1-533c1575b5c2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKm9xWcC/yWMwQrCMBAFf6Xs2YXY0tb6K+KhJK+6mK5LEqRQ+
 u8GvQzMYWanjCTIdG12SvhIlrdWOZ8a8s9ZH2AJ1al1be861/FqxRvbytmiFBat0MgvJEXkeYI
 fwyVMYz9QfVjCItvvf6N/qtgK3Y/jC3O8Txt7AAAA
X-Change-ID: 20250303-mptcp-pm-split-init-nl-kernel-a9ec7d8d9756
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2810; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RpBb9ePyKioYHWLxRaI3WUmO6Wox56jALowrXqRacRM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnxb26epOfw4h/euDRybEGLfASZrjBtQ+219Hfq
 v0iSVwKZ6GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8W9ugAKCRD2t4JPQmmg
 c23kD/96idHJ19uegygPsOkF3VaykQJoxgU38LCBdG8PmgBDzrYE6QdZWmbH2M30wIRhfuPJ64P
 0lu7xbIr53LUw+angd5w9UmOLKEo+V6seIiBH896jU+LcL8+0yhtmPD10tJ8GZxvncykMBogGvM
 mox+fzzC9qNucDvE3KK4tnzxrWqhl5ITV6oHNZ0e3MCcN8KDf7GJmFEsHQhjhcsSbbZUncv1ZEA
 KOe3s7sTAJLcYgMPM1kLqUcO48UoAgwH/uNKIlwX9v/mqxYFvB6gj8d+9+FpK+E7VqPaauTXJ+s
 EDdA4qF5ythqkCcwCmTN8V8jd8JRiJyk02b2J/bzq89vyiZ8dNyFgCAGdyHntIwvYjJ2SyPUiZE
 RsAddfQNAojahl82f0m4gu394S+rQIEfQjzJYO2Hi17W1v1OeWECoNYrzP3Wd7f656u5s/7TAxd
 Bj1RBFUSMJ3ochoyiEdavrZ7+4wCEOa4glXElFX8Hr/V4M21oDS34ad3844AvXSVZ7QA4BnUw6z
 VlkITPeglSo6cYfhkAbRMHrpTiBVZ9Wd8jbJE39+NWXr0GDNQSKVy4A3sUEuz47tvoQY2UnG+s0
 7K9fCbxwP76gzMY1ByBrEIHF7l7q9L8ZLAmRoCYPRCfJMUciCPH43yjKLIXxD7IljN+D2+okavL
 T3kL6WGQZDNp6WQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The registration of mptcp_genl_family is useful for both the in-kernel
and the userspace PM. It should then be done in pm_netlink.c.

On the other hand, the registration of the in-kernel pernet subsystem is
specific to the in-kernel PM, and should stay there in pm_kernel.c.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 1 +
 net/mptcp/pm_kernel.c  | 5 +----
 net/mptcp/pm_netlink.c | 6 ++++++
 net/mptcp/protocol.h   | 1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 833839d7286e717599579356af3117f70e39de0a..8e6a325a389803196c35175cd5ea7637624d0ee2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1022,5 +1022,6 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 
 void __init mptcp_pm_init(void)
 {
+	mptcp_pm_kernel_register();
 	mptcp_pm_nl_init();
 }
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index daf8f98a316439a67c12f63f2388ef497dae08dd..62ae68abb2cb0066a30a3fab88ae5f082c523413 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1400,11 +1400,8 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
-void __init mptcp_pm_nl_init(void)
+void __init mptcp_pm_kernel_register(void)
 {
 	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
 		panic("Failed to register MPTCP PM pernet subsystem.\n");
-
-	if (genl_register_family(&mptcp_genl_family))
-		panic("Failed to register MPTCP PM netlink family\n");
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b2e5bbdcd5df920887ffbd9b6d652f422b32d49e..50aaf259959aeaf36e7ab954c6f7957eaf2bc390 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -625,3 +625,9 @@ struct genl_family mptcp_genl_family __ro_after_init = {
 	.mcgrps		= mptcp_pm_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
 };
+
+void __init mptcp_pm_nl_init(void)
+{
+	if (genl_register_family(&mptcp_genl_family))
+		panic("Failed to register MPTCP PM netlink family\n");
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9bdfd915d62f52feb8e3f29f6f429dfa837f5f2b..bb9504e0510a1630d6903201d4fc8dcf7e47808e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1152,6 +1152,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 	return local_id;
 }
 
+void __init mptcp_pm_kernel_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);

---
base-commit: b084c48057bbf45fbedc06d7a9d4ec417992fb1e
change-id: 20250303-mptcp-pm-split-init-nl-kernel-a9ec7d8d9756

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

