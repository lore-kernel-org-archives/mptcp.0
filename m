Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C116630E;
	Sun,  8 Sep 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800833; cv=none; b=tD6UMa9C9dDI+UFoE+4nllyoWjklFVhuebOqpCyfLVYdaP99b3Th+Qi2fGXaseE5ku0Qud8KfgAelADDxmSRr0v2rf2lJgnK1CHrwMe+a8w+RKn2adsnPJMNCIiF5gy3Gnbj50jsrbFRJs+ne1/i99m5vBbx5u4V3hOSVBaMSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800833; c=relaxed/simple;
	bh=lNFqI1NSMYvDlYNGSd7rsNHMXMOw53cHsUMfj0nkYL4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=uaMuf2OaEF9lpTLGNU+YNcVMEKRRif8bwqLv8wflvvOOSsSuf6l3lVo5ljTa93ofJmKI3AOqJUHspXJOI3YyB+bHGHyx12ZLpPRHf9FsNwaNvokwkHjGzHCkiqG9O9drHgkBgzbylt6p1NSnEkUjbnGBpyi7XI3TBIclLGTpCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GHO+jJJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GHO+jJJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65C4C4CEC3;
	Sun,  8 Sep 2024 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800833;
	bh=lNFqI1NSMYvDlYNGSd7rsNHMXMOw53cHsUMfj0nkYL4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=GHO+jJJoENYdy7lP1K60TT6qjCIHzBImLGGYY+DLzUD0BxCzB2dbJn8JsBXTA9wJ9
	 boUkTwGkTvZZ0gjT5mUj1Ceb5k4apqbNnDLCDIcFM0wHiJ9tED1Of5p4wWtdhtJtED
	 7yXmq6EoV5nlXzIZZ0Dip9xK4l/UppDmKHvWwhtA=
Subject: Patch "mptcp: pm: re-using ID of unused flushed subflows" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 15:06:52 +0200
In-Reply-To: <20240906082853.1764704-2-matttbe@kernel.org>
Message-ID: <2024090851-sanctity-ruby-9b1f@gregkh>
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

    mptcp: pm: re-using ID of unused flushed subflows

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-re-using-id-of-unused-flushed-subflows.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73729-greg=kroah.com@vger.kernel.org Fri Sep  6 10:29:13 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  6 Sep 2024 10:28:54 +0200
Subject: mptcp: pm: re-using ID of unused flushed subflows
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240906082853.1764704-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit ef34a6ea0cab1800f4b3c9c3c2cefd5091e03379 upstream.

If no subflows are attached to the 'subflow' endpoints that are being
flushed, the corresponding addr IDs will not be marked as available
again.

Mark all ID as being available when flushing all the 'subflow'
endpoints, and reset local_addr_used counter to cover these cases.

Note that mptcp_pm_remove_addrs_and_subflows() helper is only called for
flushing operations, not to remove a specific set of addresses and
subflows.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-5-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ No conflicts, but the line modifying msk->pm.id_avail_bitmap has been
  removed, as it is not in this version, introduced later in commit
  86e39e04482b ("mptcp: keep track of local endpoint still available for
  each msk") and depending on other ones. The best we can do in this
  version is to reset local_addr_used counter, better than nothing. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1498,8 +1498,14 @@ static void mptcp_pm_remove_addrs_and_su
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
+
 	if (slist.nr)
 		mptcp_pm_remove_subflow(msk, &slist);
+
+	/* Reset counters: maybe some subflows have been removed before */
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static void mptcp_nl_remove_addrs_list(struct net *net,


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-pm-avoid-possible-uaf-when-selecting-endp.patch
queue-5.15/mptcp-pm-only-decrement-add_addr_accepted-for-mpj-req.patch
queue-5.15/mptcp-pm-fullmesh-select-the-right-id-later.patch
queue-5.15/mptcp-pm-skip-connecting-to-already-established-sf.patch
queue-5.15/mptcp-pm-re-using-id-of-unused-flushed-subflows.patch
queue-5.15/mptcp-pm-add_addr-0-is-not-a-new-address.patch
queue-5.15/mptcp-constify-a-bunch-of-of-helpers.patch
queue-5.15/mptcp-pm-do-not-remove-already-closed-subflows.patch
queue-5.15/mptcp-pr_debug-add-missing-n-at-the-end.patch
queue-5.15/mptcp-pm-check-add_addr_accept_max-before-accepting-new-add_addr.patch
queue-5.15/mptcp-close-subflow-when-receiving-tcp-fin.patch
queue-5.15/mptcp-avoid-duplicated-sub_closed-events.patch
queue-5.15/mptcp-pm-send-ack-on-an-active-subflow.patch
