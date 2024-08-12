Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7405C1369AE;
	Mon, 12 Aug 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466332; cv=none; b=IPCbtNtCD+cJcnZEXCGIsYdyLHTI+n02Izx0UpZleIIQvS9S36F2eEalhURLh2A1vHGyCU7aZeC2Oe+3LNR55k47dXqinM+oSo5wJP2wnJ9NMwqzkoOiCJB7gQVtNiigu+yRM2U8VZnNLl/gW2DrZ6uSHDLiVMsEOwgANXrv9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466332; c=relaxed/simple;
	bh=bxsjV2+rvbig8YCfl1zMYgSK1IliqRVW29EpeP3DppM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=sLfQexpN4gZ6BkEnKmOQto2hxvDgB650YF2SjGWPnNJk4voESBjitHBNokb6a+8K+yVn25Rt/eEJ+n8i54/12FrSRxXt6PbOi0V6vwe78vLUBNgAq8T4pkF3Kpyc+rzlLSdPaQOUBuOzaxMlUxAacqy4BoBTXnFayIF0obBFfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hs5jbB5/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hs5jbB5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8344FC32782;
	Mon, 12 Aug 2024 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466331;
	bh=bxsjV2+rvbig8YCfl1zMYgSK1IliqRVW29EpeP3DppM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=hs5jbB5/35/CSnHFifAZMPZx7ktUr8EHW2dfoweKkN/OoM9kMfg97SNwwivZxOelz
	 bxkj8y/ZkRb5A45rsi+pqt9JRw1Xc/AMoq+rfA0/b7pH+O6CqImE8ZgB9NXpTVVvjw
	 vpVfa5HecsDoYOLTxt1LhPdoDJVCOQVhfVE2u2Y0=
Subject: Patch "mptcp: fix NL PM announced address accounting" has been added to the 5.15-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:38:28 +0200
In-Reply-To: <20240809090721.2699120-2-matttbe@kernel.org>
Message-ID: <2024081227-lumber-tanned-fbc8@gregkh>
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

    mptcp: fix NL PM announced address accounting

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-nl-pm-announced-address-accounting.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66129-greg=kroah.com@vger.kernel.org Fri Aug  9 11:07:37 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 11:07:22 +0200
Subject: mptcp: fix NL PM announced address accounting
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, "David S . Miller" <davem@davemloft.net>
Message-ID: <20240809090721.2699120-2-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 4b317e0eb287bd30a1b329513531157c25e8b692 upstream.

Currently the per connection announced address counter is never
decreased. As a consequence, after connection establishment, if
the NL PM deletes an endpoint and adds a new/different one, no
additional subflow is created for the new endpoint even if the
current limits allow that.

Address the issue properly updating the signaled address counter
every time the NL PM removes such addresses.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ Conflicts in pm_netlink.c, because the commit 6fa0174a7c86 ("mptcp:
  more careful RM_ADDR generation") is not in this version. The
  conditions are slightly different, but the same fix can be applied:
  first checking the IDs, then removing the address. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1323,6 +1323,7 @@ static bool mptcp_pm_remove_anno_addr(st
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
@@ -1462,19 +1463,20 @@ static void mptcp_pm_remove_addrs_and_su
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX &&
-		    slist.nr < MPTCP_RM_IDS_MAX) {
+		if (alist.nr < MPTCP_RM_IDS_MAX &&
+		    slist.nr < MPTCP_RM_IDS_MAX &&
+		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
 			alist.ids[alist.nr++] = entry->addr.id;
 			slist.ids[slist.nr++] = entry->addr.id;
-		} else if (remove_anno_list_by_saddr(msk, &entry->addr) &&
-			 alist.nr < MPTCP_RM_IDS_MAX) {
+		} else if (alist.nr < MPTCP_RM_IDS_MAX &&
+			   remove_anno_list_by_saddr(msk, &entry->addr)) {
 			alist.ids[alist.nr++] = entry->addr.id;
 		}
 	}
 
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
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
