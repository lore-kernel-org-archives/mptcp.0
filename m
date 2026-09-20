Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993D32B13E;
	Sun, 20 Sep 2026 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889978; cv=none; b=DsXikJ08dzY3hb3UsBUm8b7OCyaxYW351Wj8sB0Ddo7zb7K2m5Dnu8S3QJrwne28PL+/BDfleMbuCUriIN05mcODu9lhsEKzbi16FgMgt35SMBEnzyGKPC6lJcGtspIHjGu4AQ64bRmuI0na2UuR2+UE28rgAJOeGARwFCz7QQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889978; c=relaxed/simple;
	bh=jnUGwK252LU+iMfqKmaBN36iJyTJKUKrkKGavozQOxI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=PiqJb8wol0wFTGWbLM2h1CbckMxv6XcafhpzF0eRpgvtVArgIXPt9S/oNQhoXYRQYNEQ6QGlPs4wyVU/vwN0LNP/anLZVuOjHYn1gn1ccN1GQo8lqJq/T6yqGqCvZSEGp3GaBwbtFNGigUL9FP745Hbasa/dUf7CXJv1LEZfkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i6UY4ilF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i6UY4ilF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D6D1F000FF;
	Sun, 20 Sep 2026 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789889976;
	bh=t/fKnivQnFRC2CoDjtiVXwqAEeaQIsCbb8HLUxOwIzA=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=i6UY4ilFmXhbBvnB8ztdOdMC9L83uNuma9XVRvmz85tkMfNrAOgTulG/bnXHo0m3u
	 9P5OJZ9N69GCexDiv9eFU3in0Q9kDMltgmDAyWyWGaxArXy/hl9EwV9ItRtA0HlTMA
	 c71NEcOtVWBNdd5ea+I6Uz7GHqqeE15MpyeHljUo=
Subject: Patch "mptcp: hold mptcp socket before calling tcp_done" has been added to the 5.10-stable tree
To: fw@strlen.de,gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matthieu.baerts@tessares.net,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:31 +0200
In-Reply-To: <20260919204002.2106015-6-matttbe@kernel.org>
Message-ID: <2026092031-dreary-uprising-7d63@gregkh>
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

    mptcp: hold mptcp socket before calling tcp_done

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-hold-mptcp-socket-before-calling-tcp_done.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338615-greg=kroah.com@vger.kernel.org Sat Sep 19 22:40:23 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 22:40:04 +0200
Subject: mptcp: hold mptcp socket before calling tcp_done
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Florian Westphal <fw@strlen.de>, sashal@kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20260919204002.2106015-6-matttbe@kernel.org>

From: Florian Westphal <fw@strlen.de>

commit ab82e996a1fa1b9ae514fa357d9ce8df62321157 upstream.

When processing options from tcp reset path its possible that
tcp_done(ssk) drops the last reference on the mptcp socket which
results in use-after-free.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
[ Conflicts in subflow.c, because commit 3ba14528684f ("mptcp: avoid
  setting TCP_CLOSE state twice") has already been backported and also
  had the same conflict: this commit here should have been backported
  first. Fixed now! ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/subflow.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -279,11 +279,16 @@ void mptcp_subflow_reset(struct sock *ss
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 
+	/* must hold: tcp_done() could drop last reference on parent */
+	sock_hold(sk);
+
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
 	    schedule_work(&mptcp_sk(sk)->work))
-		sock_hold(sk);
+		return; /* worker will put sk for us */
+
+	sock_put(sk);
 }
 
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/mptcp-hold-mptcp-socket-before-calling-tcp_done.patch
queue-5.10/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-5.10/mptcp-close-race-between-scheduler-and-state-change.patch
queue-5.10/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
