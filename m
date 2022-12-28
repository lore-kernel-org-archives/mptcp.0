Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06B10FD
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:09 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id x22so37371023ejs.11
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq3E4HRxn6yxKUsEwffezaIZxNXLvcYcDLjRAQfS+5Q=;
        b=oNeLYjIK46oTeG3rS6zH+aQjCv+f9hacF5P33sSuQ0oHwwcXGMZ+Yhk26/vQt0+0TU
         YVt0J3ALAmj1xkApBQgUdxkzFBrZxfpHX2b0NuR3sVxJorUIuralrzfLbSPY6l+S2OF/
         WhywOp1lhgZFW9Xd1OUMMSxQHR9KXlktQe53DmHnyb4vd1FbV/OkSL1KiMpfSWoPSG3O
         RdsQKa8tYP3GUlkG2/o42x3yxa+fZN8S81XgAbXmuSwHvrZQN9s46FSx+4s7DlczYv7U
         n4M+p4MVQD4CezrKe3fqYHtGrTw2wQsNvRUvsYSY3nkeeUDbaxe7drbrc5qGBhNlVlZe
         MLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq3E4HRxn6yxKUsEwffezaIZxNXLvcYcDLjRAQfS+5Q=;
        b=nOPfcsENBWB8kr6CKJUWKIwzQzJi3k8Hja28bNKNp+K51mXIiwi2TBHJIHA5OI35Ke
         w1nlj/A32b8rqzJfkhYqaHbgqgHQ1f4sRFc9f1i+hmXKXhlTm0+0dTJ5R5T2m26jPa5a
         QiNlzwqOmnGpapgUpgEB2sj0oE+6BaXITb7l/aCNKtWQRqLRmWvjIi9oDBEplDlyQa9Q
         ewxAo9+UzGTHjsPVY3lWhJ3BIK+S00QBV8wua9mJMBAGJaLvNZ6pD9IKUpoP+vaWFEoQ
         jy0O4HwUAr6sbIR48wac3NebWTGfJ7f2JKQYBY/Xo+9Si1nv981bD+uQ1EDlTqA5Iy12
         pAoQ==
X-Gm-Message-State: AFqh2koTAa31O0yzfeffrvP8tu/bqM7rWFBCjf2rsp8ubI7NnQ1diLeU
	fAR6Z9FGITdJCVvRBGKxJcRVB7lShwdCzwv6Ad1rYw==
X-Google-Smtp-Source: AMrXdXs9KJWrId+AeHlF8dsjLHzRgPuGVLmPqd4aFplo5cDg00FE9UWqxZrytDzd3BCxKO+C6/tbcQ==
X-Received: by 2002:a17:906:9be4:b0:7c0:e99a:e353 with SMTP id de36-20020a1709069be400b007c0e99ae353mr18733737ejc.56.1672222687338;
        Wed, 28 Dec 2022 02:18:07 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:06 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v4 01/12] mptcp: explicitly specify sock family at subflow creation time
Date: Wed, 28 Dec 2022 11:17:37 +0100
Message-Id: <20221228101748.2518303-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=2d3UcZEI4VmYmUKskWW4hroBAzI3yr+/Q0t9Liyx5So=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe+c1hsPJ40uIi91KDLtfepM+0LFk36Wa3QODeH
 bs3zbKuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvgAKCRD2t4JPQmmgc647EA
 DQSgPvTrDqSUSQVGBUtGlyyD71Y42VOuq2uP6nwk2EVUACEnZRzBF/mNB/9qhDeOYmBMp5dtkyKkVA
 vB/wcCyu+aMnW9FW1lKP4+lIT6pX3QIh6bssFoSahXtJNdIIqxHEapuG34/duTqrmuqmIIYpa5nHEI
 Q5oKxCFPHeaxG4cWXdw2hUWZrxond5UqXSEzVt50YvXNDcL3E+zgF1l1N3nATQmtKJ7UReeTg/fLK0
 eu+hhp6Mz4L25OsUkxSfnLDdgxc2bv0Kro+a6au2fAfvCZ4ogxe9bZ3x1BUXcmKERq1rOKdszRd+QA
 9rfcwNSii4HRx6aJAW3dfhuEDseYrn14wznTXdZyflpo4H2uNXVswIDk7Yde0jje6R/U7iWkwwcIJR
 0gsoHhjNfmElUwwuL0zc6eWUl/aewO8I7GQ6uAsxSSjmr0M/1L3wc376/LE64l8tSvA62nmHSCeQW6
 U2oTMlsKoiUU7KGJoD4lFWwsCpk8YfG0UPFRp4DuhAmHxdJwV1zrmpEpxq0AR2U80LA1jiQslgMM7C
 mHwVmp9NAZ8Qm2cyPS6pPALYMl5QS1YxWFoSwFdhgNZkaseWwTq3jO5GOK5UzU+9i89LIGRbufyVXo
 7bCibhtfs4PO6hmRQtAuVMKVCnVnFqvSBRwL+xs0pX3keFCZZiwH27/96O8g==
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

