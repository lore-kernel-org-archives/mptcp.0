Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FED2CA2
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 15:57:32 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id m21so165021747edc.0
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 07:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZRucwN/iu3JhRKyQBm7cwK6+MBX/OabN6ofIvRd0nQ=;
        b=GfGgRMnvMinVLkUPdGS8nQKDqMYzbAFaQEufsu3NKUNo/lcbzLKWGvoBIxoQ+LSc/3
         VNlwQbfLs8k+w1fsHCH53VM0cQPceGi23LfvpLSdF5Shuk44kDfuQNCUG4Fjy+uCaiWr
         EbN/D0adfCVE6lAw6iqfYpN3MmvDGvedXDLmeh9XYz8NNz/M4skIP9RJ3Ka2QtQIEHbv
         N/hPY63yvqPIgHXhCUwDONq1BF3tPDokdNfI6kBnREPoJyFPdE0C4tojZtwiU4kuNtLy
         y72u6Oj+aBlXGMx2GZAIB4b1uoZqk4bdk3qFZyQKS/CdvA565gSSexDwPPdThqRECoq9
         C9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZRucwN/iu3JhRKyQBm7cwK6+MBX/OabN6ofIvRd0nQ=;
        b=AgyrpzCcQUtUE1iymOYSXFdsEe0zN2ixSLzq34L5HjxupmZ3EELWha7rHWQHJu67Bp
         h/WoLKbVZeN9WCJRykFRnjqasYrqEpitGHZsWxaEFR1DBaMx9JJSgRC1HptFzrtVB7e2
         s0cGy9qkt//NryrjtHqSgOTRr2fIHZiV82tCUlHI/y6rg9hwcmZ6tK9+NkZbPYjw9LyH
         LfJjNb+rJ+7nTWhrnqAGbDiJe4QwmaiNy5AtFFpCxHvhK8euq1FQ1yIexZeVdEj2mMao
         UGD7PQUbBRKObVMn3mEup5DYaZrJ0VgEFT4Ax/sd0lf6A/W20WXcUZoFKnhj0YHqiEzj
         J4EA==
X-Gm-Message-State: AOAM531jf6u1f8+PyZukZgljjtCVhg046VUbzC3rF12zXh5URxgu+B9u
	60wJowZRWuNVyctsdDKg2A7CS+tbgmL5bHD9OCU=
X-Google-Smtp-Source: ABdhPJz4fciRRhe6zdEwdh0xHXXRTwfn6OvJRjGCxAUMWdFKrspY8/Jr0qZMhUwDNqdtORvEujt+kg==
X-Received: by 2002:a17:906:7954:: with SMTP id l20mr42833590ejo.358.1641398250744;
        Wed, 05 Jan 2022 07:57:30 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id c30sm12399684ejj.190.2022.01.05.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:57:30 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 3/8] mptcp: fix a DSS option writing error
Date: Wed,  5 Jan 2022 16:56:57 +0100
Message-Id: <20220105155702.165123-4-matthieu.baerts@tessares.net>
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

'ptr += 1;' was omitted in the original code.

If the DSS is the last option -- which is what we have most of the
time -- that's not an issue.

Fixes: 1bff1e43a30e ("mptcp: optimize out option generation")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 36ab69906af3..bbf61dedb4b5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1334,6 +1334,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 			}
+			ptr += 1;
 		}
 	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
-- 
2.33.1

