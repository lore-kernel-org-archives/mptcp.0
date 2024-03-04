Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651015AE0;
	Mon,  4 Mar 2024 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540780; cv=none; b=A2CwUzn3pNw2OabdogoiF/rPSx1Vzg1OxnqA7P0am6b6rKrcW6c6ChznClS1BKhfYnlHuUx/nk9c6cxOLsc4JBSQmW0JtW/tfj9kUnHC3OlgGVgYWsakeFZvz6epusmRAIbazOuUnXk3m9VpWsaQgQ1HsNbSaOimikc3LeD2anU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540780; c=relaxed/simple;
	bh=LziQQknb1C4Zny4CRIuROaIvq0eP4/7rV8DCzh2hd54=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Cx+QJE5CWh+Zlz+CDMGyrxks3WFaBtvmAJlr2Tb1xDFvMDaSB2/AjcQI/SgDh6/sOFJc70rFLaz/yzH7NjXeZCnOYL5ipmiM4FuL8KT0Beu6wZbWG2nd+bz3zLBBQRGVPohNwRoV+SwrzisC0dQjUJSWWBh7P7352AG7lCRaqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WuveAS4v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WuveAS4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E6CC433C7;
	Mon,  4 Mar 2024 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709540779;
	bh=LziQQknb1C4Zny4CRIuROaIvq0eP4/7rV8DCzh2hd54=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=WuveAS4vUE1aXiKwWFXMKaMw8pRviWBHqvnYYdrG08ouwJGfjOHK9pTx6xzDHmG+t
	 MKi1+LV52cBBHvt3m/7gNigbiLUzA/70uHgUGlA/6SqP6cY6+LQLFbPvDW3s0YxT7z
	 19Ib8jQjjBp4adF4dtHc/porVKDVwNu9Dexmp5TE=
Subject: Patch "mptcp: clean up harmless false expressions" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matthieu.baerts@tessares.net,matttbe@kernel.org,mptcp@lists.linux.dev,sakiwit@gmail.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 09:26:08 +0100
In-Reply-To: <20240228173714.262012-3-matttbe@kernel.org>
Message-ID: <2024030408-easel-swimsuit-0ebd@gregkh>
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

    mptcp: clean up harmless false expressions

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-clean-up-harmless-false-expressions.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-25407-greg=kroah.com@vger.kernel.org Wed Feb 28 18:37:44 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Feb 2024 18:37:15 +0100
Subject: mptcp: clean up harmless false expressions
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Jean Sacren <sakiwit@gmail.com>, Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20240228173714.262012-3-matttbe@kernel.org>

From: Jean Sacren <sakiwit@gmail.com>

commit 59060a47ca50bbdb1d863b73667a1065873ecc06 upstream.

entry->addr.id is u8 with a range from 0 to 255 and MAX_ADDR_ID is 255.
We should drop both false expressions of (entry->addr.id > MAX_ADDR_ID).

We should also remove the obsolete parentheses in the first if branch.

Use U8_MAX for MAX_ADDR_ID and add a comment to show the link to
mptcp_addr_info.id as suggested by Mr. Matthieu Baerts.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jean Sacren <sakiwit@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -38,7 +38,8 @@ struct mptcp_pm_add_entry {
 	u8			retrans_times;
 };
 
-#define MAX_ADDR_ID		255
+/* max value of mptcp_addr_info.id */
+#define MAX_ADDR_ID		U8_MAX
 #define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
 
 struct pm_nl_pernet {
@@ -854,14 +855,13 @@ find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MAX_ADDR_ID + 1,
 						    pernet->next_id);
-		if ((!entry->addr.id || entry->addr.id > MAX_ADDR_ID) &&
-		    pernet->next_id != 1) {
+		if (!entry->addr.id && pernet->next_id != 1) {
 			pernet->next_id = 1;
 			goto find_next;
 		}
 	}
 
-	if (!entry->addr.id || entry->addr.id > MAX_ADDR_ID)
+	if (!entry->addr.id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter.patch
queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter-in-v6.patch
queue-5.15/mptcp-add-needs_id-for-netlink-appending-addr.patch
queue-5.15/mptcp-rename-timer-related-helper-to-less-confusing-names.patch
queue-5.15/mptcp-process-pending-subflow-error-on-close.patch
queue-5.15/mptcp-clean-up-harmless-false-expressions.patch
queue-5.15/mptcp-move-__mptcp_error_report-in-protocol.c.patch
