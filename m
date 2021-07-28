Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADDB72
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 09:35:27 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id e21so1964479pla.5
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 02:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nVFnjdFvmVEM5H0eEhKIqD0Xax0jELBSHPIrjXwpTI=;
        b=TTRWOUnnPzPEVqxkviGSaf5XeT8L0dotqaKxzSc6pl5mlV8xIFB3T/3e+2jjXoeEsl
         HMW6yuFvukcFqJHXcJyQmfjKfmTV1cGtbffpSaKMD8jau86/7BvnE2Gsi9OEJcDUnZiF
         FmWtmIneJGJ9dFTeHyD+W+rRftPsrkeK0McjpYjPQGMXOCXD5iCOyjfY8zbGAzjoXvJP
         +uSbQ8QBzGBtF1CpmbSmhxTVBprkS50MueYa8pAlf86M+oI9qBv2CXwSanPpbXhuIEcP
         VUxKPzn8FypIGnmpwPm0fB88BKh4KgibUxXyVBrDKrYC4M5FdZnm+fXL5+kWWmrmyxW4
         JZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nVFnjdFvmVEM5H0eEhKIqD0Xax0jELBSHPIrjXwpTI=;
        b=D4hYrUqA4G7prMSUmMmRbd8+ht480K9jrICyL+gxeUl3Bpq1K98XT5fDDTggAM17mz
         tixp9/U6k3HquCGrfoaeNiph0wVhT3aTfZEbxBdZmEMeAij699SmNu4+YmS5zQ7/lb5a
         +1dpdP1kdTzXGb7TLn4kWhwuFJY8J4AtkVgUj5rP1jCow3oqGSCwApuJ6WIjIVt82aGv
         ie0YVCiC4AkhAhHkFLHLCAkn+XuwK930kudvKEkp6+aK/12fEZlWfgsLVwpJjQ0hTVU3
         PoDvxP6yGB1Fv7kEYRnAjx82k0nKK8EZqt7v9PeT36Y2lDZBXZfd2pXeWP3+r7vXI7vx
         2bbQ==
X-Gm-Message-State: AOAM530xiY+ATGy2EgpIgFLHCBaUyE/ip/vnPKDmUxyjpS7YjJP5WjsO
	wtngOdJJSSGCgiehQ9jm2YbaDlcPSi0=
X-Google-Smtp-Source: ABdhPJxl7Tj0K5ItCJ5LfFvgsBkfNhF6m3XMp+s3MsBGXe7HqRxY9sr1ve2iT+RnPaINv40LNLw1Ew==
X-Received: by 2002:a17:90b:38ca:: with SMTP id nn10mr7140307pjb.3.1627464927064;
        Wed, 28 Jul 2021 02:35:27 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id v10sm5312560pjd.29.2021.07.28.02.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:35:26 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v6 mptcp-next 4/5] mptcp: add the mibs for MP_FAIL
Date: Wed, 28 Jul 2021 17:35:11 +0800
Message-Id: <0e7f6c209ba05ef9e5b7300f490f8b6db4df3334.1627464017.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <19469d95c33169d6e4dd553394ab4466756ff001.1627464017.git.geliangtang@xiaomi.com>
References: <cover.1627464017.git.geliangtang@xiaomi.com> <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com> <a39b8f2a49c2798d4ff80ed527cd8990e64f8def.1627464017.git.geliangtang@xiaomi.com> <19469d95c33169d6e4dd553394ab4466756ff001.1627464017.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the mibs for MP_FAIL: MPTCP_MIB_MPFAILTX and
MPTCP_MIB_MPFAILRX.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 1 +
 net/mptcp/pm.c      | 1 +
 net/mptcp/subflow.c | 1 +
 5 files changed, 7 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 3a7c4e7b2d79..b21ff9be04c6 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -44,6 +44,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
+	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
+	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 8ec16c991aac..ecd3d8b117e0 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -37,6 +37,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
+	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
+	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd9ec4acf127..8b899c308b83 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1160,6 +1160,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	if (mp_opt.mp_fail) {
 		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
 		mp_opt.mp_fail = 0;
 	}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c2df5cc28ba1..43530d3a78e9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -258,6 +258,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 	if (!mptcp_has_another_subflow(sk)) {
 		if (!subflow->mp_fail_expect_echo) {
 			subflow->send_mp_fail = 1;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		} else {
 			subflow->mp_fail_expect_echo = 0;
 			/* TODO the single-subflow case is temporarily
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a69839520472..c25b1d961206 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -911,6 +911,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
 		subflow->send_mp_fail = 1;
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.31.1

