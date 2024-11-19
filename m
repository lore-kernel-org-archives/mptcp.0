Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933A1C2454;
	Tue, 19 Nov 2024 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021389; cv=none; b=VuQ4eMaC7BUIDXQgZIR/uozKp5/7EvUgZd8BuR2xnsfVmNjN7PtAdtgAMy9QzmVm5PwIClHeEmXVq+h3nWCjRIyXhOyupMLWT/0rCz2YpVG1o9qBZsPqZ8AohjH15+rBCER+42+15amKZ/o+n4H+bgRSWZB7b1FCFtTj364ssqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021389; c=relaxed/simple;
	bh=QzZXGy1ZFnMlJAYc3G425YiEhRDbDj1b1OzCRxXcNcQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=vBIt0wnZfO5c2p6PAv8DUippNSeZx/IkP64uXEyady6SHT+pjoL9bOzQ6JhmjLqSryCVdX3CNp7vlLYwymuRImCpDSKzt5xQ8esApeUWM4qkfZcb8Rk7VJPUac4jQMZDOjlCRpj8ztHKIpDHMUgcAq+7WuNxqCrhuflkcjRQGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YARlw5JW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YARlw5JW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D32C4CECF;
	Tue, 19 Nov 2024 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021389;
	bh=QzZXGy1ZFnMlJAYc3G425YiEhRDbDj1b1OzCRxXcNcQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=YARlw5JWXZSnlV7sdjpfuWmjBgo4y+V1OPy9/4giVyjpjEpZl94vS2EdJP0krhf9V
	 yr05HGrcyw7yJHa0rnF1ln7ItDUmlbnPSY0PBfRfXvDIUAoLjVq/t7LldTzv4iobT5
	 BEvR/Kiv5vCVre2p5x53vGsLRcOPIzefHiMDJ0m8=
Subject: Patch "mptcp: update local address flags when setting it" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Nov 2024 14:02:35 +0100
In-Reply-To: <20241118182718.3011097-11-matttbe@kernel.org>
Message-ID: <2024111935-elongated-exquisite-03b7@gregkh>
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

    mptcp: update local address flags when setting it

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-update-local-address-flags-when-setting-it.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-93824-greg=kroah.com@vger.kernel.org Mon Nov 18 19:27:52 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 Nov 2024 19:27:21 +0100
Subject: mptcp: update local address flags when setting it
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241118182718.3011097-11-matttbe@kernel.org>

From: Geliang Tang <tanggeliang@kylinos.cn>

commit e0266319413d5d687ba7b6df7ca99e4b9724a4f2 upstream.

Just like in-kernel pm, when userspace pm does set_flags, it needs to send
out MP_PRIO signal, and also modify the flags of the corresponding address
entry in the local address list. This patch implements the missing logic.

Traverse all address entries on userspace_pm_local_addr_list to find the
local address entry, if bkup is true, set the flags of this entry with
FLAG_BACKUP, otherwise, clear FLAG_BACKUP.

Fixes: 892f396c8e68 ("mptcp: netlink: issue MP_PRIO signals from userspace PMs")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-1-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_userspace.c, because commit 6a42477fe449 ("mptcp:
  update set_flags interfaces"), is not in this version, and causes too
  many conflicts when backporting it. The same code can still be added
  at the same place, before sending the ACK. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_userspace.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -563,6 +563,7 @@ int mptcp_userspace_pm_set_flags(struct
 				 struct mptcp_pm_addr_entry *loc,
 				 struct mptcp_pm_addr_entry *rem, u8 bkup)
 {
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -583,6 +584,17 @@ int mptcp_userspace_pm_set_flags(struct
 	    rem->addr.family == AF_UNSPEC)
 		goto set_flags_err;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &loc->addr, false)) {
+			if (bkup)
+				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+			else
+				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
 	release_sock(sk);


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
queue-6.6/mptcp-error-out-earlier-on-disconnect.patch
queue-6.6/mptcp-hold-pm-lock-when-deleting-entry.patch
queue-6.6/mptcp-cope-racing-subflow-creation-in-mptcp_rcv_spac.patch
queue-6.6/mptcp-drop-lookup_by_id-in-lookup_addr.patch
queue-6.6/mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
queue-6.6/mptcp-define-more-local-variables-sk.patch
queue-6.6/mptcp-update-local-address-flags-when-setting-it.patch
