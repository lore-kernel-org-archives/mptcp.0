Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F22CA7
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 15:47:24 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id e7so7897378wrc.12
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681487243; x=1684079243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpfal81Z6EjmtDozR8H17bXhP01vB1EPYt1nMaTOgpk=;
        b=BjHbrGR353z8XzYk0NmEqBE4BXavNlUJuFfFmC68Ouil3tuI80t345U+ERJEZ/Nuol
         eu3nfrm1UsmMTeZEQCrkA/gqDFL7UpPw2pb/6EVtF8D+JU1fevLuzQsHX4nJUfA1rFL3
         LbVu1Mukg8HB3EZsdHXdcGGQ4lXJjpSvime1S2/zK+K/mepEYy95F+p6kMbx+/+JM7qX
         J0/IcY+5TAZq3De4fSII9kpS171mUh9xNVSDgiX4apbuqE5j4q+VVyqhz4Q062hduw5f
         RXuayg5xTlu+oLLgxOtsKDThOaJe0QhY1bH/9Pnodswi9MJRcDy1dVO+L5Kxv9wOP/mt
         ndww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487243; x=1684079243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpfal81Z6EjmtDozR8H17bXhP01vB1EPYt1nMaTOgpk=;
        b=i91hFZghkO5odo3DVPXQN5EmfDfyJNhMgiNxV87N2p6TCGoZFVQCTjPWD1h4lkL54h
         zmHbHmIcXxM+zzd8fmiMI8jPCShsGshpdg/48nU2QUj/bna4QU6aB5ZuH6dpNZa6pxm7
         nIv9YRdur4XZtZh9dZcjjFMn4eJzn9sJuFUtm5zB+42U2RdESncBEM04Edg/SfgJIwUO
         vRwulyTT9pM/XS/oAamlP55NyBN0VDeRwfSBhjJGMZpg9dVnc+YVpRJ3AkauRPYlV87c
         u9Hj0cEC7YEGr7G6M1a6wz7JSwGlw9in4M5CxIYu2S1S3VEyRmEWjg4vuPME/U9/p2B/
         mLdg==
X-Gm-Message-State: AAQBX9cJqru4H/WAnTMAOzcRe2vQIPp3g1QNGCl+uR4zy7HPtH+jvtCH
	Z9rSpqglMBsdS3roMrY92m8e9A==
X-Google-Smtp-Source: AKy350b7kxOu/2UHaSN/4QDEHhLPiSWqhgwkMuXY1t3gxQlX5ThPZKJijRbxbAMNMYF+qRNjj7IlKw==
X-Received: by 2002:a5d:4a08:0:b0:2f5:ac53:c04f with SMTP id m8-20020a5d4a08000000b002f5ac53c04fmr4271971wrq.28.1681487242678;
        Fri, 14 Apr 2023 08:47:22 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id x2-20020a05600c21c200b003f149715cb6sm1034298wmj.10.2023.04.14.08.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:47:22 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 14 Apr 2023 17:47:08 +0200
Subject: [PATCH net-next 3/5] mptcp: remove unused 'remaining' variable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-3-5aa4a2e05cf2@tessares.net>
References: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-0-5aa4a2e05cf2@tessares.net>
In-Reply-To: <20230414-upstream-net-next-20230414-mptcp-small-cleanups-v1-0-5aa4a2e05cf2@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Abaci Robot <abaci@linux.alibaba.com>, Mat Martineau <martineau@kernel.org>, 
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=gV1NcAY6/tnkKf9VWYi1pcEwxZE3vF9bAm0gXkwoyA0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkOXWGmzpIRZ4fEeI/XlxK7M8E3sW44SLtFzFCe
 HKsivJpijGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDl1hgAKCRD2t4JPQmmg
 c8/QEACW882WEIPQ3ClfAl0TkV1bi26AGu5zGcgIICpo+6Q/BTNtG6Frl8WXegx6U8lRSx+LtCZ
 m4LhA/JDIhQBHUpNI7V6Q7bkB7cZWN7mugfV79O5Cpv7k3jxOvUW18dcXSAxiSb3oKfHpD24R8r
 G+5q0sirItKuWcZ2x6XQrCT/ForhoMRfDUGPvJnwpOrheZnTMXOw0hRW0y7ZBcbKnfHLPXInm6u
 jncpbEQuHJjMo3uEMzeTx4bJZk+ml4kfBPT7lu/ZSbLCQh+A4eOk1gKutvGnsADjnqgyuPki1TE
 8xw3W1L6lN9si4uB1W9QjORPj+qlCVBcxHJ5h3mykGbqOy8dzvWyiSXIEaJWcZdkJmRJuVm5lWg
 gD3PtY5Ka+O0WukGMMEYaYYiBOKeryrydMdQ9Hti48K6TYN3HAO8hVlNtnNoYb53JgyaxfKILlu
 Q/7+JdLu+NlHTiVkmRAyk8Le5Ft8oMz9BMFdB23ck+v9IfFeWwywHt4aocx8UHsjUx1PQaKxqv3
 fDgmkYc8YlbAyjggwO8ew5DmgGPzs6KgRfRWmYGzEbJPg7C4nuvRZzOEKn8OFkQxkEUyQPsPDgB
 3HGLN7brliNO3C8uXWYe3uwIvz9nUXnszNCiyASJtz0IlypE245rbqYDxHDtW9BciMyrO6rU3GK
 WToe4Ewe7e85lmA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In some functions, 'remaining' variable was given in argument and/or set
but never read.

  net/mptcp/options.c:779:3: warning: Value stored to 'remaining' is never
  read [clang-analyzer-deadcode.DeadStores].

  net/mptcp/options.c:547:3: warning: Value stored to 'remaining' is never
  read [clang-analyzer-deadcode.DeadStores].

The issue has been reported internally by Alibaba CI.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Suggested-by: Mat Martineau <martineau@kernel.org>
Co-developed-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 355f798d575a..a9801cfe7d15 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -442,7 +442,6 @@ static void clear_3rdack_retransmission(struct sock *sk)
 static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 					 bool snd_data_fin_enable,
 					 unsigned int *size,
-					 unsigned int remaining,
 					 struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -556,7 +555,6 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 					  bool snd_data_fin_enable,
 					  unsigned int *size,
-					  unsigned int remaining,
 					  struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -580,7 +578,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 			opts->ext_copy = *mpext;
 		}
 
-		remaining -= map_size;
 		dss_size = map_size;
 		if (skb && snd_data_fin_enable)
 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
@@ -851,9 +848,9 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	}
 
 	snd_data_fin = mptcp_data_fin_enabled(msk);
-	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remaining, opts))
+	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, opts))
 		ret = true;
-	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
+	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, opts)) {
 		unsigned int mp_fail_size;
 
 		ret = true;

-- 
2.39.2

