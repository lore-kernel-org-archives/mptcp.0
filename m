Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4613224;
	Sun,  8 Sep 2024 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800821; cv=none; b=qc2ERn9JuC7m1Ujzduf1TgPJL5/34Z7tG7Wo54e9QLRUezcIes6Zy+6tOhR3VhXH4x2SS0m5kyVKF4HhkFS1J4VJd1NSXhxTeHnbS5mgVp/PfhLYtw3Y+yGRUWFdLoXlYX1wnApGeloy/gtgqegXggBTXVSHlMr7ZGsm5FMHp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800821; c=relaxed/simple;
	bh=1DTLzt6N0aMajR29Lin+vLyVqUhWXuoPgRzRMIESB44=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=bhxRuZtnw9CVrDV6EHKeQmvt8iPhHtCRqUpb0V9/goTl9ftxT9LMU1xqGvJFunZogUDPg/PoyOh0Foq83ZJE0faJFXgXfDRbsU2gEuqp/OZ83MiO1ddu0QQEH7AlhgOSjGEocnVJWb8XbIt+qnYA258iJVh+KuEcj4YVka9vc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUQbYBdl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUQbYBdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4807C4CEC3;
	Sun,  8 Sep 2024 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800821;
	bh=1DTLzt6N0aMajR29Lin+vLyVqUhWXuoPgRzRMIESB44=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=CUQbYBdlA5ufv59kIUJaUxZs2jbDNWa26gVlduFMSIprIFc4XAM9ylisAgX7ONw/z
	 Pnal6LLTE5wtI2eJmbT2eGU8SvURBgSf/wgj6JUWrMe8lOeoTHhOWoswjIe7WqvYDn
	 wX24ujd+dJxeTkjPT0ukMFcsgBcCXFPKGymqhFF4=
Subject: Patch "mptcp: pm: do not remove already closed subflows" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 15:06:48 +0200
In-Reply-To: <20240906083401.1771515-2-matttbe@kernel.org>
Message-ID: <2024090847-catching-tidy-9a51@gregkh>
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

    mptcp: pm: do not remove already closed subflows

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-do-not-remove-already-closed-subflows.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73739-greg=kroah.com@vger.kernel.org Fri Sep  6 10:34:41 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  6 Sep 2024 10:34:02 +0200
Subject: mptcp: pm: do not remove already closed subflows
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240906083401.1771515-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 58e1b66b4e4b8a602d3f2843e8eba00a969ecce2 upstream.

It is possible to have in the list already closed subflows, e.g. the
initial subflow has been already closed, but still in the list. No need
to try to close it again, and increments the related counters again.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm_netlink.c, due to commit 3ad14f54bd74 ("mptcp: more
  accurate MPC endpoint tracking") which is not in this version, and
  changes the context. The same fix can be applied here by adding the
  new check at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -767,6 +767,9 @@ static void mptcp_pm_nl_rm_addr_or_subfl
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow->local_id;
 
+			if (inet_sk_state_load(ssk) == TCP_CLOSE)
+				continue;
+
 			if (rm_type == MPTCP_MIB_RMADDR)
 				id = subflow->remote_id;
 


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
