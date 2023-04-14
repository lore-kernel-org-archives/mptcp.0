Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F802F2E
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 15:47:25 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so8515845wmb.3
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681487243; x=1684079243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWDTtECwsAjmhmHRuxNIr9S2DI1LKdsoQ3rswGr32ds=;
        b=T2DCjD57aRc+HD2UC5CMLxlwCrnIpr+ZgwwhHPf3yqK/ASgz6n8armT5rL08ozQSSf
         b9S4kPyCVEM5sHxPm7hs1US6/AKSuj5KaKgVSw7ZB4nYPIj/fGdm+TNV5hub2G8ooQgW
         mSe9BnrVn19slUkgQHPoExUNRCxP9UzBLstdgWWzYbSqv2hWpyymlFiFSXXMHX9H216o
         0x/i3UDr8/1WpdgwjZBFe1tE80AYJMpMb2I0QrDdoYDSS3qZrQ2lvaTUIkI38i56GNfF
         OMQ/BeFiqZnR74OCv4HM+mCjpN0REhuGkExModyFzrBJz8d3cShGkgyAOnjRxADTa1Mq
         wehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487243; x=1684079243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWDTtECwsAjmhmHRuxNIr9S2DI1LKdsoQ3rswGr32ds=;
        b=ZpkuwhwTHB8YSQ9aCVrQRTc9pJo3L2PycGcsbrApWEJIPWdLvYKHEqWJk2wCEMi3pR
         cLerFUQfrqSaZF+DYqifiQvk5/xJEJaRhmJsKa2TVLuTWZbep/7nsiRrYusj+xpaSeJa
         50WFoQzj+0V60AiO/tGlZG2KkOaZxwCNnYkTu/lKPkIMcaLyw0dHTWKo8ng3PbK7krF+
         t2e/OrRGRjE/1tuHeCV4vBwPc8CJuvV5YKrmdHlbNXZ4y+qPReR81/eyxnu5Y2nz8xT+
         mo4G7gPOeWOjivPd65FPjjlgqYzEdaLH83ZkY/SNBrJs459t9N8Q3fBNDwtar1Z3ryHL
         xyWQ==
X-Gm-Message-State: AAQBX9fA009KqxEtjLFEcpol7roaN7cCVENynCve1LcsE93etGqXCV0p
	2grl40lSPh8ZgAVbYsprB8viZw==
X-Google-Smtp-Source: AKy350Zbfb/+ETHLfVDp+FeQgfyIrS1HLwN+tktEDWnNLW6wqZcaSBxXV5L/gCAOFber58De+xX88Q==
X-Received: by 2002:a7b:c405:0:b0:3f1:4971:5cd0 with SMTP id k5-20020a7bc405000000b003f149715cd0mr1275134wmi.21.1681487243619;
        Fri, 14 Apr 2023 08:47:23 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id x2-20020a05600c21c200b003f149715cb6sm1034298wmj.10.2023.04.14.08.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:47:23 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 14 Apr 2023 17:47:09 +0200
