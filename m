Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2724C669;
	Sat, 23 Aug 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960827; cv=none; b=sVbdnPzCXsenHEK2tmUFEPc4e1gI5j69xqng1T053vWD5STXit3qj9Abp8s4iOwWZOwx4+VFRjY/+D+8gJywGrzrnxJ4NJcMDo7go97b6IkdAqlGOs9R5me9G4b7dNbYarxgQT7EnlhgY1T2mN5atEw4y8Z2zJ2mNvPCqx3AyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960827; c=relaxed/simple;
	bh=bkR7ok2Fe1mqUjbfAt05JJx/lJmr3DU9ajrheIGjoHg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=nXhgDFJLxCSb8cTzDm8pJLdUzFZNsmwyOfBV/SVqxoau9s5ZNHihd6JgDfyLNk56swvZz0cR/aOMGe8fLscZkrMo9P801msKYnZxrzirBpIDvAHtt4iA3v7A2uBq2IVVLMyW6TW5PQbcbMBA4Ozy/gHhbH/Yp5/5HskOfd0qY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2CP5Xo3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2CP5Xo3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28863C4CEE7;
	Sat, 23 Aug 2025 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755960827;
	bh=bkR7ok2Fe1mqUjbfAt05JJx/lJmr3DU9ajrheIGjoHg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=2CP5Xo3hHEGfhLkjQvJD62dRX027zO6kgBUfqABV6+eUmTn5XnFNqCpd7LJy8m3x3
	 GACYpahu57029ZjX1+8djTIbWS0GUKNjB+zvHMleECx5ZgkH6oxY8sgETPHFNgs3N3
	 iImSsYnYq1541Q86GIMvk3Muhb2drdeWbrM5X6as=
Subject: Patch "mptcp: remove duplicate sk_reset_timer call" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 16:53:35 +0200
In-Reply-To: <20250822141059.48927-6-matttbe@kernel.org>
Message-ID: <2025082335-alienable-slideshow-962d@gregkh>
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

    mptcp: remove duplicate sk_reset_timer call

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-remove-duplicate-sk_reset_timer-call.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-172411-greg=kroah.com@vger.kernel.org Fri Aug 22 16:15:31 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 22 Aug 2025 16:11:01 +0200
Subject: mptcp: remove duplicate sk_reset_timer call
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250822141059.48927-6-matttbe@kernel.org>

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 5d13349472ac8abcbcb94407969aa0fdc2e1f1be upstream.

sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.

Simplify the code by using a 'goto' statement to eliminate the
duplication.

Note that this is not a fix, but it will help backporting the following
patch. The same "Fixes" tag has been added for this reason.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Before commit e4c28e3d5c09 ("mptcp: pm: move generic PM helpers to
  pm.c"), mptcp_pm_alloc_anno_list() was in pm_netlink.c. The same patch
  can be applied there without conflicts. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -373,9 +373,7 @@ bool mptcp_pm_alloc_anno_list(struct mpt
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -389,6 +387,7 @@ bool mptcp_pm_alloc_anno_list(struct mpt
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+reset_timer:
 	sk_reset_timer(sk, &add_entry->add_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-disable-add_addr-retransmission-when-timeout-is-0.patch
queue-6.6/mptcp-remove-duplicate-sk_reset_timer-call.patch
queue-6.6/mptcp-drop-skb-if-mptcp-skb-extension-allocation-fails.patch
queue-6.6/mptcp-pm-kernel-flush-do-not-reset-add_addr-limit.patch
queue-6.6/selftests-mptcp-pm-check-flush-doesn-t-reset-limits.patch
