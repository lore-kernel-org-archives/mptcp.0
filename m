Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ADB2C9D
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644347197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3ARgymVTVtsiXYGKLmMNFhJnfkY/4+I36Zn1I2Cj0Q=;
	b=PaeajB/KjIuie/Mr+kJ95EMt/ECvNafTUSYjT9slvr3NseRLrDDCXzWAb2hAHmwWmkXx21
	oJdFVm3gODZzuU6/0TkqoyjfPsCpGKnTleAeFpJRe9E3mdEL7NtyC38XpBgDB8Ip4FEpwJ
	Pq80TKmpms5mrSO0zHQAuTZuY7xG7Wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-Y4NZW4IIMHWIsJRvX-TwhA-1; Tue, 08 Feb 2022 14:06:36 -0500
X-MC-Unique: Y4NZW4IIMHWIsJRvX-TwhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D70410247A8
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.58])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E6A460BF4
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 3/4] mptcp: add mibs counter for ignored incoming options
Date: Tue,  8 Feb 2022 20:06:17 +0100
Message-Id: <47890ba6bf9dc9cb16aa93d9cdfe0b79c78c8f11.1644346664.git.pabeni@redhat.com>
In-Reply-To: <cover.1644346664.git.pabeni@redhat.com>
References: <cover.1644346664.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The MPTCP in kernel path manager has some constraints on incoming
addresses annunces processing, so that in edge scenarios it can
end-up dropping (ignoring) some of such announces.

The above is not very limiting in practice since such scenarios are
very uncommon and MPTCP will recover due to ADD_ADDR retransmissions.

This patch adds a few MIBs counter to account for such drop events
to allow easier introspection of the critical scenarios.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/mib.c | 2 ++
 net/mptcp/mib.h | 2 ++
 net/mptcp/pm.c  | 8 ++++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index c12251cb0d44..d544b5304596 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -36,12 +36,14 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
 	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
 	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
+	SNMP_MIB_ITEM("AddAddrDropped", MPTCP_MIB_ADDADDRDROP),
 	SNMP_MIB_ITEM("MPJoinPortSynRx", MPTCP_MIB_JOINPORTSYNRX),
 	SNMP_MIB_ITEM("MPJoinPortSynAckRx", MPTCP_MIB_JOINPORTSYNACKRX),
 	SNMP_MIB_ITEM("MPJoinPortAckRx", MPTCP_MIB_JOINPORTACKRX),
 	SNMP_MIB_ITEM("MismatchPortSynRx", MPTCP_MIB_MISMATCHPORTSYNRX),
 	SNMP_MIB_ITEM("MismatchPortAckRx", MPTCP_MIB_MISMATCHPORTACKRX),
 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
+	SNMP_MIB_ITEM("RmAddrDrop", MPTCP_MIB_RMADDRDROP),
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 7901f1338d15..785cf751e5c0 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -29,12 +29,14 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=0 */
 	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=1 */
 	MPTCP_MIB_PORTADD,		/* Received ADD_ADDR with a port-number */
+	MPTCP_MIB_ADDADDRDROP,		/* Dropped incoming ADD_ADDR */
 	MPTCP_MIB_JOINPORTSYNRX,	/* Received a SYN MP_JOIN with a different port-number */
 	MPTCP_MIB_JOINPORTSYNACKRX,	/* Received a SYNACK MP_JOIN with a different port-number */
 	MPTCP_MIB_JOINPORTACKRX,	/* Received an ACK MP_JOIN with a different port-number */
 	MPTCP_MIB_MISMATCHPORTSYNRX,	/* Received a SYN MP_JOIN with a mismatched port-number */
 	MPTCP_MIB_MISMATCHPORTACKRX,	/* Received an ACK MP_JOIN with a mismatched port-number */
 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
+	MPTCP_MIB_RMADDRDROP,		/* Dropped incoming RM_ADDR */
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1f8878cc29e3..c28dd5c21cbe 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -213,6 +213,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote = *addr;
+	} else {
+		__MPTCP_INC_STATS(sock_net((struct sock*)msk), MPTCP_MIB_ADDADDRDROP);
 	}
 
 	spin_unlock_bh(&pm->lock);
@@ -253,8 +255,10 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 		mptcp_event_addr_removed(msk, rm_list->ids[i]);
 
 	spin_lock_bh(&pm->lock);
-	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
-	pm->rm_list_rx = *rm_list;
+	if (mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED))
+		pm->rm_list_rx = *rm_list;
+	else
+		__MPTCP_INC_STATS(sock_net((struct sock*)msk), MPTCP_MIB_RMADDRDROP);
 	spin_unlock_bh(&pm->lock);
 }
 
-- 
2.34.1

