Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E870
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 04:29:27 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id d12so14341049pgd.9
        for <mptcp@lists.linux.dev>; Sun, 27 Jun 2021 21:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wxzmdl/Lh7PUrh3DRLU2lqeX+ZI50LZrBxjScxodBQ8=;
        b=LbFNR27An6Q9YkmvotMDejgji5SOjMVgx8Bpvz/YRk1Mcm9Lss4z786uPgnIaNx5N3
         wPosYZ4OqyWWhjyMPx8TgDtrtS/DB/RuZAqYplN4bojKSIB0f3ueWSrPfEf9SnDeYbST
         zBi86KVqhrWsR9Tsjylf2cxH4mjyifk3MgyZXheYFqaipNWmgoXFwFW2/kdZk3Xe5T19
         8axDjmtvyouSeflMrENIk6XXkGRyOFsQWSUDYk2ALEyzD1cpM1uyFUZa0bfDwxLBalPg
         cTbUYANSAHc+ef2O+XcYGbcfKr4JgEaBdjmH8ZH1jTwqyLpiudozfXeYPdD6odugP37e
         pwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wxzmdl/Lh7PUrh3DRLU2lqeX+ZI50LZrBxjScxodBQ8=;
        b=Tv75RoG5HOAoy0Xu1OUoUIPI9R3naXheEzdSKNhTSC4AJQQvPnKMyug2SCfD0EXl6x
         L59PyTnkjDEDXByTqZ2aNlfkiwslMwfDCSj95vewEBJ03Fmj9NFoSOGrBAToFO0sPxDx
         1QkVU/4nb9QzzXwsQisoQDrfcMD8O3yp79ky1Zrq1fggBy19JCcGEUWuQM2CGy/wjalk
         36B2ucun/mf4yB44s+g4WF8mtwqQmajHaMGQrjS1xvNTTYSIeljSOHfTAZ8b5+dnFTvq
         XUE9M93O7HDm7WBvqLCfN75Fq/IA8GRebVRS2mcLNTplB176hGgf0d/OSmhtBmcadKDs
         1D5Q==
X-Gm-Message-State: AOAM531fUIOtUcb3ksfKfgiE7vE6Y40mg+4jxVoE7GEYUb6jIxTYE/Id
	6k2rA5wp3DiffYumCKOq97+EUJTRnpXoiw==
X-Google-Smtp-Source: ABdhPJzf3rERf0x9ce+/htBOdlbZCJiSA87gXkfaVVyZ+LX4fqwZvFbuMRffuyOw9piXUflc7hq96A==
X-Received: by 2002:aa7:920d:0:b029:2d9:2ead:70dd with SMTP id 13-20020aa7920d0000b02902d92ead70ddmr22639170pfo.67.1624854567296;
        Sun, 27 Jun 2021 21:29:27 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g8sm12837391pgo.10.2021.06.27.21.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:29:27 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 8/8] mptcp: add a mib for the infinite mapping sending
Date: Mon, 28 Jun 2021 12:29:04 +0800
Message-Id: <7b57c6db408adf430273052985895aa13a8357dd.1624854005.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <699d4e2d58c11360fd7244e4e4aee8c7f01ef189.1624854005.git.geliangtang@gmail.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com> <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com> <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com> <fd3ac7612efa93564019e8542bf67ed38ef06627.1624854005.git.geliangtang@gmail.com> <926e95605f1d2a7cdc02b99a1701a1dddf1e6424.1624854005.git.geliangtang@gmail.com> <0e01e10358c89896ad265d9b57cfe4995965e445.1624854005.git.geliangtang@gmail.com> <699d4e2d58c11360fd7244e4e4aee8c7f01ef189.1624854005.git.geliangtang@gmail.com>
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
 net/mptcp/mib.c     | 1 +
 net/mptcp/mib.h     | 1 +
 net/mptcp/options.c | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 3f0df09138b2..1ac11966bdcd 100644
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
index 2a6cb1d8704c..fe0d1b2e9455 100644
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
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1fce6fddb6ab..abd0d4660a67 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -575,12 +575,16 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 static void mptcp_write_infinite_mapping(struct mptcp_subflow_context *subflow,
 					 struct mptcp_ext *ext)
 {
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	struct sock *sk = (struct sock *)msk;
+
 	pr_debug("fail_seq=%llu", subflow->fail_seq);
 
 	if (ext->use_map) {
 		ext->data_seq = subflow->fail_seq;
 		ext->data_len = 0;
 		WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_INFINITEMAPTX);
 	}
 }
 
-- 
2.31.1

