Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6151CCEE5;
	Tue, 19 Nov 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021991; cv=none; b=hkP2QCric7PCl88TeEtBjoP1ibdjHZ8DSyh1DskeUN3hvd7YrlheIQSjYXCfNpmYkfVB2d4487njhBFQsbudwpcjTfLtNXd/TqN8K9vbpxPAnXAveT/0JeM5H6RigjRMM7R8P+uBBL0qdTZYAuvKQ+9IF8Wh7DU+BKKyrKY6MC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021991; c=relaxed/simple;
	bh=+A4G+jh25rjbt/tJK3FV/vsOAHCTcdwSqCZhyGjjKoo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=rUgmIIC260lKVUfizeHBudJTxS/rcbanOgb/2i61SVZT3EzJ6PteSTrpzb/ZUDGimp1hpNnPO6MtZSEXBDBHfw2tv0YdAr1A+VAHzP57TqjdHbk7cevKi+LG0Pz0ejRTIjzGSRJ4Cj3SlSdSvlJjQD2BDeTKZQD5Dh7y7MOJaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P+xuIREn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P+xuIREn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A6CC4CECF;
	Tue, 19 Nov 2024 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021991;
	bh=+A4G+jh25rjbt/tJK3FV/vsOAHCTcdwSqCZhyGjjKoo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=P+xuIREnGjCPDaRM3xZScAXVqODFSYT0mDCqGshD6PL7/+QM4c3g74TCn8ou5pUBR
	 Ns3/itR36tYMBf2zdY90a1o7491ElAITiiMV+JhxhD48B8etnA+2kXEQi8xBHI1r6X
	 npHhxoymc27Wb9BJo3Qjh528GfwlPZ5GGGS8vz3c=
Subject: Patch "mptcp: add userspace_pm_lookup_addr_by_id helper" has been added to the 6.1-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Nov 2024 14:12:46 +0100
In-Reply-To: <20241119083547.3234013-12-matttbe@kernel.org>
Message-ID: <2024111946-resend-vending-8670@gregkh>
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

    mptcp: add userspace_pm_lookup_addr_by_id helper

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-93938-greg=kroah.com@vger.kernel.org Tue Nov 19 09:36:45 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 Nov 2024 09:35:51 +0100
Subject: mptcp: add userspace_pm_lookup_addr_by_id helper
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, "David S . Miller" <davem@davemloft.net>
Message-ID: <20241119083547.3234013-12-matttbe@kernel.org>

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 06afe09091ee69dc7ab058b4be9917ae59cc81e5 upstream.

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: f642c5c4d528 ("mptcp: hold pm lock when deleting entry")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_userspace.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -106,22 +106,29 @@ static int mptcp_userspace_pm_delete_loc
 	return -EINVAL;
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	*flags = 0;
 	*ifindex = 0;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -282,7 +289,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -319,13 +326,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-pm-use-_rcu-variant-under-rcu_read_lock.patch
queue-6.1/mptcp-error-out-earlier-on-disconnect.patch
queue-6.1/mptcp-hold-pm-lock-when-deleting-entry.patch
queue-6.1/mptcp-cope-racing-subflow-creation-in-mptcp_rcv_space_adjust.patch
queue-6.1/mptcp-drop-lookup_by_id-in-lookup_addr.patch
queue-6.1/mptcp-add-userspace_pm_lookup_addr_by_id-helper.patch
queue-6.1/mptcp-define-more-local-variables-sk.patch
queue-6.1/mptcp-update-local-address-flags-when-setting-it.patch
