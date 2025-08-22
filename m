Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734742FFDE0;
	Fri, 22 Aug 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870305; cv=none; b=aQSr3YNZdM+nkm3W9crBaIFl3CI9vSt+6229fw3sgniKBCXNK/g/1fg17yoBouLmevFvCzunkuVs2/IVbAOu+po6xF/th4EtCisehwkpQF4TUr6FNPiwfnkf2TvP0PzFLDB3fOmsr3coJJSitwb631F4eCufKEywZS/8PWVQAyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870305; c=relaxed/simple;
	bh=con0j6zNof4weexmcwolfKnH7du7nSVlLRiO6/Fp4/o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=rzMAnZLbhe5FgyMwQfuQCsNLSDeh/f+206vWmqmAtVK15tBr9VVshDzut9sbd78AyXpJuRLcxTqV48YShLJOq83h+sUJ3a6kuY6gE4Sh2Sp+tc4gwPDQHeGS6kF4zjVZs/j20h7c/dRr2wvz2813kMVOkgFyI2FvT57/NzDrLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SCFTDBBp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SCFTDBBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B953C4CEED;
	Fri, 22 Aug 2025 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870305;
	bh=con0j6zNof4weexmcwolfKnH7du7nSVlLRiO6/Fp4/o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=SCFTDBBp4eQm+FXZpDZcTMmOUh9TaVbq1ZKX43jwKkp+glToj2LN0YaE647kdkSD0
	 PJrDVPFW9JnyLMhN/rSrJq+6eb3bQRGDblwbOVLQs4LqHkNhR/1wZ0uxM6rLipWQ4v
	 k250mu/xhdzng18dTD/gG2F4Nq6/AdumG0BZG6Xk=
Subject: Patch "mptcp: introduce MAPPING_BAD_CSUM" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:44:34 +0200
In-Reply-To: <20250731112353.2638719-11-matttbe@kernel.org>
Message-ID: <2025082234-among-computer-ca4f@gregkh>
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

    mptcp: introduce MAPPING_BAD_CSUM

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-introduce-mapping_bad_csum.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-165648-greg=kroah.com@vger.kernel.org Thu Jul 31 13:24:25 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 31 Jul 2025 13:23:57 +0200
Subject: mptcp: introduce MAPPING_BAD_CSUM
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Mat Martineau <mathew.j.martineau@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20250731112353.2638719-11-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 31bf11de146c3f8892093ff39f8f9b3069d6a852 upstream.

This allow moving a couple of conditional out of the fast path,
making the code more easy to follow and will simplify the next
patch.

Fixes: ae66fb2ba6c3 ("mptcp: Do TCP fallback on early DSS checksum failure")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in subflow.c, because commit 0348c690ed37 ("mptcp: add the
  fallback check") is not in this version. This commit is linked to a
  new feature, changing the context around. The new condition can still
  be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/subflow.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -848,7 +848,8 @@ enum mapping_status {
 	MAPPING_INVALID,
 	MAPPING_EMPTY,
 	MAPPING_DATA_FIN,
-	MAPPING_DUMMY
+	MAPPING_DUMMY,
+	MAPPING_BAD_CSUM
 };
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
@@ -963,9 +964,7 @@ static enum mapping_status validate_data
 				 subflow->map_data_csum);
 	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
-		if (subflow->mp_join || subflow->valid_csum_seen)
-			subflow->send_mp_fail = 1;
-		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
+		return MAPPING_BAD_CSUM;
 	}
 
 	subflow->valid_csum_seen = 1;
@@ -1188,10 +1187,8 @@ static bool subflow_check_data_avail(str
 
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
-		if (unlikely(status == MAPPING_INVALID))
-			goto fallback;
-
-		if (unlikely(status == MAPPING_DUMMY))
+		if (unlikely(status == MAPPING_INVALID || status == MAPPING_DUMMY ||
+			     status == MAPPING_BAD_CSUM))
 			goto fallback;
 
 		if (status != MAPPING_OK)
@@ -1232,7 +1229,10 @@ no_data:
 
 fallback:
 	/* RFC 8684 section 3.7. */
-	if (subflow->send_mp_fail) {
+	if (status == MAPPING_BAD_CSUM &&
+	    (subflow->mp_join || subflow->valid_csum_seen)) {
+		subflow->send_mp_fail = 1;
+
 		if (mptcp_has_another_subflow(ssk) ||
 		    !READ_ONCE(msk->allow_infinite_fallback)) {
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-drop-unused-sk-in-mptcp_push_release.patch
queue-5.15/selftests-mptcp-connect-also-cover-alt-modes.patch
queue-5.15/mptcp-drop-skb-if-mptcp-skb-extension-allocation-fails.patch
queue-5.15/selftests-mptcp-connect-also-cover-checksum.patch
queue-5.15/selftests-mptcp-make-sendfile-selftest-work.patch
queue-5.15/selftests-mptcp-initialize-variables-to-quiet-gcc-12-warnings.patch
queue-5.15/mptcp-pm-kernel-flush-do-not-reset-add_addr-limit.patch
queue-5.15/mptcp-do-not-queue-data-on-closed-subflows.patch
queue-5.15/selftests-mptcp-add-missing-join-check.patch
queue-5.15/mptcp-fix-error-mibs-accounting.patch
queue-5.15/mptcp-introduce-mapping_bad_csum.patch
