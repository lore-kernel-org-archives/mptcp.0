Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D68916D9AE;
	Mon, 12 Aug 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466713; cv=none; b=ao9sB1OH1jqFtn0Ki5/hUMEPdtJeBSj4hLL7aayjnwnS6xnFNaHhVbtN3+qMxSVwzXEFDom4Ii6iTqhC5IbF5b5DjztG1yuGI1AFR/b8U+M58IrqWtqMslcG2H23TOj2me5GgCuzJfnEmagonXCT3adtR+CeTirr+c/CJ2zYN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466713; c=relaxed/simple;
	bh=Hj721kDsYk91nFMJ2+K9gW8McT6oYIV0Ogbe4KJ2fXA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=DETeLnGRoXyTRnKBZp7cs26oIKtLJQkNZJTvXllh9NSXSO1xQ9UW0I0onrkDcjKQwJFgFXUVXkcO+B1dnzm9kSlCSEPKZ6rPqmwPZJ5eZLwUFyf3mesNnIAMSTKxZL01XO/+vmFDJUdiQd7jW0kX7mG8Kq70XDgCx+A0HvUkfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kMgkz0fQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kMgkz0fQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D287C32782;
	Mon, 12 Aug 2024 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466713;
	bh=Hj721kDsYk91nFMJ2+K9gW8McT6oYIV0Ogbe4KJ2fXA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=kMgkz0fQ7ZhidoPG7VkIJio4Bm5jix1/cW+7BEshclcWJu8CL0iI3uP/x0DYlDAG1
	 GejZdGsjFGK2rhZycgdtOTXzjhk1GrtkX1QOVyymCNyY4h+lud8AZib+r1fRcgvzR8
	 UR3Espyi5d2X7ExA1pqNl++ZxlCCcQEbhGhoftZE=
Subject: Patch "mptcp: sched: check both directions for backup" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:44:53 +0200
In-Reply-To: <20240809105412.2901173-2-matttbe@kernel.org>
Message-ID: <2024081253-shown-trash-1c28@gregkh>
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

    mptcp: sched: check both directions for backup

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-sched-check-both-directions-for-backup.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66248-greg=kroah.com@vger.kernel.org Fri Aug  9 12:54:29 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 12:54:13 +0200
Subject: mptcp: sched: check both directions for backup
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240809105412.2901173-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit b6a66e521a2032f7fcba2af5a9bcbaeaa19b7ca3 upstream.

The 'mptcp_subflow_context' structure has two items related to the
backup flags:

 - 'backup': the subflow has been marked as backup by the other peer

 - 'request_bkup': the backup flag has been set by the host

Before this patch, the scheduler was only looking at the 'backup' flag.
That can make sense in some cases, but it looks like that's not what we
wanted for the general use, because either the path-manager was setting
both of them when sending an MP_PRIO, or the receiver was duplicating
the 'backup' flag in the subflow request.

Note that the use of these two flags in the path-manager are going to be
fixed in the next commits, but this change here is needed not to modify
the behaviour.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in protocol.c, because the context has changed in commit
  3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation") and in commit
  33d41c9cd74c ("mptcp: more accurate timeout"), which are not in this
  version. This commit is unrelated to this modification.
  Note that the tracepoint is not in this version, see commit
  e10a98920976 ("mptcp: add tracepoint in mptcp_subflow_get_send"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1124,11 +1124,13 @@ static struct sock *mptcp_subflow_get_se
 		send_info[i].ratio = -1;
 	}
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		*sndbuf = max(tcp_sk(ssk)->snd_wnd, *sndbuf);
 		if (!sk_stream_memory_free(subflow->tcp_sock))
 			continue;
@@ -1139,9 +1141,9 @@ static struct sock *mptcp_subflow_get_se
 
 		ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
 				pace);
-		if (ratio < send_info[subflow->backup].ratio) {
-			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].ratio = ratio;
+		if (ratio < send_info[backup].ratio) {
+			send_info[backup].ssk = ssk;
+			send_info[backup].ratio = ratio;
 		}
 	}
 


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.10/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.10/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.10/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.10/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.10/mptcp-sched-check-both-directions-for-backup.patch
queue-5.10/mptcp-export-local_address.patch
