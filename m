Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A1322B
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:49 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id k9so26157067wri.0
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=IyhqBXZcntykYwHoMAqYkJIjhx7GOIDvM+xBrS8J4cM=;
        b=ntZZjI3bQQdA9jsHOYDCRDLeeAuAD52tKQ7hOu0mlH8lAuamjVqZoq4LONH5vHbsu9
         ytvhQmDrEtoqplT1ywzrerLkNXpG0OgkAcN1InoJUcO4Myg33NJUiJ16QZn3nBhD/Ey+
         Mq5eT4gzicWkmoAk332xElLWTRGtafm/Ke2Fphau3LP+6LU5G3T6CNIGP2BgqmV446v9
         qbhFR9d3866b36C8Y/ltS4FMNn8vEC+97Z2cZh5atmBSn1uZSmOGlWhy/0tiLLq/S3ik
         vhf3SPrWj3DahlsszqzUUFdMBoU3BcU0BI1gBVFXMEiei+jFT6d70EQi5IUHXxH62I+O
         E1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=IyhqBXZcntykYwHoMAqYkJIjhx7GOIDvM+xBrS8J4cM=;
        b=i4AaQtjAS/VuqRcvMPpvJUN6PSU4LDu9oz7rTUMNQrYhAvPceuqOtfH7VwQrvffHfZ
         0h8pW6DfLmTQEKO/JJ4D1n99ykywEVu8dPtkuo09Nj/v/T8kY/BIv9eDpLjQV7nYcxKn
         nbt3MqazK41H9KFOGJ2p3vlrVHXgT5RHgW+r1RWahUvvgjfUtr2oXmKXV4FVo6xKT1fS
         ELQ/dlYvXLYOmgAvioLNrXzTQwDSjH5E9NevvgLV88LIBy05lcVO4wpVNEP3i3Krk5eU
         obZMOrBC/ICUsy/kjK43PVoXUw60L/1mS5ef8Lsf3cyOuWjWF2wGguxLLzHlaklr44zA
         n88A==
X-Gm-Message-State: ACgBeo0+PqFl1gVfCH1eHH0ICrSZRaXRMiCj9Sr6EOxda3kejLPh4OAX
	0OdM5R48EG/IqqxYQX617WY/b8RS8HGvl9Ho72G264KW5t9nfuERh3DJ6C9ULezvvwvCv5uWd5D
	o0SzHxdy0/UmM0badrnYmEQ==
X-Google-Smtp-Source: AA6agR7M/G3mJQNFadBVoDlEAOqiAKV+y7HIxQUt8M7+ksLSmRjurMarHtI2cjCkUSevSmrO3dsDeg==
X-Received: by 2002:adf:8b07:0:b0:228:da7c:80ee with SMTP id n7-20020adf8b07000000b00228da7c80eemr5121248wra.25.1662644327388;
        Thu, 08 Sep 2022 06:38:47 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:47 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 03/10] mptcp: handle defer connect in mptcp_sendmsg
Date: Thu,  8 Sep 2022 15:38:22 +0200
Message-Id: <20220908133829.3410092-4-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
References: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

When TCP_FASTOPEN_CONNECT has been set on the socket before a connect,
the defer flag is set and must be handled when sendmsg is called.

This is similar to what is done in tcp_sendmsg_locked()

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---

Notes:
    The error case is probably not correctly handled. To be checked.

 net/mptcp/protocol.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55442df8fb97..ad81824bdbfe 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1668,6 +1668,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
+	struct socket *ssock;
 	size_t copied = 0;
 	int ret = 0;
 	long timeo;
@@ -1681,6 +1682,24 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	lock_sock(sk);
 
+	ssock = __mptcp_nmpc_socket(msk);
+	if (ssock && inet_sk(ssock->sk)->defer_connect) {
+		int copied_syn = 0;
+
+		lock_sock(ssock->sk);
+
+		ret = tcp_sendmsg_fastopen(ssock->sk, msg, &copied_syn, len, NULL);
+		copied += copied_syn;
+		if (ret == -EINPROGRESS && copied_syn > 0) {
+			release_sock(ssock->sk);
+			goto out;
+		} else if (ret) {
+			/* The error case is probably not correctly handled. To be checked. */
+			release_sock(ssock->sk);
+			goto out;
+		}
+	}
+
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


