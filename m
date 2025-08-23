Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A8261593;
	Sat, 23 Aug 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960820; cv=none; b=IW11jA9AdK0AEGJIaJLTt1+1vbL/EDC0Zv92wMkecw0o5b6JsvXxZEGSRzrNTCqMqhnhg1aR/AHI+aX0T5nsPkbyUzqKuxf+Ve3xJan21lV9B6OZ4J5RTWeie0PqH1J43T1Sg3S4x8GjpZ+O8ENKxVasDaq9W45mU30gMb6EOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960820; c=relaxed/simple;
	bh=XrBN/7QmxKlDiKTqRNapSyosPI3ZTzcVZGaWjE5IaF8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=YzTsNCnEY3Dtg1q27hP1GoWj/iXFdjlmRs1aB/03PDOXMxyo4nVq63utofz3Eht4i67QDLCUX9f2DSgqB4u7vWVOqbGcjCndcB5FxeZaMGLtzsMPM0NicrvaMErhngxCQ8tUfJ7os4Bgujd0sOiAfoyk0BWb7G+AH+keLR1fQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bj4GlmG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bj4GlmG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCF6C4CEE7;
	Sat, 23 Aug 2025 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755960818;
	bh=XrBN/7QmxKlDiKTqRNapSyosPI3ZTzcVZGaWjE5IaF8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=bj4GlmG98lYwgdRr5WAEen1tFiXW2ladh0G9zWNNd2XsGKwZvgJRaTjj2YnGg/S9x
	 jIDgVPB5MqhSlV3yCJJMYpclXcCn3Asge//pGHozuh3+oDAK1+GwMB1Lw7ZtpeT0cI
	 miows9MbHhLzdZgk9vNPUa4teukFiwEEG+9wBPdo=
Subject: Patch "mptcp: disable add_addr retransmission when timeout is 0" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 16:53:35 +0200
In-Reply-To: <20250822141059.48927-7-matttbe@kernel.org>
Message-ID: <2025082335-morbidly-unsightly-6218@gregkh>
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

    mptcp: disable add_addr retransmission when timeout is 0

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-disable-add_addr-retransmission-when-timeout-is-0.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-172412-greg=kroah.com@vger.kernel.org Fri Aug 22 16:17:20 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 22 Aug 2025 16:11:02 +0200
Subject: mptcp: disable add_addr retransmission when timeout is 0
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250822141059.48927-7-matttbe@kernel.org>

From: Geliang Tang <tanggeliang@kylinos.cn>

commit f5ce0714623cffd00bf2a83e890d09c609b7f50a upstream.

When add_addr_timeout was set to 0, this caused the ADD_ADDR to be
retransmitted immediately, which looks like a buggy behaviour. Instead,
interpret 0 as "no retransmissions needed".

The documentation is updated to explicitly state that setting the timeout
to 0 disables retransmission.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-5-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Before commit e4c28e3d5c09 ("mptcp: pm: move generic PM helpers to
  pm.c"), mptcp_pm_alloc_anno_list() was in pm_netlink.c. The same patch
  can be applied there without conflicts. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/networking/mptcp-sysctl.rst |    2 ++
 net/mptcp/pm_netlink.c                    |   13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -20,6 +20,8 @@ add_addr_timeout - INTEGER (seconds)
 	resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
+	Do not retransmit if set to 0.
+
 	The default value matches TCP_RTO_MAX. This is a per-namespace
 	sysctl.
 
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -294,6 +294,7 @@ static void mptcp_pm_add_timer(struct ti
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -311,6 +312,10 @@ static void mptcp_pm_add_timer(struct ti
 		goto out;
 	}
 
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	if (!timeout)
+		goto out;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
@@ -322,7 +327,7 @@ static void mptcp_pm_add_timer(struct ti
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + timeout);
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -364,6 +369,7 @@ bool mptcp_pm_alloc_anno_list(struct mpt
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
+	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -388,8 +394,9 @@ bool mptcp_pm_alloc_anno_list(struct mpt
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 reset_timer:
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+	timeout = mptcp_get_add_addr_timeout(net);
+	if (timeout)
+		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
 	return true;
 }


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-disable-add_addr-retransmission-when-timeout-is-0.patch
queue-6.6/mptcp-remove-duplicate-sk_reset_timer-call.patch
queue-6.6/mptcp-drop-skb-if-mptcp-skb-extension-allocation-fails.patch
queue-6.6/mptcp-pm-kernel-flush-do-not-reset-add_addr-limit.patch
queue-6.6/selftests-mptcp-pm-check-flush-doesn-t-reset-limits.patch
