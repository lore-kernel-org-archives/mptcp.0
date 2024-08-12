Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927217A5AC;
	Mon, 12 Aug 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465575; cv=none; b=GtXE1W+T4VBOzVy2rzLzBC08pvl9wFXYn6C9E34WoopfC/rTMObc2ujd8lgpBCNrCyfbsa3yasNcwQKzUtenksU5WyL/rMj8o4glfeVIrNuKwqBg4MQJ8i2c1HFfbZ1dkwIhBMEMNJBWUEHE8BYAtv+8enosYMWiypbkTzodwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465575; c=relaxed/simple;
	bh=wSdsrzANDT9S4rjRYkDNlBAL6TQYu/cuN4VN/FNHk4A=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=qYX4zmGl2xtPEjFio+bIwWOQtN1zkvgHYHXIuVQTQchrQBFqd5S+ISLEWh1664jbFV0STgmsGGzP9fZqz/zcrwpvlUygtyMdpo3raSMe7NIbopOitpi0Na/n6Zu3KK3QQ/NHtj80QAd3cbpSO5e8r+2gLykLv3zRuooPzhKzYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VpiS5qNR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VpiS5qNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D98FC32782;
	Mon, 12 Aug 2024 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723465575;
	bh=wSdsrzANDT9S4rjRYkDNlBAL6TQYu/cuN4VN/FNHk4A=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=VpiS5qNRLR2TrVAXHasEnztPn24c3O1mRE8HLHNC9kvCbNXdvRYyMxIlIvM/3sERU
	 cYRshTQiOjNIdLBM1sUYDdGt0m4MUGbY52esd51Tu09tXLd7GOrqhWxhYntdr5R1xK
	 XRU5THXZrOAdfL1fNFN9P7hrzrwlP1/TByBmVR8M=
Subject: Patch "mptcp: pm: fix backup support in signal endpoints" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:25:58 +0200
In-Reply-To: <20240808153546.2315845-4-matttbe@kernel.org>
Message-ID: <2024081257-daughter-resigned-8d47@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: pm: fix backup support in signal endpoints

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-fix-backup-support-in-signal-endpoints.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66068-greg=kroah.com@vger.kernel.org Thu Aug  8 17:36:21 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu,  8 Aug 2024 17:35:48 +0200
Subject: mptcp: pm: fix backup support in signal endpoints
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240808153546.2315845-4-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 6834097fc38c5416701c793da94558cea49c0a1f upstream.

There was a support for signal endpoints, but only when the endpoint's
flag was changed during a connection. If an endpoint with the signal and
backup was already present, the MP_JOIN reply was not containing the
backup flag as expected.

That's confusing to have this inconsistent behaviour. On the other hand,
the infrastructure to set the backup flag in the SYN + ACK + MP_JOIN was
already there, it was just never set before. Now when requesting the
local ID from the path-manager, the backup status is also requested.

Note that when the userspace PM is used, the backup flag can be set if
the local address was already used before with a backup flag, e.g. if
the address was announced with the 'backup' flag, or a subflow was
created with the 'backup' flag.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/507
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm_userspace.c because the context has changed in commit
  1e07938e29c5 ("net: mptcp: rename netlink handlers to
  mptcp_pm_nl_<blah>_{doit,dumpit}") which is not in this version. This
  commit is unrelated to this modification.
  Conflicts in protocol.h because the context has changed in commit
  9ae7846c4b6b ("mptcp: dump addrs in userspace pm list") which is not
  in this version. This commit is unrelated to this modification.
  Conflicts in pm.c because the context has changed in commit
  f40be0db0b76 ("mptcp: unify pm get_flags_and_ifindex_by_id") which is
  not in this version. This commit is unrelated to this modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm.c           |   12 ++++++++++++
 net/mptcp/pm_netlink.c   |   18 ++++++++++++++++++
 net/mptcp/pm_userspace.c |   18 ++++++++++++++++++
 net/mptcp/protocol.h     |    3 +++
 net/mptcp/subflow.c      |    3 +++
 5 files changed, 54 insertions(+)

--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -416,6 +416,18 @@ int mptcp_pm_get_local_id(struct mptcp_s
 	return mptcp_pm_nl_get_local_id(msk, skc);
 }
 
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
+{
+	struct mptcp_addr_info skc_local;
+
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
+
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_is_backup(msk, &skc_local);
+
+	return mptcp_pm_nl_is_backup(msk, &skc_local);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1110,6 +1110,24 @@ int mptcp_pm_nl_get_local_id(struct mptc
 	return ret;
 }
 
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	struct mptcp_pm_addr_entry *entry;
+	bool backup = false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return backup;
+}
+
 #define MPTCP_PM_CMD_GRP_OFFSET       0
 #define MPTCP_PM_EV_GRP_OFFSET        1
 
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -159,6 +159,24 @@ int mptcp_userspace_pm_get_local_id(stru
 	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
 }
 
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	bool backup = false;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	return backup;
+}
+
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -913,6 +913,9 @@ bool mptcp_pm_rm_addr_signal(struct mptc
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -99,6 +99,7 @@ static struct mptcp_sock *subflow_token_
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	return msk;
 }
@@ -513,6 +514,8 @@ static int subflow_chk_local_id(struct s
 		return err;
 
 	subflow_set_local_id(subflow, err);
+	subflow->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)sk);
+
 	return 0;
 }
 


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.1/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-6.1/selftests-mptcp-join-check-backup-support-in-signal-endp.patch
queue-6.1/selftests-mptcp-join-validate-backup-in-mpj.patch
queue-6.1/mptcp-export-local_address.patch
