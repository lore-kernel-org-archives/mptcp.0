Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A3107B0
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 16:00:30 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso26258435e9.0
        for <mptcp@lists.linux.dev>; Fri, 07 Jul 2023 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688745629; x=1691337629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xeq8sRLnjGrw3maYyBofnm9B7mHn4a/exqLD4jwmTc=;
        b=32ixuT399BPr82QmpUoVMxfwVZ3/QctdDTmh+zCJh48wav2HwPEeOTJpz0xwPIynwu
         3onzW0mWuJRastGrMObIHRNwR//eXCxBWeRR/MyFV/OSuuwtxmwhAQceFzsRngAQaBwB
         GEOEJO6nSfvitFCJREuLdaVeGAWUa2boOzVkGgouWrm561E8LHc0Y/yBZfUCZsVeacDH
         9xq+pp7F29yzveYzmI3d5ZuXW8bIAbxiT2mZfZhrxXwsmHkFlyAioceL6SqiTZ5120AO
         BWXmKDd90U1KXLEZCMiqj6surBntyaw3U6RYkkRWNpB/2SvOjDq0AslyrttSHWoJWvB3
         8Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745629; x=1691337629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xeq8sRLnjGrw3maYyBofnm9B7mHn4a/exqLD4jwmTc=;
        b=RI/W56NuW2kFkdkmLDQTN+lH9q2G1fOiXbxdMdW8qr0EWN4d0Tt5QBGdhLU2AAp0Xi
         wyPPKl7AFMxpCSryGj2c9AR14mb4aGjskSXCeeJYwsqRrN3WbUeIHdVXbhffc25TGK4h
         GvyoUU/6BIM9wtU3CxH+B/uG1ZjunpZCxRwQx8Wyuoi/yD0qd3dnSacUtuJO/j24tDsy
         7WmhRzTG0cz/XzPCsj/jSYnre3FwK2poeR0KBOak/iEm47qlmznJBwVqtCPNx6CVKYKR
         GsPgDcOvTpJEWKs/wpe6k54Cqtqkv7U5XUsyWNMAvEOEuy49R81M+BmqAA0pjJfQUdjy
         2Zcw==
X-Gm-Message-State: ABy/qLYO5zLRQHbn4vrIzpTFedR3kzCEy11jmOqyQxMTenu9ELIVg8Fo
	nldwqTWB7D9lJDfq9s4yxlGKv3hxXLQIGZEkXI/m0w==
X-Google-Smtp-Source: APBJJlEtqA/AvWWFjpyxHNfrTPayNxny5i6iz45KgFPfFwMWVhroiDdOmn3eFlFPpWvu2S7MybKkJw==
X-Received: by 2002:a7b:c415:0:b0:3fb:fa26:45a8 with SMTP id k21-20020a7bc415000000b003fbfa2645a8mr82831wmi.28.1688745628722;
        Fri, 07 Jul 2023 09:00:28 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c108b00b003fba137857esm2829186wmd.14.2023.07.07.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:00:28 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Jul 2023 18:00:16 +0200
