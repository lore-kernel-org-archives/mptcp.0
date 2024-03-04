Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533914A8C;
	Mon,  4 Mar 2024 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540772; cv=none; b=WHMUAAB67Iz6djowFJyClJBqCZQgOwVFOjkpwgUdQ5P1pZOGQBKZyl6oRgie99uurn7w67M1O/UdELUfWMX9vRmWwF2zvxDr/DmPnkeFoH0qVgUDBcaGnUmnjYJ/8IYoUfNT1KlLMSPjQGhrcK7rWzQ7G77TNLjwCU4Q+MGyXxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540772; c=relaxed/simple;
	bh=+GVTbKcpz03zz9xVdxIhWpfZZQT9UwDiPgkWtnid4Pc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=NwzfIrjBz5AzipR2w24gh58QB4jFzMmARFBjCQlQhwSVgZGqUcZ4zgj50CvCZo+GaQ/iqj1LJKyB5TevHO7q7sIn6Dveall+ZZcqGHpszKTdufsi7OZ5abRUFwU5lWa0u139Hj1QRvtLZkIzm4YXUwPgjJVLbswz+A5bbrXMp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ub0nd+dC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ub0nd+dC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1654BC433C7;
	Mon,  4 Mar 2024 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709540771;
	bh=+GVTbKcpz03zz9xVdxIhWpfZZQT9UwDiPgkWtnid4Pc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=Ub0nd+dCdyXU2YjupnyCN6AdzX+sRoY1OjIIQuNKmqoKvCOw3v9+IkLTZRVxQqZqq
	 2ZRUBItuDqF1n4xVCYNsIN4W41SrVx1Xk7qDkfDNLTaD6i03IvrmgFjNKHxVwkbtef
	 fGXyGkeQNAPC3OFRNFTUIrzekuQ/EARcBcToZFXE=
Subject: Patch "mptcp: add needs_id for netlink appending addr" has been added to the 5.15-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,tanggeliang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 09:26:08 +0100
In-Reply-To: <20240228173714.262012-4-matttbe@kernel.org>
Message-ID: <2024030408-paralegal-gimmick-10ef@gregkh>
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

    mptcp: add needs_id for netlink appending addr

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-add-needs_id-for-netlink-appending-addr.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-25408-greg=kroah.com@vger.kernel.org Wed Feb 28 18:38:00 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Feb 2024 18:37:16 +0100
Subject: mptcp: add needs_id for netlink appending addr
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <tanggeliang@kylinos.cn>, Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, "David S . Miller" <davem@davemloft.net>
Message-ID: <20240228173714.262012-4-matttbe@kernel.org>

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 584f3894262634596532cf43a5e782e34a0ce374 upstream.

Just the same as userspace PM, a new parameter needs_id is added for
in-kernel PM mptcp_pm_nl_append_new_local_addr() too.

Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
ID is set from PM or not.

In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
needs_it.

Fixes: efd5a4c04e18 ("mptcp: add the address ID assignment bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -823,7 +823,8 @@ static bool address_use_port(struct mptc
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool needs_id)
 {
 	struct mptcp_pm_addr_entry *cur;
 	unsigned int addr_max;
@@ -850,7 +851,7 @@ static int mptcp_pm_nl_append_new_local_
 			goto out;
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && needs_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MAX_ADDR_ID + 1,
@@ -861,7 +862,7 @@ find_next:
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && needs_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1001,7 +1002,7 @@ int mptcp_pm_nl_get_local_id(struct mptc
 	entry->ifindex = 0;
 	entry->flags = 0;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1202,6 +1203,18 @@ next:
 	return 0;
 }
 
+static bool mptcp_pm_has_addr_attr_id(const struct nlattr *attr,
+				      struct genl_info *info)
+{
+	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
+
+	if (!nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
+					 mptcp_pm_addr_policy, info->extack) &&
+	    tb[MPTCP_PM_ADDR_ATTR_ID])
+		return true;
+	return false;
+}
+
 static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -1228,7 +1241,8 @@ static int mptcp_nl_cmd_add_addr(struct
 			return ret;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
+						!mptcp_pm_has_addr_attr_id(attr, info));
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
 		if (entry->lsk)


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter.patch
queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter-in-v6.patch
queue-5.15/mptcp-add-needs_id-for-netlink-appending-addr.patch
queue-5.15/mptcp-rename-timer-related-helper-to-less-confusing-names.patch
queue-5.15/mptcp-process-pending-subflow-error-on-close.patch
queue-5.15/mptcp-clean-up-harmless-false-expressions.patch
queue-5.15/mptcp-move-__mptcp_error_report-in-protocol.c.patch
