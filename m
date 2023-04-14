Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106122107
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:08:30 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id s12so9165356wrb.1
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681481309; x=1684073309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m66cRDfB61TtjfV8yD54rvNQYmtYBLMGnE8NSc4/AeM=;
        b=fY6FXzLykolJ+i9Za1CV4ll8jWr69FyB35y2mOLGOihNwAFCEZQOp8fOjHcwtyL02I
         u5vd0ml7sD3Fr4Qtnbfyc5QH5cfa43RpmK1NozI/0c0gdHT7ZwNSc8qluqcpm7795JpG
         xqtP6e/1jo172fq3SmjUOzkZRVIJAJ76/GgZ6JE5HTIU0wKD/Oz/SMwO5RJ5L4CPVmuJ
         4p7BCaZ1DPzd4Eec0cxV2PeqngvlIZgZ5jfshNLHoIWa+GPsjezIkLKixGvFyJKfUgRy
         r+mLB4xBUezdkFjGOvXayAqFaXyqYmd8Ts7Njzc3JVGvoUxVYYPgjcGnB74F/Y1bCadg
         413w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481309; x=1684073309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m66cRDfB61TtjfV8yD54rvNQYmtYBLMGnE8NSc4/AeM=;
        b=HWG704tGEaw2J+Tr13NkbsPkaDdfxax/Na+zn7W5aveozuPycwPb6q6alGlu5fedC4
         rTehL9CpU46enXf3b2GTlHYbtDCyK+OGW3r2hwmRQd1e8Tg1TQ5ShkAEyIVUMPhBPvNz
         PhVn98x3wY9HbETcCfYNFYtUVLh9QPnuKQytG7j5/eVoDy3TIX5gPXVbow1StXHHGvKB
         u62dm12Lpk2eOjgC/zQXAFC8nGYTo1kL+VSXwDOHu6jkercyXOOdtE5PtXoagBxgRvor
         NlWRF+326joaCZRkkR/JpQQTE9/ppnP0j9zeWtEqhlyQ8INE7UuhmwWCJGhW/GnOBy2O
         2EuA==
X-Gm-Message-State: AAQBX9cagWnTdqpDN//sbhqr06cndhImKYY+4PwR2xWeKoaq5dGqi8Ys
	Y6g6zP5RH/fxpa0VvCUWDqS18w==
X-Google-Smtp-Source: AKy350bA8/0376eltw9U92W6fyJcWu/gjRqArOrAL4R63+NWGnvftSBEoJT1Vi8etirM2fPo1S6idQ==
X-Received: by 2002:adf:ebc7:0:b0:2f6:6f0c:a2ba with SMTP id v7-20020adfebc7000000b002f66f0ca2bamr3318268wrn.63.1681481309191;
        Fri, 14 Apr 2023 07:08:29 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d58c5000000b002f47ae62fe0sm3648185wrf.115.2023.04.14.07.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:08:28 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 14 Apr 2023 16:08:01 +0200
Subject: [PATCH net-next 2/5] mptcp: avoid unneeded __mptcp_nmpc_socket()
 usage
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-upstream-net-next-20230414-mptcp-refactor-first-subflow-init-v1-2-04d177057eb9@tessares.net>
References: <20230414-upstream-net-next-20230414-mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net>
In-Reply-To: <20230414-upstream-net-next-20230414-mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=v3ERWSmGTwhX1zfSOFHxV4yLOCVx2TIDjGL56UvMCw0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkOV5Zyl/LCHrWjit6z8vyaL4Okf2RFmEt3FnMi
 GJI4vpLCoiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDleWQAKCRD2t4JPQmmg
 cxroEACJ0K+liYP3kEeK1Y3OyVkmSgD4Y+GGfKtR0SOc9aYpBCMnVKufnipdwiV2iJ4j4hfwbt7
 6Q5g3VcDB7g/210e3iBTx0pjawiePuwz7YknZA1hHl3l5nWcuTLQG1yAESzwTTom7WJNTTJFJLu
 VpaNJFTtU1twEV9JmF+qBVReTZ+sa0A2cpgznnnOXii8zLtUzTsAWUXSrSWxJT1Y8c5mgjhbGmu
 Z8m+d3/Tm8izeLQtZfhnnyCV/ZG3950G7+te/gzIjeY5SAD4+ByZyz2F7Z9+O8sOKLTMwXFBGxv
 IRtATjxXwHzmW+tzijxnL4mODecfX7KRfD+P6soi4dj/hQHGzbfcNgj5n+SBT/3NEPZljm9CSw1
 zK9iUKr6Te4lW2Ewzd6uA+wzpfb3ibluVyV21Q5TLiqu3vTC2ZRoyzl2U0HGKbyuWufsRfeJ2jR
 eTWOSL7ZuAH+q6a6Hf1gJZ8IHXI0KhymFlKiMsvTY/kCBmvQkLeg04q7FRXuk5Cs9Laekn0nGQi
 jtd29DF6maOOO5NLdMAlf1puJ+zIybKP9kUjg/PtkKK6G+pWswf8W99JHjnQSlKn/78jWLUJtbj
 0wy2DQD86waQ+ded1+8otDps+5fSarm7qr/c8XEkbLZkD54ZiT197PngORD7nCpmr4JCOtzE5ho
 g/llVsoT5mxWjjg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

In a few spots, the mptcp code invokes the __mptcp_nmpc_socket() helper
multiple times under the same socket lock scope. Additionally, in such
places, the socket status ensures that there is no MP capable handshake
running.

Under the above condition we can replace the later __mptcp_nmpc_socket()
helper invocation with direct access to the msk->subflow pointer and
better document such access is not supposed to fail with WARN().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e6cb36784a68..9cdcfdb44aee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3143,7 +3143,7 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 	struct socket *listener;
 	struct sock *newsk;
 
-	listener = __mptcp_nmpc_socket(msk);
+	listener = msk->subflow;
 	if (WARN_ON_ONCE(!listener)) {
 		*err = -EINVAL;
 		return NULL;
@@ -3363,7 +3363,7 @@ static int mptcp_get_port(struct sock *sk, unsigned short snum)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct socket *ssock;
 
-	ssock = __mptcp_nmpc_socket(msk);
+	ssock = msk->subflow;
 	pr_debug("msk=%p, subflow=%p", msk, ssock);
 	if (WARN_ON_ONCE(!ssock))
 		return -EINVAL;
@@ -3709,7 +3709,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 	pr_debug("msk=%p", msk);
 
-	ssock = __mptcp_nmpc_socket(msk);
+	/* buggy applications can call accept on socket states other then LISTEN
+	 * but no need to allocate the first subflow just to error out.
+	 */
+	ssock = msk->subflow;
 	if (!ssock)
 		return -EINVAL;
 

-- 
2.39.2

