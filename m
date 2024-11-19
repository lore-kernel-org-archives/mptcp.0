Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D61CCEE5;
	Tue, 19 Nov 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021992; cv=none; b=YykaEDcdLuisFtZmYSle6ek3M1VAeS7dxkq07arvAgOfypcLkAFuQooMn2SbJPBQnBX3HJtKgalWA8lV2gYt4u60FLcmHBksbOFBjistdguFo/AyuZPoR/4kpi2Ok1znwMHemcXBuJcz4JSFiymrs/E3GL6AX/HZN4ZQhX75XFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021992; c=relaxed/simple;
	bh=W3qMn1OOVOXsCWy/tu3buRGsYLzRNzkzpDd+47QSwJ0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=XF4DNcwZRI8RtJwj6BuEas3uMsF5ZXYGZF6jETiqxR06SvjUHr1YplM5X4X0rdnK/JCcvW4yluGLKjzKPmtE4lr4wLxik6PBHJQCQi/jsoaB5SvZ1Xq0ldXfCULjLVr0rV0TBLsU/CnDo9qKj91NahXPQMORw5Ds7YnTRI8kZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WvspOBM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WvspOBM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D7AC4CECF;
	Tue, 19 Nov 2024 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021992;
	bh=W3qMn1OOVOXsCWy/tu3buRGsYLzRNzkzpDd+47QSwJ0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=WvspOBM4oJUjkbwgQDO90vwVh6ymRrw+WqIofRP2fhObFu5hEjz3LTYC0OfUS3wHq
	 Yx+xXLBeneTtCQoLTrEzhbSfOjj31V+9JfkvIXyWT9L1n3JdXpQwtsUEXf2zUo8+5W
	 M1kJGgOAw58S4Br6tP/gHl9jRIwHy9LXpF6Qoy5E=
Subject: Patch "mptcp: cope racing subflow creation in mptcp_rcv_space_adjust" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Nov 2024 14:12:46 +0100
In-Reply-To: <20241119083547.3234013-10-matttbe@kernel.org>
Message-ID: <2024111946-length-tactful-0f53@gregkh>
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

    mptcp: cope racing subflow creation in mptcp_rcv_space_adjust

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-cope-racing-subflow-creation-in-mptcp_rcv_space_adjust.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-93936-greg=kroah.com@vger.kernel.org Tue Nov 19 09:36:20 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 Nov 2024 09:35:49 +0100
Subject: mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241119083547.3234013-10-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit ce7356ae35943cc6494cc692e62d51a734062b7d upstream.

Additional active subflows - i.e. created by the in kernel path
manager - are included into the subflow list before starting the
3whs.

A racing recvmsg() spooling data received on an already established
subflow would unconditionally call tcp_cleanup_rbuf() on all the
current subflows, potentially hitting a divide by zero error on
the newly created ones.

Explicitly check that the subflow is in a suitable state before
invoking tcp_cleanup_rbuf().

Fixes: c76c6956566f ("mptcp: call tcp_cleanup_rbuf on subflows")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/02374660836e1b52afc91966b7535c8c5f7bafb0.1731060874.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in protocol.c, because commit f410cbea9f3d ("tcp: annotate
  data-races around tp->window_clamp") has not been backported to this
  version. The conflict is easy to resolve, because only the context is
  different, but not the line to modify. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2057,7 +2057,8 @@ static void mptcp_rcv_space_adjust(struc
 				slow = lock_sock_fast(ssk);
 				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
 				tcp_sk(ssk)->window_clamp = window_clamp;
-				tcp_cleanup_rbuf(ssk, 1);
+				if (tcp_can_send_ack(ssk))
+					tcp_cleanup_rbuf(ssk, 1);
 				unlock_sock_fast(ssk, slow);
 			}
 		}


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
queue-6.1/mptcp-error-out-earlier-on-disconnect.patch
queue-6.1/mptcp-hold-pm-lock-when-deleting-entry.patch
queue-6.1/mptcp-cope-racing-subflow-creation-in-mptcp_rcv_space_adjust.patch
queue-6.1/mptcp-drop-lookup_by_id-in-lookup_addr.patch
queue-6.1/mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
queue-6.1/mptcp-define-more-local-variables-sk.patch
queue-6.1/mptcp-update-local-address-flags-when-setting-it.patch
