Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366B32ED21;
	Wed,  8 Apr 2026 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654630; cv=none; b=dNPBmVsokRJSpczyYaRJ2hU47dXwe3hFzwgwR+MiSXCQgarjXz5LeMk4JPpIa9Pwlbqo59jaH5Jc6g1ViQyhyX0f/VLwxOspXNsquZ8MHQlStUrPQXcafYgyUymhylaRsO0hiIrxcrCnnBT27Mlrak9KmpLMP8hZpBLSCTMw08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654630; c=relaxed/simple;
	bh=ZrLVu7gtUH8GR2I7Lr+VPmz5KWgHVmJi7vHIzkUWlqc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ie3JcYW/RP5+pUXH5zgM6YdZzxpjVIiwQpV+EP1SEDJHhMWChURh8eQ0xLhq1lIPRkOh5jZZ2+mvXqUVZELfX01BYIB2ACCH4qHAweDeoUsOOAlg4EG546+rY+wKRJhZBPdstk15T2NPdNNI67XItC4gHWhmieJS2SvUgk2pNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b4DoiIhC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b4DoiIhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D44C19421;
	Wed,  8 Apr 2026 13:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775654629;
	bh=ZrLVu7gtUH8GR2I7Lr+VPmz5KWgHVmJi7vHIzkUWlqc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=b4DoiIhCLbc+kWDdE/oijqW5w5mqkXi+jPTcVqRXIzigYwV5zH/mjalc4HMtLcVYl
	 /ethrrtJlQhIEOSGH50N/OQBieL8WzkV/g8cbFUj4zPu5MvW2RyccWUt4pNCTHxh3k
	 xNmOg/b013C9SPAibWZx4Pu4hDM4p6nMen9gypQc=
Subject: Patch "MPTCP: fix lock class name family in pm_nl_create_listen_socket" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,lixiasong1@huawei.com,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:23:10 +0200
In-Reply-To: <20260402173907.3408529-2-matttbe@kernel.org>
Message-ID: <2026040810-anymore-unripe-0c24@gregkh>
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

    MPTCP: fix lock class name family in pm_nl_create_listen_socket

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-lock-class-name-family-in-pm_nl_create_listen_socket.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Thu Apr  2 19:39:16 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu,  2 Apr 2026 19:39:08 +0200
Subject: MPTCP: fix lock class name family in pm_nl_create_listen_socket
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Li Xiasong <lixiasong1@huawei.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260402173907.3408529-2-matttbe@kernel.org>

From: Li Xiasong <lixiasong1@huawei.com>

commit 7ab4a7c5d969642782b8a5b608da0dd02aa9f229 upstream.

In mptcp_pm_nl_create_listen_socket(), use entry->addr.family
instead of sk->sk_family for lock class setup. The 'sk' parameter
is a netlink socket, not the MPTCP subflow socket being created.

Fixes: cee4034a3db1 ("mptcp: fix lockdep false positive in mptcp_pm_nl_create_listen_socket()")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260319112159.3118874-1-lixiasong1@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in pm_kernel.c, because commit 8617e85e04bd ("mptcp: pm:
  split in-kernel PM specific code") is not in this version, and moves
  code from pm_netlink.c to pm_kernel.c. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1184,7 +1184,7 @@ static struct lock_class_key mptcp_keys[
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
+	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct socket *ssock;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-fix-lock-class-name-family-in-pm_nl_create_listen_socket.patch
