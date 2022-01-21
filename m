Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF129CA
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 07:39:38 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id pf13so8671454pjb.0
        for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 23:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/KI/DDN8T1ayErpxnQiZZ4iJShjEoYH/kl3zkOkoNM=;
        b=NMy5ZakHpoNnM2tGCEPIZUk5eQaDDt7d6UOXJA9Bkot8hQ8cwZWFw7AHkVV7w45aj/
         fooKSMsoNkTHHIHkKH0gBuFJR16x7IRrQdjuhm91pTk/A5qOnoOf9sp84fc88zCe0sb5
         s/V282A3oyIuK5gVHLmNNOitYm0EbJ0ffVyPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/KI/DDN8T1ayErpxnQiZZ4iJShjEoYH/kl3zkOkoNM=;
        b=hERPRui/iUmaeLnNcM9xUT34OAZjiuIzO23uR51Kb1kPpN7Jq5qk0Ymrn5ubX8V5qK
         8jQpIjEhKLMuJ7EWI0fZSdSxBvbzGCS7F3VaJV7HvvgKbhJHov2XcwyB8ebojxeOoGY6
         ZhlwEJKqlWEqlAxDMmCZ7BFij3SlRxksVcIl3qVQCRtLjEGYPvz16P/pjBX3oivCfJZo
         /n2eAYliEq5TSCy08Xhs/Wfva/nQh1m6vYVZ6O3nxPzi1qvY2AM780470KQdKRF/RFQD
         3X71KO7+Ml5xwx449jg5ylh6QfdNi0lL2BNYbeo3DIfBbqgOQ/XzFXIvl98dmYh855bm
         mnXw==
X-Gm-Message-State: AOAM532hErMnO/TLLpJtz0qshM+79FC+fWhoBc/fC5BaV4Fo8zYgCGVw
	AwGOW2eR8Ygbq7KpCHQvfPdb1g==
X-Google-Smtp-Source: ABdhPJzfwDP5KCYaZ2avm4GFVowDxl+HQFPqbIp0EUSpzjd3VONNETepWQLeksdkGayD/hvQVtkD7w==
X-Received: by 2002:a17:902:6b4a:b0:149:7c73:bd6f with SMTP id g10-20020a1709026b4a00b001497c73bd6fmr2966661plt.46.1642750777816;
        Thu, 20 Jan 2022 23:39:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t1sm6005968pfj.115.2022.01.20.23.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 23:39:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mptcp: Use struct_group() to avoid cross-field memset()
Date: Thu, 20 Jan 2022 23:39:35 -0800
Message-Id: <20220121073935.1154263-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; h=from:subject; bh=yGrVKJycM9qivlstRAt4EfHl5vdMltBdt/HqxajR6wA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh6mM3Kzvim73jJw1jchuqW5i5KKj0xFVS8nRZ1MEy YrQE6iOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYepjNwAKCRCJcvTf3G3AJmx1D/ 41qpIDOaMktPi/OXv2JS0l8Y6yahywC7M/IL2yWxJqReTyQ/TGSfDZIx+g5bsg4+CSBxEyqePyxc8I BOCEmGny2GqWbeixcRQpzODGJmidasyWIQJYr/tR4fJq/TzbkrUy8omwXlfDzWxV/f90ONw8I3ZsBv rAeik1f80B4OmkGlxhAIrihDRlxPLYdC9OAW7NKGMD+6TiK94xVMy2Md2soiznKz0zrINsMwykTi2r hjUEhUCo7zdwnew0qdn9EpMTWtRbV0X9jwaylle24dI/0xUuCnau2FYPd9CaArUKAGCwdBLNzwP05c oDcT4M5WF86HnonrnAPFmheRPU3DOKESv+0Tx0MdeAzTQdhMLoVl/rP13wvh9ivzZUxHWteCA0+WPf RrpLoCRwTxSfs6K90OQiO5HgJA0lIh2KE0EPxFxrNUWWkYo15prCPU73zqCNnj2jv+WEksf3X0LSXz upMs54qoPEovaR1/XGZ6ds0SCyPJuyQsmRj61gaHoHVS9/Y35/CfQQFuM1zYV0eStN4+Uy8yZWTpPx Hzr6CJE3nJv1JGfGjAKxLZpakcvUeH9VCxHy1/DoV+J4F4zFL5dcteTqQ2oGvPepXq61bNA5rQYa9w ZwAI/1E3+GIx2JA2dfkvqyJmBQAuQZLRaxX55hOCuJdCGHq8CxdP45lxz5Zg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() to capture the fields to be reset, so that memset()
can be appropriately bounds-checked by the compiler.

Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/mptcp/protocol.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0e6b42c76ea0..85317ce38e3f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -408,7 +408,7 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
 
-	char	reset_start[0];
+	struct_group(reset,
 
 	unsigned long avg_pacing_rate; /* protected by msk socket lock */
 	u64	local_key;
@@ -458,7 +458,7 @@ struct mptcp_subflow_context {
 
 	long	delegated_status;
 
-	char	reset_end[0];
+	);
 
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
 
@@ -494,7 +494,7 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 static inline void
 mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 {
-	memset(subflow->reset_start, 0, subflow->reset_end - subflow->reset_start);
+	memset(&subflow->reset, 0, sizeof(subflow->reset));
 	subflow->request_mptcp = 1;
 }
 
-- 
2.30.2

