Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0517A5B5;
	Mon, 12 Aug 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466695; cv=none; b=i2usZjQaZhQZNncDZhXvhn9rhDAnxyG31WVfQHGJwyjX/XtQdNGPL1Bv6livdT/PRmvGJfJ00/WzZFYJBOix2A+qgNZnEWZ6HHMDBPJKlsEod9L1f9QAFLuCql0scyZLFbm5Ki+cvhRTCOKaTUxcUFXxqeU2YmhbBBjQNK/FV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466695; c=relaxed/simple;
	bh=9S7EKJ9e8p3i0ugrH+BeJR+S39AiefByFUTRAuRXyII=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=m7scNA3RpB9OxG0kivC8ktTnQDM0gFlnyg4NsxiY+6XKMAPbucTVJcnwDhsg59queFiz9s9Y5Po3yJ6Wz77G5QfU1bjw07luHxn69G5a7meSPT1QGBL8YoyWNfmcCbveez23VG+U0DgZ4Fq5sE0jGDZ9ku8ra0IOwDw2/ZzJOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdps/Y2L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdps/Y2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD45EC32782;
	Mon, 12 Aug 2024 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466695;
	bh=9S7EKJ9e8p3i0ugrH+BeJR+S39AiefByFUTRAuRXyII=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=cdps/Y2LziW3ENbqfqqlJPIslVgFuxNU7f+vzQlN3ER/BP+hY5tSL4xkcdO3EiatA
	 tGEIeCqTg02ppwOHq5eKxguHaexVolUc3yBWoX0Qbzl6LQb54JrqoX7md8eaDeOwdu
	 7PGAJ+L7UtR1f0kCIa8zQ0eROVtFIsHcoNEevgdA=
Subject: Patch "mptcp: distinguish rcv vs sent backup flag in requests" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:44:52 +0200
In-Reply-To: <20240809105430.2901613-2-matttbe@kernel.org>
Message-ID: <2024081252-octane-grunge-7358@gregkh>
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

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66249-greg=kroah.com@vger.kernel.org Fri Aug  9 12:54:48 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 12:54:31 +0200
Subject: mptcp: distinguish rcv vs sent backup flag in requests
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240809105430.2901613-2-matttbe@kernel.org>

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
  modification.
  Same in protocol.h, with commit bab6b88e0560 ("mptcp: add
  allow_join_id0 in mptcp_out_options"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c  |    2 +-
 net/mptcp/protocol.h |    3 ++-
 net/mptcp/subflow.c  |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -708,7 +708,7 @@ bool mptcp_synack_options(const struct r
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
@@ -261,7 +261,8 @@ struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
 		mp_join : 1,
-		backup : 1;
+		backup : 1,
+		request_bkup : 1;
 	u8	local_id;
 	u8	remote_id;
 	u64	local_key;
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1395,6 +1395,7 @@ static void subflow_ulp_clone(const stru
 		new_ctx->mp_join = 1;
 		new_ctx->fully_established = 1;
 		new_ctx->backup = subflow_req->backup;
+		new_ctx->request_bkup = subflow_req->request_bkup;
 		new_ctx->local_id = subflow_req->local_id;
 		new_ctx->remote_id = subflow_req->remote_id;
 		new_ctx->token = subflow_req->token;


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.10/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.10/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.10/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.10/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.10/mptcp-sched-check-both-directions-for-backup.patch
queue-5.10/mptcp-export-local_address.patch
