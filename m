Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF657491
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 16:46:38 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id f27so29841462eje.1
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 08:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRkaRWa68s+KfYUixfZ8VbXXfSdcHjHt5h/6roHd4ZI=;
        b=dj0keSH82ZrUXCEr20kUKMFs/qzFXCcxFzUGu6MLUumlMQ1VjD1GWLcSjB5WvR9bHi
         z1U7mMbT1OHO854eBfxxhEr21EM003ihOZkf2WVcoOMIWoarxNHJybrnyDNPO4vTkLky
         0mJfQXbvCwOI2Anrakzm+6cmaXhGjLOBsgcyTKhgFnruFlx4OQxg0pTalOIgujYvw6hT
         cTG8lSS0ST3J5dZCq+jkRXkDl3alF33FyLJMiTJeZgGDIF2ydXHjXucsGoxDAFVvfOze
         ggGQl/2Yc2u2SGOxsIObN7/eW3eTgAisZhhVXGpvmxFRXLsM8ZbqGDvStRL5d/KaclJy
         qJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRkaRWa68s+KfYUixfZ8VbXXfSdcHjHt5h/6roHd4ZI=;
        b=vXofEfew5NELMVoh6uDm9vQSi+euOUWUJEww8li0K18Weblr4VUdc1EXWy2I2wJq6G
         frib8HXOAFEaEqkLAfbyX5tlmhpE1qslVqkOlUxBPf9MfdsfPWENTCNSOSg7LHZhfjup
         CI1HSrlU79VW5gqBhCmJURP0TlnzMRu3vehmvz02aGOd7UyPWHKlzlBzPmeFNVYngpd6
         LOvKt8yaNkgae/dve2rufwYxImgVWQOHMhf+ZN50lhl/4Gt3hk73me/lD8VS06s65n3I
         AOoCwLcNYW+Bl95HrOhCjj59U9TjUQzulSLu40v7t/RZ66bNZVmbuSsBDthLjn4SnwuV
         PjSg==
X-Gm-Message-State: ANoB5pnbDG//n59WwBW8x+ouXba7kaxhKZoe8SjQXOJCsfrB6UE1+U5l
	ycvZgD5MwBCRtmcXg/tWt2xr9LTZLIDWAQ==
X-Google-Smtp-Source: AA0mqf5gnoLanoNR5cCC//CgNZ/7MnxWTtQ3e29xoTRZasgZQHfx0nVDNeYEUdl6zbaE5v/f2hlxfA==
X-Received: by 2002:a17:906:2305:b0:78e:975:f0b4 with SMTP id l5-20020a170906230500b0078e0975f0b4mr10776257eja.641.1668444396755;
        Mon, 14 Nov 2022 08:46:36 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b00773f3ccd989sm4377877ejb.68.2022.11.14.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:46:36 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 1/5] Squash-to: "mptcp: implement delayed seq generation for passive fastopen"
Date: Mon, 14 Nov 2022 17:45:57 +0100
Message-Id: <20221114164601.861295-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221114164601.861295-1-matthieu.baerts@tessares.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=Ygbh73xM7sA/FfzSwGszFyY8KY4zusxoYdFnK14EZ80=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjcnAxxQdMeDncK80BEj0Orw8Eb+AMITe7I+Se0aSY
 g0hGrwSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY3JwMQAKCRD2t4JPQmmgc9udD/
 0ZGlze1gHHPEdYsi1bjQXa8PDHt1TDcpvMrwt3mvacXO7di6XpVGbhwfZOk3JwDJeZDAmNHvIwoPZW
 QsgTl86CMve8KZ1iqT0JNtmkti2T7OcKlgRCeuvoU6k7HtWoF4NGODnOP3YA8NN9AI8cusIV2DfgJR
 NTJ2RbHwrJ+OGyxpeaB17a4eIj0EuFec/ZpbSea2PsKUlY/U9NlDj6iSItWqX4TA1GCgZLmaPAj8Iw
 CYgcQ17psdWTWeR4Rcu4WIhksBJdN5kEvQbvvWk9ZoG5j1AgxQ3F/JsFSQQqzF3OA3xFQTdJcpbrwa
 S4CsjC5n1CsmJdgFCLPTzNHV4n5LCBx+173E9v34GYFXCNesaJPK75+mWFMNBYBEriVK5fkB6D5BEZ
 r3pis+imhNLsWu335NuYAs0nuCdqS0TyBrcbOz4XhKDA46Mk4GGlM/Ei2IhlPHXayPwA+zXemVsOK6
 sOrF4bZdxTOgckNLWep8b9gSL8dFP+kQq88hbwHi+qJdQ5lpxysNM87YbCdcWpoqdx5reYo8f8tdQg
 FeTgBrzb7/hgvHsqFiR4MM1JYDpgiDkAbVpWdNZViXmjwmpyiYPIs4APV8gX1LcA1fTyOBQ4HDkl36
 g2lDS8SYUgrr/TZpwymQZC3Xic/5cmTjFR3Gz0BU9JtExRBDHERFu9bHUxZw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

mptcp: fastopen: uniform function names

Functions are usually prefixed with mptcp_<filename>_(...), e.g.
mptcp_fastopen_(...). Do the same here with the new fastopen functions.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/fastopen.c | 2 +-
 net/mptcp/protocol.h | 2 +-
 net/mptcp/subflow.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index e1fe919c00c2..d3f1ce7b45ac 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -51,7 +51,7 @@ void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subfl
 	mptcp_data_unlock(sk);
 }
 
-void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt)
 {
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0f1e26e55c01..96a3386c908a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -848,7 +848,7 @@ void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
-void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
+void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9c6f6c9a1f9a..b613046fea11 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -687,7 +687,7 @@ void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(msk->fully_established, true);
 
 	if (subflow->is_mptfo)
-		mptcp_gen_msk_ackseq_fastopen(msk, subflow, mp_opt);
+		mptcp_fastopen_gen_msk_ackseq(msk, subflow, mp_opt);
 }
 
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
-- 
2.37.2

