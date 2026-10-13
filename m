Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D2358D00
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881773; cv=none; b=enNCPwuSOkL1U0Q2kTHRGjSnCcg2jjUdM9Oe9qB6aB/Djx+XQGpDTtZ9mdLhMp/CDQKQtjfnyFwLC7hgL+6ro20qIwbJjgfnEcU6oZT+knHNspYeFgrYi9XQKT16Q3NMbeZj93dcy80NAgzUIQS7HnDQWJPtiHxMXLl9KOuw1HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881773; c=relaxed/simple;
	bh=Xy+MTukBcfUtxBhKAPV4uGJUiRsjgNxFkikpxfzdIuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lvhOLIS/SZRm7PqBI5NZrtJVufRr1/K521Gsiuj5YH24MVR3RNlfZVSb4tRkXRxxe3muRciAjZivnLAVTdMoXmI+eeeMIItCgcUDD3B4Idj+MtuoMrc86luqr5E+AsGLiwDw6+YbTu6ljukhmao2XomXmIhl/Y71f7+75l5oCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j20XRgdz; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j20XRgdz"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-141395927feso4879262c88.0
        for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791881771; x=1792486571; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ydoXtL1b+rm8DE6mQtlEhB4i5rcpR8iVwntBET9sHc=;
        b=j20XRgdzi01BO563xrBJp2q/Dzpae+YhXk5XkO8gZ/Vmn0Xx7jM8OVY1Tjip34cCtp
         yDDLUn9h4B+xS05be7JEdck3Mrn+IBgKI285vmR4v+kd1/OqRyxU7DFw4yRiwgZKT9GI
         lEWN/vkwWXks1A3rEZeaYcQzmnpUVopgsVI6lm8xqOHgJ1gPp3kH1ALYrood1xxjBY8q
         vVqAmQtf/e9xrNClTWy1AMHCcNEKKR4F4JeFs3V1xx8BGoSiRFjpclHm1naYLtQdRGfD
         P8u7PrPLKc4ytoy4bHkcOdybsL39Quz0JMF5263e1gWxGId1nKvot6A3voeWv2FYzTUS
         iDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881771; x=1792486571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ydoXtL1b+rm8DE6mQtlEhB4i5rcpR8iVwntBET9sHc=;
        b=N3jXzbf6oZtWI0Ae0Gm9g/GSUTPKUviBYa6OXWZPzC7GBZuOmZ/XOsp9mLtO6pcX91
         V4z2tvjnspUUS9ZbuM68Zw3rPw5HRPPk1sYGRTaZtjVt7u+dVqEYZ9Ub2GwvnapRSHwL
         sr0BoYGhUFgsVpQ2FGMdhpwkaZpNX9STZ+UfDK93vML1OHopMZnWZrJX49PpZqDx6jkU
         hUu+DVV4yfAsWn0lx0c09MJG0pbcbPsG2rhiaGm+fbHocREZ1GHJm24KqnI5yfqXRs3f
         rUHhEK9Mf3ixb6uS9Pld836ibcGLUw+JK2OrkEH5ynYaonof3nbHxcfe7FxU5w5R9XRR
         iX6g==
X-Gm-Message-State: AFq9FYKWxa17nUN6czVb8SNkIvTXzjrkQL3KCXn+zf8oZKPGBh8aAZ/i
	DNurmwKOoe+aGNbyYZDMu7jpUSBNTHN0a3tFI6ZdckWAG+MlnPcu8MZHPL7KU+PHufo=
X-Gm-Gg: AYBFou10EqqLdMruqoWB0yoZVngiq/5fGMOJhG7Omx7Revastvsth+t29nzqxkAYC+b
	Vt8WI85RpL5QslER6xqxOpLa3Df9iX/4fwIAbR6dhBdHgwAsaE14g1NqBYHPaf8FF4ZEQIwchIq
	aMvm/kJASb3Yt4CZZsxpNWlXUlBtQcMQOEUbaxV8iemb9cgTYU9Dblffhz7j2HNZVmNpWet9x1p
	T9pYaeiFjsb2ozegt0rqgnUANL1QJ80t5sujA1gf7y4RCisZi3aO1/Q38hQnzACPAxOzv+MCHox
	5BxvJfkZl3twin3ct2t81uVoIXMMycdBPVCLO7kDoojDKh0DgGEG6LNDKqmFaNnSCEEog83BBV1
	C06ooluD5u7p5GPX9o7P9co5Gh10ksj+sKZ+/URoRtxo69J4aHj9AdohprOZsJXLOkneIi8zaKo
	+imyf04hxOkelkXwTI6FqQtg3wXlPtBbxgjpCLJCcBpYrZ5xk2TNYoVyYbfYeJ/7BqLmgKLellS
	WXFvg5N
