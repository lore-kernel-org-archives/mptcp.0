Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CB3B7A8;
	Mon, 12 Aug 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466341; cv=none; b=C+8bXcBAQL1gL+nVZi9uW204shz6UWSAIiClJjBEZPh3jjYKfeFeTAkCoDzqBasVzNcyxhlpZKvdHuks9g8/6SQuyUNkxNNWyi4F88At3LU/1rpLm5MlBzKgRekUVBSnxok6f5StEwaQQyddp4JnYOX1SPgLd9s+8N2teKulwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466341; c=relaxed/simple;
	bh=zR18XRwHe81Q5pyuoJOPxZtXPZtEasJLQFIMcFBxU4o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=UgMojeD8YWj/05NbG0MoMXnvg+qUEHwhi+HVe+/1tS3ByDBDQmH5bbZxs2W293cF8SGsAGyae8fJA8NzlsVDOAqS6SmWZKN80RFw7yL1jr3xpAhHf1fQE3BrsTDA4/Q7mMPIsPFymJib/fFFgV9GKxcg8eUGKeojHNdqxPHDk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JIk9su0R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JIk9su0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B48C32782;
	Mon, 12 Aug 2024 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466341;
	bh=zR18XRwHe81Q5pyuoJOPxZtXPZtEasJLQFIMcFBxU4o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=JIk9su0Ry5I62o9p7EnBYoHnBgHa4NJigPRbZz0OdHy8NBr2b9ZaG+FFVd/M8ofYi
	 qAvEMpVVMBWNUI0Z/kJfb0h1JFYUs5tZK0jm3kOCoYX6hHGBtV1dzNivErsjPtwMVS
	 bSAipS7lWN+QDm+wf09FWaq0nygr9DS7NDHXfYgg=
Subject: Patch "mptcp: pm: only set request_bkup flag when sending MP_PRIO" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:38:29 +0200
In-Reply-To: <20240809090845.2700989-2-matttbe@kernel.org>
Message-ID: <2024081228-gutter-unengaged-de8e@gregkh>
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

    mptcp: pm: only set request_bkup flag when sending MP_PRIO

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-only-set-request_bkup-flag-when-sending-mp_prio.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66132-greg=kroah.com@vger.kernel.org Fri Aug  9 11:09:00 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 11:08:46 +0200
Subject: mptcp: pm: only set request_bkup flag when sending MP_PRIO
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240809090845.2700989-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 4258b94831bb7ff28ab80e3c8d94db37db930728 upstream.

The 'backup' flag from mptcp_subflow_context structure is supposed to be
set only when the other peer flagged a subflow as backup, not the
opposite.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm_netlink.c, because the commit f5360e9b314c ("mptcp:
  introduce and use mptcp_pm_send_ack()") is not in this version. This
  code is in mptcp_pm_nl_mp_prio_send_ack() instead of in a dedicated
  helper. The same modification can be applied there. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -699,7 +699,6 @@ int mptcp_pm_nl_mp_prio_send_ack(struct
 
 		if (subflow->backup != bkup)
 			msk->last_snd = NULL;
-		subflow->backup = bkup;
 		subflow->send_mp_prio = 1;
 		subflow->request_bkup = bkup;
 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.15/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.15/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.15/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.15/selftests-mptcp-join-validate-backup-in-mpj.patch
queue-5.15/mptcp-export-local_address.patch
queue-5.15/mptcp-pm-only-set-request_bkup-flag-when-sending-mp_prio.patch
queue-5.15/mptcp-fix-bad-rcvpruned-mib-accounting.patch
