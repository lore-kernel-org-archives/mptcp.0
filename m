Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111DB441D;
	Wed,  4 Sep 2024 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460152; cv=none; b=OZOclM0lzLMo/8l+kS5xv474UB2HgHylJhhONYHR3k3qfEhO2BrVnl+0zLMAETz2duAPkXRokfKPHrQHyuGxLouxN6NcAuPxtZ0yo5MxTE+QVJUe26c1J9EtimfYxND4916Pd5PzKYGpFtUELuVXrR0RAQ4ttP9d3KrMQjfuBWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460152; c=relaxed/simple;
	bh=R4nWj777SKMiT1iXNw0t1klYAVvN34Pl2RQJlPunoPA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=iko0fTUqQNyqJ8fpvnUaUMSilwn9nnGkP1rlh2rjB8+ysJbBmdpqAKJYtgJNSqmLLGYjh/ildIe1aqSxUDMuGNdozgo5FqSbmgNm5KGHyepoT80cIDJTnH9+I/cDC1aB/Sm5+nOTfnVnGByEyf/Z8/waijTAZIfOTHQxCWjZm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2y+C/ns; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2y+C/ns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D1AC4CEC2;
	Wed,  4 Sep 2024 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460151;
	bh=R4nWj777SKMiT1iXNw0t1klYAVvN34Pl2RQJlPunoPA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=x2y+C/nshQlP3R3KnQeUFYC4jN36TIFPf8AlM5nyptAF2GhoaKOf/QXsXpn3QwCkI
	 7SdVwBCvoA9ILu541JEsO1PZXooUs1kAfTEqZSC+AC7IVvA5U0Hjq9eyxQ2kseu06Z
	 mBqOxXzZs2jF4LNzTjepAmZubuwganQU186BCk70=
Subject: Patch "mptcp: avoid duplicated SUB_CLOSED events" has been added to the 6.6-stable tree
To: arinc.unal@arinc9.com,gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:29:04 +0200
In-Reply-To: <20240903101747.3377518-2-matttbe@kernel.org>
Message-ID: <2024090404-proximity-outpour-52d3@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: avoid duplicated SUB_CLOSED events

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-avoid-duplicated-sub_closed-events.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-72801-greg=kroah.com@vger.kernel.org Tue Sep  3 12:18:08 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue,  3 Sep 2024 12:17:48 +0200
Subject: mptcp: avoid duplicated SUB_CLOSED events
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "MPTCP Upstream" <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, "Arınç ÜNAL" <arinc.unal@arinc9.com>, "Mat Martineau" <martineau@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Message-ID: <20240903101747.3377518-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit d82809b6c5f2676b382f77a5cbeb1a5d91ed2235 upstream.

The initial subflow might have already been closed, but still in the
connection list. When the worker is instructed to close the subflows
that have been marked as closed, it might then try to close the initial
subflow again.

 A consequence of that is that the SUB_CLOSED event can be seen twice:

  # ip mptcp endpoint
  1.1.1.1 id 1 subflow dev eth0
  2.2.2.2 id 2 subflow dev eth1

  # ip mptcp monitor &
  [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9

  # ip mptcp endpoint delete id 1
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
  [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9

The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
second one from __mptcp_close_subflow().

To avoid doing the post-closed processing twice, the subflow is now
marked as closed the first time.

Note that it is not enough to check if we are dealing with the first
subflow and check its sk_state: the subflow might have been reset or
closed before calling mptcp_close_ssk().

Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflict in protocol.h due to commit f1f26512a9bf ("mptcp: use plain
  bool instead of custom binary enum") and more that are not in this
  version, because they modify the context and the size of __unused. The
  conflict is easy to resolve, by not modifying data_avail type. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    6 ++++++
 net/mptcp/protocol.h |    3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2471,6 +2471,12 @@ out:
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
+	/* The first subflow can already be closed and still in the list */
+	if (subflow->close_event_done)
+		return;
+
+	subflow->close_event_done = true;
+
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
 
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -500,7 +500,8 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		__unused : 10;
+		close_event_done : 1,       /* has done the post-closed part */
+		__unused : 9;
 	enum mptcp_data_avail data_avail;
 	bool	scheduled;
 	u32	remote_nonce;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/selftests-mptcp-add-mptcp_lib_events-helper.patch
queue-6.6/selftests-mptcp-join-validate-event-numbers.patch
queue-6.6/selftests-mptcp-join-check-re-re-adding-id-0-signal.patch
queue-6.6/selftests-mptcp-join-cannot-rm-sf-if-closed.patch
queue-6.6/selftests-mptcp-declare-event-macros-in-mptcp_lib.patch
queue-6.6/mptcp-pm-fix-rm_addr-id-for-the-initial-subflow.patch
queue-6.6/mptcp-make-pm_remove_addrs_and_subflows-static.patch
queue-6.6/selftests-mptcp-dump-userspace-addrs-list.patch
queue-6.6/selftests-mptcp-join-stop-transfer-when-check-is-done-part-2.2.patch
queue-6.6/selftests-mptcp-join-test-for-flush-re-add-endpoints.patch
queue-6.6/selftests-mptcp-add-explicit-test-case-for-remove-re.patch
queue-6.6/mptcp-avoid-duplicated-sub_closed-events.patch
queue-6.6/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
queue-6.6/mptcp-pr_debug-add-missing-n-at-the-end.patch
queue-6.6/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
queue-6.6/selftests-mptcp-userspace-pm-create-id-0-subflow.patch
queue-6.6/selftests-mptcp-userspace-pm-get-addr-tests.patch
queue-6.6/selftests-mptcp-join-disable-get-and-dump-addr-checks.patch
