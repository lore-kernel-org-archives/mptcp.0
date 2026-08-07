Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227C3F8254
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100285; cv=none; b=KWKXSF/R5invcbbWt6cwjJK+eF9Nzg/0RGIcTFUwI0IxFr3ehQeVeLLipbnVRK9zCQC+8yW8Ng525Ig6HhN659+4ufj8+tmMOBprhhd8YpqdM5M4VK6JZjhiM+CEiltDRlF8x96bmA33maMoODWxb2F6VogP2fXXmJZ3izM5/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100285; c=relaxed/simple;
	bh=79cJUTpC8VKNUeuOZqlviNbhJiiEU/En1nEuUM2L03g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HatNT5RhqkNKIxa0tlyYxqTU7b0nF3N2md8wVkEwUYpYk+QjqE+wwgI1hEMwAUzNJIbm6dnV0KH2kgr2Hl3ezaY900bNLJ3xXA5U0kgvHZqstLzkYSyFNvtQlmn8sZsxGgvKllILs7yQNlhnvnybjFOAgvouNvi4fuGCeMF7QuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWxlW4Ka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWxlW4Ka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08F11F000E9;
	Fri,  7 Aug 2026 10:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786100283;
	bh=op0CLLuxRxbj/m45COPGP5my9LVTxBpirdNUtRNXz8A=;
	h=From:Date:Subject:To:Cc;
	b=eWxlW4Kas0CDBOkcXcHGdF4xDTrhV/OE8PQ+/8WkUqqA/AOadw8LfLeRLRzLDdwam
	 eommztdw6HdTBGU2zURL8s3zlv8AZdwk9AslNIHEhluqP2aJehgi1vzMeK4vnkAaVD
	 2LKbYvl9Vm6/FnAY/HH0MFK8EDBTtCCnN4hoS40x/LuxxN/Se/e1So/XwsYEfMXysI
	 c+orMJegXDKPR82XhVfTLeCBtynhmO3Dnk4+9rTPXDKQB7ah9eIi1QYUo7z0WJtQpU
	 E4Ak4Z11cChwBWn+RFYEvUKjtHDZ2OdPJtqTcsk5Ksf7cYP00MwHv5J6/ukzuiVYpw
	 Ww2xN6ZRIC9Rg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 12:51:06 +0200
Subject: [PATCH next mptcp-next] mptcp: pm: userspace: make
 remove_addr_entry static
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mptcp-pm-user-remove_addr_entry-v1-1-c080a8a30e40@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNUQqDMBAFryL73YUo1UqvUorEZNNuITFsoljEu
 5vWz+ExbzZIJEwJ7tUGQgsnnkKB+lKBeevwImRbGBrVdKpXN/Qxm4jR41xMFPLTQoO2VgYKWb4
 4Glfra9tZ5XooL1HI8fovPOCUA60ZnueW5vFDJv8SsO8H0tqA248AAAA=
X-Change-ID: 20260807-mptcp-pm-user-remove_addr_entry-bcf1a456d0f8
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2023; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=79cJUTpC8VKNUeuOZqlviNbhJiiEU/En1nEuUM2L03g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKd1mJrfv2MPLfVCv5vtMWJ85eXTmpivn7tt8P9GdNq
 XnUxths11HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARPk+G/zXRj21Xv7SrfzXF
 5rHcmiVHTm/kKVudrqDn1xl60tpzdgYjw+z5h/te7ZFJ9Ove/E3/oOW6uWIRrgeqJ71fHdZ7Ref
 jawYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Only used in pm_userspace.c.

While at it, use the mptcp_userspace_pm_ prefix, like most functions in
this file: that makes it clear it is specific to this userspace PM.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 7 ++++---
 net/mptcp/protocol.h     | 2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8537fd75f73f..f723a134356f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -291,8 +291,9 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 	return err;
 }
 
-void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
-				struct mptcp_pm_addr_entry *entry)
+static void
+mptcp_userspace_pm_remove_addr_entry(struct mptcp_sock *msk,
+				     struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
 	int anno_nr = 0;
@@ -350,7 +351,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	list_del_rcu(&match->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	mptcp_pm_remove_addr_entry(msk, match);
+	mptcp_userspace_pm_remove_addr_entry(msk, match);
 
 	release_sock(sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2f5b2f671c44..70200e75facf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1149,8 +1149,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
-				struct mptcp_pm_addr_entry *entry);
 
 /* the default path manager, used in mptcp_pm_unregister */
 extern struct mptcp_pm_ops mptcp_pm_kernel;

---
base-commit: f393de6a43c333c11fbecdd76fa4fa3cc06aa834
change-id: 20260807-mptcp-pm-user-remove_addr_entry-bcf1a456d0f8

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

