Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78B848D;
	Mon, 12 Aug 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466707; cv=none; b=cezLPnsQb3ThQwcsknRIwpdBMkMmtKdA5jhjWitlWEtbPH4Su5gJRKlOC6gAEvHmcAajDj//m6BlMQcfDBo7jUad+8jQ+OJ6DimLKwWHZWlJoKLVeSnkkdIH/2bieVobe2xierve+JTtXnDT6wC3MVasrUpn/he82DoxuBgxNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466707; c=relaxed/simple;
	bh=tJw1osxfcZZf6YpxTr8LSSjLwxMeih/F7ixUjbCLK1o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ruoYJRK8kXavmVUj26lHzytRhXgfT6Zo21rvx4Z445q9T3xUZp1YCOppSCy/Q20BGBEg/soy6mnpcrAaaDNxhfCJtrLdwmHob0CkqdL/o7lA4p5AGzNrUo/vXkY9JgRY7jZoe40ZV8L5vUEGkSOVlAkTNCyIM90sQgS+lM84zsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JCStOd+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JCStOd+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24624C32782;
	Mon, 12 Aug 2024 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466706;
	bh=tJw1osxfcZZf6YpxTr8LSSjLwxMeih/F7ixUjbCLK1o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=JCStOd+QMtaT5EgLX7gnuJLfeoAPB2PZsbSevu3TH7tmzBIhYptrkA+LyVIpleN9Y
	 7IjsmQydk2jw/meBVXVcbMmp+orJpIDZUjvvzWODkXk+rIX2E2WHWH04ncut3AKrOi
	 9x1jU+mITUr/4+K2dej6LpmWmocHLCFUo4SH7/R4=
Subject: Patch "mptcp: fix NL PM announced address accounting" has been added to the 5.10-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:44:52 +0200
In-Reply-To: <20240809105449.2902071-2-matttbe@kernel.org>
Message-ID: <2024081252-buckle-probe-2d3d@gregkh>
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

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-nl-pm-announced-address-accounting.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66251-greg=kroah.com@vger.kernel.org Fri Aug  9 12:55:06 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 12:54:50 +0200
Subject: mptcp: fix NL PM announced address accounting
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, "David S . Miller" <davem@davemloft.net>
Message-ID: <20240809105449.2902071-2-matttbe@kernel.org>

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
[ Conflicts in pm_netlink.c, because the commit 06faa2271034 ("mptcp:
  remove multi addresses and subflows in PM") is not in this version.
  Only the modification in mptcp_pm_remove_anno_addr() is then needed. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -759,6 +759,7 @@ static bool mptcp_pm_remove_anno_addr(st
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, addr->id);
 		spin_unlock_bh(&msk->pm.lock);
 	}


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.10/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.10/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.10/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.10/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.10/mptcp-sched-check-both-directions-for-backup.patch
queue-5.10/mptcp-export-local_address.patch
