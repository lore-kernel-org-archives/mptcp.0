Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4E17B4E9;
	Mon, 12 Aug 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466704; cv=none; b=h7TgxrKShgHdrz9qbQwDrGCu8iVOmy7b2/JokKyqyJfarMYRTHvLAXCBzxdtcHXACq70UGM0FsA9C5nS5HS+hmrKHqam/ZEahOf/I8rAWX5x5HJp0pUp90wXv6PCRvOZtDYu+nukMR77fcHsggQgr67QhpgZwI/qjFExlI2utfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466704; c=relaxed/simple;
	bh=AiiUTzTYfliBAz4wvWxWMv9RYs9VJhsAwtzLlWWK9UY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=W3IDEX0BLU7qw7eS4ru7ibpOfe/rrwNEADZ1VFuMCDiXCovoXdrTac7sPwMuy4Y3v/hazWF+Q3kbU280yZUibbF7SarL15/ct0L7rg/aNqlj7/zTF4vyYEOybjRvW/JKybrqriLg8azuZijpRhWOizUaw3iIIQPC+AFjHt6iqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JXExVbVf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JXExVbVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38678C32782;
	Mon, 12 Aug 2024 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466703;
	bh=AiiUTzTYfliBAz4wvWxWMv9RYs9VJhsAwtzLlWWK9UY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=JXExVbVfnsVjHdQlyLiO46HYakgzSq+s6d5PyQIpjxN36EUs1pRazJuhDfKo8p4gM
	 XPfUOTTQVeujGf7tXij6iNPx6hgpSz5PS+la5Ik2K/9A/asMctEPoORBnB/98YaXEs
	 kRW5sSNI8vxYPJsZ5Bq4QykQdbqwj+Or5FowaUAs=
Subject: Patch "mptcp: export local_address" has been added to the 5.10-stable tree
To: geliang.tang@suse.com,gregkh@linuxfoundation.org,kuba@kernel.org,larysa.zaremba@intel.com,matthieu.baerts@tessares.net,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:44:52 +0200
In-Reply-To: <20240809105538.2903162-3-matttbe@kernel.org>
Message-ID: <2024081252-stainless-case-ebdb@gregkh>
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

    mptcp: export local_address

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-export-local_address.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66254-greg=kroah.com@vger.kernel.org Fri Aug  9 12:55:55 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 12:55:39 +0200
Subject: mptcp: export local_address
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliang.tang@suse.com>, Matthieu Baerts <matthieu.baerts@tessares.net>, Larysa Zaremba <larysa.zaremba@intel.com>, Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20240809105538.2903162-3-matttbe@kernel.org>

From: Geliang Tang <geliang.tang@suse.com>

commit dc886bce753cc2cf3c88ec5c7a6880a4e17d65ba upstream.

Rename local_address() with "mptcp_" prefix and export it in protocol.h.

This function will be re-used in the common PM code (pm.c) in the
following commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 6834097fc38c ("mptcp: pm: fix backup support in signal endpoints")
[ Conflicts in pm_netlink.c and protocol.h, because the context has
  changed in commit 4638de5aefe5 ("mptcp: handle local addrs announced
  by userspace PMs") which is not in this version. This commit is
  unrelated to this modification. Also some parts using 'local_address'
  are not in this version, that's OK, we don't need to do anything with
  them. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    9 ++++-----
 net/mptcp/protocol.h   |    1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -84,8 +84,7 @@ static bool address_zero(const struct mp
 	return addresses_equal(addr, &zero, false);
 }
 
-static void local_address(const struct sock_common *skc,
-			  struct mptcp_addr_info *addr)
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
 {
 	addr->port = 0;
 	addr->family = skc->skc_family;
@@ -120,7 +119,7 @@ static bool lookup_subflow_by_saddr(cons
 	list_for_each_entry(subflow, list, node) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
-		local_address(skc, &cur);
+		mptcp_local_address(skc, &cur);
 		if (addresses_equal(&cur, saddr, false))
 			return true;
 	}
@@ -533,8 +532,8 @@ int mptcp_pm_nl_get_local_id(struct mptc
 	/* The 0 ID mapping is defined by the first subflow, copied into the msk
 	 * addr
 	 */
-	local_address((struct sock_common *)msk, &msk_local);
-	local_address((struct sock_common *)skc, &skc_local);
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -372,6 +372,7 @@ void __mptcp_close_ssk(struct sock *sk,
 		       struct mptcp_subflow_context *subflow,
 		       long timeout);
 void mptcp_subflow_reset(struct sock *ssk);
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.10/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.10/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.10/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.10/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.10/mptcp-sched-check-both-directions-for-backup.patch
queue-5.10/mptcp-export-local_address.patch
