Received: from mta1.migadu.com (out-227.mta1.migadu.com [95.215.58.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0B33B97D
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529204; cv=none; b=hthgmCBLV0bN//D7NCad7Tlw8Ut5eofV8qzUfPFpsZebNbtyZwOnpILfeEslaFNWpkhHw0i/QUDZP7tIRCC++uLl5pQjj/ZVbLBLaAMQlO49bkfq4QZC4I2nLNzRJKRpjLcPpYXR5MV8qKQNXTZnQNnKGKaZ1V8Rd3qrUfiO5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529204; c=relaxed/simple;
	bh=MQkQwga6nNuR+PE09NLyd493bEQDdpxETdpTt2o99XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aePB+pwiowvGddquqQhNvdSOizgpV7Ta7YdQRmr0u0ZS3l52sP6B4mkMNSqKiqV8ZwmV33mrnCLKmCVUd/lK4fGu4YPUWKBXvxMjVKE6djiRYOXu9v/LNOAz3C3wOvwV/Vm8wKKsR61qfgzeBMxadb0DJosvDy0utFby54B23iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hTkNcpCO; arc=none smtp.client-ip=95.215.58.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hTkNcpCO"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=MQkQwga6nNuR+PE09NLyd493bEQDdpxETdpTt2o99XY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786529200; v=1; x=1787134000;
 b=hTkNcpCOTEowMVt/9Vl540HAOyHFWwLzXGTeTfNNmeHbnJxOkFfQrwU2AUO3TSuUJeUqg4Oa
 WG455qlHDYfX5vQFSYKUg3nPvP782ntd42WBT9NheGoMjCjpekJgL6OnPAmVNopbMVFyMjDUKQR
 n1bSk1/sb2ZQjzdThcmBrpXc=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (120.244.49.214)
	by smtp.migadu.com with ESMTPS id 4bae616b51b72218;
	Wed, 12 Aug 2026 10:06:40 +0000
Authentication-Results: mta10.migadu.com;
	none
X-Migadu-Scanner: mta10.migadu.com
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] mptcp: add MIB counter for received invalid options
Date: Wed, 12 Aug 2026 18:05:50 +0800
Message-ID: <20260812100550.148670-3-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812100550.148670-1-gang.yan@linux.dev>
References: <20260812100550.148670-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

In mptcp_parse_option(), an MPTCP option is silently ignored via a
'break' under a number of conditions.

This patch adds a MIB counter tracking this as an evidence to show
someone is trying to attack the peer

Assisted-by: Claude:GLM-5.2
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/628
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/mib.c     |  1 +
 net/mptcp/mib.h     |  1 +
 net/mptcp/options.c | 98 +++++++++++++++++++++++++++++++++------------
 3 files changed, 74 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb568897c..10e8870dd985 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -95,6 +95,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
+	SNMP_MIB_ITEM("InvalidOptionRx", MPTCP_MIB_INVALDOPTIONRX),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9534..ae0751addd64 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -98,6 +98,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
 	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
+	MPTCP_MIB_INVALDOPTIONRX,	/* Received an invalid MPTCP option */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dfdcc888efe3..e9deea0e483a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -53,9 +53,12 @@ static void mptcp_parse_option(struct net *net,
 
 		/* Only the MPC + ACK can be used with a RM_ADDR */
 		if (subopt == OPTION_MPTCP_MPC_ACK) {
-			if ((mp_opt->suboptions & ~OPTION_MPTCP_RM_ADDR) != 0)
+			if ((mp_opt->suboptions & ~OPTION_MPTCP_RM_ADDR) != 0) {
+				MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 				break;
+			}
 		} else if (mp_opt->suboptions != 0) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
 		}
 
@@ -71,22 +74,29 @@ static void mptcp_parse_option(struct net *net,
 		 */
 		if (opsize != expected_opsize &&
 		    (expected_opsize != TCPOLEN_MPTCP_MPC_ACK_DATA ||
-		     opsize != TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM))
+		     opsize != TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM)) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		/* try to be gentle vs future versions on the initial syn */
 		version = *ptr++ & MPTCP_VERSION_MASK;
 		if (opsize != TCPOLEN_MPTCP_MPC_SYN) {
-			if (version != MPTCP_SUPPORTED_VERSION)
+			if (version != MPTCP_SUPPORTED_VERSION) {
+				MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 				break;
+			}
 		} else if (version < MPTCP_SUPPORTED_VERSION) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
 		}
 
 		flags = *ptr++;
 		if (!mptcp_cap_flag_sha256(flags) ||
-		    (flags & MPTCP_CAP_EXTENSIBILITY))
+		    (flags & MPTCP_CAP_EXTENSIBILITY)) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		/* RFC 6824, Section 3.1:
 		 * "For the Checksum Required bit (labeled "A"), if either
@@ -133,8 +143,10 @@ static void mptcp_parse_option(struct net *net,
 	case MPTCPOPT_MP_JOIN:
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_RM_ADDR |
-					    OPTION_MPTCP_PRIO)) != 0)
+					    OPTION_MPTCP_PRIO)) != 0) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
 			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYN;
@@ -163,6 +175,8 @@ static void mptcp_parse_option(struct net *net,
 			ptr += 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
 			pr_debug("MP_JOIN hmac\n");
+		} else {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 		}
 		break;
 
@@ -172,8 +186,10 @@ static void mptcp_parse_option(struct net *net,
 					    OPTION_MPTCP_RM_ADDR |
 					    OPTION_MPTCP_PRIO |
 					    OPTION_MPTCP_FASTCLOSE |
-					    OPTION_MPTCP_FAIL)) != 0)
+					    OPTION_MPTCP_FAIL)) != 0) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		pr_debug("DSS\n");
 		ptr++;
@@ -216,6 +232,7 @@ static void mptcp_parse_option(struct net *net,
 			mp_opt->ack64 = 0;
 			mp_opt->use_ack = 0;
 			mp_opt->data_fin = 0;
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
 		}
 
@@ -265,32 +282,38 @@ static void mptcp_parse_option(struct net *net,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
 					    OPTION_MPTCP_RM_ADDR |
-					    OPTION_MPTCP_PRIO)) != 0)
+					    OPTION_MPTCP_PRIO)) != 0) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		mp_opt->echo = (*ptr++) & MPTCP_ADDR_ECHO;
 		if (!mp_opt->echo) {
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR ||
-			    opsize == TCPOLEN_MPTCP_ADD_ADDR_PORT)
+			    opsize == TCPOLEN_MPTCP_ADD_ADDR_PORT) {
 				mp_opt->addr.family = AF_INET;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-			else if (opsize == TCPOLEN_MPTCP_ADD_ADDR6 ||
-				 opsize == TCPOLEN_MPTCP_ADD_ADDR6_PORT)
+			} else if (opsize == TCPOLEN_MPTCP_ADD_ADDR6 ||
+				 opsize == TCPOLEN_MPTCP_ADD_ADDR6_PORT) {
 				mp_opt->addr.family = AF_INET6;
 #endif
-			else
+			} else {
+				MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 				break;
+			}
 		} else {
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE ||
-			    opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
+			    opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT) {
 				mp_opt->addr.family = AF_INET;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-			else if (opsize == TCPOLEN_MPTCP_ADD_ADDR6_BASE ||
-				 opsize == TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT)
+			} else if (opsize == TCPOLEN_MPTCP_ADD_ADDR6_BASE ||
+				 opsize == TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT) {
 				mp_opt->addr.family = AF_INET6;
 #endif
-			else
+			} else {
+				MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 				break;
+			}
 		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_ADD_ADDR;
@@ -332,12 +355,16 @@ static void mptcp_parse_option(struct net *net,
 					    OPTIONS_MPTCP_MPJ |
 					    OPTIONS_MPTCP_DSS |
 					    OPTION_MPTCP_ADD_ADDR |
-					    OPTION_MPTCP_PRIO)) != 0)
+					    OPTION_MPTCP_PRIO)) != 0) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		if (opsize < TCPOLEN_MPTCP_RM_ADDR_BASE + 1 ||
-		    opsize > TCPOLEN_MPTCP_RM_ADDR_BASE + MPTCP_RM_IDS_MAX)
+		    opsize > TCPOLEN_MPTCP_RM_ADDR_BASE + MPTCP_RM_IDS_MAX) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		ptr++;
 
@@ -353,11 +380,15 @@ static void mptcp_parse_option(struct net *net,
 		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_MPJ |
 					    OPTIONS_MPTCP_DSS |
 					    OPTION_MPTCP_ADD_ADDR |
-					    OPTION_MPTCP_RM_ADDR)) != 0)
+					    OPTION_MPTCP_RM_ADDR)) != 0) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
-		if (opsize != TCPOLEN_MPTCP_PRIO)
+		if (opsize != TCPOLEN_MPTCP_PRIO) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_PRIO;
 		mp_opt->backup = *ptr++ & MPTCP_PRIO_BKUP;
@@ -367,11 +398,15 @@ static void mptcp_parse_option(struct net *net,
 	case MPTCPOPT_MP_FASTCLOSE:
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
-					    OPTION_MPTCP_RST)) != 0)
+					    OPTION_MPTCP_RST)) != 0) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
-		if (opsize != TCPOLEN_MPTCP_FASTCLOSE)
+		if (opsize != TCPOLEN_MPTCP_FASTCLOSE) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		ptr += 2;
 		mp_opt->rcvr_key = get_unaligned_be64(ptr);
@@ -383,14 +418,20 @@ static void mptcp_parse_option(struct net *net,
 	case MPTCPOPT_RST:
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_FAIL |
-					    OPTION_MPTCP_FASTCLOSE)) != 0)
+					    OPTION_MPTCP_FASTCLOSE)) != 0) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
-		if (opsize != TCPOLEN_MPTCP_RST)
+		if (opsize != TCPOLEN_MPTCP_RST) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
-		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
+		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_RST;
 		flags = *ptr++;
@@ -403,11 +444,15 @@ static void mptcp_parse_option(struct net *net,
 	case MPTCPOPT_MP_FAIL:
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
-					    OPTION_MPTCP_RST)) != 0)
+					    OPTION_MPTCP_RST)) != 0) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
-		if (opsize != TCPOLEN_MPTCP_FAIL)
+		if (opsize != TCPOLEN_MPTCP_FAIL) {
+			MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 			break;
+		}
 
 		ptr += 2;
 		mp_opt->suboptions |= OPTION_MPTCP_FAIL;
@@ -416,6 +461,7 @@ static void mptcp_parse_option(struct net *net,
 		break;
 
 	default:
+		MPTCP_INC_STATS(net, MPTCP_MIB_INVALDOPTIONRX);
 		break;
 	}
 }
-- 
2.43.0

