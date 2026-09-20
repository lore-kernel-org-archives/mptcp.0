Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0666F3DDB13;
	Sun, 20 Sep 2026 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890015; cv=none; b=kLZrdxKRbOSJM8rpMRO6KmXdV1QW3GVl3Zqxoibm2aQFAso9lgaBysY3+p6Vgb8SygflPC0JGjRkCDBMiUR2yPpxjb/39os/VO+ZAniY2XcGmr+YASsxb4MZUNEtTi8ks3e/zqiqAm07aPuf/pljTI9Q0kbElXx5L0Mv9oVhq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890015; c=relaxed/simple;
	bh=4XL5sxJjp01BsPK+JB0cl3hHdcjmhFHtyl0n9e5UGUk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=eA2y+aQwB5gFbPJ3qKwYdp6Itv83eWfmh2Df/50KaSIm7/tIbwrCBRcn7dTIqFdaI/6tAIeGXK5mX8RScNfj4CgX3udCc9QRpQ6kEPDwiQ5THX9k3D6b2lI69N822iPu33XkNuEVu+E3B5Q0se8EqS+UfcHQ+cxzQC97kT3X/t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2IA9XMZp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2IA9XMZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EF31F000FF;
	Sun, 20 Sep 2026 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890013;
	bh=RzYHYzrLRrurIivbISpx/pigWflOeVdn71tVYpCbZLs=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=2IA9XMZpT1hmly15MB0exWa+pQwIJfvJxAhjmzvLgaI0NBi9ucjy9Nze+MArpjHAZ
	 4eSz6/LBKFro8WMaKuk9UhggXBL/ngGlFW+ZwLcCs8uhOtL8HyuQVzRYO2xxBm3CKR
	 oWzD3ljwwlltNoq8NNfaI2diCE0z5BgjkTxV67ps=
Subject: Patch "mptcp: fix bad accounting in __mptcp_subflow_push_pending()" has been added to the 6.12-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:37 +0200
In-Reply-To: <20260919195642.1977885-12-matttbe@kernel.org>
Message-ID: <2026092037-headscarf-mandatory-25fa@gregkh>
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

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338602-greg=kroah.com@vger.kernel.org Sat Sep 19 21:57:31 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 21:56:48 +0200
Subject: mptcp: fix bad accounting in __mptcp_subflow_push_pending()
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919195642.1977885-12-matttbe@kernel.org>

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
@@ -1757,7 +1757,8 @@ static void __mptcp_subflow_push_pending
 			ret = __subflow_push_pending(sk, ssk, &info);
 			if (ret <= 0)
 				keep_pushing = false;
-			copied += ret;
+			else
+				copied += ret;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.12/mptcp-annotate-data-races-around-subflow-fully_established.patch
queue-6.12/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-6.12/mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
queue-6.12/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-6.12/mptcp-remove-unneeded-read_once-annotation.patch
queue-6.12/mptcp-close-race-between-scheduler-and-state-change.patch
queue-6.12/tcp-use-gfp_atomic-in-tcp_send_active_reset.patch
queue-6.12/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-6.12/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-6.12/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
