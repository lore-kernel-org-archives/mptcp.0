Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DA3845AB;
	Thu, 23 Apr 2026 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943775; cv=none; b=ayOdrPVHGDywn7kj8kTEVnFlSPhSvTwr0IHPWuNmo9270/7pT9dWy++secy1V3LOC/q3VL3zGjVMXkiSZpjh1SmHAf0Gihsud9qFNDAOteDIApLET81KgBWkGOWoWOSLELKnrRqXChHKf2/cWbZQ3Ov7YlTvUcxcb2+ewpwjFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943775; c=relaxed/simple;
	bh=zeTyH3uEO7A/6yWlCdBx0+oDvE4382EN62vO+gWdbgA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=MtOGS2SxP9sQKQ84gwzM/bFdziWo95I72dpb5kV4NLn2j6F1jD9czCg9D/fk+Qhzp87UEwX/fm/G+tjjKI6nfBnNJX7h7QprOaO+2ZwvXUqOd7NSyjdEjPKH5GjZUUnIYk8B+T8Z3isEgu6OJQhYbJrPMHknz0xZTGZ4M4UU1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xxwzxtrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xxwzxtrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E04C2BCAF;
	Thu, 23 Apr 2026 11:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776943775;
	bh=zeTyH3uEO7A/6yWlCdBx0+oDvE4382EN62vO+gWdbgA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=xxwzxtrqIQJx4aRQDgfiWdCFNL9sUYbd51HYWgYEBvu9n4Kdn+nipKhVESpxScMru
	 F2Ihm60I1qOw7xpuUojQ27O3mKYNwU4PJWbydxW8ZQ89g9TZocQKgXXl57o0PMIYRF
	 4/+7e1DLnyy0PmUldkYoZ5NUqu0F9zlNTTA498SE=
Subject: Patch "MPTCP: fix lock class name family in pm_nl_create_listen_socket" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,lixiasong1@huawei.com,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Apr 2026 13:29:14 +0200
In-Reply-To: <20260402174200.3474039-2-matttbe@kernel.org>
Message-ID: <2026042314-fantasize-stiffness-5819@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-lock-class-name-family-in-pm_nl_create_listen_socket.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-233086-greg=kroah.com@vger.kernel.org Thu Apr  2 19:42:24 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu,  2 Apr 2026 19:42:01 +0200
Subject: MPTCP: fix lock class name family in pm_nl_create_listen_socket
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Li Xiasong <lixiasong1@huawei.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260402174200.3474039-2-matttbe@kernel.org>

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
@@ -1041,7 +1041,7 @@ static struct lock_class_key mptcp_keys[
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
+	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct socket *ssock;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-fix-lock-class-name-family-in-pm_nl_create_listen_socket.patch
