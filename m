Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4396C0B7
	for <mptcp@lists.linux.dev>; Tue, 14 Feb 2023 16:05:30 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso14059617wms.0
        for <mptcp@lists.linux.dev>; Tue, 14 Feb 2023 08:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ly6DfkEKz/G+rxKKbWncYYr46bc2Li2tCDDJdiz0T8M=;
        b=ag05wB9PpHBHmboVYhZi7jl9gaupeMoVum/iIEd4UdEfztJtdlqtoqaxK8cG0vAqpa
         HVxiTBnhAm8HYDuRjIQn/h7S2LtHv9sRBA9JaSMxs1bgacFBXFIlNNIgPb6jGqzIGulf
         KUWRtn8mCG3blgQmHPsqTlgJZy5JQ4GN+cIkstq1VmD+ULkVnxxVk83M1+PyKLAyvb0v
         lXweCzJHI89+kBcTlSbe0GnZYeVfJZNjyrlta/XWFbFGKbhTOQbTGQAjDAXW1FaAH4a3
         Etvf1Mpp8cZMxqVzVoSMJs9RHKkTQh2IKypPgjHKx7E+gTTFI2+1NPt8CnaWNz9b1ZIE
         GTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly6DfkEKz/G+rxKKbWncYYr46bc2Li2tCDDJdiz0T8M=;
        b=MBLYfLtDofcAbLGosQtWTJ38l16N9H+dMAxeKqjwMx2i3I/w6o+WOoPNXXKVxzQLKK
         ELOdqNqGseAeE4h+KPx9dPvJibOYNroZkKhyqah0u1KbXPUhkP8x8ylI70fMJ+Ruryg6
         sf+/SuDcGCqrpFcxc1U8eFDsQHBuULm49mUbC90BVe1Nl+JIxRfAlMFybWKR4vm9OcJf
         3VPWx1l9anaLGbzT31IumPNED/x4UHg89aFGkE6QKGI84LOikgE/8zrjZznjEZ1AkVCR
         But0CmN2lMT4/MEYXN861T7cpjVWXu/wtFvKJRtd5NtnFoegdpKh82w+xAXQVDjeFoWW
         aouw==
X-Gm-Message-State: AO0yUKWUG4fUF58GkZ/7poQX3wseEP13hjbRb3dIzey44L5SbpVeMo3R
	BbzXatbWsIYHSeNpNRGH66tn+l1SCdblJqeCMshdlQ==
X-Google-Smtp-Source: AK7set9dsNaaz8mZMAVPHChTu9UZgZGDw+xvILUMyZHZQ/STzLl27yRjoWAXXjB7Fo2PehqG7Lj3xg==
X-Received: by 2002:a05:600c:4ab0:b0:3de:d9f:3025 with SMTP id b48-20020a05600c4ab000b003de0d9f3025mr2313297wmp.0.1676390728817;
        Tue, 14 Feb 2023 08:05:28 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b003db012d49b7sm4435537wmb.2.2023.02.14.08.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:05:28 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 14 Feb 2023 17:05:07 +0100
Subject: [PATCH 6.1 1/4] mptcp: sockopt: make 'tcp_fastopen_connect'
 generic
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-1-02f36fa30f8c@tessares.net>
References: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-0-02f36fa30f8c@tessares.net>
In-Reply-To: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-0-02f36fa30f8c@tessares.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
 mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Mat Martineau <mathew.j.martineau@linux.intel.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=XgzkoybHN6ABv/TX942NWNid6qtwPZKWNVbrOVabEK8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj67FGqQtd+YwgDINrS+SBqFBoIc+L3o3Bk6Jmi
 IEkgWfMNwmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY+uxRgAKCRD2t4JPQmmg
 c7GtD/4un9n6YptAU7aNzIVTvTx9aLILOaddL0mVlwN6l+YChgp1geqYAsP6sfdxokobJZAouON
 qs+fzhGSJaQIl0ViU2OA+fzrNvLCLwvu/ZwNU0NbrEsSu5YmvFx1tR3VvjbvnPTf5CsNiuUSBt3
 fyleKiM9piQXwWBtRSnbhA7HHzlgKyVrl2T2a3a65CmfRYI6fX0WE4nrsIb7yZARdbxWAiNOonl
 op78YmaN1eiHuLziJxyw8tURkwM7X9AeftMw+yGJLMY1/+wtu1SVcn6BRKh2IyCS8/Ui6jiGs51
 OIJiT/vacHr4PHi1bsaBTiqt+Tb5ba3UCRy1JPwmzyFfFcTpoZ7LS5+5uUIErp0tz69IinxNg0r
 ryU6XsZ3OoMRYopVV7tXtQOmc06Ji6MYO68HPjGGBoFX0rR58JVLG/KO06nUSRe9XxF8f0PKPtt
 lQTd5d8Q+tFBFpZFx0x8Cpx63jsb3rmQNK5TryBJgAcIhhjDaoorYp6B4J6p1dP1UpENvdTky+A
 tK5ovhb92b3Kau0ejsleEdUZITndbT17y+2BXgM0erVKSz0now8CaxrRhQZlyhT8lDiyP6t77ss
 Rqf53ATYYx0Y3vzcpEusTiiui1zmPjUUrjgW5CGuOYOpzR9cxgfI/82LC3rO1yoGcVHv1psgEyC
 9Mhnev1123FwSYw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

[ Upstream commit d3d429047cc66ff49780c93e4fccd9527723d385 ]

There are other socket options that need to act only on the first
subflow, e.g. all TCP_FASTOPEN* socket options.

This is similar to the getsockopt version.

In the next commit, this new mptcp_setsockopt_first_sf_only() helper is
used by other another option.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 21e43569685d ("mptcp: fix locking for setsockopt corner-case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index c7cb68c725b2..8d3b09d75c3a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -769,17 +769,17 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optv
 	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
 }
 
-static int mptcp_setsockopt_sol_tcp_fastopen_connect(struct mptcp_sock *msk, sockptr_t optval,
-						     unsigned int optlen)
+static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
+					  sockptr_t optval, unsigned int optlen)
 {
 	struct socket *sock;
 
-	/* Limit to first subflow */
+	/* Limit to first subflow, before the connection establishment */
 	sock = __mptcp_nmpc_socket(msk);
 	if (!sock)
 		return -EINVAL;
 
-	return tcp_setsockopt(sock->sk, SOL_TCP, TCP_FASTOPEN_CONNECT, optval, optlen);
+	return tcp_setsockopt(sock->sk, level, optname, optval, optlen);
 }
 
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
@@ -811,7 +811,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_DEFER_ACCEPT:
 		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
 	case TCP_FASTOPEN_CONNECT:
-		return mptcp_setsockopt_sol_tcp_fastopen_connect(msk, optval, optlen);
+		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
+						      optval, optlen);
 	}
 
 	return -EOPNOTSUPP;

-- 
2.38.1

