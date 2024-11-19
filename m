Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7B1C2454;
	Tue, 19 Nov 2024 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021388; cv=none; b=aVgn9xXe92WeCrshHIhk2RC2HgYYf+0+o21HeNqQrilWV0MmOT2WfrCOQ7dR5b8i1oQXipIiRHnDu8wkIKJuJg4/rlCeG2SkJj5vZvorMG3LoVa3ljTfnVh8q4ZSoy9P503frEz6I5ekfjoEQIwEu6NPUmD05AnyPAKcEzVu2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021388; c=relaxed/simple;
	bh=+ouU80Wis/pAK7gdCbMsyLK0LQzRR+9yg59+lqiGzqo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=bdr/S3OsFDlZDQVLme2iXFXSjpyyKv9wTlSYgD3ziCq5KDZSBmvO3zOTZwkFpD8Aa/b9L1e9kwQ/qv/7Cnhx1tEB0+hYrertqxCidbxN6MjLUvYRqEZrjjhn1/0vJ8xbJEK+TSIzXOeEANpElBq0lIX8enO2WKFRvuBF3LGjwhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hQFxUYf3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hQFxUYf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B26C4CECF;
	Tue, 19 Nov 2024 13:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021388;
	bh=+ouU80Wis/pAK7gdCbMsyLK0LQzRR+9yg59+lqiGzqo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=hQFxUYf3ARuLMy8LNI7/YBuK31fEcJQsbw+7wa2q4viQzrjoEHRZD77lo3TyFWGd3
	 Mw9bQYmPItgeccFAvCK6WVv/dazGMFIeKb8bu7xe2Y4PIcWYpf2YOzMqBZKObgBBPj
	 c1L1zw1E0B359wg2kGS8h9io8md76JsTIFPD2kAg=
Subject: Patch "mptcp: pm: use _rcu variant under rcu_read_lock" has been added to the 6.6-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Nov 2024 14:02:35 +0100
In-Reply-To: <20241118182718.3011097-14-matttbe@kernel.org>
Message-ID: <2024111935-epilogue-siren-759e@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-93827-greg=kroah.com@vger.kernel.org Mon Nov 18 19:28:00 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 Nov 2024 19:27:24 +0100
Subject: mptcp: pm: use _rcu variant under rcu_read_lock
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241118182718.3011097-14-matttbe@kernel.org>

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
@@ -525,7 +525,8 @@ __lookup_addr(struct pm_nl_pernet *perne
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
queue-6.6/mptcp-error-out-earlier-on-disconnect.patch
queue-6.6/mptcp-hold-pm-lock-when-deleting-entry.patch
queue-6.6/mptcp-cope-racing-subflow-creation-in-mptcp_rcv_spac.patch
queue-6.6/mptcp-drop-lookup_by_id-in-lookup_addr.patch
queue-6.6/mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
queue-6.6/mptcp-define-more-local-variables-sk.patch
queue-6.6/mptcp-update-local-address-flags-when-setting-it.patch
