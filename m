Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EDEED2
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 07:51:27 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so8097116pjm.2
        for <mptcp@lists.linux.dev>; Sun, 18 Dec 2022 23:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDMRQQgmzcLrWi3iJXP5+Yn2rtVedztMbMwGnRNqbyM=;
        b=WqssJt35Vw8YCNhjznxPUVo4AxHoiKzx+lY5u+DEiDZnVUDPUYdoEn425ll4v+3gpK
         N7gk4xBL6J9cqNqcr3dtbTNQmOA2+81vO6PQNSh3Pd+Wqxo8HGeJ0RqpQfLkGqaLkQqy
         qZ+wL4dVnDh4+jsoeEDkHwDEEeuwOw6cmFV+jiz45WyRFfYcLKzxSZpMHYJv4i4mk+em
         +VM8V5fsbejOye0AApJd3VN0EETu9xU36kn6F1uwdTnPQE+/qRgURhnr5db7dxoVweFZ
         44Sc/iRdW0RrSOF09BELBdHEhdc5LeNsWIZ00cztYBxi6GM/nzIqsTU0hTaWI59zAB18
         bIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDMRQQgmzcLrWi3iJXP5+Yn2rtVedztMbMwGnRNqbyM=;
        b=b4QSAA/XJCmKzRkeRsphQo5g29OhZLCbTci2c4iMFzso48FtRLb1h86NXh/JHRVkn9
         cr3/0lP1cW2a8VdCXN1AdWx42OPzJlYazOLT7ri+VTCvIsGr2izRnrccEHZu8e9K4Fwj
         6Y2w7qDybxRO65CYmMOqcN9ci5NmqvPn78lgMj8Trs2kj+1wuw0/jr7c+IbtesG56LY+
         8+56SFOW6HMXyUNnuCz//dhlHclKwEZ5ga0Q7/SKkHdbUPwv1yAJ3/+BOjB8tRKGPwIc
         0J8uHlTZFKdTmfXRFDHZ05DqVmcbgkgA3D36UoZkCiJNPohfEiLeHonXxDLMpFD2XKT5
         J9uA==
X-Gm-Message-State: AFqh2koY0e200B9wNdlV9NUmUc88DlFmVOOmt8D4jkjzY8NcbN3E1yg0
	redZOQqFF71mQ84dJcb9yqU=
X-Google-Smtp-Source: AMrXdXtB/1EMpKXP3zVnqHsP+RvmLTRVHEOw+QgHNKX0XAsIGsETl47HNxpU8JSclBP86hzHdm9nqQ==
X-Received: by 2002:a17:903:124e:b0:191:1e88:ea4c with SMTP id u14-20020a170903124e00b001911e88ea4cmr4721415plh.40.1671436287168;
        Sun, 18 Dec 2022 23:51:27 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001888cadf8f6sm6366673plg.49.2022.12.18.23.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 23:51:26 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v9 1/6] mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
Date: Mon, 19 Dec 2022 15:50:43 +0800
Message-Id: <20221219075048.255811-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221219075048.255811-1-imagedong@tencent.com>
References: <20221219075048.255811-1-imagedong@tencent.com>
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
index 5e813580c394..3de45444557d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3655,12 +3655,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
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
@@ -3668,18 +3669,18 @@ static int mptcp_listen(struct socket *sock, int backlog)
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

