Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA270
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 04:18:39 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so4674617pjb.4
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 21:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GAsNNFF6id3sFTKwTltehaaVKBPByUiOLLz0EkI5NJ4=;
        b=bUaYxInlRqugdsSjc7LVOV2wURLoe+VgXjcJiQfNpNLPM+urq22WG+AsrMb4yBkV7p
         G47IsoZuyCgePwiDkjVPUuJ6psZ2XQJeROe/0CdxgupIzyfQZuSHuX2IvinZo+pH2duJ
         +w3sEeluqYmTbeQKhuPoVeKPEP8Hw4ytiBmWwkD8ySlf8xzj5pk94hhakNevGLTL/GZR
         kh8fSLpUycjsFdZdgHCxNmt+nSLBgf9Uohza1oVISJ3ynxm8asn/iOKj7vp0YGNP08ea
         QOgt9IYU0kOm83ymDcdVGFMP3uzWFx8463SY26PMuhsW1nVGSpOEoRJSYTY8avkrGDSu
         dBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GAsNNFF6id3sFTKwTltehaaVKBPByUiOLLz0EkI5NJ4=;
        b=XQZNGUjyk1II5TfkRfkq8ZU2OTzVvu4oxzgWvck+6zOFWuO6ZTr/M8TXebEXvrnG1f
         QYWXJzhHGA1PU5qwCZ97eJvC6Qi+/EFSNLRFDZaFZJrkFX7IiGERYvCkvJE1c21gQY07
         v9KoFHjpnqTPO2Y+kxt4HJAG2PeE5T1WnaUKlrgErEcUa8BFD6fSgUzDVaj3JA26Ha7c
         G6y7LDkwr1zP1+5wBP6fnCt36dC8UBThDXCveECLwWFzOq8Il7aWTNHIM3TR/Y/FtFBt
         9loXdY/7TNiOt9jBCnoks/LFUodSD1tmhd/Ej8xBswQcUXQgroITICxQ4uyYepcHeIjR
         VuLw==
X-Gm-Message-State: AOAM532as4HFruUSA/iG1d5CzhPFx8TfmAFnqvWndrTYDpFxM1wXRY8h
	bfbE80xSeschT5ELdf+ne3xjo24CAI4=
X-Google-Smtp-Source: ABdhPJwjgU7Qfcn9rh1cBy/D1TYyk6frd0w8VHr3PG9pnEYvbPwrKOobiX6Hq2p+M6MznY+MpuOpoQ==
X-Received: by 2002:a17:902:e88a:b029:ed:6bf3:2290 with SMTP id w10-20020a170902e88ab02900ed6bf32290mr7846695plg.20.1620361118898;
        Thu, 06 May 2021 21:18:38 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id 66sm3399307pfg.181.2021.05.06.21.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 21:18:38 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: generate the data checksum"
Date: Fri,  7 May 2021 12:18:35 +0800
Message-Id: <694573465901ea0fc5318b379af75f5287a4f77f.1620360953.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the csum_replace2 trunk into the later patch "mptcp: receive
checksum for MP_CAPABLE with data".

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index beac01f58cba..99fc21406168 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -519,9 +519,6 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 		 */
 		ext->data_fin = 1;
 		ext->data_len++;
-
-		/* the pseudo header has changed, update the csum accordingly */
-		csum_replace2(&ext->csum, htons(ext->data_len - 1), htons(ext->data_len));
 	}
 }
 
-- 
2.31.1

