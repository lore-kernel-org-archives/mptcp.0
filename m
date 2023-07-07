Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43F107AD
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 16:00:29 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso21928765e9.0
        for <mptcp@lists.linux.dev>; Fri, 07 Jul 2023 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688745627; x=1691337627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkHge0rkKG2/PW/SMFkc+m6KHSEISwSWDC4wQW6IX18=;
        b=M0beoubqsabjPathcuROd0UUVMo5zRbE+07kmzMGMpCh6qDRMXOu0o1Uwh/wqlAL/N
         wUndvZIEGvF7QeDstQbflHQxOh/Q4L8dyIxu+nzx01iPXpWw2izqFQsG6C6Cp9bhlmCX
         ZE8neS6akneQzD8pVKBb2hDkgWogYGcm9X2rqA3DwqtEqV3+tINSv8r1uPqjvAD0dKMQ
         JlyTfzv0ZweQhJj9d0HxcGQCTbcXX3sJfvj/OTX4Pu+WoavSG4Q4ql+7oWloiNl4pSBG
         oHReyYm+mnGcp6KgMusB0j6ZY7V6zRdv19KbehZTJmfDLVQepEbPoibU9SgSFTDtckbf
         Tr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745627; x=1691337627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkHge0rkKG2/PW/SMFkc+m6KHSEISwSWDC4wQW6IX18=;
        b=XZPhUJKmB7Iuwx02uitbvfJw73HNbqmeRqjGa3xnbUWtr+MxZkEwk2Z+pWHBZZArIc
         2fcvplyV2zJ2z9z+9b2MuyAsUPd0hjRl2Qix5TEUbHCLM+NyKRVw073Cur/sxhqiAUZS
         EMqSNPskRDM+unLRWo0EgrTYxEilPGxwehtOVPmnaCD3TsSc2e3n8dcMZP7jk68DVAAc
         daGeJwaDXoMRyMIKWdK4ZJXa/9qgNe64dIwMR80C8EEHa13paq/5kiQb5gN7srFXQ0bK
         B2gF98NMjLr/Lc7yIT/u1g+8h8xVpySeXuA5rxsh43xAuFtht4vnJsXvfM6K6F+aUuIL
         C97g==
X-Gm-Message-State: ABy/qLZODNbfHiEDW9A3DHUeChUzemr44Ktik9YP3ApyhddSX7ECSc1E
	l1klfZzrRqNT8uKhJapwNS0oeITSGz8eqrRmNdY6oA==
X-Google-Smtp-Source: APBJJlGETLsw/PtI5b6cfazfsWCHuHf+5dqeRuHn1JErjT0tB389F0Tt2R6v3Q+jt2hxpbyux+vuXw==
X-Received: by 2002:a7b:c387:0:b0:3fb:ac9c:e6f with SMTP id s7-20020a7bc387000000b003fbac9c0e6fmr4319300wmj.38.1688745627637;
        Fri, 07 Jul 2023 09:00:27 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c108b00b003fba137857esm2829186wmd.14.2023.07.07.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:00:27 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Jul 2023 18:00:14 +0200
Subject: [PATCH mptcp-next 4/6] mptcp: sockopt: add missing getsockopt()
 options
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230707-mptcp-unify-sockopt-issue-353-v1-4-693e15c06646@tessares.net>
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
In-Reply-To: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=93zTB91dpZB/7U3jGgselwKSU+2REzhYoE2Isk/cmqg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkqDaYaiNwYan5ESnNJIuWVThZWCYnxs8c0DoAa
 aEfpSquI8SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKg2mAAKCRD2t4JPQmmg
 c9ZGD/9bsl1Idzznh7LSfziwmpf1ahZgc8Y8bF79PpyX8lsNqIA42KABoZKyNk2zIBakOId51Nu
 NzoiB//Y4tBfL/9o6LWE+opyObBTdUNKVVFL37sde97IaTbPNSAxrGt7yK34EHosRAfCDuvm4aw
 6Qllhk87BzsJyyhp0QLcnOvt57k6rPBmwFZK27OSV+DoAjUZPxDfbJGuumhMICgrS26MIBB1b8s
 I6J7qu1KleAsrWB5GNK29RmmaBaVX+/d+JTmXXWxZ530rkk//xmAt8u5khjBowQvgyL+gcHUMhE
 QvwEKOWB5q33fg4Vgl4i11adggSwEYwiWQYSmGVdHGMi9Ygke/iZi/ojMo16z+rIqSi62KJA9ns
 FaP107v3NCdaW4SDVuUIfhxwrVReZu48tWxKryo9lKmhuezcKkEaL88EowZFLGKEev7aLmbdtBc
 b26Lqnu0NudiAggQLc6B3/AUKr5TibZP/Un8VsigycNHW9I06U+j2gngGqcXRNq3wgtUojyOYSa
 hYHp3k8kc/1WvOhMWup41eJjDEtx/dXFklyyqztsuKQfexmZkbMpmHgxmFVpDQUc9GNeYPZXAXJ
 VyjftAe++YeluWF/fQkv/XbCAy2tBw4GRW1/PwFQt9UT13QA+6XlHoww3UIcKsWZ7mEsRoEIe9v
 fzOiBfS6FYDbUwQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some socket options had a support for the "set" part but not the "get"
one:

 - IP_FREEBIND
 - IP_TRANSPARENT
 - IPV6_V6ONLY
 - IPV6_TRANSPARENT
 - IPV6_FREEBIND

Thanks to the previous commit, we can easily support them.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 673bcf8a97f0..f0007fa7a0a8 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1367,6 +1367,8 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 			       char __user *optval, int __user *optlen)
 {
 	switch (optname) {
+	case IP_FREEBIND:
+	case IP_TRANSPARENT:
 	case IP_TOS:
 		return mptcp_getsockopt_msk(msk, SOL_IP, optname, optval, optlen);
 	}
@@ -1374,6 +1376,19 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	switch (optname) {
+	case IPV6_V6ONLY:
+	case IPV6_TRANSPARENT:
+	case IPV6_FREEBIND:
+		return mptcp_getsockopt_msk(msk, SOL_IPV6, optname, optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
 				      char __user *optval, int __user *optlen)
 {
@@ -1413,6 +1428,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 
 	if (level == SOL_IP)
 		return mptcp_getsockopt_v4(msk, optname, optval, option);
+	if (level == SOL_IPV6)
+		return mptcp_getsockopt_v6(msk, optname, optval, option);
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	if (level == SOL_MPTCP)

-- 
2.40.1

