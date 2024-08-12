Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4803B7A8;
	Mon, 12 Aug 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466311; cv=none; b=Mz6nJV900YjqL4fNEF9s0SoNNvnoQ9tt9QmbXLaXwvUOGo8UqpvOhahwg34LA/JJ9WfbYC2DtMvHXXVZT+U4t6KQAMPAf9+aVtFAnhXEW7QhJpsJcvxLHJq4SkAVoMl/BlS5wzhvlxe+yyNAmopxmxwNy5+ipzDufWTTEV7X3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466311; c=relaxed/simple;
	bh=2qTqcSgZXXcWsg3oGx5dnhGyHuf53Fi29UamrbNICoY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=iQi9d7yNFsF9xb0enCuffWk2KvQjeabWu1zdMKQydIONDAkwBuFsubNiO5ld/koQkJu0aBNqLcubYYG2T88hf4jzZxu70drDURORA0HxjSPgNLunfKffvmulHobiVj129jkdY2dEb1KcWNimpzla4RRFUXYMncFJJSJGpFHKT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LxUSdXQz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LxUSdXQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C7FC32782;
	Mon, 12 Aug 2024 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466310;
	bh=2qTqcSgZXXcWsg3oGx5dnhGyHuf53Fi29UamrbNICoY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=LxUSdXQznybSCt0rYvu62zEY5XUDddiuHzpFST2SLP/16gxwDvNad8xLzPFgqNr/U
	 nwXTPpWr88lVah/Xja8FdzUKo0ljwARGrJ6CfCo4cMu+5cg5TqzEh1tiEothnA82Ds
	 pielc9Aev2F/6zBhSQ4A+RcaJ8jyWdiv2Rh9JV6k=
Subject: Patch "mptcp: distinguish rcv vs sent backup flag in requests" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:38:26 +0200
In-Reply-To: <20240809090607.2697543-2-matttbe@kernel.org>
Message-ID: <2024081226-junior-prolonged-0212@gregkh>
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

    mptcp: distinguish rcv vs sent backup flag in requests

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66128-greg=kroah.com@vger.kernel.org Fri Aug  9 11:06:20 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 11:06:08 +0200
Subject: mptcp: distinguish rcv vs sent backup flag in requests
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240809090607.2697543-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit efd340bf3d7779a3a8ec954d8ec0fb8a10f24982 upstream.

When sending an MP_JOIN + SYN + ACK, it is possible to mark the subflow
as 'backup' by setting the flag with the same name. Before this patch,
the backup was set if the other peer set it in its MP_JOIN + SYN
request.

It is not correct: the backup flag should be set in the MPJ+SYN+ACK only
if the host asks for it, and not mirroring what was done by the other
peer. It is then required to have a dedicated bit for each direction,
similar to what is done in the subflow context.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in subflow.c, because the context has changed in commit
  4cf86ae84c71 ("mptcp: strict local address ID selection"), and in
  commit 967d3c27127e ("mptcp: fix data races on remote_id"), which are
  not in this version. These commits are unrelated to this
  modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c  |    2 +-
 net/mptcp/protocol.h |    1 +
 net/mptcp/subflow.c  |    1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -877,7 +877,7 @@ bool mptcp_synack_options(const struct r
 		return true;
 	} else if (subflow_req->mp_join) {
 		opts->suboptions = OPTION_MPTCP_MPJ_SYNACK;
-		opts->backup = subflow_req->backup;
+		opts->backup = subflow_req->request_bkup;
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -370,6 +370,7 @@ struct mptcp_subflow_request_sock {
 	u16	mp_capable : 1,
 		mp_join : 1,
 		backup : 1,
+		request_bkup : 1,
 		csum_reqd : 1,
 		allow_join_id0 : 1;
 	u8	local_id;
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1766,6 +1766,7 @@ static void subflow_ulp_clone(const stru
 		new_ctx->mp_join = 1;
 		new_ctx->fully_established = 1;
 		new_ctx->backup = subflow_req->backup;
+		new_ctx->request_bkup = subflow_req->request_bkup;
 		new_ctx->local_id = subflow_req->local_id;
 		new_ctx->remote_id = subflow_req->remote_id;
 		new_ctx->token = subflow_req->token;


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.15/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.15/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.15/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.15/selftests-mptcp-join-validate-backup-in-mpj.patch
queue-5.15/mptcp-export-local_address.patch
queue-5.15/mptcp-pm-only-set-request_bkup-flag-when-sending-mp_prio.patch
queue-5.15/mptcp-fix-bad-rcvpruned-mib-accounting.patch
