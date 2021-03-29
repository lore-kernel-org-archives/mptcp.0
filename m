Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA9A6F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:26 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so7494899pjc.2
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fnwKaEn4WFRm9/uQhzdU5bCVnr0x2VyGVBlZxje6zY=;
        b=SqV3kqTZsviILEG7iYtB7WUoyr+4K5H5MfDlEuw1IlMv0UXVSNurI/pGa77w/1+ZlE
         5qvM5/PHKFH5Oj0mWOff5mSi4r6AzQHDH7hPj0oP+OpwRPOnVSIJTex8evioNkWkX7f1
         YngDEwqVy/jUMC6xnmiFP8DVOqthuNZo7XfD5qeQZrfpngGPkc+30AeQOH96rFHMrjV/
         452M58JMbo3CbB9b5e24vobGCq1i8f0X6ZV5RP+f6ZCTLkGzQYKx+y42H1CEpoYlSx5f
         5lbz/+Q/fGwIjUhJ53G75GzAgnttICcJWqR4BgYciz/kFn9fV9v2ksJjCjnpzSK6PCHI
         zSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fnwKaEn4WFRm9/uQhzdU5bCVnr0x2VyGVBlZxje6zY=;
        b=L2kahiOz+q3VWIDTD/g7XMwUKB18CTGSNnBCb5d3n7OposkcUNyXCJLXGgVk8v2Cf3
         QrA8CY7y5HA5JZrbgW/vvi47iaoUc2No7yJ0CaCoV7T/utUfR3Z+i9ixS5Ri4Cy7kcel
         c19Bt+5iPGQPqYrWs3OP+Ps/o7gw0fRaLAa7WBspDJOBs0U7URtRs9BRDm8k80uRe5pj
         3HkDIM76sW4DhWzs3BTV2bMzWsVDbUQq1NhzZJYh7WndYvhD6tE2VIyfZm/9vdKjb/9F
         nd+Xt4NDWxhpOZjMiEI0+sOfNqw5qDINL9UFnNihIIFpYB3nwr3vhGM+XZHcNsn+P6Gn
         8FmA==
X-Gm-Message-State: AOAM530fB7J5/HPkCPhobK4LXVv/zjv2UlrRbkHIEkl0jndpT88pJ7Uh
	EAEtEY+K1XfWh5xgTiPa75Q6WEHkimPGkQ==
X-Google-Smtp-Source: ABdhPJx2q6cIRqJ3kZs6YEaWpDcHNBwKJKbgUEk8ePqB4eNBpEs8I2wO2Khi8SfjvjaQsz4zRHE9Hg==
X-Received: by 2002:a17:90b:4aca:: with SMTP id mh10mr24915889pjb.185.1617014486148;
        Mon, 29 Mar 2021 03:41:26 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id ha8sm14725198pjb.6.2021.03.29.03.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:25 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 10/16] mptcp: validate the data checksum
Date: Mon, 29 Mar 2021 18:40:41 +0800
Message-Id: <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com> <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com> <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com> <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com> <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com> <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com> <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com> <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch add three new members named data_csum, csum_len and map_csum in
struct mptcp_subflow_context, implemented a new function named
mptcp_validate_data_checksum(). Validate the data checksum in the function
__mptcp_move_skbs_from_subflow.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 35 +++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  |  7 +++++--
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 436969d95e36..0b4ab35e234a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -532,6 +532,35 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	return ret;
 }
 
+static bool mptcp_validate_data_checksum(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	struct csum_pseudo_header header;
+	__wsum csum;
+
+	if (__mptcp_check_fallback(msk))
+		goto out;
+
+	if (subflow->csum_len < subflow->map_data_len)
+		goto out;
+
+	header.data_seq = subflow->map_seq;
+	header.subflow_seq = subflow->map_subflow_seq;
+	header.data_len = subflow->map_data_len;
+	header.csum = subflow->map_csum;
+
+	csum = csum_partial(&header, sizeof(header), subflow->data_csum);
+
+	if (csum_fold(csum))
+		return false;
+	subflow->data_csum = 0;
+	subflow->csum_len = 0;
+
+out:
+	return true;
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -600,6 +629,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			if (tp->urg_data)
 				done = true;
 
+			if (READ_ONCE(msk->csum_enabled)) {
+				subflow->data_csum = skb_checksum(skb, offset, len,
+								  subflow->data_csum);
+				subflow->csum_len += len;
+				mptcp_validate_data_checksum(ssk);
+			}
 			if (__mptcp_move_skb(msk, ssk, skb, offset, len))
 				moved += len;
 			seq += len;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6be10ebabcd5..d4bf264d16cc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -394,6 +394,9 @@ struct mptcp_subflow_context {
 	u32	map_subflow_seq;
 	u32	ssn_offset;
 	u32	map_data_len;
+	__wsum	data_csum;
+	u32	csum_len;
+	__sum16	map_csum;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 75664da251a6..df7ad478bb2e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -944,9 +944,12 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	subflow->map_data_len = data_len;
 	subflow->map_valid = 1;
 	subflow->mpc_map = mpext->mpc_map;
-	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u",
+	subflow->data_csum = 0;
+	subflow->csum_len = 0;
+	subflow->map_csum = mpext->csum;
+	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%u",
 		 subflow->map_seq, subflow->map_subflow_seq,
-		 subflow->map_data_len);
+		 subflow->map_data_len, subflow->map_csum);
 
 validate_seq:
 	/* we revalidate valid mapping on new skb, because we must ensure
-- 
2.30.2

