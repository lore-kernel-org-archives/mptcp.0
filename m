Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F61369AE;
	Mon, 12 Aug 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466329; cv=none; b=OSsfYCgK7Y5uJv+HzAU7YsL96x7SB/EaqLnutImDJU5eYDAj9rFUvAUppGHG+f8+Pt6SzKFJq2uqeBIw4V+UZnJ08+Eni1EHOiTIwirri43CkXthcwvUdiRH/DsKwhyBS3P/wptb2P6VvchBVEcthVwpYEtHcFonhG84fuipLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466329; c=relaxed/simple;
	bh=G2BlWMXafcGwAE3ap19BzcabSqSWmd5MpoesSu3mDIQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=lTmnDBNCxTJhkeLXjgU6m3dn8mc68MzgsE2L8ZrTS6AUY5V+2VrE3i+8ZY2IVIeEOAIl8O4MuHEYtCpTpAJ2el5CaNt8Cs1SMdnPc2dawe6AuG6F3e3+JcWwwwPRtjRlRlcnoyKJvBMmWuBC4T8qUa7wax9Mti5CDPeViVhq+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ve58boWO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ve58boWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA5EC4AF0E;
	Mon, 12 Aug 2024 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466328;
	bh=G2BlWMXafcGwAE3ap19BzcabSqSWmd5MpoesSu3mDIQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=ve58boWOCUHdYrDUcjzo3tazKAnqZzkP5T9v9RAEvlMZytTgO7uSaAAlAtX88h02Z
	 zrjiSlfcN1f1RZTg3DLVtQ7fRKoblAUoxOQRGeQJhmI6MmisAYCwYfk4IbLo5y7h1p
	 /uOqmZsjWd8u0T4CnD18hsLuNIS8L5un0ES3JrrI=
Subject: Patch "mptcp: pm: fix backup support in signal endpoints" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:38:28 +0200
In-Reply-To: <20240809090912.2701580-4-matttbe@kernel.org>
Message-ID: <2024081228-earache-marshland-c7b3@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-fix-backup-support-in-signal-endpoints.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66134-greg=kroah.com@vger.kernel.org Fri Aug  9 11:09:35 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 11:09:14 +0200
Subject: mptcp: pm: fix backup support in signal endpoints
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240809090912.2701580-4-matttbe@kernel.org>

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
  not in this version. This commit is unrelated to this modification.
  Conflicts in subflow.c, because the commit 4cf86ae84c71 ("mptcp:
  strict local address ID selection") is not in this version. It is then
  not needed to modify the subflow_chk_local_id() helper, which is not
  in this version.
  Also, in this version, there is no pm_userspace.c, because this PM has
  been added in v5.19, which also causes conflicts in protocol.h, and
  pm_netlink.c. Plus the code in pm.c can be simplified, as there is no
  userspace PM. And the code in pm_netlink.c needs to use
  addresses_equal() instead of mptcp_addresses_equal(), see commit
  4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs").
  The code in pm_netlink.c also needs to be adapted because the
  pm_nl_get_pernet_from_msk() helper is not in this version, introduced
  later in commit c682bf536cf4 ("mptcp: add pm_nl_pernet helpers"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm.c         |    9 +++++++++
 net/mptcp/pm_netlink.c |   20 ++++++++++++++++++++
 net/mptcp/protocol.h   |    2 ++
 net/mptcp/subflow.c    |    1 +
 4 files changed, 32 insertions(+)

--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -341,6 +341,15 @@ int mptcp_pm_get_local_id(struct mptcp_s
 	return mptcp_pm_nl_get_local_id(msk, skc);
 }
 
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
+{
+	struct mptcp_addr_info skc_local;
+
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
+
+	return mptcp_pm_nl_is_backup(msk, &skc_local);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1014,6 +1014,26 @@ int mptcp_pm_nl_get_local_id(struct mptc
 	return ret;
 }
 
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
+	bool backup = false;
+
+	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (addresses_equal(&entry->addr, skc, entry->addr.port)) {
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return backup;
+}
+
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -821,6 +821,7 @@ bool mptcp_pm_add_addr_signal(struct mpt
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
@@ -828,6 +829,7 @@ void mptcp_pm_nl_work(struct mptcp_sock
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -97,6 +97,7 @@ static struct mptcp_sock *subflow_token_
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	return msk;
 }


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.15/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.15/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.15/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.15/selftests-mptcp-join-validate-backup-in-mpj.patch
queue-5.15/mptcp-export-local_address.patch
queue-5.15/mptcp-pm-only-set-request_bkup-flag-when-sending-mp_prio.patch
queue-5.15/mptcp-fix-bad-rcvpruned-mib-accounting.patch
