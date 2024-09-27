Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53C17BECB;
	Fri, 27 Sep 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425527; cv=none; b=WgooPAFtoi7/ae+WQQtTvwEZ4c9oNRWbvQed4jrj/u70b51lE5jH8Zxr6Dh8QJW3xPrVVbECF7cULVPGJn3Uh6ki/5oyfaLD1QGeJc5C6Cdvbc/UTvNlWULndcXcYjVQnlScNNgz3XWvlngRFRw6Mb+qNzyZ8d8zgPgBm+fjhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425527; c=relaxed/simple;
	bh=YcDOUqqj1b4UfRKcWFYW3jqgz3tA9A2PD2ZNDS19INU=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=S20HXhHuuV40OgHP3QeqXRTjpxLU4xGNtlc/bdTteQyXODfud/dIVZdAMX1Ob34JXTY9idZE392oGcOj909NI/8EPLm1QCrmU8dPcFMbR1mfaz2imCmmI2eS7k4aaO0D7Qpp5hQyKGzCwtCWCcJrR8MR8xlLAJHamkgsMw+wv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vrEJUl1k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vrEJUl1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25CEC4CEC4;
	Fri, 27 Sep 2024 08:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727425527;
	bh=YcDOUqqj1b4UfRKcWFYW3jqgz3tA9A2PD2ZNDS19INU=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=vrEJUl1kZJdifFsfp7qfAfLPOtuC9JCiT/pY4/zh96k+su5kOIYYIFuoCMswm7hMA
	 AgR+8FtyS9bJc+mqXriYKrsd0AQjUC628EWiF+OIxiNJ4s8T6KugWfJhKYSjAdbQiA
	 NQ98DmYyqmS128MFvEHYM4BHERKm9GRhMA0as770=
Subject: Patch "mptcp: validate 'id' when stopping the ADD_ADDR retransmit timer" has been added to the 5.10-stable tree
To: davem@davemloft.net,dcaratti@redhat.com,gregkh@linuxfoundation.org,mathew.j.martineau@linux.intel.com,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 27 Sep 2024 10:25:13 +0200
In-Reply-To: <20240917072607.799536-7-matttbe@kernel.org>
Message-ID: <2024092713-anemia-colonist-8da3@gregkh>
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

    mptcp: validate 'id' when stopping the ADD_ADDR retransmit timer

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-validate-id-when-stopping-the-add_addr-retransmit-timer.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-76549-greg=kroah.com@vger.kernel.org Tue Sep 17 09:26:36 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 17 Sep 2024 09:26:10 +0200
Subject: mptcp: validate 'id' when stopping the ADD_ADDR retransmit timer
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Davide Caratti <dcaratti@redhat.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20240917072607.799536-7-matttbe@kernel.org>

From: Davide Caratti <dcaratti@redhat.com>

commit d58300c3185b78ab910092488126b97f0abe3ae2 upstream.

when Linux receives an echo-ed ADD_ADDR, it checks the IP address against
the list of "announced" addresses. In case of a positive match, the timer
that handles retransmissions is stopped regardless of the 'Address Id' in
the received packet: this behaviour does not comply with RFC8684 3.4.1.

Fix it by validating the 'Address Id' in received echo-ed ADD_ADDRs.
Tested using packetdrill, with the following captured output:

 unpatched kernel:

 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0xfd2e62517888fe29,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 1.2.3.4,mptcp dss ack 3013740213], length 0
 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0xfd2e62517888fe29,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 90 198.51.100.2,mptcp dss ack 3013740213], length 0
        ^^^ retransmission is stopped here, but 'Address Id' is 90

 patched kernel:

 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 1.2.3.4,mptcp dss ack 1672384568], length 0
 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 90 198.51.100.2,mptcp dss ack 1672384568], length 0
 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 198.51.100.2,mptcp dss ack 1672384568], length 0
        ^^^ retransmission is stopped here, only when both 'Address Id' and 'IP Address' match

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: b4cd80b03389 ("mptcp: pm: Fix uaf in __timer_delete_sync")
[ Conflicts in options.c, because some features are missing in this
  version, e.g. commit 557963c383e8 ("mptcp: move to next addr when
  subflow creation fail") and commit f7dafee18538 ("mptcp: use
  mptcp_addr_info in mptcp_options_received"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c    |    2 +-
 net/mptcp/pm_netlink.c |    8 ++++----
 net/mptcp/protocol.h   |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -915,7 +915,7 @@ void mptcp_incoming_options(struct sock
 			mptcp_pm_add_addr_received(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
-			mptcp_pm_del_add_timer(msk, &addr);
+			mptcp_pm_del_add_timer(msk, &addr, true);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
 		mp_opt.add_addr = 0;
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -249,18 +249,18 @@ out:
 
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr)
+		       struct mptcp_addr_info *addr, bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry)
+	if (entry && (!check_id || entry->addr.id == addr->id))
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry)
+	if (entry && (!check_id || entry->addr.id == addr->id))
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
@@ -764,7 +764,7 @@ static bool remove_anno_list_by_saddr(st
 {
 	struct mptcp_pm_add_entry *entry;
 
-	entry = mptcp_pm_del_add_timer(msk, addr);
+	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
 		list_del(&entry->list);
 		kfree(entry);
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -450,7 +450,7 @@ void mptcp_pm_rm_addr_received(struct mp
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr);
+		       struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				struct mptcp_addr_info *addr);


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/mptcp-pm-fix-uaf-in-__timer_delete_sync.patch
queue-5.10/mptcp-validate-id-when-stopping-the-add_addr-retransmit-timer.patch
queue-5.10/mptcp-export-lookup_anno_list_by_saddr.patch
