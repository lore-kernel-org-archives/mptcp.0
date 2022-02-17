Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77281FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645134303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgOFHWmmKOGZSAB7ZfDqkTFFOfv1EwuyUDi5VDFQ0hk=;
	b=Xv2IZ9bTU/tvLcfu7rE8phmH2JxwTgbtMA6fH7gAFGRtfBT4Md+wgxGFF+X5h2Ym512rc4
	/DTsaxvVY0PV+6v6DGqtvQqevJ0OZyX/DXxTpOcnXGR0fJlgw6EyW2AWOfIoXvagpBcznC
	zYN9oFVm5h1o3EbXr9vdA9h4Cm2Lu6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-LktLvA2bPB2QQoBRurGRDA-1; Thu, 17 Feb 2022 16:44:53 -0500
X-MC-Unique: LktLvA2bPB2QQoBRurGRDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E13B6814249
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55AF645312
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 1/4] mptcp: more careful RM_ADDR generation
Date: Thu, 17 Feb 2022 22:44:11 +0100
Message-Id: <09b238d91c9f02ef154b5adcfbafc676ab6bc78b.1645134065.git.pabeni@redhat.com>
In-Reply-To: <cover.1645134065.git.pabeni@redhat.com>
References: <cover.1645134065.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The in-kernel MPTCP path manager, when processing the MPTCP_PM_CMD_FLUSH_ADDR
command, generates RM_ADDR events for each known local address. While that
is allowed by the RFC, it makes unpredictable the exact number of RM_ADDR
generated when both ends flush the PM addresses.

This change restricts the RM_ADDR generation to previously explicitly
announced addresses, and adjust the expected results in a bunch of related
self-tests.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c                          | 10 ++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  6 +++---
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 56f5603c10f2..619746611110 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1458,14 +1458,12 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 
 	list_for_each_entry(entry, rm_list, list) {
 		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX &&
-		    slist.nr < MPTCP_RM_IDS_MAX) {
-			alist.ids[alist.nr++] = entry->addr.id;
+		    slist.nr < MPTCP_RM_IDS_MAX)
 			slist.ids[slist.nr++] = entry->addr.id;
-		} else if (remove_anno_list_by_saddr(msk, &entry->addr) &&
-			 alist.nr < MPTCP_RM_IDS_MAX) {
+
+		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
-		}
 	}
 
 	if (alist.nr) {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b48b11714817..6f16337409e3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1577,7 +1577,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
-	chk_rm_nr 2 2
+	chk_rm_nr 1 1 invert
 
 	# subflows flush
 	reset
@@ -1588,7 +1588,7 @@ remove_tests()
 	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows" 3 3 3
-	chk_rm_nr 3 3
+	chk_rm_nr 0 3
 
 	# addresses flush
 	reset
@@ -1884,7 +1884,7 @@ add_addr_ports_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
 	chk_join_nr "flush subflows and signal with port" 3 3 3
 	chk_add_nr 1 1
-	chk_rm_nr 2 2
+	chk_rm_nr 1 1 invert
 
 	# multiple addresses with port
 	reset
-- 
2.34.1

