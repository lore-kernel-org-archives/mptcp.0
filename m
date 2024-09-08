Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E23224;
	Sun,  8 Sep 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800830; cv=none; b=NsNbA1w5k0PmQ5YBQ03eqx+vS07UdUnmsBkBrKLoCZ9QJUdyOHNOU39BzyATq84SXQXZpRhAczKHnFKgEQvIBB+h0JGhHzyvkpi77o37taZWvpGizZd6GZcc3QdHh7yQlBW/FNDrfSKbYeK80wIlPdJ/IMUBeNyEPUBo20ILeYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800830; c=relaxed/simple;
	bh=Ne7o4xuutK8hRjuOI6S0anI4c5LOreo0BUHf2F7YeII=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=mQhqknwA0eg5YqvMuEbNZA8tZ+n76A5WEHvWX2y7PedrGLknN8usTfH0/RzQ1Q9QnyWOd3HghMgYG4LUdO3jNJQvaN6cxMaLlUIhiO0bpHg45SfF90PthY0Oet9vypPfC1kY6d95cVxRxfQ7BXDHefDcyCKQW1Ch08GEURzWXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UkbK1l8K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UkbK1l8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B46C4CEC3;
	Sun,  8 Sep 2024 13:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800830;
	bh=Ne7o4xuutK8hRjuOI6S0anI4c5LOreo0BUHf2F7YeII=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=UkbK1l8KJm9tzjOsCnUVTGnikaohsbXV8HkijaZi2RhpcfSfUjDpPwLkOhsFZsd2v
	 VGG1tsW/hpeMhWjHI4eMG4sGpTNHyp2L66TC3XUsmzz1gpwsa0LCe9o0iBNvmsz4yj
	 wFhxi6p7pUyCwNoiK3SN6qTduY8DMhis9YQPaKQw=
Subject: Patch "mptcp: pm: only decrement add_addr_accepted for MPJ req" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 15:06:51 +0200
In-Reply-To: <20240906083000.1766120-2-matttbe@kernel.org>
Message-ID: <2024090850-mollusk-evolution-819b@gregkh>
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

    mptcp: pm: only decrement add_addr_accepted for MPJ req

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-only-decrement-add_addr_accepted-for-mpj-req.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73730-greg=kroah.com@vger.kernel.org Fri Sep  6 10:30:19 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  6 Sep 2024 10:30:01 +0200
Subject: mptcp: pm: only decrement add_addr_accepted for MPJ req
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240906083000.1766120-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 1c1f721375989579e46741f59523e39ec9b2a9bd upstream.

Adding the following warning ...

  WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)

... before decrementing the add_addr_accepted counter helped to find a
bug when running the "remove single subflow" subtest from the
mptcp_join.sh selftest.

Removing a 'subflow' endpoint will first trigger a RM_ADDR, then the
subflow closure. Before this patch, and upon the reception of the
RM_ADDR, the other peer will then try to decrement this
add_addr_accepted. That's not correct because the attached subflows have
not been created upon the reception of an ADD_ADDR.

A way to solve that is to decrement the counter only if the attached
subflow was an MP_JOIN to a remote id that was not 0, and initiated by
the host receiving the RM_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-9-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c, because the context is different, but the
  same lines can still be modified. The conflicts are due to commit
  4d25247d3ae4 ("mptcp: bypass in-kernel PM restrictions for non-kernel
  PMs") and commit a88c9e496937 ("mptcp: do not block subflows creation
  on errors"), adding new features and not present in this version.
  Note that because some features to better track subflows are missing
  in this version, it is required to remove the WARN_ON, because the
  counter could be 0 in some cases. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -757,7 +757,7 @@ static void mptcp_pm_nl_rm_addr_or_subfl
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed = true;
+			removed |= subflow->request_join;
 			msk->pm.subflows--;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
@@ -767,7 +767,11 @@ static void mptcp_pm_nl_rm_addr_or_subfl
 		if (!removed)
 			continue;
 
-		if (rm_type == MPTCP_MIB_RMADDR) {
+		if (rm_type == MPTCP_MIB_RMADDR && rm_list->ids[i] &&
+		    msk->pm.add_addr_accepted != 0) {
+			/* Note: if the subflow has been closed before, this
+			 * add_addr_accepted counter will not be decremented.
+			 */
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
 		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {


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
