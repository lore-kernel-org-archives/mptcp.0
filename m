Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E8219BDB
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 21:17:47 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso9988075e9.1
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689283066; x=1691875066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsJALsxCC7W/CAsd1l447Gkg4QP+b67KVu4aEHXx1H8=;
        b=bt3cywbmI2xlzlVR6vRTSp+EcwPMU/Po0YAkZsTxYd4qeBDWmBtWWW1L7ZLZu7/Rp0
         /rorCNOUTXNVUWcLrGeCXbk9yTbznrWpdKIZ7g9alJTVVuqw2gcb2COuguuFWoQ4WVon
         8Np8h5Mwx8NsaQNfcxYyX911xkWytdrDTsxbw4eODsgaFgUIe4+SqpMumx7RaLTQ5+8X
         MIOFF8AO8Bz0TWAlXVTJYgThE16Hn01Y+16mpzsUXW83Vbix9Z+QtRQAytDsiOD3+9vj
         z9e71xvYt+xLgB2ItMz8f8lLgv4n2Y8YAhJ+U0f4CoRe+c31H6HDYo85nab2G+EVApeg
         4c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689283066; x=1691875066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsJALsxCC7W/CAsd1l447Gkg4QP+b67KVu4aEHXx1H8=;
        b=YBvkyNEfjTqX5LSbxGQglSDKLV1VLzPEQVRjJNVdc0HMuvclNhZhcEq5pFmSUpkvgL
         8mTIJ2bcmW/ureW4cwl4EG8VPx73dRkA+9GXJDtIs+Vdpn2uwrt0R1RoQ2qlzJotc7r2
         eGqK1LkxDBv52kuYTS9V93SANL1hpUOQMr9rYxCRbbNX4DKEeMEUa6kflb5UI6N8UZ8L
         NU6OA47ALdvPfJ/GP3x303X3F1nVBv9nCL3OSeRRQXwURfE1WwDVT/x1ggVdKXHix5cs
         XHANfbSXwRdN41JlYnUCcWPwYnRlCEUUc8H7iMyJlvwqiY6aFnxpjuBUc4kTfyIVY/IT
         mlgw==
X-Gm-Message-State: ABy/qLafJliDDwVFWKL/u7CL3cUv6R6Mw41CKuMAP4eHn/0mMVyXXkDA
	g5ZkEMC9aeK+SdUdge7REkl0Cg==
X-Google-Smtp-Source: APBJJlEqHDqd/DaR1zZg8FeNIPs0jDRzB47sGZJXntmh5xucKXav31Pxi0b1G9aQg7Zs3wM4F2CWHg==
X-Received: by 2002:a7b:cbc9:0:b0:3fb:e1ed:7f83 with SMTP id n9-20020a7bcbc9000000b003fbe1ed7f83mr2882825wmi.33.1689283066347;
        Thu, 13 Jul 2023 14:17:46 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bcb94000000b003fbfea1afffsm8734136wmi.27.2023.07.13.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 14:17:45 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 13 Jul 2023 23:16:46 +0200
Subject: [PATCH net 3/3] selftests: tc: add ConnTrack procfs kconfig
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-tc-selftests-lkft-v1-3-1eb4fd3a96e7@tessares.net>
References: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
In-Reply-To: <20230713-tc-selftests-lkft-v1-0-1eb4fd3a96e7@tessares.net>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Paul Blakey <paulb@mellanox.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, mptcp@lists.linux.dev
Cc: Pedro Tammela <pctammela@mojatatu.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=YxZMkeKTSYd/i12Y6hiS0Va0uPxVYaw6onSJrdJZ2xk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBksGn1bBYwvMN9ZJOmDSJeapOx7V3gAfyEaaHiq
 u4fgEkD5s+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLBp9QAKCRD2t4JPQmmg
 c/79EADA/xNSe+OXe+fAkOmIazz02wIFBl+djuhBXh/Wq7uTJ/wXX2LVXz7haAPg0yi452RyvW6
 Y3umutQuwMqvWzIStUfkZHrvVTBjBp2u7zvgkknGe2hDS7tDLYXmbQ667Qs340s8OUMGqvptQk7
 y25FKL03KNuLSokg0OhB1Dp1u9hAYsuDmp18420NV6kDA3jPi1WMMzd9FV0iajheLOgk3TM1/JM
 CmY1+0inJwGExfLshAmG5soMIwQwZql8d1Lq4lD4hn2tkfUPO5tsrcoOaj3y2rDxE6vECvC9sWI
 3syinI2F9TgnuGw/+OXCL7GkqLbD/1ok/fTu0M2AQV1e6dOEbi4xTxMlqhAOYlqC48rsNVrwiIC
 5xxByReFo7qwwKI9y8JVMf98hF04OY8vwow1gw/Cbwf15/GZpWnIWqFRfA9PrYpyxFs0iq4ASeL
 6opLFLVqXBXpeOsySZvp6gl3GqxMk0oNCpDRg29Q9E8EkzzMlIjqJKZUsQnFvrwJOOKNPzi00cZ
 +AWTZiSk7qawGmeIBg1KKMdLx0xcG1puAieB1bzmmSB4ZXlR4aogcXkAE+ku92dZ6PYvTxdt8nt
 2UUXOHdQmUX2S4etArxuBVMbnXQ7cHk7oHy9Fat5T/EwBWQK3QQiWZEmdI/qPOxJotVjg3ZIiaG
 r69EzqvS4gPH/QQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at the TC selftest reports, I noticed one test was failing
because /proc/net/nf_conntrack was not available.

  not ok 373 3992 - Add ct action triggering DNAT tuple conflict
  	Could not match regex pattern. Verify command output:
  cat: /proc/net/nf_conntrack: No such file or directory

It is only available if NF_CONNTRACK_PROCFS kconfig is set. So the issue
can be fixed simply by adding it to the list of required kconfig.

Fixes: e46905641316 ("tc-testing: add test for ct DNAT tuple collision")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net/T/ [1]
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/tc-testing/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index d1ad29040c02..71706197ba0f 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -5,6 +5,7 @@ CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_LABELS=y
+CONFIG_NF_CONNTRACK_PROCFS=y
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_NAT=m
 CONFIG_NETFILTER_XT_TARGET_LOG=m

-- 
2.40.1

