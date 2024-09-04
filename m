Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D01D67A6;
	Wed,  4 Sep 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460382; cv=none; b=UOZYN77eR219kEYHytSit1js499IMaqNyp1lmTnbIZHZfr+wzuMuSq5V2O4lUw1z2VQRpalkNP0FAQlxrjDIc1Lqn/FSIXhypQ/Bd3UfFzLhwy2vYU+xNUHYgC1i/Kb3EtjG40OhWNeZwXdONtJZWAJQFVYEd++b7RgHMLW/xWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460382; c=relaxed/simple;
	bh=ADxBBn2DKmtVe08R/HrKU8PRQ5hzuP2BR9mDtqfkkxc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=t4p2CuTlAh7KY/C5Xrz4zU4F6/4WfzPbKrNDzeLGy6xqFlEhJa9jpj5UeUC4/zMnp5e7SV5FDpIEIzqM3Kp/b3q8UmQUNi6Bnn1Gu0FGf72JK/AVxhfiiEpEp47P7JTQn2QbFFj6FkKkAj9OurrCp/LQYki3d8m854Hq/F6Bn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZpWugEIM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZpWugEIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1551C4CECF;
	Wed,  4 Sep 2024 14:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460382;
	bh=ADxBBn2DKmtVe08R/HrKU8PRQ5hzuP2BR9mDtqfkkxc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=ZpWugEIMJnAU3qRcE76X4FprtXP+BgpIeW3T6ksZdjRP+YVvtDqsXddSVS4sb915V
	 bwA62bMNNn3trTnLhutl7prkDVMjJRsFVX7sztOhXa+5Sm1UrAY1KtieVMUbcTXFh0
	 0reF8r1zDEPY2lIxEmTyHdU9TQSB8VLe1WiMGZTY=
Subject: Patch "mptcp: pm: fix ID 0 endp usage after multiple re-creations" has been added to the 6.1-stable tree
To: arinc.unal@arinc9.com,gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:32:50 +0200
In-Reply-To: <20240904110306.4082410-6-matttbe@kernel.org>
Message-ID: <2024090450-juice-casket-70e6@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: pm: fix ID 0 endp usage after multiple re-creations

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-fix-id-0-endp-usage-after-multiple-re-creations.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73006-greg=kroah.com@vger.kernel.org Wed Sep  4 13:04:07 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed,  4 Sep 2024 13:03:09 +0200
Subject: mptcp: pm: fix ID 0 endp usage after multiple re-creations
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, "Arınç ÜNAL" <arinc.unal@arinc9.com>, syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com, "Mat Martineau" <martineau@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Message-ID: <20240904110306.4082410-6-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 9366922adc6a71378ca01f898c41be295309f044 upstream.

'local_addr_used' and 'add_addr_accepted' are decremented for addresses
not related to the initial subflow (ID0), because the source and
destination addresses of the initial subflows are known from the
beginning: they don't count as "additional local address being used" or
"ADD_ADDR being accepted".

It is then required not to increment them when the entrypoint used by
the initial subflow is removed and re-added during a connection. Without
this modification, this entrypoint cannot be removed and re-added more
than once.

Reported-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/512
Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Reported-by: syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/00000000000049861306209237f4@google.com
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -627,12 +627,13 @@ subflow:
 
 		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
-		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 
 		/* Special case for ID0: set the correct ID */
 		if (local.addr.id == msk->mpc_endpoint_id)
 			local.addr.id = 0;
+		else /* local_addr_used is not decr for ID 0 */
+			msk->pm.local_addr_used++;
 
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
@@ -758,7 +759,9 @@ static void mptcp_pm_nl_add_addr_receive
 	spin_lock_bh(&msk->pm.lock);
 
 	if (sf_created) {
-		msk->pm.add_addr_accepted++;
+		/* add_addr_accepted is not decr for ID 0 */
+		if (remote.id)
+			msk->pm.add_addr_accepted++;
 		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
 		    msk->pm.subflows >= subflows_max)
 			WRITE_ONCE(msk->pm.accept_addr, false);


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-pm-fix-rm_addr-id-for-the-initial-subflow.patch
queue-6.1/selftests-mptcp-join-validate-fullmesh-endp-on-1st-sf.patch
queue-6.1/mptcp-pm-fix-id-0-endp-usage-after-multiple-re-creations.patch
queue-6.1/mptcp-make-pm_remove_addrs_and_subflows-static.patch
queue-6.1/mptcp-pm-avoid-possible-uaf-when-selecting-endp.patch
queue-6.1/mptcp-pm-reuse-id-0-after-delete-and-re-add.patch
queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-id.patch
queue-6.1/selftests-mptcp-join-test-for-flush-re-add-endpoints.patch
queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-re.patch
queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-readd.patch
queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-closed-subflow.patch
queue-6.1/mptcp-pm-fullmesh-select-the-right-id-later.patch
queue-6.1/mptcp-pr_debug-add-missing-n-at-the-end.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add_addr.patch
