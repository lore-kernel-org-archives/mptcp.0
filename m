Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970092596
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:06:10 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id m4so1137678wrr.5
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ish+TqBi/Plbhxxhgaos5IvZaiLo9fUwYHyVNLMFGWk=;
        b=mK4dIesbxiNRucwvhFc2C5nkxqjmFYqR76YItMG0T32PFOcAlzBq7lsasAUf5TjEaq
         kzUhAqdj/sRQCfpN1EwON1nEKgNAI5fuTCQTIvwvoYh0pMYFMrVZu2Olzr8v5cUTbJ0J
         bPvQSY6hp6NtzH1lzHtViIcSPk5jeqk7/s3FGzpEv0/7MeL9b+jtnL+nU3/04YCp9Ge+
         0HR/5UdyXcquBJyor8TlPfUTEoQ8YIVy1CldwNTERV9hluq5Xu9TbGy7ckG/+Epm0gP4
         2yPpvlW4m3rO3rx32Ppgm3QL8tKtskMpPyIBw4ihX3N7Uoks1o1xJQsiWOEOhcIuaKH2
         1toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ish+TqBi/Plbhxxhgaos5IvZaiLo9fUwYHyVNLMFGWk=;
        b=Pw1NaSscl9KGPsSEvC1k7m2xMDCRCaDNlNp4mnnuewx+p+W2rW1d2uV89hRymytjVb
         teEYWYV1CpaWPLpcj97AoU8oaatgwPh28L7yGUX52RXjUhBePW7apXbOfZLxDsPL+tq9
         BJuIOhnHZe0kVG7c78MpSzZoNKXtYUM7rQJeMFF6H0FdUREdQ8UjZRMUnS55o/8hCGtm
         M0NbBxLZH0T7iktnAULyldJ//MBbi2J+15FLYhDn7rar77+rTS2sXuNxYqxuzuFRfFkp
         5jjWCwcTRZ5odU5+agFq6iIADVjgCLULtxI1BklZzrXYPwZ9biw5+lnzqHdmJxUOOUEw
         sY5w==
X-Gm-Message-State: ACrzQf3NLd3+zcIyCh37rK0uWs56kTrod2+kx4+g32DU3l1nNHHW+f7T
	HcHROH5XGHLZN0P2EH/OsAdbse55iwYIHjpZdy0=
X-Google-Smtp-Source: AMsMyM6EXnhL/QhnbPf5CQNFDqRd3Edc4ZXz6pNgo+OkaG+2z3EDkEvr40eBr7rBWNlmOEW1icZ9mg==
X-Received: by 2002:a5d:4444:0:b0:22a:2a64:a0fd with SMTP id x4-20020a5d4444000000b0022a2a64a0fdmr17524856wrr.293.1664291167955;
        Tue, 27 Sep 2022 08:06:07 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bx31-20020a5d5b1f000000b0022a2bacabbasm2101430wrb.31.2022.09.27.08.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:06:07 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/2] mptcp: add TCP_FASTOPEN_NO_COOKIE support
Date: Tue, 27 Sep 2022 17:03:06 +0200
Message-Id: <20220927150306.1552795-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220927150306.1552795-1-matthieu.baerts@tessares.net>
References: <20220927150306.1552795-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=/ha3+L6AJvjm1E03ePr9GE4DbkFeWB3H8TzpDywkPm8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjMw+2KVFQr0EmWhbreZnPRf+qMwc5eGTuUK5qD5dV
 v57Wl4uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCYzMPtgAKCRD2t4JPQmmgczAnD/
 9ypl366nEEteG2OVYn3DMCP3O1H0SO0jcrwYV63m1QqlP0uOvrmmYmjRYwUcIFdGoH4tqKHRg6POwU
 xN2IBVPVh03BTggDnvmc8A7Q0b38ixUOjk/BdPv/G378+VHKIz7JoBEtfe0YX7/oTenUZFJBnWVKid
 L+GbMRmPrquOqgqciw2qlnh0j+X6KMjDKl3KsSFYlZHE1Awtn/4SO3VpHb0peaHRoyXfMfySP5zrkH
 W85tqXAvyJGy90SyLCYG/2gJ9im7nHygx4S2bh2MptYzOwmIEwtZh0TSJSCFPu6au79ufgKLfVQomt
 tCfmEa+NIebUeTBHkCJj9UamrVhyd+N2jH9rkwwnxZWzwe5VC2j2S5AsuMBeD3GnpC6Agl+ySMF4HR
 WHWGzJJMmnQ9pzoGQqstdXu0vGDCJoghip2zpTTs/S97p+Fm4FpUwDlAdKiA08cv0N1WqoNxXxe9pB
 A6hdRrXB1AlX4rwebs1juPHua1MI3La1Y7zJRloS0BxAIWl58eTbBVyvLXSEfdSFIv1qWb8vfRJErn
 3coJxhqVGjc2TUfZmiyALPQd/cajBRZIC/1K/SpM9mVZbl4Q/B4Y8xm5kA9bHvO1L3ZlhZVEeGVBsx
 Az3jQaz97KHJ72KmaUnxOWMeXIygLeZofHfdtccIwRfUZmwmx78wFpFoehtw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The goal of this socket option is to configure MPTCP + TFO without
cookie per socket.

It was already possible to enable TFO without a cookie per netns by
setting net.ipv4.tcp_fastopen sysctl knob to the right value. Per route
was also supported by setting 'fastopen_no_cookie' option. This patch
adds a per socket support like it is possible to do with TCP thanks to
TCP_FASTOPEN_NO_COOKIE socket option.

The only thing to do here is to relay the request to the first subflow
like it is already done for TCP_FASTOPEN_CONNECT.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8d3b09d75c3a..1857281a0dd5 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -560,6 +560,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_TX_DELAY:
 		case TCP_INQ:
 		case TCP_FASTOPEN_CONNECT:
+		case TCP_FASTOPEN_NO_COOKIE:
 			return true;
 		}
 
@@ -568,8 +569,8 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
 		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
 		 */
-		/* TCP_FASTOPEN_KEY, TCP_FASTOPEN, TCP_FASTOPEN_NO_COOKIE,
-		 * are not supported fastopen is currently unsupported
+		/* TCP_FASTOPEN_KEY, TCP_FASTOPEN are not supported because
+		 * fastopen for the listener side is currently unsupported
 		 */
 	}
 	return false;
@@ -811,6 +812,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_DEFER_ACCEPT:
 		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
 	case TCP_FASTOPEN_CONNECT:
+	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	}
@@ -1175,6 +1177,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_CC_INFO:
 	case TCP_DEFER_ACCEPT:
 	case TCP_FASTOPEN_CONNECT:
+	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
-- 
2.37.2