Subject: [PATCH net-next 4/5] selftests: mptcp: remove duplicated entries
 in usage
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-4-5aa4a2e05cf2@tessares.net>
References: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-0-5aa4a2e05cf2@tessares.net>
In-Reply-To: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-0-5aa4a2e05cf2@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=OMhBvjHspE9kilhYpui/Ahqh9sFYY67x1kU+MoI9vh8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkOXWGxSGApNnBsDJeBmCH9n9JpmD9H01vkQ0zT
 Ma71ppMdhKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDl1hgAKCRD2t4JPQmmg
 c7HcD/9kxoAJMsr/I/X47DPp8WsaXxFjLUx49XD5Bb7xI2I2i3JLR3FBVv27Yhsxs8r980pmrvB
 1yP5rjDuYTatbmW743zPNUhM7sdIZ+l9l4nUsx1ahei2sMJiQdqNaNKeWP7obQPUYHUIdY7Wm1K
 WkyCeecW4EZ7QdZxIi9ZDvQ5zA9BZsVPT1rWGZWequ2zJEEB6xPjDk10CZtCFNA6jb01M/tM2qf
 otZWbcWTjbEbuhfT4uQwIROVhRf7C7MJdZ/TfzLa1LI/fXyEnYEHUU8jpcZX4XI+Mu0aCreEAAQ
 VIgfd3gJ7J7WjZLNHKSz1Nvv//srNIuwqJG1GkaahiGc46n3Pr03aL7KfuBYWGjNv/VPoVseIV5
 8u2tfDIB6yxMr/AmdVEYlEfgpw21QNkeM5A2BoTjqS5fgXUu9O4/hcd8dAgVjYuq5D/SVseuWRW
 WhLjCM37GE6UfzOq4EpLIMlcEZxq8Gn4WpZL6dt2BAaH5kao0f01lrFzLAXfbOhNViTWLdjlVMs
 OQZnvai2OPd8gDPL1I3AbrWD6fWMHs9DU5eB2VhcLF5BZg/XNUPr44ChzlumQZDzrLwzgNnFcpc
 onjrf5hhJJdXpAutmSzLhlA3hcIsuGNPb7JNksxTuZR+1/QcsHZg8RZ72gUTRRVDKJIJm8Ju6rT
 w+rT1AZepwycxEw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_connect tool was printing some duplicated entries when showing how
to use it: -j -l -r

While at it, I also:

 - moved the very few entries that were not sorted,

 - added -R that was missing since
   commit 8a4b910d005d ("mptcp: selftests: add rcvbuf set option"),

 - removed the -u parameter that has been removed in
   commit f730b65c9d85 ("selftests: mptcp: try to set mptcp ulp mode in different sk states").

No need to backport this, it is just an internal tool used by our
selftests. The help menu is mainly useful for MPTCP kernel devs.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b25a31445ded..c7f9ebeebc2c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -106,8 +106,8 @@ static struct cfg_sockopt_types cfg_sockopt_types;
 static void die_usage(void)
 {
 	fprintf(stderr, "Usage: mptcp_connect [-6] [-c cmsg] [-f offset] [-i file] [-I num] [-j] [-l] "
-		"[-m mode] [-M mark] [-o option] [-p port] [-P mode] [-j] [-l] [-r num] "
-		"[-s MPTCP|TCP] [-S num] [-r num] [-t num] [-T num] [-u] [-w sec] connect_address\n");
+		"[-m mode] [-M mark] [-o option] [-p port] [-P mode] [-r num] [-R num] "
+		"[-s MPTCP|TCP] [-S num] [-t num] [-T num] [-w sec] connect_address\n");
 	fprintf(stderr, "\t-6 use ipv6\n");
 	fprintf(stderr, "\t-c cmsg -- test cmsg type <cmsg>\n");
 	fprintf(stderr, "\t-f offset -- stop the I/O after receiving and sending the specified amount "
@@ -126,13 +126,13 @@ static void die_usage(void)
 	fprintf(stderr, "\t-p num -- use port num\n");
 	fprintf(stderr,
 		"\t-P [saveWithPeek|saveAfterPeek] -- save data with/after MSG_PEEK form tcp socket\n");
-	fprintf(stderr, "\t-t num -- set poll timeout to num\n");
-	fprintf(stderr, "\t-T num -- set expected runtime to num ms\n");
 	fprintf(stderr, "\t-r num -- enable slow mode, limiting each write to num bytes "
 		"-- for remove addr tests\n");
 	fprintf(stderr, "\t-R num -- set SO_RCVBUF to num\n");
 	fprintf(stderr, "\t-s [MPTCP|TCP] -- use mptcp(default) or tcp sockets\n");
 	fprintf(stderr, "\t-S num -- set SO_SNDBUF to num\n");
+	fprintf(stderr, "\t-t num -- set poll timeout to num\n");
+	fprintf(stderr, "\t-T num -- set expected runtime to num ms\n");
 	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
 	exit(1);
 }

-- 
2.39.2

