Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842D3224;
	Sun,  8 Sep 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800803; cv=none; b=ef3qZU3mBWXDFGuYlXR0bwuyz70nOZrzOAlDmA/rOgPmt5KuLHSUF0Tlt7Hr4qJXD0G132qOVf0QSbkfLsZg5kR1UbbVPHeEgPTGAHQIjD3vefDIuB8kxHgHN6JDTYwxKq2yVBqGr7A9bZ0JuuZh4lzs5HJHVZCL8rnUTMBEzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800803; c=relaxed/simple;
	bh=ixlHWjPGrnWO+G9mWgKiEPQRYfn3dwg2UMEDerQPYe0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=lQcZ746JSybRiX+b2WOfo5P/67vfeeHS34kbZldJC7x4jLHDNgdONPkTjbKQqL2w4F3GEs1jBHGk9Vq1wotPaTgTLk+YSM9Gw+CvVbzfbDJO/MPvSBqqFNmSNtJ3UVCYeB8wW4wNScD6e8JjCJCS6uBmkN58SUS/YAFYGyomIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNFffr48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNFffr48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14ECC4CEC3;
	Sun,  8 Sep 2024 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800803;
	bh=ixlHWjPGrnWO+G9mWgKiEPQRYfn3dwg2UMEDerQPYe0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=VNFffr48a/pvjP3EYx4AsaAV+QHgh6cc/QrFp1HmiIGJs5Eza/A15EXUbYe23pmar
	 856fgWRPEq20qYmURjY0lzEAks44ikjR6A5AFFslwgmnBG05cI9/PibmhW1sUZdnfS
	 XDAdMYmD3cFCvgNvsrtuS6BsR8fspVEW60njaGrU=
Subject: Patch "mptcp: avoid duplicated SUB_CLOSED events" has been added to the 5.15-stable tree
To: arinc.unal@arinc9.com,gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 15:06:40 +0200
In-Reply-To: <20240906083430.1772159-2-matttbe@kernel.org>
Message-ID: <2024090839-panhandle-puppet-eaf5@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-avoid-duplicated-sub_closed-events.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73740-greg=kroah.com@vger.kernel.org Fri Sep  6 10:35:15 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  6 Sep 2024 10:34:31 +0200
Subject: mptcp: avoid duplicated SUB_CLOSED events
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "MPTCP Upstream" <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, "Arınç ÜNAL" <arinc.unal@arinc9.com>, "Mat Martineau" <martineau@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Message-ID: <20240906083430.1772159-2-matttbe@kernel.org>

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
  bool instead of custom binary enum"), commit dfc8d0603033 ("mptcp:
  implement delayed seq generation for passive fastopen") and more that
  are not in this version, because they modify the context and the size
  of __unused. The conflict is easy to resolve, by not only adding the
  new field (close_event_done), and __unused. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    6 ++++++
 net/mptcp/protocol.h |    4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2337,6 +2337,12 @@ static void __mptcp_close_ssk(struct soc
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
 	__mptcp_close_ssk(sk, ssk, subflow);
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -441,7 +441,9 @@ struct mptcp_subflow_context {
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
-		valid_csum_seen : 1;        /* at least one csum validated */
+		valid_csum_seen : 1,        /* at least one csum validated */
+		close_event_done : 1,       /* has done the post-closed part */
+		__unused : 11;
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;


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
