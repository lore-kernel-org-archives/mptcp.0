Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C11CCEF9;
	Tue, 19 Nov 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021998; cv=none; b=qV6ujgLXJV2wQeum99cEhlh4BfZ+cIEKAw1onZLXpfOPFnWKKV4FLmR6H4xfiAU+BeJOAEGiR1OuBS0LFzWTQmD9mV2fBSIXYKNRYX/WhJjzO0zYyFgNKZF7ScHohSNFjxBvaXn7uicv23SFjO35Hs9PQezftpZ/brbGxREc4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021998; c=relaxed/simple;
	bh=E3OzJY/AYasOC9o555RIXY+u+fjR4JIrgbQ+mWV/Fak=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=UB7tNPIUWU/l+OnFGjdRIdhxFm9a661tDqwCmn5ImCdAhbdy/bxpTJpp/rf3lBOW1SbsWwnpi0NDkHYtk6t8K241R00JPqac+8ToU65x7ZyvEWF2EFIIX0N654aLyyHUNmPlNg6gkp5WMiSJwhx963L7342iUTiaSBX17wHRu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xtHvCWiB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xtHvCWiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6879C4CECF;
	Tue, 19 Nov 2024 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021997;
	bh=E3OzJY/AYasOC9o555RIXY+u+fjR4JIrgbQ+mWV/Fak=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=xtHvCWiBCXEjuenJwTC8GcL2QZHbXRHQArRkIKNpiQReAQCxXT4JXgasU9cTPhgHf
	 rvd10pyraifQA7PrR6aUNS5OS5cYlzc7MFezS+bBz8kkwP67aLKLJpCljL7x7sfQQi
	 GID1mnw/JYo551bf+ijY/uhKXNl8KeHy6l6amgSM=
Subject: Patch "mptcp: hold pm lock when deleting entry" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Nov 2024 14:12:46 +0100
In-Reply-To: <20241119083547.3234013-14-matttbe@kernel.org>
Message-ID: <2024111946-revision-villain-cc8c@gregkh>
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

    mptcp: hold pm lock when deleting entry

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-hold-pm-lock-when-deleting-entry.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-93940-greg=kroah.com@vger.kernel.org Tue Nov 19 09:36:48 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 Nov 2024 09:35:53 +0100
Subject: mptcp: hold pm lock when deleting entry
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241119083547.3234013-14-matttbe@kernel.org>

From: Geliang Tang <tanggeliang@kylinos.cn>

commit f642c5c4d528d11bd78b6c6f84f541cd3c0bea86 upstream.

When traversing userspace_pm_local_addr_list and deleting an entry from
it in mptcp_pm_nl_remove_doit(), msk->pm.lock should be held.

This patch holds this lock before mptcp_userspace_pm_lookup_addr_by_id()
and releases it after list_move() in mptcp_pm_nl_remove_doit().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-2-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_userspace.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -326,14 +326,17 @@ int mptcp_nl_cmd_remove(struct sk_buff *
 
 	lock_sock(sk);
 
+	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
+		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto remove_err;
 	}
 
 	list_move(&match->list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
queue-6.1/mptcp-error-out-earlier-on-disconnect.patch
queue-6.1/mptcp-hold-pm-lock-when-deleting-entry.patch
queue-6.1/mptcp-cope-racing-subflow-creation-in-mptcp_rcv_space_adjust.patch
queue-6.1/mptcp-drop-lookup_by_id-in-lookup_addr.patch
queue-6.1/mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
queue-6.1/mptcp-define-more-local-variables-sk.patch
queue-6.1/mptcp-update-local-address-flags-when-setting-it.patch
