Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F33224;
	Sun,  8 Sep 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800827; cv=none; b=mSKsdsl0mXLmwkQswvQFiw7WlQlu4uGbQwyVB0basEHlro90hbBYXEJ2HnwKIkiohz2owd+NMsKfyLPlQysw+v5LftjrsFF5vA4lv8s+vBnhWn2fAC3i1XdR0fyqVnKCM29t9Urh+OyB7pGm0EGWnNDXT2VEiIPc3f8AhC05RlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800827; c=relaxed/simple;
	bh=DeQ9ha3ovQbp7PKqfEv3yhh2qM76V2RF00Uu4XS7WXI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=c7bY06BkJU+eqkTlVtABTE4OQOjqxDqL64H/XLmBlF/d2jahlCSuyVV9AXZW6B0pYMHoY1Ra4i5Dq+MdC0O4haH949yDmsZ3jN9C6terKJK7ALOQ6sSEp+FY7mrgpmfd/1RGgigj5GJJuqYrFBPsGzGj9ehGkgaUurZ2Aj9E5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0nbP5NvD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0nbP5NvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6C2C4CEC3;
	Sun,  8 Sep 2024 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800827;
	bh=DeQ9ha3ovQbp7PKqfEv3yhh2qM76V2RF00Uu4XS7WXI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=0nbP5NvDYVFs5+2G/SfeNaSHHIHMlYTirMEdjbO7zUW09d/XQyoszlVeImr1Hh6/X
	 /fPrmwb93y4Mg9cX1Mp/ng9kExo5pCQoqxljFhdJLED2jaYeYw+2n2pWcFr+dCiAII
	 +J52r1t4R6s/wa+DBF4HoPbfcK5nxk3UWgMJ5Kfg=
Subject: Patch "mptcp: pm: fullmesh: select the right ID later" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 15:06:49 +0200
In-Reply-To: <20240906083123.1767956-2-matttbe@kernel.org>
Message-ID: <2024090848-marina-wasting-5e21@gregkh>
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

    mptcp: pm: fullmesh: select the right ID later

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-fullmesh-select-the-right-id-later.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73733-greg=kroah.com@vger.kernel.org Fri Sep  6 10:31:36 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  6 Sep 2024 10:31:24 +0200
Subject: mptcp: pm: fullmesh: select the right ID later
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240906083123.1767956-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 09355f7abb9fbfc1a240be029837921ea417bf4f upstream.

When reacting upon the reception of an ADD_ADDR, the in-kernel PM first
looks for fullmesh endpoints. If there are some, it will pick them,
using their entry ID.

It should set the ID 0 when using the endpoint corresponding to the
initial subflow, it is a special case imposed by the MPTCP specs.

Note that msk->mpc_endpoint_id might not be set when receiving the first
ADD_ADDR from the server. So better to compare the addresses.

Fixes: 1a0d6136c5f0 ("mptcp: local addresses fullmesh")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-12-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c, because the new 'mpc_addr' variable is
  added where the 'local' one was, before commit b9d69db87fb7 ("mptcp:
  let the in-kernel PM use mixed IPv4 and IPv6 addresses"), that is not
  a candidate for the backports. This 'local' variable has been moved to
  the new place to reduce the scope, and help with possible future
  backports.
  Note that addresses_equal() has been used instead of
  mptcp_addresses_equal(), renamed in commit 4638de5aefe5 ("mptcp:
  handle local addrs announced by userspace PMs"), not in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -554,7 +554,7 @@ static unsigned int fill_local_addresses
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info local;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -562,6 +562,8 @@ static unsigned int fill_local_addresses
 	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
 	rcu_read_lock();
 	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -580,7 +582,13 @@ static unsigned int fill_local_addresses
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct ID */
+			if (addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();
@@ -589,6 +597,8 @@ static unsigned int fill_local_addresses
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
+		struct mptcp_addr_info local;
+
 		memset(&local, 0, sizeof(local));
 		local.family = msk->pm.remote.family;
 


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
