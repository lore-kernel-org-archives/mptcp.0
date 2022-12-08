Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5762C
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 02:46:33 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id k79so197776pfd.7
        for <mptcp@lists.linux.dev>; Wed, 07 Dec 2022 18:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwpGsX7iMK5E/SJU2XUAJwEavDvM+3ejc/xz/wz/5o8=;
        b=I1GSrrI+Z4ghtqwS3fEwaXW5h6rM3fOHp5rIiv/Tt5cX3NmiYsiPoQTmEMLPBJNJ3w
         wvSFy3rztm+JMGG8m0xrEYisgxwBO2LxUjFx/cXqnKNcQPbL0AmmFfHRBAzzZsn966iI
         KaTXYGCJiC1/ZdK3ooVOyUge+m4gPdiqFu7erk01jmXYdxvzSABx/Vs+EJSFq3mu9ivA
         yljC7BmOJixbpyU5YassGBgUM/3oaBm5Z4mhLVIEl2Grcld4r9jq8FSv0LWSq32vuA8y
         iVwk2Hqz8BZroS3kPgjmzsU9ZF19wTiqYHkh+TKe5X1DxLwrANpbSDYaobMS+pFfZp+n
         zHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwpGsX7iMK5E/SJU2XUAJwEavDvM+3ejc/xz/wz/5o8=;
        b=UpjO1icI2TiOdisIZMLVabSSWj9ZjxDq0/YjKgOd9PYhWITwUhxMeqvPTVAYTe/M4v
         FCGOuMmrQCz85za1B47bsDmqtUvLUFBOZbwbAYUe9GVZFYfwsLyHU2akGxpYXmMuGu7p
         z7KN6IGyNvmoNG7OEJakknKJkcI+BLkM5SrSMTSWqDKMGF81mE9F+CjQoIptwQQPsqBk
         GZ2EnzzBKvIXRd7kzzcrfeA29PHP0HDLiQ+PGMNleeqXW+HhbmOs7k3FAn9qclKuACk8
         EDb+gqJY7ypv2QWFxkF1TU7PWwCA5NOMjSS4Ua6A1DKDB3BiEkLDxE/phOwfAp2ALUi0
         u8Sg==
X-Gm-Message-State: ANoB5pl+Dby4l4m4zzmThe2ctTd1tRsKzWSec4HIcsa9no7jrm8aZ5Xj
	JlsqbBMqFkpZ+TyBCJ4IxM8=
X-Google-Smtp-Source: AA0mqf7e7w2YvD6IwSfi5TyRwyY6bK6TwYx3nPVe2RbVMtoSDg4jt+WceO7Ddc7AzRkJJDWpWR6hDQ==
X-Received: by 2002:a63:5408:0:b0:478:31a5:3656 with SMTP id i8-20020a635408000000b0047831a53656mr40542750pgb.273.1670467593095;
        Wed, 07 Dec 2022 18:46:33 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.gmail.com with ESMTPSA id a26-20020aa78e9a000000b005769cee6735sm8606394pfr.43.2022.12.07.18.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 18:46:32 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v8 1/4] mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
Date: Thu,  8 Dec 2022 10:45:40 +0800
Message-Id: <20221208024543.113633-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208024543.113633-1-imagedong@tencent.com>
References: <20221208024543.113633-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

'sock->sk' is used frequently in mptcp_listen(). Therefore, we can
introduce the 'sk' and replace 'sock->sk' with it.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/protocol.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d03bdcda33e..ffdccf26af99 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3656,12 +3656,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
+	struct sock *sk = sock->sk;
 	struct socket *ssock;
 	int err;
 
 	pr_debug("msk=%p", msk);
 
-	lock_sock(sock->sk);
+	lock_sock(sk);
 	ssock = __mptcp_nmpc_socket(msk);
 	if (!ssock) {
 		err = -EINVAL;
@@ -3669,18 +3670,18 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	}
 
 	mptcp_token_destroy(msk);
-	inet_sk_state_store(sock->sk, TCP_LISTEN);
-	sock_set_flag(sock->sk, SOCK_RCU_FREE);
+	inet_sk_state_store(sk, TCP_LISTEN);
+	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	err = ssock->ops->listen(ssock, backlog);
-	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
+	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
 	if (!err)
-		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+		mptcp_copy_inaddrs(sk, ssock->sk);
 
 	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
 
 unlock:
-	release_sock(sock->sk);
+	release_sock(sk);
 	return err;
 }
 
-- 
2.37.2

