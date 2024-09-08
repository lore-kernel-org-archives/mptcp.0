Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6E1667F1;
	Sun,  8 Sep 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800837; cv=none; b=umuhf6Gwf/vDtWK70UGotPTtoQUrJ9OS2pHr/gvrV/evwQ/I8H2nJwqbOo7UD1kuVcKa7QVArPBG43OvVLB67baa6OmpS+g+4gSwrjXQc1zBPRylW8sDEoLJj444KVWZohljGaQVqpX2AXa9Kh6Vg6CG/yewSdJrmYoM/Ab1nsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800837; c=relaxed/simple;
	bh=1q6/M+HamJhCGmRlweQQdOiHivMfS/WYEl6DcYc9LT0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=I6FrK4kV5sfM2olhw1izG68is2HRRSKIu7rYUGLAWPpPEQDftFNCsacxb6xlsO0Kvey+8qcFfaMLeqNk1HG3Fx/iQI3OPjqciEU5MYl9kMDlxBh1CAuk5ILpAYtBsYQD/XeJsy0Ijot/R3OkCk9FaHOho/UDodsO+LTh04AU2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dtVozz+j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dtVozz+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14915C4CEC8;
	Sun,  8 Sep 2024 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800836;
	bh=1q6/M+HamJhCGmRlweQQdOiHivMfS/WYEl6DcYc9LT0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=dtVozz+jQ73mjcE46gTHgdmWKX7d/nd8IdF5V3QkWVhLGL4iy1evhbbacsvhX+B2w
	 kpZjTE55wHAY+zGlRVZqEg56W7PCui/tPGp0iXiHNXF1R/LgTk93M5yj0T9C+3FV6V
	 fYyk9bE8+IYxPDGCFVQHA6pmgigbzIaGmePou18A=
Subject: Patch "mptcp: pm: send ACK on an active subflow" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 15:06:54 +0200
In-Reply-To: <20240906083334.1770934-2-matttbe@kernel.org>
Message-ID: <2024090853-secret-brethren-7768@gregkh>
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

    mptcp: pm: send ACK on an active subflow

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-send-ack-on-an-active-subflow.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73738-greg=kroah.com@vger.kernel.org Fri Sep  6 10:34:03 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  6 Sep 2024 10:33:35 +0200
Subject: mptcp: pm: send ACK on an active subflow
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240906083334.1770934-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit c07cc3ed895f9bfe0c53b5ed6be710c133b4271c upstream.

Taking the first one on the list doesn't work in some cases, e.g. if the
initial subflow is being removed. Pick another one instead of not
sending anything.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm_netlink.c, because the code has been refactored in
  commit f5360e9b314c ("mptcp: introduce and use mptcp_pm_send_ack()")
  which is difficult to backport in this version. The same adaptations
  have been applied: iterating over all subflows, and send the ACK on
  the first active subflow. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -693,16 +693,18 @@ void mptcp_pm_nl_addr_send_ack(struct mp
 		return;
 
 	__mptcp_flush_join_list(msk);
-	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
-	if (subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (__mptcp_subflow_active(subflow)) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for %s\n",
-			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
+			spin_unlock_bh(&msk->pm.lock);
+			pr_debug("send ack for %s\n",
+				 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
 
-		mptcp_subflow_send_ack(ssk);
-		spin_lock_bh(&msk->pm.lock);
+			mptcp_subflow_send_ack(ssk);
+			spin_lock_bh(&msk->pm.lock);
+			break;
+		}
 	}
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
