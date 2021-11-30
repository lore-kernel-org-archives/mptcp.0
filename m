Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADE2C80
	for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 16:55:41 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso20057980wmr.4
        for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 08:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXkIPBO2RK5jCjLXEJRFPslWxnaegU1Uqwva8W7upAk=;
        b=MhwNnXfu9NiP2WJhwG3wN9iznnJcuhp0Z7e3+3A5FipGzXkXgyGpehPexgir6QN0xD
         xZWBBuMYLcxXVERShRF5uUgr5fnzOQ+hpuqBndHQ5ZD0MaUI6KIvbPnAG8CWJh6+4UUH
         GrULNyi8oFO1OXC6Fimv5TmXtvRqjGY1pDkmFVN0568QiTxXADZx17npOhWouXiXNOCM
         IZwdznxmrLw7CaBvn04zTROCpaA5PkJpB2lkFtWM+4CvbmdbNi264VCQWhIOTCKRgOPV
         I+z0vJyHaa7GfxAPYETW8vEcvy/wSdwZl2mcXmQUGRlyOdKqsrWetKoppn5UWuECG3tu
         xknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXkIPBO2RK5jCjLXEJRFPslWxnaegU1Uqwva8W7upAk=;
        b=vVkVykK6amYdta3RZs6AuJieVX5MCb94twNWvpAdE8OTVRiQykZbJGthVAErgtIpGQ
         SISw2Bd1HLwcKhdULb79KDirIXXWcMzuvxHgfM5v0EFGDUSXXXv+Cw2SNanfHpQERoT1
         mDytyvzVXiR9626tBU3kzET/PKQ7rd658lJL3OIw2zR6rQV5SwzbODcpXYD4KoJVxxyC
         fmg1+i8f4qPFndGaga5WOn6ews2GfSYAn5vozfUuW6niMLZ+5JtvVfnAVvD/FZASKZ7n
         fCBs/T4VcfAyDDFN4GDHa7Rz8GUUBbToym38UIfF1U2UKlQ0LMeidgC8LorS3f/JOQDX
         OEHg==
X-Gm-Message-State: AOAM531c31bn2cK+agw/98/LMKJYFanSoXsH7MBoFx5NSZMrPyRBqfo+
	u3J/PT7puRa1453s2+mL0mBzVXjnMYiehwVD
X-Google-Smtp-Source: ABdhPJxdriKJLxRzGRa0K65ASe8TXyz9Yh2DAMpriRSFPKC0DeBLW61G+2XuuQS0g/zqrkKk9bLwsQ==
X-Received: by 2002:a05:600c:5101:: with SMTP id o1mr727971wms.81.1638291340219;
        Tue, 30 Nov 2021 08:55:40 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id z14sm18012570wrp.70.2021.11.30.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:55:39 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: implement fastclose xmit path"
Date: Tue, 30 Nov 2021 17:55:27 +0100
Message-Id: <20211130165527.1506827-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <e7427851-a812-05b7-6441-cb9e6f61e65c@tessares.net>
References: <e7427851-a812-05b7-6441-cb9e6f61e65c@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is linked to Geliang's patch with the same title.

If I understand the RFC properly, we can use MP_RST with an MP_FASTCLOSE
and an MP_FAIL (or none of them) but we cannot use MP_FASTCLOSE and
MP_FAIL together.

This patch implements this logic in both mptcp_established_options() and
mptcp_write_options(). Before this patch, the first function was not
allowing any of these 3 options to be used at the same time while the
second one was allowing MP_FAIL to be used with either MP_FASTCLOSE or
MP_RST.

Small note: I tried to keep Paolo's idea of reducing conditions for
"normal" options by moving MP_RST at the end and allow to jump there
from MP_FAIL and MP_FASTCLOSE but I'm not sure it makes it easy to read
and really improves perfs. We can also move MP_RST check at the
beginning.

@Geliang: feel free to re-use this patch if it looks OK to you.

PS: I didn't try this patch, just quickly wrote it to better explain
what I had in mind.

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "mptcp: implement fastclose xmit path"

 net/mptcp/options.c | 62 +++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1020e4285c..07091971a51a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -829,11 +829,17 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
-		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
-		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
+		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
 			*size += opt_size;
 			remaining -= opt_size;
 		}
+
+		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
+		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
+			*size += opt_size;
+			remaining -= opt_size;
+		}
+
 		return true;
 	}
 
@@ -1257,21 +1263,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
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
@@ -1458,19 +1450,39 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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
+	} else if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
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
+		return
+	} else if (unlikely(OPTION_MPTCP_RST & opts->suboptions)) {
+mp_rst:
+		*ptr++ = mptcp_option(MPTCPOPT_RST,
+				      TCPOLEN_MPTCP_RST,
+				      opts->reset_transient,
+				      opts->reset_reason);
 		return;
 	}
 
-- 
2.32.0

