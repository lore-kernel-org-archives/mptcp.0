Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8F1BC07B;
	Wed, 14 Aug 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657485; cv=none; b=RlfPPq5ZEqd92ysCWGKvJ9r3wpxsy4jwJ5OTwyREq8S2kpJBohJeTuKugu0PiprJWTrl7K1fU1YWjYwtNt2tj5SVrLynZJKitYWdbI/U/dzLTVA5svxd3CRzfj83VVIRWOGNtk5RbBQDJgO5AZWreTnVCa2t04L/KsQLYaa4ln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657485; c=relaxed/simple;
	bh=GUHy+MIWLQnyUCJsN0O7PNHh5etpwYnCtJE/qg/0gOw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ExGP8hdydK8nUKAxvse0QS7V73vOsMX11g/8+Ip5Xg1w75qVmmTx9PMnMRrOe+CzKxyCXLFYhuBuACFBsCVeVmz8i+mtTU6Lkek1FxCiQ6JGUTxX3dfZ7dBPXwDzByvDQdbEiDz+A/9vQMDVMKUq+U6rKU/1zQ4xNKznw1z0g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qO8D5Rq2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qO8D5Rq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37BDC4AF09;
	Wed, 14 Aug 2024 17:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723657484;
	bh=GUHy+MIWLQnyUCJsN0O7PNHh5etpwYnCtJE/qg/0gOw=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=qO8D5Rq2uXNnAnz/TPKuNZ7Cq0cofbZYJzJXgd/Wl6Qh7RbG5JSkJrgzgjlbIVsT2
	 thrxOB6ddSMnFhOonOP2wVS6K4GUI0rT7Ua/ghBrcv2PYWTR35ukXb6eVDjV4XNloJ
	 JhoHIxQmwIPQx2wfAawgC4IM55/I5VLSEYUS7/ak=
Subject: Patch "mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Aug 2024 19:44:33 +0200
In-Reply-To: <20240813092815.966749-11-matttbe@kernel.org>
Message-ID: <2024081433-untie-universe-a271@gregkh>
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

    mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-67440-greg=kroah.com@vger.kernel.org Tue Aug 13 11:28:40 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Aug 2024 11:28:20 +0200
Subject: mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240813092815.966749-11-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 85df533a787bf07bf4367ce2a02b822ff1fba1a3 upstream.

Up to the 'Fixes' commit, having an endpoint with both the 'signal' and
'subflow' flags, resulted in the creation of a subflow and an address
announcement using the address linked to this endpoint. After this
commit, only the address announcement was done, ignoring the 'subflow'
flag.

That's because the same bitmap is used for the two flags. It is OK to
keep this single bitmap, the already selected local endpoint simply have
to be re-used, but not via select_local_address() not to look at the
just modified bitmap.

Note that it is unusual to set the two flags together: creating a new
subflow using a new local address will implicitly advertise it to the
other peer. So in theory, no need to advertise it explicitly as well.
Maybe there are use-cases -- the subflow might not reach the other peer
that way, we can ask the other peer to try initiating the new subflow
without delay -- or very likely the user is confused, and put both flags
"just to be sure at least the right one is set". Still, if it is
allowed, the kernel should do what has been asked: using this endpoint
to announce the address and to create a new subflow from it.

An alternative is to forbid the use of the two flags together, but
that's probably too late, there are maybe use-cases, and it was working
before. This patch will avoid people complaining subflows are not
created using the endpoint they added with the 'subflow' and 'signal'
flag.

Note that with the current patch, the subflow might not be created in
some corner cases, e.g. if the 'subflows' limit was reached when sending
the ADD_ADDR, but changed later on. It is probably not worth splitting
id_avail_bitmap per target ('signal', 'subflow'), which will add another
large field to the msk "just" to track (again) endpoints. Anyway,
currently when the limits are changed, the kernel doesn't check if new
subflows can be created or removed, because we would need to keep track
of the received ADD_ADDR, and more. It sounds OK to assume that the
limits should be properly configured before establishing new
connections.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-5-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -524,8 +524,8 @@ __lookup_addr(struct pm_nl_pernet *perne
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -591,6 +591,9 @@ static void mptcp_pm_create_subflow_or_s
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &local->addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
+
+		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = local;
 	}
 
 subflow:
@@ -601,9 +604,14 @@ subflow:
 		bool fullmesh;
 		int i, nr;
 
-		local = select_local_address(pernet, msk);
-		if (!local)
-			break;
+		if (signal_and_subflow) {
+			local = signal_and_subflow;
+			signal_and_subflow = NULL;
+		} else {
+			local = select_local_address(pernet, msk);
+			if (!local)
+				break;
+		}
 
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.1/mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
queue-6.1/mptcp-pass-addr-to-mptcp_pm_alloc_anno_list.patch
queue-6.1/mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
queue-6.1/selftests-mptcp-join-test-both-signal-subflow.patch
queue-6.1/mptcp-pm-reduce-indentation-blocks.patch
