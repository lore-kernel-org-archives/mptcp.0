Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F84972
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 07:48:59 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id y30so4139196pgl.7
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xc6coH0dC2EvvZlDdldeBmq+Gdii7YKOfov4PS2B93s=;
        b=aGBzL2FTtU885vU56nrp4PIiUKezrFKnMi6f9CcMgdUvd5nv562GXAUgGgANMEnRMq
         NCyHXbQRJJ2FbwNdADsOJXmFu+8RFvJNy8uUmNm+tseiF3SO7BQn0JR7Iq/aka8IsFnU
         s6sLWgLMFD8HCmSf2ZVrPTF23SEprkN7TKwhbXAK828f9vveg4a7uqpE1Vz+p0jGcqB/
         CXI8vVV9V73qV3Ce9sePo+UnbogF0dKV7ycnZKs2IgJIIUnQprFG4d0yUhgToEP8XTG1
         P9kYXdwX/JJruLTU7Mo6R/2YnV02dAHlPyXnEZbtMry40hssCGTBMryVo9EEvBiuK/w2
         VnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xc6coH0dC2EvvZlDdldeBmq+Gdii7YKOfov4PS2B93s=;
        b=nnL6S1waNKmeTL+l0IMgI/bUysEiUKs2N+ZFiImVY9tAosntO4EqoYD7v+X1zwWuTY
         OV1h1q+3Dyp5imiZPfEFSGypm0H1Cksze0oyar9JtT1lb0/snPkZNXS4Ng6/beIzBDQm
         uIDMvxdhIpKKWfWtPRaHd+RjCvTUxZOLuVboBjO7eXhC3Y7yE+Q/tIWnO/U+WThYmOJC
         +k0UJWmmcPnpBV3dkv27RBzc0w6LDOGrNhM4WlMDObZ5lHJEJGcXO5Y9WZsyxU+ueYei
         6z7yaH930sKXcXYhxF2+s1U1LQigrDeIf5QlPuRYtaAA1DMZjSzIUsOdSxUVCf0frQwZ
         rDtA==
X-Gm-Message-State: AOAM531RcOgxmQwnyRY/2/ZITdW3pYxJovVUSxALh+I9wO35ORBR/nkM
	qlPjBRe7P0OMrdHUtXErzskLWQo/CyM=
X-Google-Smtp-Source: ABdhPJw1xgYACKhS76cqEGkmqS+AlabttPAP/hfp100T54x3R77HamnwsVY1nMveqGyu3L6eiw90ow==
X-Received: by 2002:a63:f447:: with SMTP id p7mr2945698pgk.272.1620287338541;
        Thu, 06 May 2021 00:48:58 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id ms2sm1347243pjb.8.2021.05.06.00.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:48:58 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 2/5] Squash to "mptcp: add the mib for data checksum"
Date: Thu,  6 May 2021 15:48:43 +0800
Message-Id: <093b409c7678032f8639402cf9f13025d2c65965.1620286893.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1ca01996cdfd7e70967d7895776e3ec3014c55cd.1620286893.git.geliangtang@gmail.com>
References: <cover.1620286893.git.geliangtang@gmail.com> <1ca01996cdfd7e70967d7895776e3ec3014c55cd.1620286893.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename DSSCSUM to DATACSUM.

Please update the commit log too:

'''
This patch added the mib for the data checksum, MPTCP_MIB_DATACSUMERR.
'''

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/mib.c     | 2 +-
 net/mptcp/mib.h     | 2 +-
 net/mptcp/subflow.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index c7042e3317b5..e7e60bc1fb96 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -25,7 +25,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
-	SNMP_MIB_ITEM("DSSCsumErr", MPTCP_MIB_DSSCSUMERR),
+	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
 	SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
 	SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
 	SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index c407358eced8..92e56c0cfbdd 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -18,7 +18,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
-	MPTCP_MIB_DSSCSUMERR,		/* The DSS checksum fail */
+	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
 	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
 	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
 	MPTCP_MIB_OFOMERGE,		/* Segments merged in OoO queue */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f60a2fe1a2cf..c8968038174f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -902,7 +902,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 
 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
 	if (unlikely(csum_fold(csum))) {
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCSUMERR);
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.31.1

