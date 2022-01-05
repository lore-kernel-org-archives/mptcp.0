Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890672CA0
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 15:57:31 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id q14so156035748edi.3
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 07:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1DYnJ6GiDDCb36cp6Mrm9pK+SQp1df2TyTcvRE0MlOc=;
        b=2bZQQbMgOu1vwuqwCyg4Rlyv75t9YUQgUoWSa+m4S/fbA7VPOwOSDIF2rlvoFhEPqQ
         eA6qhLrXWlmcYvJlcDYtK9qF7qcYs50xnMnJ7lgxMqPPoUkm9n3ABGl++7Z3Pf0jC208
         H7RWDshjO6qgPZi5vI5Dpsajr8DbMlOS8x28uCJlduSV9JDy0RQX+yj0fh+hgeG1oKSU
         2FHyGHGnHmOibFRLauRdtAvOXabpf2Y6WZo+qzl5UTHRAXGFyWSSOUkmdBQMyjz5KvDk
         H2Io/BaCMxEBN4JHdng6U1lD+AYUMy1kFPd51/qAgFPvcy+Jc5r1UUkiiCvjaTKzdvWo
         HdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DYnJ6GiDDCb36cp6Mrm9pK+SQp1df2TyTcvRE0MlOc=;
        b=J+a0bnlUKechLe1SEAZZCuMMSDrhnh/ybbk0Mc70R5tPRXNqoE75EeV9+/ayb0veRv
         3/VISgNlB9qBpAqPNoUpKiZHDD50QBA4SRHt5Wykwbbb6fb1/jOBhvzYiuHZEsu5Os9k
         d5Vgn/7WlJ43OoxizCczhNcQAzQUQZnNvr9EPg4ubcvEHrk+/fbSmOT4K/NSg/95AuzY
         l5sHiBlZfcmXGZ8ndVGiPMfAdvrmKi+pF9SmxsMwMotqsGWcQSHjOCfzXL3H1LvsRAfE
         nAUZDo1ukeDQO5h+SgXIcaPpShJ/OTgbpIJp0tvEHIpqbmmO2pDe81+GtM1zWtT4K+K1
         /xJw==
X-Gm-Message-State: AOAM533n9QZDTJf2b9CT27YSHgDb3JKgSrEa1fiqvHM/QvslB5KFV1vK
	CN/DOW39bEZyUwoGUM3HQ6JyPeLLNDLBOZEyWMg=
X-Google-Smtp-Source: ABdhPJyc06vcNvLJSkdINem5rfeVEXoxIxzy9O7SB/vV1WLHPRJjDt6t1S40TL+fZ8WnDYaEO5piCg==
X-Received: by 2002:aa7:c481:: with SMTP id m1mr52683100edq.204.1641398249649;
        Wed, 05 Jan 2022 07:57:29 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id c30sm12399684ejj.190.2022.01.05.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:57:29 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 1/8] Squash to "mptcp: implement fastclose xmit path"
Date: Wed,  5 Jan 2022 16:56:55 +0100
Message-Id: <20220105155702.165123-2-matthieu.baerts@tessares.net>
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

MP_FAIL can be sent with RST or DSS, and FASTCLOSE can be sent with
RST too. So we should use a similar xmit logic for FASTCLOSE and
MP_FAIL in both mptcp_write_options() and mptcp_established_options*().

Cc: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---

Notes:
    v8:
     - 'ptr += 2;' was missing for FastClose (Geliang)
     - moving the MP_FAIL option is now in a dedicated patch
       ("mptcp: reduce branching when writing MP_FAIL option")

 net/mptcp/options.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c6726e8389ec..aa3ed37bc59a 100644
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
@@ -1460,19 +1464,23 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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

