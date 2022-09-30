Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB91841
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 02:50:29 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id 70so3025857pjo.4
        for <mptcp@lists.linux.dev>; Thu, 29 Sep 2022 19:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dSafesNQgHD7ZwadbJT0090Fsu3V5WN0dWI0fRLQpP0=;
        b=eeM8itL/3DMjUVtIYL1lLWn2aa+KnE6ZyOTCevAP91nc/DE5JP3ViIqeQrP3KkItHG
         Q+M+mIHSjhSpjPygnfRpdC0gFFjm2LIgBpKp2ATbk8d1TCeu19zAqYfdutuDDXeFi7ef
         4VKVw+BibBnHPESw3c6gSIl7BH9K5ICgcGIsYIdjE7Q34cXelRNSOw8YiRULAXqqQKhG
         cmI6KOvPh4THqsIBdNMWFbDtWXXkfTzS5Ka6aq6hmf3yptvQoz+V0uhcCfo6yJLUtxEd
         IVCq9nR7h6L5BKOVCbPNZfkDLa8tFO1yYdm/1cXhuJelVjtaGtcStwr6rRyyMLT5SMpI
         cSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dSafesNQgHD7ZwadbJT0090Fsu3V5WN0dWI0fRLQpP0=;
        b=k4z87/tHbIN18z7UvuDV/lywSG+VRn26U/Wy3FHGsDeOlJbQUaA1qzzuFCKpuRVePE
         dEGY68JVsmXhrGBsqy3JwAuqIo2q8Nxk50n7v1dyMyxhwbGA+FxogIsg+Lp75mztrgU5
         kG64dZy+6ci4zDhFO/2Ai64vtkhfY4w/IpSXsJ7KsHmITBXFSNPJ1B0s5xFWxa4J9oz5
         nWtfvuy+wV6QFVdRCxU4UDcJ8gRkkmeWrOVy9CKPuV4g+dT68yhEtUUh+IAKIYJtgt28
         5Ux8H4RAlzhL5PI30DNux+D3e00KpvaqU5d4w16DBC6R/1OA/TfCGNh8VRV8EY5mBYal
         Vpfg==
X-Gm-Message-State: ACrzQf1DtNXwxq+rLjNDzZvjya789MG9amiV3vRrTwb9OF+Wpu1rvxLv
	jsk73ZkL3M0Bc0W33Ly1U28=
X-Google-Smtp-Source: AMsMyM7JSVvpfJaNTkS2CCTTOWN+EeT6kvxNnevoQTwKFNzOIYTSEimIAbTiPXfoZnAUk5+V81Y94w==
X-Received: by 2002:a17:902:ec82:b0:178:6b70:7eca with SMTP id x2-20020a170902ec8200b001786b707ecamr6702460plg.164.1664506229060;
        Thu, 29 Sep 2022 19:50:29 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b00176d218889esm606911plh.228.2022.09.29.19.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:50:28 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v3 1/3] mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
Date: Fri, 30 Sep 2022 10:46:05 +0800
Message-Id: <20220930024607.128202-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220930024607.128202-1-imagedong@tencent.com>
References: <20220930024607.128202-1-imagedong@tencent.com>
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
index 760404b15cd0..d817fdb2f6ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3577,12 +3577,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
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
@@ -3590,16 +3591,16 @@ static int mptcp_listen(struct socket *sock, int backlog)
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

