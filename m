Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA691CC157;
	Tue, 19 Nov 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022001; cv=none; b=WGXjTCXMZedYuEUyze2QB1z9rm2g0rDXmgm8+kaOXjhoPNLpsOFJaZPuJsAiHSMq6Gxg1tZVRZtYCmgN0tGFFiOlzVcklGiEo1nsXVPxEbifOLKq+YkNMRUn3qU6fZiaAHXVy1PKV5kRUdTgqmRPBL1BbiglbiKTEzy4FzNctO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022001; c=relaxed/simple;
	bh=Etezyzqjtww1WwlXHxgbNDB03nftprFYUm0LrPcxT40=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=cC5O7oWhpkkeGqNDMMSneiOZS8W5mq676jJMgFJirHtRb8w33z/nDf1A6hA8xp51K5WfQl3UyEcES3A6Qk7He9iZrBiJ+fMERKUexSumZ7ezZ5+u0AlbRB2wqDNbU2OFCbXZ+/BGWJY63XJVl2eV7c52j+/nTJS+sClwI1p+yoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pLxk16q7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pLxk16q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E13C4CECF;
	Tue, 19 Nov 2024 13:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732022000;
	bh=Etezyzqjtww1WwlXHxgbNDB03nftprFYUm0LrPcxT40=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=pLxk16q7uU2k0YyCMcWTVwqjv6K5mqW/Xg5wCdp7T5bDLJXS0ZpInEcTVjapLajnG
	 CSgx5aGBaWvXn1wz36G+kz5UyBPVe8ib+/8Km2XtS7OMZlZEawjW/f/+VBMsqIFzlB
	 V1bp0SIVPU3jusqqxUeBjz9kI8M1LOd6mV80T5CU=
Subject: Patch "mptcp: pm: use _rcu variant under rcu_read_lock" has been added to the 6.1-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Nov 2024 14:12:47 +0100
In-Reply-To: <20241119083547.3234013-16-matttbe@kernel.org>
Message-ID: <2024111946-next-dandelion-7b9a@gregkh>
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

    mptcp: pm: use _rcu variant under rcu_read_lock

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-93942-greg=kroah.com@vger.kernel.org Tue Nov 19 09:36:52 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 Nov 2024 09:35:55 +0100
Subject: mptcp: pm: use _rcu variant under rcu_read_lock
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241119083547.3234013-16-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit db3eab8110bc0520416101b6a5b52f44a43fb4cf upstream.

In mptcp_pm_create_subflow_or_signal_addr(), rcu_read_(un)lock() are
used as expected to iterate over the list of local addresses, but
list_for_each_entry() was used instead of list_for_each_entry_rcu() in
__lookup_addr(). It is important to use this variant which adds the
required READ_ONCE() (and diagnostic checks if enabled).

Because __lookup_addr() is also used in mptcp_pm_nl_set_flags() where it
is called under the pernet->lock and not rcu_read_lock(), an extra
condition is then passed to help the diagnostic checks making sure
either the associated spin lock or the RCU lock is held.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-3-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -529,7 +529,8 @@ __lookup_addr(struct pm_nl_pernet *perne
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
queue-6.1/mptcp-error-out-earlier-on-disconnect.patch
queue-6.1/mptcp-hold-pm-lock-when-deleting-entry.patch
queue-6.1/mptcp-cope-racing-subflow-creation-in-mptcp_rcv_space_adjust.patch
queue-6.1/mptcp-drop-lookup_by_id-in-lookup_addr.patch
queue-6.1/mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
queue-6.1/mptcp-define-more-local-variables-sk.patch
queue-6.1/mptcp-update-local-address-flags-when-setting-it.patch
