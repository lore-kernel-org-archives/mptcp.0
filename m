Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADA3E025E;
	Sun, 20 Sep 2026 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890003; cv=none; b=KGDXKfRnuj7JxbG+hIhdVduAg+EWPz2y2C3vqAEMSE6NPKYjhAfnbhYlDVSADeqCDqzPTMqZD7HN6MJHtnQQ7B0l2WUPIMQZNucMEhELjd98lg3QE5Rju9jcU7tASPYaKEMLCf7k3dIXhlhr0MN3D0RogOyEYQSeEzCqg+gdRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890003; c=relaxed/simple;
	bh=SzUzCtNpjrZCJlpnStngyxUyPSdnA5IZyP39pyNJ/n8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=WN2Da6xQawgLlUsj0kqHHBQ5jO5Rmn7TWeq+F615LzaMecKs8XkbjdBEK0HkiNE6QtXDBGZ/W3QtQNa7bcsfv7FoPSvT7S6+9oj68WW+hz5oZn0LxDRTL3C/MDSfQ7dAPnk9k9sSrVUWkZTzn+qWxp3jHTNt1R0cag2C8TyFaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ThuZKV1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ThuZKV1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305681F000FF;
	Sun, 20 Sep 2026 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890001;
	bh=tGQiMFxkNJ29ZC7X7MoQtfZgAJxIZjd56ys4GbAv2Yg=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=ThuZKV1Jr1PqyrQqiwIBGb0zFbqnB2jjhFqgKop0R3W0jNwWDbXzicwBE2N2fdRpl
	 fvfTqtOiFqY0GRJ8Z+BjaPLp5G16IE7U/TXivwEcqQ9h6vmv7wRH2rBDiyzKCN7Zbr
	 0a1q/Ca83vkY9HRKexjeuf4xkRo3itbrmAAXwi/8=
Subject: Patch "mptcp: fix bad accounting in __mptcp_subflow_push_pending()" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:36 +0200
In-Reply-To: <20260919200554.2005069-8-matttbe@kernel.org>
Message-ID: <2026092036-dirtiness-resolved-d4d3@gregkh>
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

    mptcp: fix bad accounting in __mptcp_subflow_push_pending()

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338606-greg=kroah.com@vger.kernel.org Sat Sep 19 22:06:26 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 22:05:58 +0200
Subject: mptcp: fix bad accounting in __mptcp_subflow_push_pending()
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919200554.2005069-8-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit f3ef03357396d4b147d8e76c75fb612c2f264ffc upstream.

If __subflow_push_pending() errors out we should avoid updating the
copied byte counters, to avoid mismatch push call later on.

Fixes: 0fa1b3783a17 ("mptcp: use get_send wrapper")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-3-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1748,7 +1748,8 @@ static void __mptcp_subflow_push_pending
 			ret = __subflow_push_pending(sk, ssk, &info);
 			if (ret <= 0)
 				keep_pushing = false;
-			copied += ret;
+			else
+				copied += ret;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-6.6/mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
queue-6.6/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-6.6/mptcp-close-race-between-scheduler-and-state-change.patch
queue-6.6/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-6.6/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-6.6/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
