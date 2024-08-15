Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB6D1A2552;
	Thu, 15 Aug 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723711211; cv=none; b=Gm5gdLa0RCSgp1MPhwDpAjbhQWt2Q5/26GD531PCTZCZsfdc5CjPvNyJ8Eoddi3b0K9SEwAhpa+wsTblYQ91ymUez5pvF2/+4JGklfcQyvFupgWj9waZmtuXQeBPKDo7gAaWn3F2Xv1bbjFSKZv6+NUoStFq1tddtCx3/jYlLQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723711211; c=relaxed/simple;
	bh=Lk2MIxIG5X6Nwd4KDA4qcWTEmjItmQ1NpWd7waTQwh8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Nnv7kvOJ51ew3dJYXWyeT8RNJLwTbzG4ozMLr45ArMFV4O58mlnV2JT9LYOUpyMHnK0VWxFxp7di8I6mHCWORHF4SKawprvxeA7W2aNoO+FZBBSKK1BXC+dLR2zWSCkSdB0ejBnqJkqrUCOvjWHJzg5s+2g4wi4nQgnznTzyzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nLuONfM5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nLuONfM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21639C4AF0A;
	Thu, 15 Aug 2024 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723711211;
	bh=Lk2MIxIG5X6Nwd4KDA4qcWTEmjItmQ1NpWd7waTQwh8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=nLuONfM5WXhMMXtnTqkcZk5Xmz+iv7W+8ftmg4aLlu1/2F1tBdDYW7bYfDAQAnP/y
	 ezPmQpi0bBEvUn2z5nyEGsVILIIF0o9m+e8xocThYZloqdytDSqU24prIQb+xVlYNZ
	 QqEctMqfUuojXaSAOfXqX3BVINYcsDMXsRdZWrRU=
Subject: Patch "mptcp: fully established after ADD_ADDR echo on MPJ" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 15 Aug 2024 10:39:56 +0200
In-Reply-To: <20240813090606.939542-2-matttbe@kernel.org>
Message-ID: <2024081556-nearby-outsell-c292@gregkh>
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

    mptcp: fully established after ADD_ADDR echo on MPJ

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fully-established-after-add_addr-echo-on-mpj.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-67432-greg=kroah.com@vger.kernel.org Tue Aug 13 11:07:51 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Aug 2024 11:06:07 +0200
Subject: mptcp: fully established after ADD_ADDR echo on MPJ
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240813090606.939542-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit d67c5649c1541dc93f202eeffc6f49220a4ed71d upstream.

Before this patch, receiving an ADD_ADDR echo on the just connected
MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
resulting in an MP_RESET. That's because only ACKs with a DSS or
ADD_ADDRs without the echo bit were allowed.

Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
we are not supposed to send an ADD_ADDR before because it requires to be
in full established mode first. For the MP_JOIN 3WHS, that's different:
the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
can be received on the recently created one. The other peer will already
be in fully established, so it is allowed to send that.

We can then relax the conditions here to accept the ADD_ADDR echo for
MPJ subflows.

Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-1-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in options.c, because the context has changed in commit
  b3ea6b272d79 ("mptcp: consolidate initial ack seq generation"), which
  is not in this version. This commit is unrelated to this
  modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -950,7 +950,8 @@ static bool check_fully_established(stru
 	}
 
 	if (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo)) {
+	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
+	     (!mp_opt->echo || subflow->mp_join))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.1/nfsd-remove-nfsd_stats-make-th_cnt-a-global-counter.patch
queue-6.1/nfsd-move-reply-cache-initialization-into-nfsd-startup.patch
queue-6.1/sunrpc-remove-pg_stats-from-svc_program.patch
queue-6.1/mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
queue-6.1/nfsd-rename-nfsd_reply_cache_alloc.patch
queue-6.1/nfsd-make-all-of-the-nfsd-stats-per-network-namespace.patch
queue-6.1/mptcp-pass-addr-to-mptcp_pm_alloc_anno_list.patch
queue-6.1/nfsd-move-init-of-percpu-reply_cache_stats-counters-back-to-nfsd_init_net.patch
queue-6.1/nfsd-replace-nfsd_prune_bucket.patch
queue-6.1/nfsd-stop-setting-pg_stats-for-unused-stats.patch
queue-6.1/sunrpc-don-t-change-sv_stats-if-it-doesn-t-exist.patch
queue-6.1/nfsd-make-svc_stat-per-network-namespace-instead-of-global.patch
queue-6.1/nfsd-fix-frame-size-warning-in-svc_export_parse.patch
queue-6.1/nfsd-rename-nfsd_net_-to-nfsd_stats_.patch
queue-6.1/mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
queue-6.1/nfsd-refactor-nfsd_reply_cache_free_locked.patch
queue-6.1/mptcp-fully-established-after-add_addr-echo-on-mpj.patch
queue-6.1/sunrpc-use-the-struct-net-as-the-svc-proc-private.patch
queue-6.1/selftests-mptcp-join-test-both-signal-subflow.patch
queue-6.1/sunrpc-pass-in-the-sv_stats-struct-through-svc_create_pooled.patch
queue-6.1/mptcp-pm-reduce-indentation-blocks.patch
queue-6.1/nfsd-rewrite-synopsis-of-nfsd_percpu_counters_init.patch
queue-6.1/nfsd-expose-proc-net-sunrpc-nfsd-in-net-namespaces.patch
queue-6.1/nfsd-refactor-the-duplicate-reply-cache-shrinker.patch
