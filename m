Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C2C9473
	for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 20:42:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso10347240wmo.0
        for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681245746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJSkDzvHDv+IldvOKYCUeGWLBa1YxITsKTNgz5UKiD4=;
        b=0yNawdYCXfHfH1a2o5KD4daFIw5hxojs6Vivsduai6u32Icbn0QMEKlF5qVaEZydDS
         ZTi9tokkuRtihm1pcqaeBvUBvBhvYDEm/l2HgI7DYHn5HZyqah9ur1KYEiAJrVRHsdat
         qRpEIWdvc3CC2VJ/LyrPBmaKibCPdsCFRYIz7fxF1COXjWcgpaSbP/+1pUZpcdtmCfsI
         j6Q2FG2UXt77b61OSneGev8C9QKvzefw+IAMTDuoTWa431wBo/XBJuh4VkkpXAd+hjFn
         +nZAPNILDcvS/6x24zbu+Hc+1/r3wQ78p5c+9llT4dXddUY9oAOq0WtF+cdbZfagIt4v
         wheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681245746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJSkDzvHDv+IldvOKYCUeGWLBa1YxITsKTNgz5UKiD4=;
        b=X7HKf8O4jQFrvZBtcGulpKsX2EsSyBcevE5pMQnrap5ZaeHKzf4Wom12m668czOqYx
         TNXCEWw5L5f3HPJh8Yc0zeSAnrDFCFo+KgT/WO3p0UakUaoUGYVo6eshzaMrPf6vdZJi
         x7U+mWZSUm34yh/LIWzH1hCObjey7rz/S3XllS6rih9D7/pr46wwyw7cbHslhh+8RnkG
         YjvNr4A3/6O3mWaku6+wQbbIGurDY5WUVLfwk35s/I76jcjZLBILJ098i33GI9TyIyzC
         s2LSAbL0u8yCDSesPcWvMqxmvmevapyjbX9jUcVTfvxm70SL8/W2Cjs8xspaHf6tclg3
         rwNQ==
X-Gm-Message-State: AAQBX9d/gT0fwvQk3mc7qEn4+U424clI8vuIkcvRiKWn2iDM6WIBV7gH
	T21vZN9ZElLkCVUlv9B4VD55yA==
X-Google-Smtp-Source: AKy350aIa6jYhKVLXpHR/Nd/AgNCfOHPkHJFHkAnJcVDq7eVZ/9K1b7yxtV82ST3VPC1yLZBlohU/g==
X-Received: by 2002:a05:600c:1e25:b0:3ed:24f7:2b48 with SMTP id ay37-20020a05600c1e2500b003ed24f72b48mr279773wmb.8.1681245746479;
        Tue, 11 Apr 2023 13:42:26 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c7417000000b003f0824e8c92sm86887wmc.7.2023.04.11.13.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:42:26 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 11 Apr 2023 22:42:11 +0200
Subject: [PATCH net 3/4] mptcp: fix NULL pointer dereference on fastopen
 early fallback
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-upstream-net-20230411-mptcp-fixes-v1-3-ca540f3ef986@tessares.net>
References: <20230411-upstream-net-20230411-mptcp-fixes-v1-0-ca540f3ef986@tessares.net>
In-Reply-To: <20230411-upstream-net-20230411-mptcp-fixes-v1-0-ca540f3ef986@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Dmytro Shytyi <dmytro@shytyi.net>, Shuah Khan <shuah@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=M0lbg2vrKXi+X9w75ix6Wwp/oOxfY96lIrVHUJdPEwE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkNcYuUYRtIKl0zwJ/mKGDzxR9gRBkAHRRLlrq4
 oIYSLoVXneJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDXGLgAKCRD2t4JPQmmg
 c2/hEACJPabxn8n8GOLIdaDIhZa3hSUPMXr+LVjq3jLWwu2tFeLrppZQpoNO50UqV5Lui8cDLjw
 JH1Y6vIxKp1Bptqd194v+luCJ3HvCC+oshWSCDjfRD1nHSNE41BMe52hiFk+a1RBfiUhxwA6MLb
 QMy/EDQMJYJyJrJnGsH3tOBHN8oQFXlfqj1Oe++zYK3joDZFIgJRJq1UNUIfsrBA/LQsb28KPe3
 UhSL/xflT3pdVZzzAG1R0jhLAIjOf/MpD82d3rmQLaz1AAB/1sCqSQRgjQFEPKjYPHXLrjO4Ud0
 ks7j9FOefboDIUG1zEe6xOJuGPHUV9vHDL1DTXkSHLKzgrBOryPELBNfMauvzlEcAUr5HJJsXEL
 l0IWbret5sg+uWszLZth+6nv8XU5MOkmA1HRaQcbFdg6Ni+KVe7XFuroxMeU9vd+y9H6OqlnEep
 zWi12vS5L+5zvmPZlfkIBwOBH3y13xIqa68AL/3SasDxeG5sncUZLI2tSFu6l2Hgxsh7yj6Kg2z
 vc55pl0aIjoRU9Lv0a1e79/y309ZUK6iHwaUtj6wHNgrI58IP/3PjXvVyIaUvwcTnUJ8osQp+AW
 07Qdpdn1CQhNnhhAPQeTCfShcCvBISudqowh+fQBf7tInGC0v7sACxSfqxyD6U6V2+au0tFkE3w
 KHw2vyIrQNnmdBg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

In case of early fallback to TCP, subflow_syn_recv_sock() deletes
the subflow context before returning the newly allocated sock to
the caller.

The fastopen path does not cope with the above unconditionally
dereferencing the subflow context.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/fastopen.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index d237d142171c..bceaab8dd8e4 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -9,11 +9,18 @@
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req)
 {
-	struct sock *ssk = subflow->tcp_sock;
-	struct sock *sk = subflow->conn;
+	struct sock *sk, *ssk;
 	struct sk_buff *skb;
 	struct tcp_sock *tp;
 
+	/* on early fallback the subflow context is deleted by
+	 * subflow_syn_recv_sock()
+	 */
+	if (!subflow)
+		return;
+
+	ssk = subflow->tcp_sock;
+	sk = subflow->conn;
 	tp = tcp_sk(ssk);
 
 	subflow->is_mptfo = 1;

-- 
2.39.2

