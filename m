Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B603211
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:07:27 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id b23so5675730pfp.9
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fqcxDCQo1/0iHvZ44vRnswDULknZ6z/uDiM4ATUulvM=;
        b=qFTf2LfPNoy8ng40UPhPoeecc+X5mZHf7yTe7+EjEg+8qS420xPE/PVruMEnKJ4lX7
         fE8Y5VvanVV1jStGCQqRKhG3tELDuloa1EJfQdCLb3fbOkT05NfZmpYcAzylYCPXPXqk
         SUuWuRoEPsJEbci4Dsmxk8/ILOhXtIgwM1f+pYqtv+s6tE3l0mJQd08TxUNKQLWEbP/q
         jrL3VO+LSkpk8SG4nMyXE57AmCdnOWSUznVQnGIfnMI2wbj5Bv59r81gUWS2mF8G7B3C
         qrBfjcS+r+29ASpFOTdM1jiQtAfi/SSJ+/ck88pprJxF2CiEL+dipBDBPe1NqIPw68jw
         AT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fqcxDCQo1/0iHvZ44vRnswDULknZ6z/uDiM4ATUulvM=;
        b=OPmggWrN1JFT+l7a5UqXiEUjcomY4MRJH/CD8nilpIdZc6bJmSU4KMM4LeOio0M326
         kQDKaLylS8tKn+lxDNIZ7T7VM2XweoI6EY2mEhOAW6UmCsCj0Z8xLmTlOwHIIstfMg42
         c14TKj3otrbyADRWdcEM36s67DKnfaMrXDyG49yltnmyNCV9LyGvyv6t5e4lpCb/O4fD
         8LpNG1BCtceZZUdpBIDjDmaRQMo8EhEq0RbGazoRdsyfpsrWrYpJL/G4Qak+ms9mk39M
         Kp9acbsBMzCeN+44QrJcmyNu18ukvrH5t4NOyt1Oihpg85J8e765HE2hAHmcQs7JiWji
         aX+w==
X-Gm-Message-State: ACrzQf1l6OJ4IqhKtnS8t6vAJHoX2OqlBDhw4XEoqeZBC79sVmN2pwQw
	pk6sjggr0nuAXyU9gVnGMm4=
X-Google-Smtp-Source: AMsMyM7VKVp7Y/0IvoNdiKz1bXJ2yHafLyTq6qtYRpZ+LK3PzKoyxCCuVAbRoFvWDoTYHeFJA3wavA==
X-Received: by 2002:a05:6a00:22cb:b0:543:7003:21a1 with SMTP id f11-20020a056a0022cb00b00543700321a1mr28473789pfj.3.1663762047306;
        Wed, 21 Sep 2022 05:07:27 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b00174fa8cbf31sm1869233ple.303.2022.09.21.05.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 05:07:27 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v2 1/2] mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
Date: Wed, 21 Sep 2022 20:04:41 +0800
Message-Id: <20220921120442.320727-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921120442.320727-1-imagedong@tencent.com>
References: <20220921120442.320727-1-imagedong@tencent.com>
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
index d6d3ebeb7c9b..1550455f7640 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3548,12 +3548,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
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
@@ -3561,16 +3562,16 @@ static int mptcp_listen(struct socket *sock, int backlog)
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

