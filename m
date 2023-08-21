Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E6847C
	for <mptcp@lists.linux.dev>; Mon, 21 Aug 2023 15:27:37 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so32839515e9.1
        for <mptcp@lists.linux.dev>; Mon, 21 Aug 2023 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692631655; x=1693236455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hljjb3cfrRq4ndL+1CO/uD3iiUC8IzVTwhM+dZ0bUY=;
        b=R8PT/Uowtpy/iJXLNtHR81puDZLD1dh39zf/0bPlMN0RtdqOMiK9+oMw2UP3Op3A/s
         1x0j6fNkNCTZjWLFnKclqlPN4PAaoFDTOA9u9wIHXAW5R8vwOTudfHtKuXL+/dF5gt3J
         wNiKg6YVgqUFf/NodUTabs2ChDejE2ux8ATeHkZwl0J+2SjjK4fXA3UX7PPEzDirzoR1
         ChKnMPiaQk1hie5lNugoKU9GIFRiSrc3d47zWUBG9vj+X4AVeqHTsLJ4vE2X0UttspaG
         mpNLuJCsnFfIVVc/46OsJiRCl94Mo0Dd3mvaR38mXUtpBkmsdsVk6dJM2Q8a3bcA4dKh
         dSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692631655; x=1693236455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hljjb3cfrRq4ndL+1CO/uD3iiUC8IzVTwhM+dZ0bUY=;
        b=M5tDGJ7bV8Xlx2TVA3mAH/WW40OJtktCrV31GP+S1/icwP8GTyvqY9dElT+8vRtBE4
         pIwmilOJsKtKefSVdMvd5yXWImDrWQg2GEiy9W31WPQvIiT6XzXNfoukSoRuLFyVyxES
         6fDxJ120iZTamfu3Q/V7IivSRA+Dsp/kucyfnJjtZa/k5YqOIl4dfgrrWDBxKgev4wiC
         YSf/yFHdvIRdA18HIuMa5Tkzp78rxwobSzcVtZXAFoU1R1zRkaXaxVZ2mYT1/Pm6ol/I
         0Y6KtGUrFWqnZlVtsUL+atIHpadubQw1PhcOzDdVnj17/qE2nGHQjfCp2tPxKDkcHHY9
         xa3Q==
X-Gm-Message-State: AOJu0YzzhRiNY2K61L1k2UU3GM6qyEXkQIe0P1h7TOvZI4+A1soqK0KI
	KK8ChbHq87dqj6nixifKwaxW4jxQGeNtuqhwIE2hjQ==
X-Google-Smtp-Source: AGHT+IHhXEehHQ4vz44/ssEXW6HIEeZQf8Qf6PzZHfpnOfRMnk5eWx8wrJCzbVWp4os1Vi3cVCoY3g==
X-Received: by 2002:a05:600c:2349:b0:3fe:18be:76f8 with SMTP id 9-20020a05600c234900b003fe18be76f8mr5427980wmq.38.1692631655523;
        Mon, 21 Aug 2023 08:27:35 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id a19-20020a5d4573000000b003143add4396sm12803959wrc.22.2023.08.21.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 08:27:34 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 21 Aug 2023 17:27:28 +0200
Subject: [PATCH mptcp-iproute 3/3] ss: mptcp: print missing info counters
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-3-e5d91ad566ca@tessares.net>
References: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
In-Reply-To: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=+JNQfl4yrYzDciGtueQ+DmcmUe5J2KPMT22uDiyB/OM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk44JlI8EdUT7KsEH1hqcKUsqXOqxVHFcBNYws7
 fNzHCZ1Yy2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZOOCZQAKCRD2t4JPQmmg
 c5M2EADHFyjklmNcMVaTLycA/MEA97EIrhxMhT4gv0X6WdrIT3RrBgh51lVMYnw1QsnLCaYCGrc
 3XL99VW6lqJopOfINKLfP02ShxQAePSJXT/i8Tins2wxq2cxJlEG1ANIc6ICBbPQNPFCs/Igjnf
 uWvBT9mHs03Ho+Ou7sTBhNQKLHj9OkQNpShBRKM4x9oDVGeJ0FClkPClJh3mGs8yHQkJCig3JmM
 p8m6PbEHwIO1PV8oM0LjHuMs3Sv9S2USrhIAik9bE0/6OxJYoXcllivxaXgpMGJFkDdsEoDUbku
 smN42nzjxYdyutnhhwmPJEwAVaFuaWCgT54k5+128JzLmQEfaJ51Q7iAY35rXD8+NYNSKO0ytzX
 lt5lSTE9sHf8qoCLwlJdyW3YKA1F42LQqT2WRUr0e4fnIhf6s+vb4QZPIWc1sbKG/VqDTZ5Kf2Q
 ACy8FGYLdZZaY/jmoDNv5qagB6BRt1UdpGfifvvffLpAHNBpUfw9shQnaaXJQSqmQ4UFpwMAG5/
 Qg3ibP9NgOfTPAeSlrRR4foei4s1NoTwP57mWRM6V9iodBlYmsDOUiml2xwlkXbFuKUAwE3okn5
 /eE4V17wNnyTMt9/cgDPLKHtr/YIzJkjVnAcN/yoBTCxIzad9BdtHfuI3LtWgWESizKIxiOiMIi
 E0EGtaL2sN5z9kA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These new counters have been added in different kernel versions:

- v5.12: local_addr_used, local_addr_max

- v5.13: csum_enabled

- v6.5: retransmits, bytes_retrans, bytes_sent, bytes_received,
  bytes_acked

It is interesting to display them if they are available.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/415
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 misc/ss.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/misc/ss.c b/misc/ss.c
index d1779b1d..9a6188bb 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3255,6 +3255,22 @@ static void mptcp_stats_print(struct mptcp_info *s)
 		out(" snd_una:%llu", s->mptcpi_snd_una);
 	if (s->mptcpi_rcv_nxt)
 		out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
+	if (s->mptcpi_local_addr_used)
+		out(" local_addr_used:%u", s->mptcpi_local_addr_used);
+	if (s->mptcpi_local_addr_max)
+		out(" local_addr_max:%u", s->mptcpi_local_addr_max);
+	if (s->mptcpi_csum_enabled)
+		out(" csum_enabled:%u", s->mptcpi_csum_enabled);
+	if (s->mptcpi_retransmits)
+		out(" retransmits:%u", s->mptcpi_retransmits);
+	if (s->mptcpi_bytes_retrans)
+		out(" bytes_retrans:%llu", s->mptcpi_bytes_retrans);
+	if (s->mptcpi_bytes_sent)
+		out(" bytes_sent:%llu", s->mptcpi_bytes_sent);
+	if (s->mptcpi_bytes_received)
+		out(" bytes_received:%llu", s->mptcpi_bytes_received);
+	if (s->mptcpi_bytes_acked)
+		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
 }
 
 static void mptcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,

-- 
2.40.1

