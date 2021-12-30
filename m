Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA032C80
	for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 19:17:47 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id m21so102706992edc.0
        for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 11:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugdlGyoxxcEr3RwXgTx3Zvpw14Hz/Qm+DG89uJqxLIo=;
        b=eZn1UZI8o1b6/hQFtUBiMCT8z9hg5qF65QLk261qNxiVOfOSvdEhqRNwGQ19RbpIPp
         EhsN9HpduDHEd0BBS8nHnV3YgCZ2vkTbP4Huev7JakWeKDGBx7/7Kv2i82LzWQOt79F3
         FAQ4ZvMbpKyS2Pr9inG1mapuFVeMPFpiwoQsBn/VZhvpYuS0uEgs6IdjZE21VrvY9GFt
         +mItoNBKEL275FpQ3CTqNI+wrwBEFkXUZY2q5HKRERRX1wRGiVr8DVZvARbAgR3ho2/1
         i5ifW2SpJqLliCdOiDM+ylCthvemxOrseUyVIhuiLK02+P31ksftlIXgIc3D2yKoR4Ws
         RB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugdlGyoxxcEr3RwXgTx3Zvpw14Hz/Qm+DG89uJqxLIo=;
        b=A99ygGVB+KztLRgHFeBPOZui12L4bDl08S5dTjAjB30YIXSQU+9XDWoblTvDRZr0oc
         332v/B/ILWfmKQm6GBbdokGF8aAZ4PD3VIqWyH7J1IIKeTClOvlXzkYJGjY+pyCm+KVC
         5u4QN0JdKUG6Jvmgz7Adcx4KVG7Zo++8xjIxaPUcsMxtCyezvnANeFR7APB0LELiuDJz
         IXnTkojsUGLxETpF/PRFUTH7AzDqVmGTzJ+utOABGQZYH8RWkMa8lW+J/B2Y5paiWTAA
         BK0F/cW7HKhhTr3pwhFq0hlj/XGgmWO3Iw2VW5qCtR03VwUBhPWK0LEpU/Zei835Kem1
         Ehjg==
X-Gm-Message-State: AOAM531mDHNj0Qyr0i14jcTD1mcdtwp7GvKtH9U6qMdKoNxov+iGqaLD
	EFMEPbXVZwZydkqSb2ZnbjQKTlBESikdOINQ
X-Google-Smtp-Source: ABdhPJwvJuxiXR7JG1noG7P9KbrISaJ1ou7OGQXf409OMxHklEtA4s8MCEdrh9bG3f+WEO/H4vWHLA==
X-Received: by 2002:a17:907:7282:: with SMTP id dt2mr25592372ejc.653.1640891865639;
        Thu, 30 Dec 2021 11:17:45 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id m6sm9918244edc.36.2021.12.30.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:17:45 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 2/4] mptcp: print out reset infos of MP_RST
Date: Thu, 30 Dec 2021 20:16:49 +0100
Message-Id: <20211230191651.1831507-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
References: <20211230191651.1831507-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch printed out the reset infos, reset_transient and reset_reason,
of MP_RST in mptcp_parse_option() to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9d2c1c9edbe6..3427b31c0da7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -336,6 +336,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		flags = *ptr++;
 		mp_opt->reset_transient = flags & MPTCP_RST_TRANSIENT;
 		mp_opt->reset_reason = *ptr;
+		pr_debug("MP_RST: transient=%u reason=%u",
+			 mp_opt->reset_transient, mp_opt->reset_reason);
 		break;
 
 	case MPTCPOPT_MP_FAIL:
-- 
2.33.1

