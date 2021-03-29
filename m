Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D85F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:36 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id s21so5804740pjq.1
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkQ7Lmt7lG3VwYppocvPx8EawmQC1/wlbKy00CPDiQ4=;
        b=YLFeSHOUORbQliTCxVqFUt7z7Jjna5dUWv+btjtuMKlnN5ewnMmWVQMxhY/uNw3EFR
         KqCsJLfHhKfVyo51EaiO27ak8GOieZSobFmDzHIBL3EVhqorLKSQAM0T0qCHuhKuAAbY
         M1+d0ndqulH5Q2DKaDIxVCI++0PiceWDrH+KSCVnQtiKzz7fo8zAl1KRJpAdd4oMi9Pm
         OxtFRVIxTJD5UB5vHOT/JWmO9kQK2UdIDFZifHBgCdh6I7ojhnj5pCsiJ8ZkdpQsj8xu
         cQL1Hr1NixU6Hxjcm7to7uPlcTo2o5TSKaFVRsjrDBFm/9xEtMW5qpVrC3K30gpYcqsk
         A1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkQ7Lmt7lG3VwYppocvPx8EawmQC1/wlbKy00CPDiQ4=;
        b=GObFiMp4ByAtK4I42p5ft3V6lhlQ3Nxd5isVaNiiqDIyYZZDkamlwX/47q6WexBLiC
         GdBAr0kZ93jnnH3A0NXfmDsAgxJObEDIZ3Px7A1cApEh1cRHvMvNJsP7Ws3IANgM72L8
         edUQYL8UTt3K5MpJc411U+CSun5oKBX1ihP1547lmUCBHXrTJ5ML3m+PDIrKnAye1C3D
         y9/dJdSWqbVc3iTQTNKyXgIUA9WjYD6bVWOHnUSU95f/w9yDTIrGegJ/3ts5qGt1V+/B
         Wnn6bzQU2LwX+ShHzNAOVUyNHkSd9zoYJZbfhJOJgm4cCjjBEQGY3834BH909eIy7uoE
         aBvw==
X-Gm-Message-State: AOAM532ERXdLsivcJYwMhX+tc5eLhxXthcQETWLspVDOux0SQVsf8SeK
	woC3A4GL7TQj/c+9kwX6RSGb3iQSU/t+8w==
X-Google-Smtp-Source: ABdhPJyirpLnw198nMLLmZeM5QpDQ6KZKEJXgLWfJk1NCjJsDV79veu6KjgN1G/6SxR6cLiNbwqzyA==
X-Received: by 2002:a17:90b:228e:: with SMTP id kx14mr26335009pjb.71.1617014496266;
        Mon, 29 Mar 2021 03:41:36 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id w5sm16837205pge.55.2021.03.29.03.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:35 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 13/16] mptcp: add mptcpi_csum_enabled in mptcp_info
Date: Mon, 29 Mar 2021 18:40:44 +0800
Message-Id: <5364f608199436bf7125d8f89a4fefcaad2b5eb3.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <44262de5d6a76c02e585ba148117af9b81355d0d.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com>
 <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com>
 <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com>
 <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com>
 <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com>
 <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com>
 <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com>
 <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com>
 <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com>
 <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com>
 <95dff6615e84496cab649de3d74917790f6a571f.1617014019.git.geliangtang@gmail.com>
 <44262de5d6a76c02e585ba148117af9b81355d0d.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added mptcpi_csum_enabled in struct mptcp_info to expose the
msk->csum_enabled.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/mptcp_diag.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 8eb3c0844bff..7b05f7102321 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -105,6 +105,7 @@ struct mptcp_info {
 	__u64	mptcpi_rcv_nxt;
 	__u8	mptcpi_local_addr_used;
 	__u8	mptcpi_local_addr_max;
+	__u8	mptcpi_csum_enabled;
 };
 
 /*
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index f16d9b5ee978..8f88ddeab6a2 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -144,6 +144,7 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 	info->mptcpi_write_seq = READ_ONCE(msk->write_seq);
 	info->mptcpi_snd_una = READ_ONCE(msk->snd_una);
 	info->mptcpi_rcv_nxt = READ_ONCE(msk->ack_seq);
+	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	unlock_sock_fast(sk, slow);
 }
 
-- 
2.30.2

