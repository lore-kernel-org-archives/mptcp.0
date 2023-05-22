Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947214277
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:22 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f606a89795so9757495e9.2
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773501; x=1687365501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRdcnAYRLQ3c0s+J28sFDIiH5JEZCF4I77YILf6D1KQ=;
        b=4JQfft+Zu8BVkyJA2Lh+OOogm8TrH1mGDA8QW/O+GvskKEeKAmG150IOQn+qLg5h9S
         Lt9KUfcx//T3NQoK4oDqOfyCH+88jTlNz1xXtJK8xFU/Biyq4UJ6JAHe//vDzguOyZII
         nYVQx4vXfzpQC0NKf2g0F615cL2KJyBXWhpGrUEEVGTzLssJkhXUBC4TWWHppoI83kLx
         AWsxjp/4lrDNKMiZOXQQmDqkEEyrif/K8RAaYUvRr8z/ITHkuu0gLOnduBF94Xhjj6Dn
         l3Oa3oWJynfhtXUrHM52eUfHKo7TzDWG9YP4maBcb0IjmutCiekU9pceKasERQKCW9EO
         6IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773501; x=1687365501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRdcnAYRLQ3c0s+J28sFDIiH5JEZCF4I77YILf6D1KQ=;
        b=AGCI1ppUATQzjjiF3Ho4rb+Cy/7nutqltBORUIwelPV/bvQP4W7ari4koU3dHPqup0
         Wh+AA3MeSeZmyIA8bzlmexvbDFkM6Tb3x4IwLGEChyyX+kdlJdyHckYFIFUGOeNO94X3
         mqSYBGYR+NVFN0eYPtF85oocQ5yQKmnGAdDVN7HTd+uGIZge8gFDJTPixu7qmtNT0SOs
         U3nTU/LoX6IzovKhlCRIRsQ2TNfSJZKVulFa9sdd741+tzXl6KPgW4KQhBhlQCRiUCZD
         B8y2A40fOkJySg6Kw94kP/BcWyTwgi2GLNMehVJ2gDomKmzRLCT1kE8AEeVIxlF1uTGa
         YZXA==
X-Gm-Message-State: AC+VfDy4B+wDu6MWaqiKqteXn6ZSGkCbG1wZHnsXnbkFn5t6N+VdwatE
	7ECPwv6b2XwepjISAZu9PgW7jPSajgROIiAC6+DhOw==
X-Google-Smtp-Source: ACHHUZ4pHczOV+wEgXB96/TQwRom92BAu+zyIvt0SNzpgskhyahkXAaFm5GLAl1cHW6BNwEE4cPc0A==
X-Received: by 2002:a1c:f217:0:b0:3f4:2c71:b9ad with SMTP id s23-20020a1cf217000000b003f42c71b9admr8184745wmc.30.1684773500907;
        Mon, 22 May 2023 09:38:20 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:20 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:46 +0200
Subject: [PATCH mptcp-net v2 14/37] selftests: mptcp: diag: skip inuse
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-14-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=3jTbimzQize+d4RXaNGIa2DEkBgDmaDPaIBUUhQFATY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pw15TPhRIE94HrobcFOcrAufF0eD6mAZRta
 WF1EMJbdbyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 cz1kD/9INWGbk6z8Jy3awaQLl9EsOgeXDfD3QnbzRLLqYRSrx5wvfyntXEduji9DJ0hnMYS7YCs
 qTvtssOHCZgmeVAQ4jB/xmQEx5owwArp3UQp1wi1AlfUOGli4X2RIhwxTeF7bi5IaBEkRt1hyxz
 fxMmMWsO7ARy+T4gkoYmO+LOwWd825P/HmKv3qX9p5CnVkL+SaA0pInAw+aUUF4Chd3IdLldGxU
 IopsAi0SAVdgqZMyh/PrlzLar+jyTds7rgpvc6BOzcOHlXxmwR9lcRnE6E6Ghmz2ak7GksgyEuW
 XTtQeqjG9BCPWCWVoYUTadXya0PxsNw8/8XMegCnOTxwrQuhrQeitfTXhHuO4rtQ5ZwFd/2hqDc
 QnwS2wmTAnbg+f4Mdtl0h3HQKlM7R4E3lcHyKnAorZXaw25x2UNKBzNZK1OXxkswtyka6jB511i
 0gqa8Kpx1T9/CFm2gZO0D+H4HfUIzs1Hu/IejDHz9+85WIvxQVr6w0za8kc+a99dAMqymeEMprz
 EoE0If0mq6rJ/mT5p+cG9hiDCBr+L4Megk0QQa6WmASKqWp/Guy0WlQTZ8bP0qNsiYSKm9TbK99
 QE9+FJU0EG2ZnC72SUbgaCyOwqeb/bNuc4nLlRlmGEnx8TxFt3hgutLlXGAKSRyNtIqGbowXT0k
 GeiZh13EHljHZ3g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the reporting of the MPTCP sockets being used, introduced
by commit c558246ee73e ("mptcp: add statistics for mptcp socket in use").

Similar to the parent commit, it looks like there is no good pre-check
to do here, i.e. dedicated function available in kallsyms. Instead, we
try to get info and if nothing is returned, the test is marked as
skipped.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: e04a30f78809 ("selftest: mptcp: add test for mptcp socket in use")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4a6165389b74..fa9e09ad97d9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -173,7 +173,7 @@ chk_msk_inuse()
 		sleep 0.1
 	done
 
-	__chk_nr get_msk_inuse $expected "$msg"
+	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
 # $1: ns, $2: port

-- 
2.39.2

