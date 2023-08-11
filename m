Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD034CDD
	for <mptcp@lists.linux.dev>; Fri, 11 Aug 2023 15:58:50 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-307d20548adso1921833f8f.0
        for <mptcp@lists.linux.dev>; Fri, 11 Aug 2023 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769529; x=1692374329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0e3CJJrqZ7ewmH2P5w0S/0zIFsn4QxREbiOM6aZrWvM=;
        b=lX+Ys8CLIATfx0LJtFzeLQ0ERTTrxPkesrFPMmBBNHN86jFrD5P1lfm+ZuIU+kAt7e
         BKBApd8RB4H0cU1jcFTrQziVbtFXdP1duoGwh18rf/io955LcWi7us/52WSQe7pFxdrN
         EJwVzpvtfkWkZnUNNLZTu/xoWO5mMB33a6uemnlGsaUvGomWxdXoxtP0zmFEhhokvjCV
         j/sqlOHXHII4646BvzRoTJ5hcYJbNMEgjwc+ULaarg5W/hYVGjbZHwIv/en9my3r/+zp
         yt5LVvVLIh5SJ7x/IeBaD3TVW7tdwEaGCfOtSkZAIktPoya9afYeSPdirqU9498B2Sl3
         IoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769529; x=1692374329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0e3CJJrqZ7ewmH2P5w0S/0zIFsn4QxREbiOM6aZrWvM=;
        b=XCppPxjNJ7h4RB+bxUw6E6wDm2nk24zbjaJtqdhwF2gDtNs7X/4CHoAVlx6HqtYVwS
         w2d6pci6wsDMBLQkce4zLiMfoToMHznTo1T2bFUu77kK+U9zNe+49x06mJFociRjv1A4
         h84YO7Ue3zcvJNuc9ry5WDaeDS/j2E2v5mXDurppO3zG+1IjcUZDY+Srx6TkGWacwNOe
         g7BFHakWBcUQh6zwlDdDYoK6p4qS9N5jhfPSKlGmAASHvyhqs0LeQwA+c0lVb1c2OOnv
         u6mLeyy3PSxZ1I72QegM5+LJGdH4jcdsptT2rx6NSDKCqh82l2D797MZNdGS8QdB/CXo
         +jIg==
X-Gm-Message-State: AOJu0YwwC+JJOP0P1DN73prnaO4QoswGd+XQWhNBtptL+H/5i7FUjQ9V
	2cqEf+OaMAnZnZvRz/Dj8idwBQ==
X-Google-Smtp-Source: AGHT+IEMRuVR4UsvMsf8IVtrN3B7SqSXCFwDWFlUx5pvxeBUjQjokyhxcx8/ORvwhtNlUaLQ2ZSj+w==
X-Received: by 2002:a5d:438a:0:b0:30f:c5b1:23ef with SMTP id i10-20020a5d438a000000b0030fc5b123efmr1642236wrq.41.1691769528840;
        Fri, 11 Aug 2023 08:58:48 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:48 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 11 Aug 2023 17:57:21 +0200
Subject: [PATCH net-next 08/14] mptcp: avoid additional indirection in
 mptcp_poll()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-8-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=J9VNeffJDPfkoJa+eIaJ2TO+2VxqSncVcduqI3h44xQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvfhQYxdq5nUH4ZAoej7J8+p2L5Lmk3Y0Jp
 4uaCRiefWOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c8j2D/4z5s9NgjC9q7QH5Jp/JvDdZkfDO89mpDeftND2ALbI0xuUPpP/N2wmHEm9wtubG3ZWDPP
 1YHwLOswxY4RhycdjJc8NMo3j/IqTpCtz/hTNXmOdReLcv1BiuIERObu7456c46NuhYZbG2fepu
 j1sOGlUnf6LxHPb4MLyWv5PtU90T+gL+MQFyQr4j+uumiM719nFQm+yB7j7ULl08oD/x1ZjRdy1
 BD8Sci4RpOCJJYZ5JK3/Ms6H1NOPsULBbPGoaVJks9OsFpEMwky9aPPlpDsQOQAfKVlkLp1mMZz
 UH4zdwDsJIhMC1USzsgCLBM7TZIu3lckmH6QikfyD1nJ/6R7G4jE2u3zJC6uqLWx8EJo74mfqUu
 hakjOElfGBTXTXCBLIDoBFJTDBEFspHXFtzxztgMGB7mDZIUJ2RcUwn4K8r1t7zBK2GhLfxQrNL
 mUHr3pJ/m/h4UuJvc9cyK4DHp6gN7PF/bRO+Kg0ZCTEp2zdoi8UEi24lqRRVZfJhVd2QR+1ueuK
 JZhzQl2UjPNt+UW6kN0DcNIgcIaBi+1T4l1O1zyx8jGXfyHkfC1GQ0DZe8C42hOD9d5//IZqhV+
 T9uAVSAVqZXlJ1unylAdRkJ1lgXkkuRnOri0iROXZx/wK//VK6iWZodcb2jhuj2NaYq/xZr2oAq
 Q0T1caiGXyTPi4g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

We are going to remove the first subflow socket soon, so avoid
the additional indirection at poll() time. Instead access
directly the first subflow sock.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d8b75fbc4f24..e89d1bf44f77 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3844,12 +3844,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	state = inet_sk_state_load(sk);
 	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
 	if (state == TCP_LISTEN) {
-		struct socket *ssock = READ_ONCE(msk->subflow);
+		struct sock *ssk = READ_ONCE(msk->first);
 
-		if (WARN_ON_ONCE(!ssock || !ssock->sk))
+		if (WARN_ON_ONCE(!ssk))
 			return 0;
 
-		return inet_csk_listen_poll(ssock->sk);
+		return inet_csk_listen_poll(ssk);
 	}
 
 	shutdown = READ_ONCE(sk->sk_shutdown);

-- 
2.40.1

