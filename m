Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC286E
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 16:21:52 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id l4so22241465ejc.10
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OA/pxSDvPxWIvDlU3QWRf+aNoo3yE9sfWQ77OD3tFG8=;
        b=YNUaBa+ThjcTqgOCEpMY7N7LoVFMDnNhT5+iuNVcNUc5UkCSPtyZI03YqGqMFtOUL0
         DfDEbjvZl8W746mQh8HDo1hYbhPAX3r+Mrqp8RxdvUeciMWPSz1355a3CsEeDzOmXaqB
         zz7TjDtSmmckVyRjWDLJ5rxZThR+coScarIdbF7mF5xFYaJvZWF5GrX1TFPkHsCQs6xH
         tddORjHtmw1a2HkME0LmVpNvsbyQ7qEWKgHlpOXEPaV5cjhQJ+rHyJhC1cuTKOyJbmcu
         +mu/HaDVwF7DqpGG0MbGAG0DTXEvNU54ly0rEJDF4PhxBa3KiLkOpt2L84VFbqxBN4NL
         /8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OA/pxSDvPxWIvDlU3QWRf+aNoo3yE9sfWQ77OD3tFG8=;
        b=UalQ5vC1nG62VNqDAYBp+8k1MJomK+wxpgRBmPIPS56pajhpHjUn76IDfhKX938qBd
         cDlNwthCGF6Z9HvFAy7bpn29IPEWOZwNHYLrBVJ+MfwydWFRi2eHZkkepDLYu9YRoWs3
         ohdsZC7kod1bLDgstQ8EkJFpD5n8l/Ia4roccYiuZheKYFUVePQs0cRxqDzglUEkQZ4I
         FHg5waudahNyMQzdszlY1ZeyitEBTGOn9oZhHK1zSsNSxd6vIck8MkzKSYr6Nm8IdGBm
         Lbgw16F2JohS3EJ4DJbHo13TbstMV29/KcHah+k+oxDRx+iP9xAlzUC8Kg6o7GajOJLV
         aU2A==
X-Gm-Message-State: AOAM530YaCBXzW43vtfrCV5DOsvAlClnrRZB14eSdfJ4HMyvSqrLqcr7
	Yrkwzr0PwQWLtjs7Zh99yyFBNwjkZG3PVefw
X-Google-Smtp-Source: ABdhPJxzA8Vd5eH5361TNJfsyA7yhpouxKpjp3HnJi19KRLXQ39oVqki/he3I5GfMb8JdGkpYiDfYA==
X-Received: by 2002:a17:906:1792:: with SMTP id t18mr605971eje.378.1616430110767;
        Mon, 22 Mar 2021 09:21:50 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id wr20sm5694136ejb.111.2021.03.22.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:21:50 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev,
	mptcp@lists.01.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 1/3] Squash to "mptcp: use mptcp_addr_info in mptcp_out_options"
Date: Mon, 22 Mar 2021 17:21:30 +0100
Message-Id: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues reported by sparse because we were doing non explicit casting
from __be16 to u16.

  net/mptcp/options.c:662:72: warning: incorrect type in argument 5 (different base types)
  net/mptcp/options.c:662:72:    expected unsigned short [usertype] port
  net/mptcp/options.c:662:72:    got restricted __be16 [usertype] port
  net/mptcp/options.c:673:73: warning: incorrect type in argument 5 (different base types)
  net/mptcp/options.c:673:73:    expected unsigned short [usertype] port
  net/mptcp/options.c:673:73:    got restricted __be16 [usertype] port
  net/mptcp/options.c:1244:62: warning: incorrect type in argument 1 (different base types)
  net/mptcp/options.c:1244:62:    expected unsigned short [usertype] val
  net/mptcp/options.c:1244:62:    got restricted __be16 [usertype] port
  net/mptcp/options.c:1253:62: warning: restricted __be16 degrades to integer

Before the mentioned commit, we were using port in u16 in
mptcp_out_options, everything was OK.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7e01f44ed885..03019a6d5059 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -659,7 +659,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 							     msk->remote_key,
 							     opts->addr.id,
 							     &opts->addr.addr,
-							     opts->addr.port);
+							     be16_to_cpu(opts->addr.port));
 		}
 	}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -670,7 +670,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 							      msk->remote_key,
 							      opts->addr.id,
 							      &opts->addr.addr6,
-							      opts->addr.port);
+							      be16_to_cpu(opts->addr.port));
 		}
 	}
 #endif
@@ -1238,10 +1238,12 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 				ptr += 2;
 			}
 		} else {
+			u16 port = be16_to_cpu(opts->addr.port);
+
 			if (opts->ahmac) {
 				u8 *bptr = (u8 *)ptr;
 
-				put_unaligned_be16(opts->addr.port, bptr);
+				put_unaligned_be16(port, bptr);
 				bptr += 2;
 				put_unaligned_be64(opts->ahmac, bptr);
 				bptr += 8;
@@ -1250,7 +1252,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
 				ptr += 3;
 			} else {
-				put_unaligned_be32(opts->addr.port << 16 |
+				put_unaligned_be32(port << 16 |
 						   TCPOPT_NOP << 8 |
 						   TCPOPT_NOP, ptr);
 				ptr += 1;
-- 
2.30.2

