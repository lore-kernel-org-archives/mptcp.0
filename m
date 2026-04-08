Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A93815C8;
	Wed,  8 Apr 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654665; cv=none; b=LGWHxGaR1mAFarhFp6TtbP4RyzFM1GSQZlnzRKoY/twDyo/uihmOLX64paM1wCnRKYb9/9FtOcYKHRTYP0Leq0ocutbEYa5Y/f42oFe+kV4gkfxPTqcgudDE3+gqEdIPHSfd3jYLzGciMd8l4QWgtzK5ljK/ydwnOHxmgGa+OLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654665; c=relaxed/simple;
	bh=ANo5b4CuOgfoTfW3Jfl4MDXKl7v/Mgc9V1ETirvRDE0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=cnrl9PyTZFB0shFXsVGqWro102EE3ifyYlOswBIfmg3mCk0DTwfZZ8M/2LDSqnm5PmfM27fr/VdL23x/9A/L4hMa3K2Cp3VgbHlpL3lrTuy2F1hQ+CBMRPKde3pv2/i2TaQsyJYWSUaGVvMp+1LGJKMzRfqy7s5Hmv9trUnCcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ujouHo/A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ujouHo/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40EFC19421;
	Wed,  8 Apr 2026 13:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775654665;
	bh=ANo5b4CuOgfoTfW3Jfl4MDXKl7v/Mgc9V1ETirvRDE0=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=ujouHo/A5bwkPdqGNBXL2oOYuUFaF2rp0ZI6l4aQgYK6m4UNLa5pnX+AUA1BXlmm6
	 vvE6UhpNk3XSrTS5JgScejpTmolEi6MDe27MwlZlaySIkOtTReNBLQyLoJCPOwjJ/5
	 E0J60PrXh0CXXYm8+lwHGKgXOQPddLZRDMuMDcwk=
Subject: Patch "MPTCP: fix lock class name family in pm_nl_create_listen_socket" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,lixiasong1@huawei.com,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:23:20 +0200
In-Reply-To: <20260402173616.3331064-2-matttbe@kernel.org>
Message-ID: <2026040820-specks-smoked-155e@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-lock-class-name-family-in-pm_nl_create_listen_socket.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-233082-greg=kroah.com@vger.kernel.org Thu Apr  2 19:39:57 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu,  2 Apr 2026 19:36:17 +0200
Subject: MPTCP: fix lock class name family in pm_nl_create_listen_socket
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Li Xiasong <lixiasong1@huawei.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260402173616.3331064-2-matttbe@kernel.org>

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
@@ -1189,7 +1189,7 @@ static struct lock_class_key mptcp_keys[
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
+	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-fix-lock-class-name-family-in-pm_nl_create_listen_socket.patch
