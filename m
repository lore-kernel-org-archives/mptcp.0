Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707381494B4;
	Sun,  8 Sep 2024 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800839; cv=none; b=ghMLtstCBGQiAGmG5v8WFPW+G4fjv1fzLbOwyagbJ/PyNO/M5taacExjN3JlKE7XdyRYFKsvhefnXxZ100dj0/qsuEeWG080O++3UDCJzzj7dsuJI8cvAqeShe6FRzd5Cy4iDIUR1gRW7YRULWbjRy4rCPIXAd1yLQLeWJEuRko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800839; c=relaxed/simple;
	bh=HQfZNTnaIyzsrD27F3GmRqsn4oBOzu0tsWqv+a/Hfhc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=TOp6upVu1PVLQDjXH2U9oQRq0Mv7z07PyqUtQjN90ZLDPmK7cg71R73aMX7OgSTVMa6Cm3HlT8X/02boPE597OJ8JI7OJ2oRtkHgGfxB501P5j9F9vvnHs7SlDYG0UiFMX/1BeIp89Wmc70U3FgBrOb415KtNLuL5wkhasuBjSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G5jzYJIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G5jzYJIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED50AC4CEC3;
	Sun,  8 Sep 2024 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800839;
	bh=HQfZNTnaIyzsrD27F3GmRqsn4oBOzu0tsWqv+a/Hfhc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=G5jzYJIfRVJrt6K6it/SsOuMYPBrZbmaUfgi9imKEO7i4zFMtSJD1MWHWfTW5kva5
	 6TfoeM7wTIdfjQxBj8nmfTYqATPS2L/Ha7pgmGi85cjiIceTZhP0ZCVdtRoTq+4Q08
	 V9spebG8xxjRzqs0Y3PhSFQ2dH70SFRlM+V/Qqsk=
Subject: Patch "mptcp: pm: skip connecting to already established sf" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 15:06:55 +0200
In-Reply-To: <20240906083308.1770314-2-matttbe@kernel.org>
Message-ID: <2024090854-foyer-grower-e341@gregkh>
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

    mptcp: pm: skip connecting to already established sf

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-skip-connecting-to-already-established-sf.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73737-greg=kroah.com@vger.kernel.org Fri Sep  6 10:33:29 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  6 Sep 2024 10:33:09 +0200
Subject: mptcp: pm: skip connecting to already established sf
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240906083308.1770314-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit bc19ff57637ff563d2bdf2b385b48c41e6509e0d upstream.

The lookup_subflow_by_daddr() helper checks if there is already a
subflow connected to this address. But there could be a subflow that is
closing, but taking time due to some reasons: latency, losses, data to
process, etc.

If an ADD_ADDR is received while the endpoint is being closed, it is
better to try connecting to it, instead of rejecting it: the peer which
has sent the ADD_ADDR will not be notified that the ADD_ADDR has been
rejected for this reason, and the expected subflow will not be created
at the end.

This helper should then only look for subflows that are established, or
going to be, but not the ones being closed.

Fixes: d84ad04941c3 ("mptcp: skip connecting the connected address")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm_netlink.c, due to commit 4638de5aefe5 ("mptcp: handle
  local addrs announced by userspace PMs"), not in this version, and
  changing the context. The same fix can still be applied. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -145,12 +145,15 @@ static bool lookup_subflow_by_daddr(cons
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
-	struct sock_common *skc;
 
 	list_for_each_entry(subflow, list, node) {
-		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		remote_address(skc, &cur);
+		if (!((1 << inet_sk_state_load(ssk)) &
+		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
+			continue;
+
+		remote_address((struct sock_common *)ssk, &cur);
 		if (addresses_equal(&cur, daddr, daddr->port))
 			return true;
 	}


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-pm-avoid-possible-uaf-when-selecting-endp.patch
queue-5.15/mptcp-pm-only-decrement-add_addr_accepted-for-mpj-req.patch
queue-5.15/mptcp-pm-fullmesh-select-the-right-id-later.patch
queue-5.15/mptcp-pm-skip-connecting-to-already-established-sf.patch
queue-5.15/mptcp-pm-re-using-id-of-unused-flushed-subflows.patch
queue-5.15/mptcp-pm-add_addr-0-is-not-a-new-address.patch
queue-5.15/mptcp-constify-a-bunch-of-of-helpers.patch
queue-5.15/mptcp-pm-do-not-remove-already-closed-subflows.patch
queue-5.15/mptcp-pr_debug-add-missing-n-at-the-end.patch
queue-5.15/mptcp-pm-check-add_addr_accept_max-before-accepting-new-add_addr.patch
queue-5.15/mptcp-close-subflow-when-receiving-tcp-fin.patch
queue-5.15/mptcp-avoid-duplicated-sub_closed-events.patch
queue-5.15/mptcp-pm-send-ack-on-an-active-subflow.patch
