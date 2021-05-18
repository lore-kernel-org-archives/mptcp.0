Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAD71
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621359387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qqZrXLSCYNX7OIWbKpI0icWRXgibj1RA+WdDEgAI9N4=;
	b=gVbjtD/d+wqdgJkWqyF/U5Yt0DZLlEcmY3FieQ2zK2o9moMWvkrpFzyFZI8rAYASU+o3u4
	FpjV9NpTgDW5OfC2bFrbHcHnTcL50iWeeCCLknXDNAkV+x96r3eCBLn6o6GHPHYv+3pxA/
	65pu2kmrKmuyIXPjNxmuQydmnyh8DiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-VLQXNF1-NE-03JkVK8dHkg-1; Tue, 18 May 2021 13:36:24 -0400
X-MC-Unique: VLQXNF1-NE-03JkVK8dHkg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 966A68049D8;
	Tue, 18 May 2021 17:36:23 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.40.195.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99CDB3CC9;
	Tue, 18 May 2021 17:36:22 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net] mptcp: validate 'id' when stopping the ADD_ADDR retransmit timer
Date: Tue, 18 May 2021 19:36:10 +0200
Message-Id: <876dfafb9ec7b090a1da4c2af777be20973649ec.1621359292.git.dcaratti@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

when Linux receives an echo-ed ADD_ADDR, it checks the IP address against
the list of "announced" addresses. In case of a positive match, the timer
that handles retransmissions is stopped regardless of the 'Address Id' in
the received packet: this behaviour does not comply with RFC8684 §3.4.1.

Fix it by validating the 'Address Id' in received echo-ed ADD_ADDRs.
Tested using packetdrill, with the following captured output:

 unpatched kernel:

 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0xfd2e62517888fe29,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 1.2.3.4,mptcp dss ack 3013740213], length 0
 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0xfd2e62517888fe29,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 90 198.51.100.2,mptcp dss ack 3013740213], length 0
        ^^^ retransmission is stopped here, but 'Address Id' is 90

 patched kernel:

 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 1.2.3.4,mptcp dss ack 1672384568], length 0
 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 90 198.51.100.2,mptcp dss ack 1672384568], length 0
 Out <...> Flags [.], ack 1, win 256, options [mptcp add-addr v1 id 1 198.51.100.2 hmac 0x1cf372d59e05f4b8,mptcp dss ack 3007449509], length 0
 In  <...> Flags [.], ack 1, win 257, options [mptcp add-addr v1-echo id 1 198.51.100.2,mptcp dss ack 1672384568], length 0
        ^^^ retransmission is stopped here, only when both 'Address Id' and 'IP Address' match

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/options.c    | 2 +-
 net/mptcp/pm_netlink.c | 8 ++++----
 net/mptcp/protocol.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3428c163299b..55732b8d7e08 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1067,7 +1067,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
 			mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-			mptcp_pm_del_add_timer(msk, &mp_opt.addr);
+			mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d094588afad8..09722598994d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -346,18 +346,18 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr)
+		       struct mptcp_addr_info *addr, bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry)
+	if (entry && (!check_id || entry->addr.id == addr->id))
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry)
+	if (entry && (!check_id || entry->addr.id == addr->id))
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
@@ -1070,7 +1070,7 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *entry;
 
-	entry = mptcp_pm_del_add_timer(msk, addr);
+	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
 		list_del(&entry->list);
 		kfree(entry);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 868e878af526..16e50caf200e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -693,7 +693,7 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       struct mptcp_addr_info *addr);
+		       struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				struct mptcp_addr_info *addr);
-- 
2.31.1

