Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689AC2E54AD;
	Sat, 23 Aug 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960831; cv=none; b=EWYYL0mV+W85fW138iyyfJJDtRyGIpJJJzq3xnYivLb7eNuadGK0B8wAq9ABavs6dbzIrvkJ1jTgRhxxqQr1L0rtfgfOb9TcUusLDDYxPnjPEleGwv9bb3Q9bGsNIKh7uWnGxtawNjQnI10JDGhOjVOCo2YiCH6EBKJnlTpZ/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960831; c=relaxed/simple;
	bh=nHDvfFStYuuUkZFG08YYKdZnt8QL0Taevk/S5ROu3bE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=QzUIfPwSHOp/9Z9D/ultsG2qbQMg3oaS74QhhhCSVIQswwN4R1yMGWljAczGVddzaP+bLrfJotQHCQvjv0N5RhwrWHRTs1ReMm8eGjY8QUj+B63rMqpk8eG3o7C70nq0PxzMjoaoRaqCFHsiNFYbDP6rVh9Lhez2UYiwPt0tHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2bmjNX6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2bmjNX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791CDC4CEE7;
	Sat, 23 Aug 2025 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755960830;
	bh=nHDvfFStYuuUkZFG08YYKdZnt8QL0Taevk/S5ROu3bE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=R2bmjNX6/q01mdxB1uacLEcXHoTlJkMemNUQEDcMkQKWnid8Vk57vUH+GvJa+1dc1
	 XmrwXQdU8HEOx2ufoNQY5dQ9/eIQucpK9n7aevTnz7OpFkuGPjNTACv6zn/eWaPwM+
	 llSen3vr3f75xpFTvIpTW7R+t8z+sGGp9yOpYyMw=
Subject: Patch "selftests: mptcp: pm: check flush doesn't reset limits" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 16:53:35 +0200
In-Reply-To: <20250822141059.48927-8-matttbe@kernel.org>
Message-ID: <2025082335-flyaway-enviable-8e6c@gregkh>
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

    selftests: mptcp: pm: check flush doesn't reset limits

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-pm-check-flush-doesn-t-reset-limits.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-172413-greg=kroah.com@vger.kernel.org Fri Aug 22 16:17:21 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 22 Aug 2025 16:11:03 +0200
Subject: selftests: mptcp: pm: check flush doesn't reset limits
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250822141059.48927-8-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 452690be7de2f91cc0de68cb9e95252875b33503 upstream.

This modification is linked to the parent commit where the received
ADD_ADDR limit was accidentally reset when the endpoints were flushed.

To validate that, the test is now flushing endpoints after having set
new limits, and before checking them.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-3-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.sh, because some refactoring have been done
  later on: commit 3188309c8ceb ("selftests: mptcp: netlink:
  add 'limits' helpers") and commit c99d57d0007a ("selftests: mptcp: use
  pm_nl endpoint ops") are not in this version. The same operation can
  still be done at the same place, without using the new helper. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -134,6 +134,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 1
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
 subflows 8" "set limits"
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-disable-add_addr-retransmission-when-timeout-is-0.patch
queue-6.6/mptcp-remove-duplicate-sk_reset_timer-call.patch
queue-6.6/mptcp-drop-skb-if-mptcp-skb-extension-allocation-fails.patch
queue-6.6/mptcp-pm-kernel-flush-do-not-reset-add_addr-limit.patch
queue-6.6/selftests-mptcp-pm-check-flush-doesn-t-reset-limits.patch
