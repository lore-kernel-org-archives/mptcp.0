Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3013FC5
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 09:19:25 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so2252643pjq.1
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUUtlABPXZdGRuVvCgwvqOYGpRbdqlH2zuHRQxptxdw=;
        b=Any82s0JpAprQOKy4Nx8uuDdlbHG/+vfkL3xP0Z3K66P9TJj0M1wB5pCuStn+W2mnb
         vnOw1IDGEs5MG4buufkCWMx5MCRirqVylFJsar6OOC3p2bkfYjXrhdUeCutSHDZ8MRxm
         EqwcB+q+oWww8oALJb2w9N0sPsClSyyOf2PjNceHoZmo2VHxRn+uNZjOekvqShGHviIg
         aj1wA1JII6w6gohznMJtXItgz4xItwKqLBJ5E2UrLUDG7tpywSdRrUdYV2u/NmiuCm/H
         RcXVt93SkFirQ0qlE/3k+nuwFeZbMxzTqvC/As9LZr9R13fU88u+Y7kujLDRsIeD+tqe
         T/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUUtlABPXZdGRuVvCgwvqOYGpRbdqlH2zuHRQxptxdw=;
        b=BXEqgdg0IY/r5BzgcIH3c9kmJLFfMlVsy7jboF8E8cmfiYLJ+FzeQaAj6NtnyT7jGg
         V97SYGBmFfxGSUeHOC1x5fTKZINY9VrsF1bqFTecWbQQRr8S1iG/0M1+QKmUDcgu0bBr
         rd+sHZ/azVDZCT107QKYgJvwwYONCn1Mvc3UJ6Eq7egjkg8KqX4uajDrVgF+mKeD7G3m
         xNNFI3i/N7rTzRGzA6xGlKVwScvgIR4lXvQMiKq0tg5m7b380I54vwEjYtaUZ7Jrp1X0
         BTuhvqiZzpCfBgHbqEx+sCCGpUT0OAQijt754wS77GaZCh7a1txESZ/hxAgqISt/Et1d
         PTSA==
X-Gm-Message-State: AOAM530N+Y9zgeUd/bq7W95+/+DAns+xUzW7B/G4GbuIPHzH7i5p0Rg0
	yezKVhPGx6So3FIXaBj5RtN85mpRq70=
X-Google-Smtp-Source: ABdhPJx5xc6lZLaKl/jT8wWY8rl314m7ltDnAUwyDmRks4BcP9CrDUq1Hi3xTY3VIbJeiUO5rFA3nA==
X-Received: by 2002:a17:90b:4a06:: with SMTP id kk6mr1007414pjb.72.1631611165269;
        Tue, 14 Sep 2021 02:19:25 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id i21sm10851317pgn.93.2021.09.14.02.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:24 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v3 6/8] mptcp: add mib for infinite map sending
Date: Tue, 14 Sep 2021 17:19:05 +0800
Message-Id: <e8066a60857ef0aba78e17c15cb90664317f0603.1631610729.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631610729.git.geliangtang@gmail.com>
References: <cover.1631610729.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new mib named MPTCP_MIB_INFINITEMAPTX, increase it
when a infinite mapping has been sent out.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index b21ff9be04c6..ab55afdcae22 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -24,6 +24,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
 	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index ecd3d8b117e0..7901f1338d15 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -17,6 +17,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
+	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
 	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 77183e247e4d..48e0f55c9e45 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1286,6 +1286,7 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk, struct sock *ssk,
 	mpext->data_len = 0;
 	mpext->csum = 0;
 
+	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
 	__mptcp_do_fallback(msk);
-- 
2.31.1