X-Received: by 2002:a05:701b:4211:10b0:14a:a6dc:9cd7 with SMTP id a92af1059eb24-16a57a16ef2mr16558700c88.2.1791881770655;
        Tue, 13 Oct 2026 01:56:10 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm39034150c88.14.2026.10.13.01.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:56:10 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH mptcp-next] mptcp: add MPTCP_MIB_RCVINVALIDOPT counter for invalid options
Date: Tue, 13 Oct 2026 14:26:04 +0530
Message-Id: <20261013085604.115478-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mptcp_parse_option(), invalid MPTCP options or unsupported suboptions
and malformed option lengths are silently ignored via break statements.
As noted in GitHub issue #628, tracking these invalid options with a MIB
counter is useful to detect potential attacks, network corruption, or
misbehaving peers.

Introduce MPTCP_MIB_RCVINVALIDOPT ("RcvInvalidOpt") to track invalid
MPTCP options encountered during parsing. When mptcp_parse_option()
encounters invalid combinations, lengths, versions, or unknown subtypes,
jump to the bad_opt label to increment MPTCP_MIB_RCVINVALIDOPT.

To increment the MIB counter, mptcp_parse_option() requires a pointer to
struct net. Safely resolve net in mptcp_get_options() via mptcp_skb_net()
from skb->sk, skb->dev, or skb_dst, with NULL guards to prevent NULL
pointer dereferences when sk, dev, or dst is not set.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/628
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
 net/mptcp/mib.c     |  1 +
 net/mptcp/mib.h     |  1 +
 net/mptcp/options.c | 68 ++++++++++++++++++++++++++++-----------------
 3 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb5688..0ab1ddac8 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -95,6 +95,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
+	SNMP_MIB_ITEM("RcvInvalidOpt", MPTCP_MIB_RCVINVALIDOPT),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9..483f79dab 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -98,6 +98,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
 	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
+	MPTCP_MIB_RCVINVALIDOPT,	/* Received invalid MPTCP option */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index adbf8e077..a1af2acfa 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -20,7 +20,8 @@ static bool mptcp_cap_flag_sha256(u8 flags)
 	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
 }
 
