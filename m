Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C10AD52
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:15:56 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id c17so49413646edj.13
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq3E4HRxn6yxKUsEwffezaIZxNXLvcYcDLjRAQfS+5Q=;
        b=HamGpLsq8ll157ff4nPCjLRdSqIwhiC2bXOArgdnlGkXi8yTHVDvOIsly3h7ZXB2gg
         /UP2RbsHeDQwIMSjWk7sjJyyJYiF+5A98k9a4zPhqxRP81k1PKu62uBA7WwItITdgzoh
         cpJfOWPwk6JfN+OxzdECSyuMYPb2qYvUAqN14jDO3tq9Yjt3mrDQnaVAFlcBm8KQHb2C
         A6lPDMlfvTwEhqjlUcjWiRE2bODXwBSdmULLVGJENZ0mdxsc0Rlk4m3+K9xc+C6ddduc
         uUZ856g2OEC/8FQQlP9ubaetSMOp1dagAw3FsKF/IvxRCYyZf1O/CTH4j2xZxONkQob3
         nHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq3E4HRxn6yxKUsEwffezaIZxNXLvcYcDLjRAQfS+5Q=;
        b=Ln7nq3ELv1/ax2Q+VtIE1LrPQtirsC1oCfQ2/cfYmcRTD4RxRzO95JVbe0bACaUMbG
         XSZRal8uOv3nXWfIZzp0KkyWNhp3Koce37znB+EKPfaF8iug1CntP1Uj8/pgM6ri7f6y
         aRMpYmXzfsKDBDn13qb1VWI5muBjh+Q7b0jEEsuzUd29gFLtzGkiS9jgwGlNDPCWBxS8
         geTM1N46dOhsNGyFfAPD0y9yybEgQTAH7CmPniVVRHZDPnAUKJxkyTMGquT4TDKqN6g9
         fohMK9G1rbjnSZE3UGoNstscA4kLBZcY/r/cnRY1Ej/ynDUGRPrD9Eq+4GrqkxIf6p97
         oI3Q==
X-Gm-Message-State: AFqh2krXZkH412y9wm4Kv0RHQ1VPL+1QPxdwALXiuTZCuYuXwLo+GaHn
	lsCYulDN+6U3P9SecdmmaoEf9FgOPPlph8rnBTA=
X-Google-Smtp-Source: AMrXdXuvj4IN72S1M/A/9nNUpajbKFNKbiWopol6EgWmxcCCNqr2ARhpBhozdMBgwwBGAC4JkMgpXQ==
X-Received: by 2002:a05:6402:1217:b0:461:e5d1:73c5 with SMTP id c23-20020a056402121700b00461e5d173c5mr37103803edw.32.1672852554889;
        Wed, 04 Jan 2023 09:15:54 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:15:54 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v5 01/12] mptcp: explicitly specify sock family at subflow creation time
Date: Wed,  4 Jan 2023 18:15:15 +0100
Message-Id: <20230104171526.1416746-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=2d3UcZEI4VmYmUKskWW4hroBAzI3yr+/Q0t9Liyx5So=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQHc1hsPJ40uIi91KDLtfepM+0LFk36Wa3QODeH
 bs3zbKuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0BwAKCRD2t4JPQmmgc4FEEA
 C4/yYNbQ02whXcfLfCLcAyJPELa8T3YClu4TGUJawQMuhFeporNaRsGW7HC5lZRWxqRK6BfVNYnx5p
 2d9avS2NAnl9rdiUYi+iDB5MQhn5sBnBt1YN+I7VynKLuZ/CDaItYkw/pJM3OhyADVuK8Zx3JyuliX
 Pavvnf7pATZt70A53epB0YpuA7d515wP8OGU+VMeC9hyhFrlHLlWUKKecfERF+1w9+pXlQXPcES0hs
 W4CXiXZWiiR4x12mnaHJlvfWFoKWzcsbDYUH6vPUFJLrxL3tQMcYFPZ83OX8+MM0cm3JZpMUlUdEyo
 84cT2gl7QK4WYRRNjEDvwxerlHWr8BT2ytHGXjPr0x1VxBTd/aiK5T1SbiGYz1Lk7V6dHDobL59TPp
 nb0SUhcSRyOzPMsqC6LwIGJzrh81ItbvOnCHFyKWspal6wQKnN6KxjghljzMgCPmUytIkqOdlRzMTo
 OSPPgmREMGqs42eZi8oI2ad6z5+KhteB08amSso51j3sV3jqG8/zwVM1mpTRgjlR7oXHUrgDbHlveQ
 E+fGW+URXM3vDjrlUiOy+MubEoNfOJ6uwVd8H6WrvSZ1R/j8/yr2HECO63ReMyApZetSeJ7M78GbTi
 LEzZoy3LxIewPvnORt0t5rGaqdaSlOZqQOjYJJ1By8wvW1C5yeyhvvJPujxQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Let the caller specify the to-be-created subflow family.

For a given MPTCP socket created with the AF_INET6 family, the current
userspace PM can already ask the kernel to create subflows in v4 and v6.
If "plain" IPv4 addresses are passed to the kernel, they are
automatically mapped in v6 addresses "by accident". This can be
problematic because the userspace will need to pass different addresses,
now the v4-mapped-v6 addresses to destroy this new subflow.

On the other hand, if the MPTCP socket has been created with the AF_INET
family, the command to create a subflow in v6 will be accepted but the
result will not be the one as expected as new subflow will be created in
IPv4 using part of the v6 addresses passed to the kernel: not creating
the expected subflow then.

No functional change intended for the in-kernel PM where an explicit
enforcement is currently in place. This arbitrary enforcement will be
leveraged by other patches in a future version.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---

Notes:
    v2->v3:
      - Update the commit message because the behaviour is modified for the
        userspace PM and needed not to create subflows from/to wrong IP
        addresses.

 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 3 ++-
 net/mptcp/subflow.c  | 9 +++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index aaafdae73b6a..003b44a79fce 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -98,7 +98,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	struct socket *ssock;
 	int err;
 
-	err = mptcp_subflow_create_socket(sk, &ssock);
+	err = mptcp_subflow_create_socket(sk, sk->sk_family, &ssock);
 	if (err)
 		return err;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5b92906cb91f..b2b56a80e817 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -643,7 +643,8 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 			    const struct mptcp_addr_info *remote);
-int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
+int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
+				struct socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bd387d4b5a38..ec54413fb31f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1547,7 +1547,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	if (!mptcp_is_fully_established(sk))
 		goto err_out;
 
-	err = mptcp_subflow_create_socket(sk, &sf);
+	err = mptcp_subflow_create_socket(sk, loc->family, &sf);
 	if (err)
 		goto err_out;
 
@@ -1660,7 +1660,9 @@ static void mptcp_subflow_ops_undo_override(struct sock *ssk)
 #endif
 		ssk->sk_prot = &tcp_prot;
 }
-int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
+
+int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
+				struct socket **new_sock)
 {
 	struct mptcp_subflow_context *subflow;
 	struct net *net = sock_net(sk);
@@ -1673,8 +1675,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
 
-	err = sock_create_kern(net, sk->sk_family, SOCK_STREAM, IPPROTO_TCP,
-			       &sf);
+	err = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
 	if (err)
 		return err;
 
-- 
2.37.2

