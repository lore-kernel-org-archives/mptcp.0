Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA01CC8BF;
	Tue, 19 Nov 2024 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021390; cv=none; b=rfFEF06XsZS1DvoK9dcJSmPcwrsJoyduoerSG8WLcdIMVGBOOTCKlRFA96taXtvA0zh1P3aCKyM/8Dq5l1pZfHcp5j9DJJQenvYfKNyuv/qs8NjwIFyiBy0//iMg0qIr0HxyL1lVcQiCKP29GX5YHFP0H+nfSzRP1QWc2mFoGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021390; c=relaxed/simple;
	bh=KDysQrCRMrGpLfjVLeo6aQUvQDaCW2TrPip01+AQtQw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=XH5JXA0Ig8MjhThaGaKeDzAkh5Az+XhQi8FjgoaKc3uo/MeIzWkrpqccqvRbbPjxHMfvn5vJUmObx1h4q1bYrfdU0ReZw59u0ZHrcYkG5Nfcr5cwkC52/xtvjaiPwKfbOFMN4mYrBrg1sE6UNeonpWrDGaUEub2ldVt0gBdVqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKCSBDbq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKCSBDbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1EAC4CECF;
	Tue, 19 Nov 2024 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021389;
	bh=KDysQrCRMrGpLfjVLeo6aQUvQDaCW2TrPip01+AQtQw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=qKCSBDbq9uIy7K7O/kHfkkmf+yaaw6O4a99eDOVrMaPaPgwcQj0YSz4eKVBQ6SPZ0
	 yrPfFP4QVB5keXsJJG9eX/FKd2Xl+huOTI752ecWqhU1P7mRFFlUzDI4UwqY0QTBP7
	 kJkjrfSEGCEZIlkd9bTKo8I8E0OBYvT/Yt6a+4Sg=
Subject: Patch "mptcp: hold pm lock when deleting entry" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Nov 2024 14:02:35 +0100
In-Reply-To: <20241118182718.3011097-12-matttbe@kernel.org>
Message-ID: <2024111935-duchess-charcoal-3a4e@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-hold-pm-lock-when-deleting-entry.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-93825-greg=kroah.com@vger.kernel.org Mon Nov 18 19:27:56 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 Nov 2024 19:27:22 +0100
Subject: mptcp: hold pm lock when deleting entry
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241118182718.3011097-12-matttbe@kernel.org>

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
@@ -324,14 +324,17 @@ int mptcp_nl_cmd_remove(struct sk_buff *
 
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

queue-6.6/mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
queue-6.6/mptcp-error-out-earlier-on-disconnect.patch
queue-6.6/mptcp-hold-pm-lock-when-deleting-entry.patch
queue-6.6/mptcp-cope-racing-subflow-creation-in-mptcp_rcv_spac.patch
queue-6.6/mptcp-drop-lookup_by_id-in-lookup_addr.patch
queue-6.6/mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
queue-6.6/mptcp-define-more-local-variables-sk.patch
queue-6.6/mptcp-update-local-address-flags-when-setting-it.patch
