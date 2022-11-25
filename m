Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD02F41
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 22:30:23 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id ho10so13078463ejc.1
        for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smKymeBBa7IBeUrFR8EANYkCpmEzimtdY237ZPCzBos=;
        b=cJYbFoQdv55knTfHLQrHZieq61wqn0EYtegTu+u1gXSgMnsRcvpqsNGxzeuNmu7BZD
         pDoXmiXDEIbrjMMLpxGAl7x59J+mNCaBv3Xw7nmOw2cQiTzYCeGJ5QgYNsA6EcS5e2LL
         SdVMKBZWbRG6T5IfofnhK3dE+7zDTleSdE8oba4kledHZdgkYr5JFT6gVK/xX9FaCNZg
         gQEvk/IAe1Dvsq3CPPlUJaRxaipenGrMpxS1d2jdINi3UF2IsfITkM2FHlxwf2Ho/kQD
         Jj+CANmOEQUy+lNKCtXOuRXLfRxrgbD3jv2iEPAbrujN2uLG3y/rj296IjHjJGXNgCbT
         mRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smKymeBBa7IBeUrFR8EANYkCpmEzimtdY237ZPCzBos=;
        b=03vBlpg09J3U6Jer8yoWnG8xPX2oEk5Le8rytvTBiVdqU2xPdYAm6xlRfk11kUPJ/A
         RKxSSV9jCEtxhauHAJ+eUIRS+wiJ5AlgftS5WhVHVxSr38MugZsTt6jZVgyuMlTmZo7v
         NmkJ5BnPnxS0LDcEB8b+xW/xATrS9Pr87CmkiJr1fvVZIFBT3V4/I9t8JN29YIhEcZ8l
         Bi5WYM3glzwjffF0u2WKFJh8uBcrG7L3ee5e34FxcwMumeyy61HVZvJ29yBfyfokmys+
         pgHE/pvSDH9tiK6TZ2jG6ByTIix/Yc6m8lzIQ9Ig9ohD2aYuYt5nd5bkaRIdWCqfePTl
         SRWw==
X-Gm-Message-State: ANoB5pn8fFOcumNKyja1tYlY7f7LUAAQr4EGwMLDE5UVJQuVBQTwL+Nx
	AL9grfveQQOK90CGmAzESycJTQ==
X-Google-Smtp-Source: AA0mqf7+W06P6BKYFdnjp6apAR//b9fme6f933DJVtCH/BYJaVYzeoJcn8l3tDsyUGdjivZM+7IsEw==
X-Received: by 2002:a17:906:660e:b0:78d:b43c:81be with SMTP id b14-20020a170906660e00b0078db43c81bemr24506505ejp.600.1669415421794;
        Fri, 25 Nov 2022 14:30:21 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q1-20020a056402248100b0046267f8150csm2254612eda.19.2022.11.25.14.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 14:30:21 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/8] mptcp: track accurately the incoming MPC suboption type
Date: Fri, 25 Nov 2022 23:29:48 +0100
Message-Id: <20221125222958.958636-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221125222958.958636-1-matthieu.baerts@tessares.net>
References: <20221125222958.958636-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=J6Pasy5rywxbTiBcJF5r2K+UumRyCmzkUNlg31Z58ec=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjgUHP5Alj7g+lojdWNJTyMzRKAHbHZihRsnaAGFAQ
 ghjyeE+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4FBzwAKCRD2t4JPQmmgc/RqD/
 oDcgBqCUCwGoAi1hXNdqvmfSR1QREb7BGwoVgLgzzTivGWiXmi1+0R0+OE+dQjTpVDm3OTlOK+vTpt
 xzGX/63VwCA2HPMrVzgn9KfmcLVUnKk7ArkHgJ23f4K0t53YL7VVtiA+G8r00uFkYKabZ9XrWt7z0q
 sdsGgGwPU45fE9/GSUJ0eBtiXKRe1ergC2S1wiJvJdsuuYApCrbdoKGUqGDmPOOUpHBypcOmM4cuX3
 9tsew1nFvKMOH+fj/O+S3N5P6NMT5n7CZ9r/h1KAdGkDsQAMwkhh7bsiLE7OBV+ADuRCWDWUHKVZzp
 tHWw5+615hOM+qLWxX0IWeLGIZFzS3hQxOeldTTOX02395rhdMUOCexUZ/hPAfEmpLeBBjjPE3X3ZV
 YbwL5tV7ahrthy7uaC/s76Qxamk7Ra2+KTChdzOtZLDkchjxHzxj3Z7Nui6yO/B9w8tEYmJ/WbyFA0
 633oN/YdeLYiiv9jZGCt2E4HKW0a5YY8JppUbi7fdn2K4yYs1XMS9yfqCOU3zMIGzVbpHow6AXx++w
 kAdsWXv5ZqMC70+uF2+mElkZo2dB1jKewhCDMO6V35cCXFGbQr0P7W7zPwZAXAH+MTIgJKnlrnbHg4
 r/CW+lNDCicVF4ioYlF3EoVteIXT3ieon9AIsNcPIKn1QDZUlyV1Iiqa8qPw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Currently in the receive path we don't need to discriminate
between MPC SYN, MPC SYN-ACK and MPC ACK, but soon the fastopen
code will need that info to properly track the fully established
status.

Track the exact MPC suboption type into the receive opt bitmap.
No functional change intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 30d289044e71..784a205e80da 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -26,6 +26,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 {
 	u8 subtype = *ptr >> 4;
 	int expected_opsize;
+	u16 subopt;
 	u8 version;
 	u8 flags;
 	u8 i;
@@ -38,11 +39,15 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK_DATA;
 			else
 				expected_opsize = TCPOLEN_MPTCP_MPC_ACK;
+			subopt = OPTION_MPTCP_MPC_ACK;
 		} else {
-			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK)
+			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) {
 				expected_opsize = TCPOLEN_MPTCP_MPC_SYNACK;
-			else
+				subopt = OPTION_MPTCP_MPC_SYNACK;
+			} else {
 				expected_opsize = TCPOLEN_MPTCP_MPC_SYN;
+				subopt = OPTION_MPTCP_MPC_SYN;
+			}
 		}
 
 		/* Cfr RFC 8684 Section 3.3.0:
@@ -85,7 +90,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 
 		mp_opt->deny_join_id0 = !!(flags & MPTCP_CAP_DENY_JOIN_ID0);
 
-		mp_opt->suboptions |= OPTIONS_MPTCP_MPC;
+		mp_opt->suboptions |= subopt;
 		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
 			mp_opt->sndr_key = get_unaligned_be64(ptr);
 			ptr += 8;
-- 
2.37.2

