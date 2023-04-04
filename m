Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111CC6AA6
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680608482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjWv815WR664rkt/AqKEXpE1r4AV3VNldXUCLCBdcH8=;
	b=bCRvUrn2XLFX0+ddFC5UIag62TKm7CCEWmTEzFPsb46eZ9H1U8AsTb/XMSKiVN0U5vK4Wq
	fWGPSK86aK0hsHH7JjyIbQqx4KXAYDZ1qITPx4OmDm/Pvm2vJ7zGUWBTcOT2xjOfPRIqL8
	xNZVAvG4b63NCjMKgUJ2XHNB7zgQgHA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-AgZF1emHPyumzs5jugT4Qw-1; Tue, 04 Apr 2023 07:41:20 -0400
X-MC-Unique: AgZF1emHPyumzs5jugT4Qw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 901D685A5A3
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 11:41:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 058D7440BC
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 11:41:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/3] mptcp: introduces more address related mibs
Date: Tue,  4 Apr 2023 13:41:02 +0200
Message-Id: <9600c7e20a23212abce1fc1545e61878ed331c2c.1680544063.git.pabeni@redhat.com>
In-Reply-To: <cover.1680544063.git.pabeni@redhat.com>
References: <cover.1680544063.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently we don't track explicitly a few events related to address
management suboption handling; this patch adds new mibs for ADD_ADDR
and RM_ADDR options tx and for missed tx events due to internal storage
exahustion.

The self-tests must be updated to properly handle different mibs with
the same/shared prefix.

Additionally removes a couple of warning tracking the loss event.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/378
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/mib.c                                 |  6 ++++++
 net/mptcp/mib.h                                 | 14 ++++++++++++++
 net/mptcp/options.c                             |  5 ++++-
 net/mptcp/pm.c                                  |  6 ++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 ++--
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 0dac2863c6e1..a0990c365a2e 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -34,7 +34,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
+	SNMP_MIB_ITEM("AddAddrTx", MPTCP_MIB_ADDADDRTX),
+	SNMP_MIB_ITEM("AddAddrTxDrop", MPTCP_MIB_ADDADDRTXDROP),
 	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
+	SNMP_MIB_ITEM("EchoAddTx", MPTCP_MIB_ECHOADDTX),
+	SNMP_MIB_ITEM("EchoAddTxDrop", MPTCP_MIB_ECHOADDTXDROP),
 	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
 	SNMP_MIB_ITEM("AddAddrDrop", MPTCP_MIB_ADDADDRDROP),
 	SNMP_MIB_ITEM("MPJoinPortSynRx", MPTCP_MIB_JOINPORTSYNRX),
@@ -44,6 +48,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MismatchPortAckRx", MPTCP_MIB_MISMATCHPORTACKRX),
 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
 	SNMP_MIB_ITEM("RmAddrDrop", MPTCP_MIB_RMADDRDROP),
+	SNMP_MIB_ITEM("RmAddrTx", MPTCP_MIB_RMADDRTX),
+	SNMP_MIB_ITEM("RmAddrTxDrop", MPTCP_MIB_RMADDRTXDROP),
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 2be3596374f4..bced7004b2f1 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -27,7 +27,11 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_NODSSWINDOW,		/* Segments not in MPTCP windows */
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=0 */
+	MPTCP_MIB_ADDADDRTX,		/* Sent ADD_ADDR with echo-flag=0 */
+	MPTCP_MIB_ADDADDRTXDROP,	/* ADD_ADDR with echo-flag=0 not send due to resource exhaustion */
 	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=1 */
+	MPTCP_MIB_ECHOADDTX,		/* Send ADD_ADDR with echo-flag=1 */
+	MPTCP_MIB_ECHOADDTXDROP,	/* ADD_ADDR with echo-flag=1 not send due to resource exhaustion */
 	MPTCP_MIB_PORTADD,		/* Received ADD_ADDR with a port-number */
 	MPTCP_MIB_ADDADDRDROP,		/* Dropped incoming ADD_ADDR */
 	MPTCP_MIB_JOINPORTSYNRX,	/* Received a SYN MP_JOIN with a different port-number */
@@ -37,6 +41,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MISMATCHPORTACKRX,	/* Received an ACK MP_JOIN with a mismatched port-number */
 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
 	MPTCP_MIB_RMADDRDROP,		/* Dropped incoming RM_ADDR */
+	MPTCP_MIB_RMADDRTX,		/* Sent RM_ADDR */
+	MPTCP_MIB_RMADDRTXDROP,		/* RM_ADDR not sent due to resource exhaustion */
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
@@ -63,6 +69,14 @@ struct mptcp_mib {
 	unsigned long mibs[LINUX_MIB_MPTCP_MAX];
 };
 
+static inline void MPTCP_ADD_STATS(struct net *net,
+				   enum linux_mptcp_mib_field field,
+				   int val)
+{
+	if (likely(net->mib.mptcp_statistics))
+		SNMP_ADD_STATS(net->mib.mptcp_statistics, field, val);
+}
+
 static inline void MPTCP_INC_STATS(struct net *net,
 				   enum linux_mptcp_mib_field field)
 {
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd3b885c8faa..a100e2dd5260 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -690,9 +690,12 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	}
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
 	if (!echo) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRTX);
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
 						     msk->remote_key,
 						     &opts->addr);
+	} else {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADDTX);
 	}
 	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
 		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
@@ -726,7 +729,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 
 	for (i = 0; i < opts->rm_list.nr; i++)
 		pr_debug("rm_list_ids[%d]=%d", i, opts->rm_list.ids[i]);
-
+	MPTCP_ADD_STATS(sock_net(sk), MPTCP_MIB_RMADDRTX, opts->rm_list.nr);
 	return true;
 }
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ed4d29d9c11..bc2bb0f4753f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -26,7 +26,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 
 	if (add_addr &
 	    (echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL))) {
-		pr_warn("addr_signal error, add_addr=%d, echo=%d", add_addr, echo);
+		MPTCP_INC_STATS(sock_net((struct sock *)msk),
+				echo? MPTCP_MIB_ECHOADDTXDROP: MPTCP_MIB_ADDADDRTXDROP);
 		return -EINVAL;
 	}
 
@@ -48,7 +49,8 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
 
 	if (rm_addr) {
-		pr_warn("addr_signal error, rm_addr=%d", rm_addr);
+		MPTCP_ADD_STATS(sock_net((struct sock *)msk),
+				MPTCP_MIB_RMADDRTXDROP, rm_list->nr);
 		return -EINVAL;
 	}
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fafd19ec7e1f..095ddd747ffc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1486,7 +1486,7 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}')
+	count=$(ip netns exec $ns1 nstat -as MPTcpExtEchoAdd | grep MPTcpExtEchoAdd | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
@@ -1608,7 +1608,7 @@ chk_rm_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rm "
-	count=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}')
+	count=$(ip netns exec $addr_ns nstat -as MPTcpExtRmAddr | grep MPTcpExtRmAddr | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
-- 
2.39.2

