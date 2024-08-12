Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA28187FF7;
	Mon, 12 Aug 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477874; cv=none; b=sdgIEdrOv/sYRo4mw2mlPF/GiFW+Mg1czfs4gCKrxf3u53AydzlFl1ezY67222aB8CtCGURSRx5LbCvSqBICzEDzi3DLjmZs2mhFvae7cSaRstXHG6wzIcb1E2f8MJ4BEwpZiRGBpbFp2rBQJ7rnRMGLWPPM3rDhlyAEcTlh3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477874; c=relaxed/simple;
	bh=gs2VPlQ9bp1ZY2nBypi0FCcL0YVf1Ut8y/i5qgZIqXs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=T3UYnHm+8Iya9ax6tm3KN1/50YFPlm5cUHDZaMO1jaga1easpn5QVYQSWpDGk42xuRrlGC7nfjr3aQSMJBfmDMPZ55qLzUXEI2JkDSW5gycWwVnZ2nj7S/KjOQj/QVjdTi6oeI6g2UFuTjHhFXTXrYlgLNTWKDf72WfVAc3yj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MiIwblJM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MiIwblJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8BBC32782;
	Mon, 12 Aug 2024 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723477874;
	bh=gs2VPlQ9bp1ZY2nBypi0FCcL0YVf1Ut8y/i5qgZIqXs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=MiIwblJMBV3pPBRWE7sB9xogMYmu2Amr7wNn1w3ReuUw11fzpf4v+TnBEfXzlUw0N
	 fLWHWuDl9QHEMrb8m0hoD5CRFJXZfkTvn2hKxNvkRAzvQuYVA6nfW2ncfkGn2RwX9y
	 1UCHHus5M/Zsop0UDMOTsLi0W2dvidSXPJ8TSuVM=
Subject: Patch "mptcp: pm: reduce indentation blocks" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 17:51:00 +0200
In-Reply-To: <20240812153050.573404-8-matttbe@kernel.org>
Message-ID: <2024081200-disburse-deputy-f520@gregkh>
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

    mptcp: pm: reduce indentation blocks

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-reduce-indentation-blocks.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66751-greg=kroah.com@vger.kernel.org Mon Aug 12 17:32:49 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 12 Aug 2024 17:30:52 +0200
Subject: mptcp: pm: reduce indentation blocks
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240812153050.573404-8-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit c95eb32ced823a00be62202b43966b07b2f20b7f upstream.

That will simplify the following commits.

No functional changes intended.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-3-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -575,16 +575,19 @@ static void mptcp_pm_create_subflow_or_s
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
-				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_nl_addr_send_ack(msk);
-			}
-		}
+		if (!local)
+			goto subflow;
+
+		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+			goto subflow;
+
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
 	}
 
+subflow:
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
 	       msk->pm.subflows < subflows_max) {


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.6/mptcp-pm-don-t-try-to-create-sf-if-alloc-failed.patch
queue-6.6/selftests-mptcp-join-ability-to-invert-add_addr-check.patch
queue-6.6/revert-selftests-mptcp-simult-flows-mark-unbalanced-tests-as-flaky.patch
queue-6.6/mptcp-pm-do-not-ignore-subflow-if-signal-flag-is-also-set.patch
queue-6.6/selftests-mptcp-join-test-both-signal-subflow.patch
queue-6.6/mptcp-pm-reduce-indentation-blocks.patch
