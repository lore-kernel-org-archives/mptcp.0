Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E17BA4E
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 09:31:38 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso6634151pjq.1
        for <mptcp@lists.linux.dev>; Fri, 07 Oct 2022 02:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO7JZOj8eZzaZowvWDLnLkzvnwe/mqL013eA6SW/Fbk=;
        b=m/aOL8Ezs4MzAZiGBVy7ISB0eiKZNZOoXQp9YXfI1zKdXKPj4hyp2gyxXud2pwMc7p
         nwxKlYaZh63lmWnEk0pfZMvaK7tMt39pDjDGOoK8imt6Fukrvr3koTlSFSED9CzCh1HH
         A9TcQmfiW4oV86lHAEuKlqY7zU+3X3Zy4b3yt4B6EhKB1oAEkOwuWOtFpV93DvzpjnwR
         rwW4bJpViraycnq0xCikfFGIfO5nXK2BjYbozYMg0mNWowkQjYjBHE/UqEME5o957Gwi
         emdXqVySBuUqen9mOqeQhPHj0NMQZdWXh+7+g9Ld027j1F2BdKfcwbbHaI/OvwhlVyCR
         YZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO7JZOj8eZzaZowvWDLnLkzvnwe/mqL013eA6SW/Fbk=;
        b=QS6534Se61ZKxODi5MpgSBNlGbMqjg/13ohG6jCotaIbP9ErErySQETPnh+WYyKWSa
         okvj5LEYSGcL+LcXesmkBklu7oVPn+dk5XIRquwqOVwKp54cVYtJ3PdZ4/NzUGd147nS
         KjUkdBuJIeQ0niVkEkwrbEmcj7FCF/H09j2LXgdlWAJx1bQQR3JgJQkWqTewHPIcXOjR
         ZZeL0Tiwwiz0imGhpKAD1orv9ltCcrgK05CFaYBHODFHM6eIM77u2TOnFVhZut6tih+k
         MSHz/UW82d9jaH7CUEs1iHuc29vmo8VsLSU6vPqaWrkyzj+er/jnU3yK/7/NymdLHoiC
         3DyQ==
X-Gm-Message-State: ACrzQf1geUg+duclXaetZTVSdInzA11cOJmSGZj6YepoRRyTITlyfWHp
	99UKsmFEggTCxugFY5W4GZNPuBmqx6wwmQ==
X-Google-Smtp-Source: AMsMyM5gCz3ZEY3yP4Nud7C9ErUm3cElGmuQh63myX3B0k4D1NwZIx4OCJZ9JirPvs97WHAte3ilsQ==
X-Received: by 2002:a17:902:6807:b0:17f:7fa2:be26 with SMTP id h7-20020a170902680700b0017f7fa2be26mr4338939plk.34.1665135097518;
        Fri, 07 Oct 2022 02:31:37 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.87])
        by smtp.gmail.com with ESMTPSA id 61-20020a17090a0fc300b001fd7e56da4csm4187421pjz.39.2022.10.07.02.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:31:37 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v5 1/3] mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
Date: Fri,  7 Oct 2022 17:29:20 +0800
Message-Id: <20221007092922.13169-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221007092922.13169-1-imagedong@tencent.com>
References: <20221007092922.13169-1-imagedong@tencent.com>
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
index 1aa940928b4f..04d92dc0941f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3642,12 +3642,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
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
@@ -3655,16 +3656,16 @@ static int mptcp_listen(struct socket *sock, int backlog)
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
 
 unlock:
-	release_sock(sock->sk);
+	release_sock(sk);
 	return err;
 }
 
-- 
2.37.2

