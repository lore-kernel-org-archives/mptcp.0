Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446992C80
	for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 19:17:43 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id j6so101336357edw.12
        for <mptcp@lists.linux.dev>; Thu, 30 Dec 2021 11:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=coY5IWE8WsTmu8wB43g2Fb20MGtXGQRTSRhx9pY0gGI=;
        b=XLMBtY2xp2TziK+S4vk6NyzDOiY94RpqxwpKqTBbYkZWy+LNoOoL0eLIaMItzumPnO
         x879NBGR7+aaLb62Ilt9dcgfUbLRSGTqLp1+l+MQJNVUYFlGhG6gktseJVfYyQ0B239L
         Z+AqcHtfxoY4UztGaXPVauxNn8/GilbM/wY23jylx9XovPq01Xiwvwh/yEgKXNc9Q1Vm
         5rNm9DaK0qzw3O2yOoLjoro5FsknsOId+gj2LlQiMYhZKT9SvUha2CAyQtU/Cjnp5DlC
         Jjth0mreRPyd1TJYkBR8se9uHd9hHVZojWbhOOeVWa3DdR1qNtWSlnKd4vZT59p4XJVQ
         Szrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=coY5IWE8WsTmu8wB43g2Fb20MGtXGQRTSRhx9pY0gGI=;
        b=Tcv84Q+buVE9PL2T57gsWAi8oWSd4i+QDGThXNjaOaK9W1GfUD/vwTPBGJd0riVFw4
         HhzIW+sziQamdroxhfsSc6mlXR0gCbeKX++sWwcxyqw8WID3IWZ5CUHvntHxc4EVsaI6
         HnI/5Ri+0OYQYDPmta/sG3k00mnmFHHhKBWRo5wi23RfrPuEco3QvKO0a81T5QEUP/iq
         uORL//Hd2LPaWul3xA7VQdODbggjKs7kLAjjp4RPg/XKxCymmErhRihtX5IiBiLHfDTy
         4Gc2RWp0vHw2WIiZlUrqQm5WaPcP23PFUWMdK4BFeBziuMi4/XLgvBWucU91e7sYw+Zs
         pGDA==
X-Gm-Message-State: AOAM532Av/mwWB5EsA6vs2ySRdDwYGEMy2XZWGV3nD2P7o60M/0xhrrp
	t8nSpoWDpdsv3aWtlJqft4kL+PLqLdVazw2P
X-Google-Smtp-Source: ABdhPJx0OyRcaarl39Gx+ALxwEoFHgLSir2WZMuB0GBISxmcyRP7fY422VqvO80JbNL1Tf00L1UEZw==
X-Received: by 2002:a17:906:5d01:: with SMTP id g1mr25947538ejt.219.1640891861088;
        Thu, 30 Dec 2021 11:17:41 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id m6sm9918244edc.36.2021.12.30.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:17:40 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v7 1/4] Squash to "mptcp: implement fastclose xmit path"
Date: Thu, 30 Dec 2021 20:16:48 +0100
Message-Id: <20211230191651.1831507-2-matthieu.baerts@tessares.net>
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

MP_FAIL could be sent with RST or DSS, and FASTCLOSE can be sent with
RST too. So we should use a similar xmit logic for FASTCLOSE and
MP_FAIL in both mptcp_write_options() and mptcp_established_options*().

Cc: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 66 ++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c6726e8389ec..9d2c1c9edbe6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -829,8 +829,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
-		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
-		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
+		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+			*size += opt_size;
+			remaining -= opt_size;
+		}
+		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
+		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
 			*size += opt_size;
 			remaining -= opt_size;
 		}
@@ -1257,21 +1261,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
-	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
-		const struct sock *ssk = (const struct sock *)tp;
-		struct mptcp_subflow_context *subflow;
-
-		subflow = mptcp_subflow_ctx(ssk);
-		subflow->send_mp_fail = 0;
-
-		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
-				      TCPOLEN_MPTCP_FAIL,
-				      0, 0);
-		put_unaligned_be64(opts->fail_seq, ptr);
-		ptr += 2;
-	}
-
-	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
+	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
 	 * see mptcp_established_options*()
 	 */
 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
@@ -1328,6 +1318,10 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 			}
 		}
+
+		/* We might need to add MP_FAIL options in rare cases */
+		if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
+			goto mp_fail;
 	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
@@ -1460,19 +1454,41 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 				ptr += 1;
 			}
 		}
-	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
-		/* RST is mutually exclusive with everything else */
-		*ptr++ = mptcp_option(MPTCPOPT_RST,
-				      TCPOLEN_MPTCP_RST,
-				      opts->reset_transient,
-				      opts->reset_reason);
-		return;
 	} else if (unlikely(OPTION_MPTCP_FASTCLOSE & opts->suboptions)) {
-		/* FASTCLOSE is mutually exclusive with everything else */
+		/* FASTCLOSE is mutually exclusive with others except RST */
 		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
 				      TCPOLEN_MPTCP_FASTCLOSE,
 				      0, 0);
 		put_unaligned_be64(opts->rcvr_key, ptr);
+
+		if (OPTION_MPTCP_RST & opts->suboptions)
+			goto mp_rst;
+		return;
+	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions))
+mp_fail:
+	{
+		/* MP_FAIL is mutually exclusive with others except RST */
+		const struct sock *ssk = (const struct sock *)tp;
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx(ssk);
+		subflow->send_mp_fail = 0;
+
+		*ptr++ = mptcp_option(MPTCPOPT_MP_FAIL,
+				      TCPOLEN_MPTCP_FAIL,
+				      0, 0);
+		put_unaligned_be64(opts->fail_seq, ptr);
+		ptr += 2;
+
+		if (OPTION_MPTCP_RST & opts->suboptions)
+			goto mp_rst;
+		return;
+	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
+mp_rst:
+		*ptr++ = mptcp_option(MPTCPOPT_RST,
+				      TCPOLEN_MPTCP_RST,
+				      opts->reset_transient,
+				      opts->reset_reason);
 		return;
 	}
 
-- 
2.33.1

