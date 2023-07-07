Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF38107AC
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 16:00:28 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fbfcc6dae4so11842495e9.0
        for <mptcp@lists.linux.dev>; Fri, 07 Jul 2023 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688745627; x=1691337627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTtNxIjGCHHZxGVoyP0zNo6ljtr4ROBSIXD5hnl6EPI=;
        b=GBFDIZuqZ+k1SLJS2+t/+b9zYpst+cZSILhxGbnwI6AOKAIdkGNRjwK7Phu0ZiYZm0
         WVSz9orpOJp7F1yfM5LZUrYVBShILcBIZ57nqdPOcmS8PqaKF9FD/UlV4qbfqrAnqlXs
         x1U0qDVS6pF42w/kuP43Bh0gmlGUXLWxnhdxrbUaRXG6Sz0jg27iRZWTGJ0IR5qMQt94
         6FbsSitWZJ2oAF7StBCLfHB0OnBfJrllADSBanGgiwV5QQcyoaCca5VN7LKG1p6+vbG7
         u3cCeiTRlfqfmTTpXajKj16d27vhG0/MWvPlHZCVWYHhwTgB/HvAxGEcwwB+EO/JMEEW
         tdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745627; x=1691337627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTtNxIjGCHHZxGVoyP0zNo6ljtr4ROBSIXD5hnl6EPI=;
        b=H/VE8s/FfRcXUfaN+5Zq+zh+nA2Ol6ojtwXjzOnDJaZBZUUhcGUZJBCN/1WE8Vy4A6
         3ANQTjoEE+hwaGBN5h7hp18tEjyGJP4TsRFSbf2bj8uWro4vakbXeucPt2y7NzRexd5F
         +IRitybNHJMgcOWKkuSmybU03vYV3fwQMDK0whD1rK6UjxNGlGcxjGkShViALt9zwbZo
         ep1JEKVcQGQI4oDn/mJoc676gEgP/9+cZYLbIC2mkUgktRQdjVB7EvVCEASKjrJLDw8Q
         VpPwoyNdcC3ZNeCKJ1cXFYSgY/9WDgL4fBpp9wkWGpD3G/DtOnFRmQSBkbYVz9BOgmAW
         Wi7Q==
X-Gm-Message-State: ABy/qLZn5AOKonfvmdF+oL+M9JiFNaiUY1a/Tnts8FjPNltiMhdL3t5N
	0GOPGtcBdv8bjm5JPiL5ixS8pvxACCKqX6OOFj0EPg==
X-Google-Smtp-Source: APBJJlExj8YAReO6RN4hHglYl7vdQkLGPbAPjfH53gxHOPcCrzgjORIi49fhqdivUTqHv8/K+WRqtQ==
X-Received: by 2002:a05:600c:21d0:b0:3f9:b17a:cb61 with SMTP id x16-20020a05600c21d000b003f9b17acb61mr2541672wmj.13.1688745626892;
        Fri, 07 Jul 2023 09:00:26 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c108b00b003fba137857esm2829186wmd.14.2023.07.07.09.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:00:26 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Jul 2023 18:00:13 +0200
Subject: [PATCH mptcp-next 3/6] mptcp: sockopt: get val in a generic way
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230707-mptcp-unify-sockopt-issue-353-v1-3-693e15c06646@tessares.net>
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
In-Reply-To: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=e0iLFva+PCw1OnhEGzXFnqH/h3e1CqRZUxCBW8KwsTg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkqDaYoMc+hNmFWHvnOGlLm+PalYz37wsMVmlgI
 ZiZpOupmeyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKg2mAAKCRD2t4JPQmmg
 c19tEAC313B4d3jnAU+ROFcUNX/KU6Dkio0C8AcyIDWibXEIw3jWpV3SwPHiY/hPiDrNCm+AEuA
 zw4j/TyCnYC2vrZJxN0phPRBCc4mdfyYW+1X4FM+63DPheP01ZlfE2gRCWJ8UZFGsCAqnfcEKw+
 hLEXygSnTtdTlO2uTglUHTw2J95wzsdy5tML9I/qXWbkop/3K9tuZlnUxZ9VcAaOw/XOouRqRyF
 FOCxxR96ZbkOj6pDYzomcoODlW7zgtf39VKk0oUxg7MH3sMBKCwn2Jq4w1Jo/s3aH2FDK7+8PmS
 GtFsIZZ+4m0oRdrb9mhesSKeMG6zjCpOFU8gxsVYn/38ZFGuAf6LE2nMKbAy39LqeBkcALUeW5P
 kRPnbgGAO0JFLb0Grq3Bas4VjnHRBqPmwGBvQETKwfHkX3Z1X8CODycFyKgeT5iIsPdKXAAV5L9
 tWkQFPYdEXWHUUxFf/er+OIi4wSsXl56nQwb98Nk2bgdeEbnaoimDKqAofnj2U0z0lDxFljqSwH
 uHiOYxhRCtsXPwjXZqfvi3PsmlOSs8kuVvxZLlbyambGpDyEPVHFwWD3b9n7ZdSdzGrMS9lQYuO
 HszLi2T/W4i/DuiyFB6fwR19HQRn9vGs8OVs6LzrIWWAkNRMsk4cYSnoVTlmO8InCAQ0pWM0DH/
 +7+Zp4rAR+56eSA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, to get socket option, we deal with them case by case by
looking at the field that has been set and copying what is done
elsewhere in SOL_IP(V6). That's probably why there is only one being
supported here with IP_TOS.

Instead, we can use ip(v6)_getsockopt() to retrieve the value. By doing
that, we can also go through the BPF et Netlink hooks if needed and we
can easily support new options later.

While at it, also fix the variable declaration order to respect the
reverse xmas tree convention.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/353
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index af1d30c8832d..673bcf8a97f0 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -868,13 +868,31 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_getsockopt_msk(struct mptcp_sock *msk, int level, int optname,
+			        char __user *optval, int __user *optlen)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	/* We cannot use tcp_getsockopt() with the msk */
+	if (level == SOL_IP)
+		return ip_getsockopt(sk, level, optname, optval, optlen);
+
+	if (level == SOL_IPV6)
+		return ipv6_getsockopt(sk, level, optname, optval, optlen);
+
+	if (level == SOL_TCP)
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
 					  char __user *optval, int __user *optlen)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct socket *ssock;
-	int ret;
 	struct sock *ssk;
+	int ret;
 
 	lock_sock(sk);
 	ssk = msk->first;
@@ -1348,11 +1366,9 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 			       char __user *optval, int __user *optlen)
 {
-	struct sock *sk = (void *)msk;
-
 	switch (optname) {
 	case IP_TOS:
-		return mptcp_put_int_option(msk, optval, optlen, inet_sk(sk)->tos);
+		return mptcp_getsockopt_msk(msk, SOL_IP, optname, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;

-- 
2.40.1

