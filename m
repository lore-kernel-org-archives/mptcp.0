Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C672BB1D;
	Sun, 21 Sep 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475560; cv=none; b=Yx0ztxnDwTP6Fc9oK7XB+cu/uCFBhFwN9n/79S/TU3SMxybiL5WTYNhA4xLf/iwKe+4CKkww55TXXjLGGDIMqGQxwiqk7nihrRgqGratmRF/8dbNEsPZU2bTNCKvR/1QLmU1cIcpEGzQ/fRUt1yTyCwYP4akpp3YytnzrTroQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475560; c=relaxed/simple;
	bh=6QnVCx7h0Lh6JASmktnDEvqqeGp7VjpvojZmH6XhdwE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=tYDrtlbkdtIiNQ37AFd6VhfZ2NBVeQMaiJgimsHrSzR+hSq3NFVnxioiWA22jQYWTMthAj61RLG0CrvUmPrPAh8PlDOUTzA9bPL/FXIE5SuWDBqqYprwyG//5h/tgSY8qVYiUnbDtnoNYo9LfuKzP6ZwFEvrqdHNxDnmb8cVWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fRoFQ0LK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fRoFQ0LK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E72C4CEE7;
	Sun, 21 Sep 2025 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758475560;
	bh=6QnVCx7h0Lh6JASmktnDEvqqeGp7VjpvojZmH6XhdwE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=fRoFQ0LKCCGsLF4AXMS5kzumElsGrOSr3nGZx2wKA6DxCmC2LgXJ3IVaWwq3gPE4l
	 NNkl1QcTrXLKjHI7CGV7pJeSpcN977nxSZ8LrmETgngcNy0pjLrTEq+IKIP2Cp6wdq
	 SJ4Tf8svSgf59rviSaN7yHXyv5SXB0GbBgPodJ/M=
Subject: Patch "mptcp: set remote_deny_join_id0 on SYN recv" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 19:25:55 +0200
In-Reply-To: <20250919231743.3957803-2-matttbe@kernel.org>
Message-ID: <2025092155-configure-yapping-1bd8@gregkh>
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

    mptcp: set remote_deny_join_id0 on SYN recv

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-set-remote_deny_join_id0-on-syn-recv.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-180718-greg=kroah.com@vger.kernel.org Sat Sep 20 01:18:05 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 20 Sep 2025 01:17:44 +0200
Subject: mptcp: set remote_deny_join_id0 on SYN recv
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250919231743.3957803-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 96939cec994070aa5df852c10fad5fc303a97ea3 upstream.

When a SYN containing the 'C' flag (deny join id0) was received, this
piece of information was not propagated to the path-manager.

Even if this flag is mainly set on the server side, a client can also
tell the server it cannot try to establish new subflows to the client's
initial IP address and port. The server's PM should then record such
info when received, and before sending events about the new connection.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250912-net-mptcp-pm-uspace-deny_join_id0-v1-1-40171884ade8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in subflow.c, because of differences in the context, e.g.
  introduced by commit 3a236aef280e ("mptcp: refactor passive socket
  initialization"), which is not in this version. The same lines --
  using 'mptcp_sk(new_msk)' instead of 'owner' -- can still be added
  approximately at the same place, before calling
  mptcp_pm_new_connection(). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/subflow.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -758,6 +758,9 @@ create_child:
 			 */
 			WRITE_ONCE(mptcp_sk(new_msk)->first, child);
 
+			if (mp_opt.deny_join_id0)
+				WRITE_ONCE(mptcp_sk(new_msk)->pm.remote_deny_join_id0, true);
+
 			/* new mpc subflow takes ownership of the newly
 			 * created mptcp socket
 			 */


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-sockopt-make-sync_socket_options-propagate-sock_keepopen.patch
queue-5.15/mptcp-set-remote_deny_join_id0-on-syn-recv.patch
