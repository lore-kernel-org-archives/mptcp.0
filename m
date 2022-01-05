Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3472CA2
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 15:57:34 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id z9so93916416edm.10
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 07:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivp8ax95rhA0MAcxTz6MrRYhpRq1HirsyBfpAU4/xzI=;
        b=IMPtsuA29de9TT2WsN9+YdTeo/T/J7qx0ovp6Ezlr6d4IVRXlwKcOl5D6yG1gR19na
         QsYCOQCt76QhVWurpYD2xkMigdQ9EA1Kb6uduVq0DJ1bDpXVTlWklJlseZwapuhU38OK
         9xapr9os7oGSgzz/KceRnyTteOf4ZvTuHW9NHMAu262ZVIAEQASJgZG4NOUU/hFb0eiS
         m0eIBmAk+hNtqCF1c5faWKkaeoTZzIhBs3EU0Aeu5qIrQNbZU5WLuJcAp9OOBaGQNMuN
         KT9acQpC0nBpkMXt9RIAulO8in9kfGDjOuM8IE7Ndafp0/SxCIo6nnVWpThHIP1f3pB4
         Dfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivp8ax95rhA0MAcxTz6MrRYhpRq1HirsyBfpAU4/xzI=;
        b=YEajOW0UgR7ufvZ5L53F515x1r91wAgiRbwlcOurjiW/fSWC8NxsXEoRBp+y4urxu8
         A4VIfREOOsttaMfe3bSNhqkZzyDvVemVwPhtX0gqji2B5zewpMK1CCBohP9+H0dGw5OW
         h0gUR45lF6Qxf/+RouZIDM/bo2M37qS7iqHFTu6qwn4wnlEQZ72gj23zhwioeudBF1V8
         dfaWQA5Ghp5fTzMqysIK/m8J+gE178+zAtvYHLruqACEqshGmriDy5CmcTZFu6u+O14l
         pqYS7GCJl41qiIYWpeXy5vVejQwfQGZYDYAATsYk39OcpGMZLot5y1pQ5Cke5y2tzgMU
         SA9A==
X-Gm-Message-State: AOAM530zB+AJlc5J75SXWsJYvm9/qr7MDeGzziD3FR2A9wgC9UKNjo3M
	nBAA3/EiAjhB0Pt+6pDOo9U8Uug/EogWK/y2Hb4=
X-Google-Smtp-Source: ABdhPJyUj3G2e6e3KKSQswZLslQ6KT0dywytQSNJg7VYiYvDwXRvth0ZDhMujkmboT1+zYqNrVZwHg==
X-Received: by 2002:a17:906:2793:: with SMTP id j19mr42009708ejc.254.1641398252977;
        Wed, 05 Jan 2022 07:57:32 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id c30sm12399684ejj.190.2022.01.05.07.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:57:32 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 7/8] mptcp: print out reset infos of MP_RST
Date: Wed,  5 Jan 2022 16:57:01 +0100
Message-Id: <20220105155702.165123-8-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220105155702.165123-1-matthieu.baerts@tessares.net>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
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
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 06f64101d27b..182fb885f5e6 100644
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

