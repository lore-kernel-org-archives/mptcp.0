Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904183224;
	Sun,  8 Sep 2024 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800818; cv=none; b=Qs9Xlwf6Ftp7uCwjn7e7WBB2ZUSQQGhymH8FVgZolxIeqb+r6EDJko9mf6HcNtMAKH2F2BiZfJlTx4yMPWdIeA2TcwW3aef6Q+DQrVfyrsi2Zy0HE+dKu3Khyj+QRKlm9V/N9/rr4OkHUjYT50I3O3ZOTuyQD5jZLVnPE1F+I3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800818; c=relaxed/simple;
	bh=o42oj+yZZxcxoU/YiAWIlCFEaSOUcVYdmo7HCzdAAqo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=hNoiXiiuJBjWerN5kiX0bLdilHPA6mM3kWlKIubhrYu8H0iZ6ASVtE9wuclFWVJyL2aFuvVOU9rNRph5/qU4CTaN114gbDclbXGUfkI1wC32Ht5Ugm55TN87ZzoG+WbDbm9LjmWXqcXJ7myL0429Mu55vKOCDMLxH4Nay17iemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BK1FRDLQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BK1FRDLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1001DC4CEC3;
	Sun,  8 Sep 2024 13:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800818;
	bh=o42oj+yZZxcxoU/YiAWIlCFEaSOUcVYdmo7HCzdAAqo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=BK1FRDLQEAOcV0L4sTt/Mr2kvKmp1F+OCV0ZQZt38X3NBUP3vKMQA+KV8tEllOpER
	 CwzskYFC8kzbGTqoMKcMkMAZ3j5KJkziLukBApzm6wnPVczs7addymFd2HlMV437ec
	 TzRTJZ1bMSf3wNq3NAHqSeOIASh/CrUDl7k4YY8c=
Subject: Patch "mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 15:06:46 +0200
In-Reply-To: <20240906083043.1767111-2-matttbe@kernel.org>
Message-ID: <2024090845-dandruff-evil-c2f8@gregkh>
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

    mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-check-add_addr_accept_max-before-accepting-new-add_addr.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73732-greg=kroah.com@vger.kernel.org Fri Sep  6 10:31:09 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  6 Sep 2024 10:30:44 +0200
Subject: mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240906083043.1767111-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 0137a3c7c2ea3f9df8ebfc65d78b4ba712a187bb upstream.

The limits might have changed in between, it is best to check them
before accepting new ADD_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-10-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c, because the context is different, but the
  same lines can still be modified to fix the issue. This is due to
  commit 322ea3778965 ("mptcp: pm: only mark 'subflow' endp as
  available") not being backported to this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -772,8 +772,8 @@ static void mptcp_pm_nl_rm_addr_or_subfl
 			/* Note: if the subflow has been closed before, this
 			 * add_addr_accepted counter will not be decremented.
 			 */
-			msk->pm.add_addr_accepted--;
-			WRITE_ONCE(msk->pm.accept_addr, true);
+			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+				WRITE_ONCE(msk->pm.accept_addr, true);
 		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
 			msk->pm.local_addr_used--;
 		}


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
