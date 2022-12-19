Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545341103
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 10:24:25 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id v3so5857191pgh.4
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 02:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1ymkI2ZS9oEdM8+QN725eb8XM7yvFMf0CKAT7LDW2M=;
        b=No8pIptm0ucrQlnf+PCggDcfUzXNotEMHWBRGaTVDcppKuLefJEDvmEutTNnc8Mh5F
         eLPnGHQkCrzSX2ky8Yq0WZnCjtv7BJepff8nIT5yLSb0jvPKSIRt34QUcPP+3WeucKg+
         C1S4zdRXTsa3w2dYYnka+IWGyQRScyFzTGcmG+GZDrX20sbRdpdhRGAe5Q++V1vQkoyj
         vICNmjiPG4cLwK7RR8nI67j32abyTOenR4kt6xkbEQDWZwvPMN169032B+oCoGoaJ7VY
         xwfKf3L1UASsluEPTkcNIFecnF4YSXi62VZhjEBWPlhODHeIrKNjsyuFb/GhVse/HS8f
         CjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1ymkI2ZS9oEdM8+QN725eb8XM7yvFMf0CKAT7LDW2M=;
        b=7KueeOdG+VfCP8pWjEb5BVtbUIt5r1YCRnEYt+7S/zdWSyg6szWTKF/cTgiSQItDUx
         /rk8mUc099+RdNZXjq35QYHk3+P1epaQIKX/WKj3CDJBTSMPcynPULd0jXMiTzK28JbH
         PwwH7i366vhvwEzzw3ACiMu8QiQjHR7PFUXq7u9XqNGUWL64XWRqBvCH+G4Xy6WpIZxf
         lKObiEmsTkHDWJ1vTzXiKvVV9IzXE6HZeNxwc7Q8rwqF0gfiEJ2FirdRff0RROJjRUNM
         tP015I4FVmlkwCeZ/ieQ3f7oifN6PfVQsQk3PgaRW/liSWV9MupZl1ENdU4Htmzuktd7
         pL9w==
X-Gm-Message-State: ANoB5pl7FQH/LFYk2UTU6FzqzN7YfBBH1KIe1bYdyb6lR8cfNsJIDZqc
	75PwKUjjVb5tsGGo+4wtytE=
X-Google-Smtp-Source: AA0mqf5auK8INFIf/q+u75esm1AxnJ080UAXTIQnOVUmsqHFfZWEK17slaJmGBZzR7F+x9n0A6olyA==
X-Received: by 2002:a05:6a00:1d14:b0:57b:30b6:9e85 with SMTP id a20-20020a056a001d1400b0057b30b69e85mr22172047pfx.22.1671445465046;
        Mon, 19 Dec 2022 02:24:25 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id n5-20020a056a00212500b005775c52dbc4sm6206517pfj.167.2022.12.19.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:24:24 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v10 2/6] mptcp: init sk->sk_prot in build_msk()
Date: Mon, 19 Dec 2022 18:23:12 +0800
Message-Id: <20221219102316.627491-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221219102316.627491-1-imagedong@tencent.com>
References: <20221219102316.627491-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

The 'sk_prot' field in token KUNIT self-tests will be dereferenced in
mptcp_token_new_connect(). Therefore, init it with tcp_prot.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/token_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index 5d984bec1cd8..0758865ab658 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -57,6 +57,9 @@ static struct mptcp_sock *build_msk(struct kunit *test)
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, msk);
 	refcount_set(&((struct sock *)msk)->sk_refcnt, 1);
 	sock_net_set((struct sock *)msk, &init_net);
+
+	/* be sure the token helpers can dereference sk->sk_prot */
+	((struct sock *)msk)->sk_prot = &tcp_prot;
 	return msk;
 }
 
-- 
2.37.2

