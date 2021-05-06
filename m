Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C372
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 07:48:55 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id q2so4454721pfh.13
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 00:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pcy0MtDCE2v2WQhbuvgCLMkbkh2dXgGrD3744j14V+g=;
        b=uukUsItE2Lphxl0Nr5MPgWkCVUL/JAk++SB8vi5jwo9Y/EcYWwZB0g291GUsv9yr4E
         8XKEkk4tYCehWk/ahv6I/bKp6q+RcarebNzlrRLeLe1x9aifkvs11JedgkXzuZDCvKzH
         gNf2/Q7Mo/ssRxPSjAWT7k1SXh5SeE+yKKDpKo7A1wVUcSi2FAlH19a9pHRhbtvYcxhg
         BPr2ZWU5TaFBMZ18g5qBTUrqiGjFb9l6Sa6/wGpN0T21BoMjN30Ad8RQo84JtfuRnyKk
         7EFvNNUHGwPn0JHiT0NjmJdVl4VpIAJ602VYrt4S1SAkWbLOinHeQvnHIWcTe2+Tsygj
         URbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pcy0MtDCE2v2WQhbuvgCLMkbkh2dXgGrD3744j14V+g=;
        b=S2n9YdCcaPKoX2NlFqToclcZK/mwCSqE47d7OoOtsmrstl65+mHSUlJtljRMJvOzfx
         8lfQcQO21GPbYT7deuPDV6fXQySnqYIoqPzou7+7cyR5cRTOH19w9fljL/NGGKlF0T/X
         vfJwSN7hJ2Ho5alQrUoLgcaFFobVzu1wqE1/PUdn7cgqlVR2iHC//kbjrPVvQpJwp+04
         Wbvmp/zpzFP48vzmu+OniDGlX4LrClKFaMJJ+m7GcC/nwOOaX3iIfUkQyWWTkRID7B64
         avJW4/9Giebi9JCUcYCgklGf7x91MtY25Mqo6GH2KhO3ezTVIXjjEwoaOr3eATDeMRV8
         dozA==
X-Gm-Message-State: AOAM532aqRQCTEv3sO6DC2pVVhldl1mS227/zA1xcMasdRejvUTLgpBi
	1sZ+1EqZwaFjF80QM3o6YJhj6xjmiLA=
X-Google-Smtp-Source: ABdhPJwF0L1pcUh4ZRww2S6r5tJtduXCvhpEywaHqlFMYZjEA/F9TfoiNapND0T8U6W3o+3iSr4ynA==
X-Received: by 2002:aa7:824e:0:b029:20a:3a1:eeda with SMTP id e14-20020aa7824e0000b029020a03a1eedamr3148978pfn.71.1620287335293;
        Thu, 06 May 2021 00:48:55 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id g15sm1314908pfv.127.2021.05.06.00.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:48:55 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 1/5] Squash to "mptcp: add csum_reqd in mptcp_out_options"
Date: Thu,  6 May 2021 15:48:42 +0800
Message-Id: <1ca01996cdfd7e70967d7895776e3ec3014c55cd.1620286893.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620286893.git.geliangtang@gmail.com>
References: <cover.1620286893.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update this patch as Mat suggested in the "MP_CAPABLE C flag" series.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index bd272c34b53c..d61bbbf11979 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -65,8 +65,8 @@ struct mptcp_out_options {
 	struct mptcp_rm_list rm_list;
 	u8 join_id;
 	u8 backup;
-	u8 reset_reason:4;
-	u8 reset_transient:1,
+	u8 reset_reason:4,
+	   reset_transient:1,
 	   csum_reqd:1;
 	u32 nonce;
 	u64 thmac;
-- 
2.31.1