-static void mptcp_parse_option(const struct sk_buff *skb,
+static void mptcp_parse_option(struct net *net,
+			       const struct sk_buff *skb,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
@@ -53,9 +54,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Only the MPC + ACK can be used with a RM_ADDR */
 		if (subopt == OPTION_MPTCP_MPC_ACK) {
 			if ((mp_opt->suboptions & ~OPTION_MPTCP_RM_ADDR) != 0)
-				break;
+				goto bad_opt;
 		} else if (mp_opt->suboptions != 0) {
-			break;
+			goto bad_opt;
 		}
 
 		/* Cfr RFC 8684 Section 3.3.0:
@@ -71,21 +72,21 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		if (opsize != expected_opsize &&
 		    (expected_opsize != TCPOLEN_MPTCP_MPC_ACK_DATA ||
 		     opsize != TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM))
-			break;
+			goto bad_opt;
 
 		/* try to be gentle vs future versions on the initial syn */
 		version = *ptr++ & MPTCP_VERSION_MASK;
 		if (opsize != TCPOLEN_MPTCP_MPC_SYN) {
 			if (version != MPTCP_SUPPORTED_VERSION)
-				break;
+				goto bad_opt;
 		} else if (version < MPTCP_SUPPORTED_VERSION) {
-			break;
+			goto bad_opt;
 		}
 
 		flags = *ptr++;
 		if (!mptcp_cap_flag_sha256(flags) ||
 		    (flags & MPTCP_CAP_EXTENSIBILITY))
-			break;
+			goto bad_opt;
 
 		/* RFC 6824, Section 3.1:
 		 * "For the Checksum Required bit (labeled "A"), if either
@@ -137,7 +138,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_RM_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
-			break;
+			goto bad_opt;
 
 		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
 			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYN;
@@ -166,6 +167,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			ptr += 2;
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
 			pr_debug("MP_JOIN hmac\n");
+		} else {
+			goto bad_opt;
 		}
 		break;
 
@@ -176,7 +179,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 					    OPTION_MPTCP_PRIO |
 					    OPTION_MPTCP_FASTCLOSE |
 					    OPTION_MPTCP_FAIL)) != 0)
-			break;
+			goto bad_opt;
 
 		pr_debug("DSS\n");
 		ptr++;
@@ -219,7 +222,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->ack64 = 0;
 			mp_opt->use_ack = 0;
 			mp_opt->data_fin = 0;
-			break;
+			goto bad_opt;
 		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_DSS;
@@ -269,7 +272,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
 					    OPTION_MPTCP_RM_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
-			break;
+			goto bad_opt;
 
 		mp_opt->echo = (*ptr++) & MPTCP_ADDR_ECHO;
 		if (!mp_opt->echo) {
@@ -282,7 +285,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				mp_opt->addr.family = AF_INET6;
 #endif
 			else
-				break;
+				goto bad_opt;
 		} else {
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE ||
 			    opsize == TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
@@ -293,7 +296,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				mp_opt->addr.family = AF_INET6;
 #endif
 			else
-				break;
+				goto bad_opt;
 		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_ADD_ADDR;
@@ -336,11 +339,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 					    OPTIONS_MPTCP_DSS |
 					    OPTION_MPTCP_ADD_ADDR |
 					    OPTION_MPTCP_PRIO)) != 0)
-			break;
+			goto bad_opt;
 
 		if (opsize < TCPOLEN_MPTCP_RM_ADDR_BASE + 1 ||
 		    opsize > TCPOLEN_MPTCP_RM_ADDR_BASE + MPTCP_RM_IDS_MAX)
-			break;
+			goto bad_opt;
 
 		ptr++;
 
@@ -357,10 +360,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 					    OPTIONS_MPTCP_DSS |
 					    OPTION_MPTCP_ADD_ADDR |
 					    OPTION_MPTCP_RM_ADDR)) != 0)
-			break;
+			goto bad_opt;
 
 		if (opsize != TCPOLEN_MPTCP_PRIO)
-			break;
+			goto bad_opt;
 
 		mp_opt->suboptions |= OPTION_MPTCP_PRIO;
 		mp_opt->backup = *ptr++ & MPTCP_PRIO_BKUP;
@@ -371,10 +374,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
 					    OPTION_MPTCP_RST)) != 0)
-			break;
+			goto bad_opt;
 
 		if (opsize != TCPOLEN_MPTCP_FASTCLOSE)
-			break;
+			goto bad_opt;
 
 		ptr += 2;
 		mp_opt->fc_recv_key = get_unaligned_be64(ptr);
@@ -387,13 +390,13 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTION_MPTCP_FAIL |
 					    OPTION_MPTCP_FASTCLOSE)) != 0)
-			break;
+			goto bad_opt;
 
 		if (opsize != TCPOLEN_MPTCP_RST)
-			break;
+			goto bad_opt;
 
 		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
-			break;
+			goto bad_opt;
 
 		mp_opt->suboptions |= OPTION_MPTCP_RST;
 		flags = *ptr++;
@@ -407,10 +410,10 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		/* Can be used with a restricted number of other options */
 		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
 					    OPTION_MPTCP_RST)) != 0)
-			break;
+			goto bad_opt;
 
 		if (opsize != TCPOLEN_MPTCP_FAIL)
-			break;
+			goto bad_opt;
 
 		ptr += 2;
 		mp_opt->suboptions |= OPTION_MPTCP_FAIL;
@@ -419,13 +422,28 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	default:
+bad_opt:
+		if (net)
+			MPTCP_INC_STATS(net, MPTCP_MIB_RCVINVALIDOPT);
 		break;
 	}
 }
 
+static inline struct net *mptcp_skb_net(const struct sk_buff *skb)
+{
+	if (skb->sk)
+		return sock_net(skb->sk);
+	if (skb->dev)
+		return dev_net_rcu(skb->dev);
+	if (skb_dst(skb) && skb_dst_dev_rcu(skb))
+		return skb_dst_dev_net_rcu(skb);
+	return NULL;
+}
+
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
+	struct net *net = mptcp_skb_net(skb);
 	const struct tcphdr *th = tcp_hdr(skb);
 	const unsigned char *ptr;
 	int length;
@@ -458,7 +476,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 			if (opsize > length)
 				return;	/* don't parse partial options */
 			if (opcode == TCPOPT_MPTCP)
-				mptcp_parse_option(skb, ptr, opsize, mp_opt);
+				mptcp_parse_option(net, skb, ptr, opsize, mp_opt);
 			ptr += opsize - 2;
 			length -= opsize;
 		}
-- 
2.34.1

