Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1018562A;
	Mon, 12 Aug 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477871; cv=none; b=KUBV095Z4l8vxh2QkL4itGHUQhZMhyMdNHjPOeOBdunHWjZswYtFxdmrhMqZeynzW1O2xkbvXsUh/aOyM5oQ26zznoC8/Q2XLuMleiFtdt/0qAGGH4Lz7ti0DJ960tu41U/gFy1eYwOt/uy/Hn9bqOq43Ys4MMTncVA5k4pVq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477871; c=relaxed/simple;
	bh=d8OHa3i8Gjc72PnPATNDO2R29h73iX/ZaJ5N2xfkHlQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=dNHYQGtkEH8mOj1PFqFRt3P14flB92J99QzQMVRfHnTnZL8Feu5PgSRK3kPWhU8jOuQi/LUm9hfh7zsWTpya/QnMEIiK3lSMHAOX6OdE1gu0QN7tSVqARfnjTlGVVuIK7sdJnZ1j9EtE2+Mo7uGc8ScWB6fxq4IBAKEWt4hzfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TT4mqkCg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TT4mqkCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80646C4AF0D;
	Mon, 12 Aug 2024 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723477871;
	bh=d8OHa3i8Gjc72PnPATNDO2R29h73iX/ZaJ5N2xfkHlQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=TT4mqkCgpRaL5XuENEAvb5eHbQeP2CSq/Xefa5CMo4jojdlacbWDV8etggRCarq0Z
	 94wubHhY1IWxvYKCeg0RM/eP0gkqYp01Ev0rm2HD2Gr6TiFOwt7ZAKH+bGLrJo1kHT
	 /bNaMId5m74PbQpvWNmQB+QXXmyBzNc9BQaZabsM=
Subject: Patch "mptcp: pm: don't try to create sf if alloc failed" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:51:00 +0200
In-Reply-To: <20240812153050.573404-9-matttbe@kernel.org>
Message-ID: <2024081200-tweed-compactly-b5a2@gregkh>
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

    mptcp: pm: don't try to create sf if alloc failed

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66752-greg=kroah.com@vger.kernel.org Mon Aug 12 17:32:50 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 12 Aug 2024 17:30:53 +0200
Subject: mptcp: pm: don't try to create sf if alloc failed
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240812153050.573404-9-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit cd7c957f936f8cb80d03e5152f4013aae65bd986 upstream.

It sounds better to avoid wasting cycles and / or put extreme memory
pressure on the system by trying to create new subflows if it was not
possible to add a new item in the announce list.

While at it, a warning is now printed if the entry was already in the
list as it should not happen with the in-kernel path-manager. With this
PM, mptcp_pm_alloc_anno_list() should only fail in case of memory
pressure.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-4-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -353,7 +353,7 @@ bool mptcp_pm_alloc_anno_list(struct mpt
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
-		if (mptcp_pm_is_kernel(msk))
+		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
 		sk_reset_timer(sk, &add_entry->add_timer,
@@ -563,8 +563,6 @@ static void mptcp_pm_create_subflow_or_s
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
-		local = select_signal_address(pernet, msk);
-
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -575,11 +573,15 @@ static void mptcp_pm_create_subflow_or_s
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
+		local = select_signal_address(pernet, msk);
 		if (!local)
 			goto subflow;
 
+		/* If the alloc fails, we are on memory pressure, not worth
+		 * continuing, and trying to create subflows.
+		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
-			goto subflow;
+			return;
 
 		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.6/mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
queue-6.6/selftests-mptcp-join-ability-to-invert-add_addr-check.patch
queue-6.6/revert-selftests-mptcp-simult-flows-mark-unbalanced-tests-as-flaky.patch
queue-6.6/mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
queue-6.6/selftests-mptcp-join-test-both-signal-subflow.patch
queue-6.6/mptcp-pm-reduce-indentation-blocks.patch
