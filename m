Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE063B6
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:37 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id m18so33550745eji.5
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq3E4HRxn6yxKUsEwffezaIZxNXLvcYcDLjRAQfS+5Q=;
        b=otlJZIput4YglvtfNSi0JalkwDv+S2iwuvLBorH2zjVSdwcJeYBAzc/IX1CnrPIJN+
         csGwqiDXu/hhYQwHgRT7akQL0WAp8aIgsiJ1HiRmkcZnUgvMEgnsHfGjSUrBIa0BOHHR
         oZn/Vx5yB1FbR/GUQJr7JtdjMn4XcOxx/1oTR7itJem0JFnTM9EhMaEGM7nEt2MCEcwZ
         1nkZj4jGUMJAJKSZD9G+KFggvpBnGlpbHS5wv06ycr9msb6aZarUqg/yhJAB87+AfA8C
         UtiZrW4+YCOt4n3lidiRx6pU97OS9u2x8w60wcCh6drNlWQNJbzbts56YYHnlfv3Ko3V
         /9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq3E4HRxn6yxKUsEwffezaIZxNXLvcYcDLjRAQfS+5Q=;
        b=arpzEa5UKjJgxNsgTN6Yz4itHZsBRf+t8LdZtHsfxuYqfvawGn4StXm0n88ew91fEi
         Af1oom9iEWjkfDsrs7CB0aW4S7sVXLDSZCjkV8Taa3E053tBl/MgrdGAmhVpBtAVMxam
         1Phdgp7bhKom7JJ/xX7IArEojh1LoL1K/pAiOL7+EzoTmqlLahjyus/+gCGyeEuVkmxv
         BLnCZBn9iv0U6LVyAbHvzw8GlTW0xZv9ntjCjI/W78Q2zxtN3oF9iUKCBp2Mdb/ORQEP
         mfOiivx6wzmhjYS62crTycWUBEXwrAFF+9Q9YLE5VXF29iI725wp2YVsUScAYgaE1i2x
         82nA==
X-Gm-Message-State: AFqh2krj4GI/rl/UsubIcKYq0KTlZmFzBLybMRvzzIz0O2MzwjVhrlVW
	KDGvBVI2pD/K7CCmNTGUa+gEn735KlN8RNGrbGAFjA==
X-Google-Smtp-Source: AMrXdXt4QY1zQpFlqPboI1MKcjM86Q3Ft6mb7Vu3+uW0EYOmGdP2qEi7i/8L5WrreYRvjsPudx5kgQ==
X-Received: by 2002:a17:906:6dcb:b0:7e7:4dd7:bbcc with SMTP id j11-20020a1709066dcb00b007e74dd7bbccmr18942353ejt.73.1672165295950;
        Tue, 27 Dec 2022 10:21:35 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:35 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net v3 01/11] mptcp: explicitly specify sock family at subflow creation time
Date: Tue, 27 Dec 2022 19:20:47 +0100
Message-Id: <20221227182057.2288816-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=2d3UcZEI4VmYmUKskWW4hroBAzI3yr+/Q0t9Liyx5So=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd5c1hsPJ40uIi91KDLtfepM+0LFk36Wa3QODeH
 bs3zbKuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3eQAKCRD2t4JPQmmgc+WEEA
 CbKXi+NM7yBbQxeo61y6c6gTMhAtiB2wpfCZBIvstFUEK5GCdgnhITv9PxcrxC+3/v56lkVAns5LVD
 PIuuu/MePZ5L4tpP0kSsZf3nvvLied49jCqY4hKdYszd/VCPYz5iac3c4H39G8A5xjJjL6hAOQuzXR
 ZL+NhyqDDfPb8DqCthYJWXOtorLhSxajXkPsY5KGd/qBeZPw9CWYEFv2fCPRQml2iMKgfy0WJLGuOT
 uUUz663fdvMq2eahtQNl5MHsCVS3szBuxoyTFPuzvfX/YRK6GR7K7pBWIJW3xwtuIgHD88sgCiScZ6
 YKWOMf4mSGJwbdn4cMVOWp8iHyG4ggAry3y1KAe5nDGNOOURYjS7/+g6qqsHUxWUCFdUlrFAKnBzGB
 JWh+2jMb6q3NXwbDXQm4TBdXq7ZtdyDFQpehrTK9v4BmZBUW52kxLZEuPFIXIkCOHuE7EOR734aKGV
 5xOKGuVhLIXpoyZeJZBgdPHMp/5Q8bjzHl5La6+SzHw+ex+bHMylvoiosEEYRtBOmmgYlly4UWQekl
 0ULN9zrGYZyucV17d+Jpk/JbmxTWbaRlN+vkKlslzNHiqiWQ9ppmk9CjtyhM0eFe9UV4UGj/QD2Eye
 SKUATdjh+MdgRNAPp4bZ5DaUE2XdavoKz0nye7tszx4Xb9Is4i2D2N1bhDag==
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