Subject: [PATCH mptcp-next 6/6] mptcp: sockopt: support IP_TTL &
 IPV6_UNICAST_HOPS
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230707-mptcp-unify-sockopt-issue-353-v1-6-693e15c06646@tessares.net>
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
In-Reply-To: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3003;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=XoXkCw/r20bM9+9XCYW29khspTN7it+40kFbty2kfIU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkqDaYf52ikSusJ333dxjpQ6EaYg7qDs0BkfJBi
 PuYBqCrHWiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKg2mAAKCRD2t4JPQmmg
 cxc3D/wLOQLBhgJU7A84xjw3vLRXYf/T5G+pAc40c8lQy3Us4gZ64Jz0fF13abJR+bSm16dEsYS
 qimAlOtz1bgEQwmd8aH0pfpPM7xjox3urbuyRZt79zMcq+KULfV4CYa/nz9IltAaZW+HHy2nVCG
 wucfrWfwHGjm5NH8XJSOheMlD91gIj/o9iMFb14R/rclW34OkuHR9fPk1tCXs0GN+3sNLREu0D5
 /FRhFULvyNXMyZ3iGRTWUhaJKEPb8YCOH14klx96NRmNsreAHF+VRbU4LLBkObtPVVSFEYlEeun
 5q/KHs8XdeN0r2jLrXNT+QQ5Zi77kpDIbS8sEz7VNsyV227tzzCMlXWwsDD1o17WXPaM/ZALrI1
 yWrzlzXzenYYXM5UeJDE1jUhi/CkiPx8nl668M+Cyv01kA/TDLatI9O2/ft/HUNiTsNXYmlqbNv
 SUY4LxWWn9HVuMwO7UtiKAy+9rLi6AaE3pX8QGnpjYAQkcUFTJ7toj+CKpoiM7mSVbbMgp9C6MV
 F3KPHreoizsCImvyfhy1ET6bOq0904zBQ3SC1TEiQkLSTM0Wh/PytZU+K8MfOb7W8aQ9jJ0F4tz
 N2C6FpLbps8/ObgD6CuoApIBfZq0Cs9t450UNB+CCjkhoS2Tj5ZUQOZhJZiMGzUXwcp8FbU8RcS
 9X0XZeqsYp3fahQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This adds support for IP_TTL and IPv6_UNICAST_HOPS, the IPv6 equivalent.

The socket option is propagated to all subflows by default.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/296
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a17739683fdb..cf35775179ab 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -393,6 +393,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case IP_FREEBIND:
 		case IP_TRANSPARENT:
 		case IP_TOS:
+		case IP_TTL:
 
 		/* the following are control cmsg related */
 		case IP_PKTINFO:
@@ -406,7 +407,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case IP_RECVFRAGSIZE:
 
 		/* common stuff that need some love */
-		case IP_TTL:
 		case IP_BIND_ADDRESS_NO_PORT:
 		case IP_MTU_DISCOVER:
 		case IP_RECVERR:
@@ -438,6 +438,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case IPV6_V6ONLY:
 		case IPV6_TRANSPARENT:
 		case IPV6_FREEBIND:
+		case IPV6_UNICAST_HOPS:
 
 		/* the following are control cmsg related */
 		case IPV6_RECVPKTINFO:
@@ -460,7 +461,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case IPV6_TCLASS:
 		case IPV6_PKTINFO:
 		case IPV6_2292PKTOPTIONS:
-		case IPV6_UNICAST_HOPS:
 		case IPV6_MTU_DISCOVER:
 		case IPV6_MTU:
 		case IPV6_RECVERR:
@@ -734,6 +734,7 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	case IP_FREEBIND:
 	case IP_TRANSPARENT:
 	case IP_TOS:
+	case IP_TTL:
 		return mptcp_setsockopt_all_sf(msk, SOL_IP, optname, optval, optlen);
 	}
 
@@ -747,6 +748,7 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_V6ONLY:
 	case IPV6_TRANSPARENT:
 	case IPV6_FREEBIND:
+	case IPV6_UNICAST_HOPS:
 		return mptcp_setsockopt_all_sf(msk, SOL_IPV6, optname, optval, optlen);
 	}
 
@@ -1322,6 +1324,7 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	case IP_FREEBIND:
 	case IP_TRANSPARENT:
 	case IP_TOS:
+	case IP_TTL:
 		return mptcp_getsockopt_msk(msk, SOL_IP, optname, optval, optlen);
 	}
 
@@ -1335,6 +1338,7 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_V6ONLY:
 	case IPV6_TRANSPARENT:
 	case IPV6_FREEBIND:
+	case IPV6_UNICAST_HOPS:
 		return mptcp_getsockopt_msk(msk, SOL_IPV6, optname, optval, optlen);
 	}
 
@@ -1436,6 +1440,10 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	inet_sk(ssk)->transparent = inet_sk(sk)->transparent;
 	inet_sk(ssk)->freebind = inet_sk(sk)->freebind;
+	inet_sk(ssk)->uc_ttl = inet_sk(sk)->uc_ttl;
+
+	if (ssk->sk_family == AF_INET6)
+		inet6_sk(ssk)->hop_limit = inet6_sk(sk)->hop_limit;
 }
 
 static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)

-- 
2.40.1

