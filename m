Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71175817;
	Wed, 19 Jun 2024 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793680; cv=none; b=KffLQh1i+YQPd3LGooMToVcAb0TT7+SA3/bzNhhSDkHcpKq2L+bqjRj1XECcSrtQtXx7LsSzyZu/QynWDlWwpPkz0NRi69MjEfWwWDlnn1gOM/3GD9BH5ATDlKPx9cM82g8rOSa18ZzhOWPN6dZav5lteoOQVKy2Y+a+4KVRdqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793680; c=relaxed/simple;
	bh=9/kKCFldH84AyGm8TZpt5WMb1M6k+6AXFX9lbIl0pKo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=BrROGoVTxXlsCIz5wsCxzLmUX8qdNai+OwdAY1u8OBwbOU1aMEeUjwEp/6hRyhBnlJFxsjZ57CpMTt7KSmwBIT8WtVXoZGqHxA3Zx2lmXVPoW4EuDk4S7KuN6mB9xTPsK1RRTcWgx+K4dB8NEJABtajf18ot3rqveBboxoKeTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P2mzXLZm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P2mzXLZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385CDC4AF4D;
	Wed, 19 Jun 2024 10:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718793679;
	bh=9/kKCFldH84AyGm8TZpt5WMb1M6k+6AXFX9lbIl0pKo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=P2mzXLZm7KETqoyUOxyAT3bPMW8ESh0K5PEATCIISm2QmOPG86Kg22izq3wWt+J9K
	 vR/hJX5rRuOjpc6xIMCWO2jlDqH3igIY20GO51oSpE4/3ITln0cG48iiEprN2igbTd
	 GKjPRRAycFdqfWlmGB+dp03Sruo4/dlwEfKhOYPc=
Subject: Patch "mptcp: pm: update add_addr counters after connect" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,liyonglong@chinatelecom.cn,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 12:41:06 +0200
In-Reply-To: <20240618122531.641433-2-matttbe@kernel.org>
Message-ID: <2024061905-shifting-writing-82d6@gregkh>
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

    mptcp: pm: update add_addr counters after connect

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-update-add_addr-counters-after-connect.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-52671-greg=kroah.com@vger.kernel.org Tue Jun 18 14:25:44 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Jun 2024 14:25:32 +0200
Subject: mptcp: pm: update add_addr counters after connect
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, YonglongLi <liyonglong@chinatelecom.cn>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240618122531.641433-2-matttbe@kernel.org>

From: YonglongLi <liyonglong@chinatelecom.cn>

commit 40eec1795cc27b076d49236649a29507c7ed8c2d upstream.

The creation of new subflows can fail for different reasons. If no
subflow have been created using the received ADD_ADDR, the related
counters should not be updated, otherwise they will never be decremented
for events related to this ID later on.

For the moment, the number of accepted ADD_ADDR is only decremented upon
the reception of a related RM_ADDR, and only if the remote address ID is
currently being used by at least one subflow. In other words, if no
subflow can be created with the received address, the counter will not
be decremented. In this case, it is then important not to increment
pm.add_addr_accepted counter, and not to modify pm.accept_addr bit.

Note that this patch does not modify the behaviour in case of failures
later on, e.g. if the MP Join is dropped or rejected.

The "remove invalid addresses" MP Join subtest has been modified to
validate this case. The broadcast IP address is added before the "valid"
address that will be used to successfully create a subflow, and the
limit is decreased by one: without this patch, it was not possible to
create the last subflow, because:

- the broadcast address would have been accepted even if it was not
  usable: the creation of a subflow to this address results in an error,

- the limit of 2 accepted ADD_ADDR would have then been reached.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-3-1ab9ddfa3d00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c because commit 1a0d6136c5f0 ("mptcp: local
  addresses fullmesh") is not present in this version (+ others changing
  the context). To resolve the conflicts, the same block is moved later,
  and under the condition that the call to __mptcp_subflow_connect()
  didn't fail.
  The selftest modification has been dropped, because the modified test
  is not in this version. That's fine, we can test with selftests from a
  newer version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -371,15 +371,12 @@ void mptcp_pm_nl_add_addr_received(struc
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_addr_info remote;
 	struct mptcp_addr_info local;
+	int err;
 
 	pr_debug("accepted %d:%d remote family %d",
 		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
 		 msk->pm.remote.family);
-	msk->pm.add_addr_accepted++;
 	msk->pm.subflows++;
-	if (msk->pm.add_addr_accepted >= msk->pm.add_addr_accept_max ||
-	    msk->pm.subflows >= msk->pm.subflows_max)
-		WRITE_ONCE(msk->pm.accept_addr, false);
 
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
@@ -391,9 +388,16 @@ void mptcp_pm_nl_add_addr_received(struc
 	local.family = remote.family;
 
 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect((struct sock *)msk, &local, &remote);
+	err = __mptcp_subflow_connect((struct sock *)msk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 
+	if (!err) {
+		msk->pm.add_addr_accepted++;
+		if (msk->pm.add_addr_accepted >= msk->pm.add_addr_accept_max ||
+		    msk->pm.subflows >= msk->pm.subflows_max)
+			WRITE_ONCE(msk->pm.accept_addr, false);
+	}
+
 	mptcp_pm_announce_addr(msk, &remote, true);
 }
 


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.10/mptcp-pm-inc-rmaddr-mib-counter-once-per-rm_addr-id.patch
queue-5.10/mptcp-ensure-snd_una-is-properly-initialized-on-connect.patch
queue-5.10/mptcp-pm-update-add_addr-counters-after-connect.patch
