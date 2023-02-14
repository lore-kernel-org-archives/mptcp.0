Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC944C0B9
	for <mptcp@lists.linux.dev>; Tue, 14 Feb 2023 16:05:31 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id bu23so16171488wrb.8
        for <mptcp@lists.linux.dev>; Tue, 14 Feb 2023 08:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/j0dQwXx6AIG08VyqZYo5n7fbJdrLUUxSJIZ8auBLdo=;
        b=qZnlQQy55pXjOWZ6DAwHoPbPOplfbvv3FpCSBi/m9R/gtUR4hg8FdmGUSMxYoCYegi
         BltbdKy6a7yw6gA0odXf4xvQXTS2VygQcXr7iuR5mezCGq4lNZCn5Iq0Pk+xm8qXaZVt
         tkk/6LtDmWkiDhr+J8orlQCcgjPvA+oE9YN00vAoN2DVG1vo1j/q+O+ZXz50EUOi+cvM
         NeDAIMa/k9JTM/EfKdI+xljHgovVInQbG7Fr1ew4k7ymAVi8mmJrU00N9MwdOIJzTaOU
         0zXAj6p9iFXc83GgwB5L/jiejeZJWtpWHcdLJY9Z7+poyP9Ync9hTQm0fsMFqBllsUZ9
         vRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/j0dQwXx6AIG08VyqZYo5n7fbJdrLUUxSJIZ8auBLdo=;
        b=BPSiGt+dpC5pdUciLfi5E5y7EWRNlbjah2rnetGT0h4nJ/YOKDnQAbv6f0Ae5t/xK7
         dKlxK85pMOzUv9WH0mjRTFU0URKqx0HbBxaA1r4TcUEWn4bYLb/VQ8C4azrSNot275OH
         l2Jr6I56PYSKwhkEck5iUB18UDA7dAl5maE1z2DHFlmZpF3cLPwI7jYhcDo5p7OT4ilR
         TasfGGVxTuEDDgixODfL+ybU3FLKRlEY+pxqwheaoNotRP+gCsbqWda7MKE1u8mIW8C2
         wpBPm8uQi9uOuI45D6aFFJn578xcf3GN+1X4HZzVbT3ubaMWBkBIgseXASgtJoQ51SA7
         rVpw==
X-Gm-Message-State: AO0yUKURvwB70MBLcsvvA687XFTyCIgUfCbpwm+ZRnRnm8nuVuLtbC68
	SMdkNRTSWDtghHfqCD/0cPHe7/YXMZCf7of544ZC3g==
X-Google-Smtp-Source: AK7set+1CYzNTBfFCsuzloGVhP8KsfC6aujEwUBtmCOyjWJ1RlJ8y9L+lMFJQjyyfwfwQQQ6lzC7Nw==
X-Received: by 2002:adf:f744:0:b0:2c5:41f4:b878 with SMTP id z4-20020adff744000000b002c541f4b878mr2521389wrp.43.1676390729781;
        Tue, 14 Feb 2023 08:05:29 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b003db012d49b7sm4435537wmb.2.2023.02.14.08.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:05:29 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 14 Feb 2023 17:05:08 +0100
Subject: [PATCH 6.1 2/4] mptcp: fix locking for setsockopt corner-case
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-2-02f36fa30f8c@tessares.net>
References: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-0-02f36fa30f8c@tessares.net>
In-Reply-To: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-0-02f36fa30f8c@tessares.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
 mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=i6ETWnLe4bzct348gCvCTLhKQXFC5wvBIaCMrpk/Xjc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj67FGCqR0MNOTk4dTfFX0NXFES9yH/zkaZBZ8Q
 5kGmGDHtNiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY+uxRgAKCRD2t4JPQmmg
 c75cEADoH/JEjTlQxNpGu5GKfnwnD7p+zlxq5XSrsepsw9vudIwtWjMBuQBdUNfD2DZkEePurPc
 oJlNHcrdJqh8ii6tun5AuQ09EzYwpi/WfFps+yuNEY6egAJJiz0tt1b1685KngXF1NgawQa5T3q
 3EMZXgBW7smsWjDX9bXCbJSjpW31vJ8m1DRew+XM/XuIL/5c+Xo5QSNm8o5CuuxBMLrP+ski0z5
 bUls8HT0EuEkDkbXdo76u7ras4I+dWJ2ZCclOfY4kDdUz49y77dnS413uhFzCs2KWj+Kglgelna
 n6Tl1XQrD4EIuFgiExIVee5KFSGonN4nVEgxdBcaUaPsyelVhLVgvN+tWTH9pMoSmISRMAxgt/P
 CTllTPx8Bff39mxYzIRnOArY/4+KXmpawO1vGCdOi1ra1HHXnDJUhBI9ztHPqGUUWDyhD1Ti0tt
 4soSWafx02+o4VEpgUlMKDOHzWTJXYRg0OoHTlztdayuzfAZH1/ucUqA52Bb93MjQL6WxFQRx4G
 KnjsBGq4DqUnzk4ZGDXG9aKNhtV3hfSdzzSUTuWJOXC8148D4wEXeaYh/eZ78L8o/kgiWEKvfut
 aCindYF2l5LNDzsLtd3d3tJEfXjIDQrmpS/0qgkZvSeMp4oZuFkQE+e+mF1yddxyLmSSi6WIvLV
 VsmkW439GjqbwoQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 21e43569685de4ad773fb060c11a15f3fd5e7ac4 ]

We need to call the __mptcp_nmpc_socket(), and later subflow socket
access under the msk socket lock, or e.g. a racing connect() could
change the socket status under the hood, with unexpected results.

Fixes: 54635bd04701 ("mptcp: add TCP_FASTOPEN_CONNECT socket option")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8d3b09d75c3a..696ba398d699 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -772,14 +772,21 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optv
 static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
 					  sockptr_t optval, unsigned int optlen)
 {
+	struct sock *sk = (struct sock *)msk;
 	struct socket *sock;
+	int ret = -EINVAL;
 
 	/* Limit to first subflow, before the connection establishment */
+	lock_sock(sk);
 	sock = __mptcp_nmpc_socket(msk);
 	if (!sock)
-		return -EINVAL;
+		goto unlock;
 
-	return tcp_setsockopt(sock->sk, level, optname, optval, optlen);
+	ret = tcp_setsockopt(sock->sk, level, optname, optval, optlen);
+
+unlock:
+	release_sock(sk);
+	return ret;
 }
 
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,

-- 
2.38.1

