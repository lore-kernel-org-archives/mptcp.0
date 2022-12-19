Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D17ED2
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 07:51:48 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id m4so8242685pls.4
        for <mptcp@lists.linux.dev>; Sun, 18 Dec 2022 23:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1ymkI2ZS9oEdM8+QN725eb8XM7yvFMf0CKAT7LDW2M=;
        b=XRNUS9xA/ydUnguaeoTj3YMu/tYb4kwv7t9lbpzzK37+0rB238of73fqB6R3CG6fqE
         INWMRy98e9x1i5s+JeqxR9Yaa70Mhp6l8O73ZcE7UXhoP0bWDiPZFn0SgqJSTu61v+QQ
         QmIP1a++YlDrZX6yFXEdv+xGTT117+jRFQZmI09OM0BIHabDccA61oiPbPfkmPMDAjyj
         aeMjlM2lAdlZ8Ou0e9DOfJyePuyALeUnfI28xrt7LVHdl55lGcuypg8EcUxgdNG1kRo1
         bagmcjhvUYXgD57NOo/nf5AoAY1512eKkPOy/XxXQ7lqwiGv+C6BXKm8fM1G1ucK6L5x
         iLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1ymkI2ZS9oEdM8+QN725eb8XM7yvFMf0CKAT7LDW2M=;
        b=MPtL1FBWZCaCPsUEnDewRglxcAPaOvgszKQutj/X2V0SMOGFWxyu/wXcTs2u2L5xZD
         8K0sVygdnkmUv4TMCdG2kCp81sl8So50BsRWKrJf7dt9ZH5dKlTB1+o67nRBKqA5ria7
         smP8qLVfARp5MUkMY4cwFeZjlcfpbtA8kDj4ti4rGasuRcG+kn4ocsQa7aAT0QryAMCx
         BIALlNdbFNr5uUM7TUg9jAgQ3YSSb+p2nbLqJL5o60/Eo85wcaoZ75jfnTewz0V0y/jT
         UtNaVyBN7/Froti0kCSUFQy4k0AFIxOjmCWGvLwSKgxfTlMqaoBdM/LBqTUHFeKKJbJF
         4CdA==
X-Gm-Message-State: AFqh2kqPZ66pYqn0lIyPS3UlLcXvI1nAU7xBqoqgmkYFI65JLcHalT8N
	/3CspxXTZIH4kCXE1b+Vsmk=
X-Google-Smtp-Source: AMrXdXuda6ex+o0bLC0rqlwqwWiTzoqXMbQJIxtoyyS3g7qcVjUq3EYyAzalTQ1ujaaO/yMgHbPkCQ==
X-Received: by 2002:a17:902:f113:b0:191:7d3:7fe4 with SMTP id e19-20020a170902f11300b0019107d37fe4mr10585234plb.59.1671436308100;
        Sun, 18 Dec 2022 23:51:48 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001888cadf8f6sm6366673plg.49.2022.12.18.23.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 23:51:47 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v9 4/6] mptcp: init sk->sk_prot in build_msk()
Date: Mon, 19 Dec 2022 15:50:46 +0800
Message-Id: <20221219075048.255811-5-imagedong@tencent.com>
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

