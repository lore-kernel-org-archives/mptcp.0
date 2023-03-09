Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D7D50B
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 14:51:04 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-17638494edbso2509688fac.10
        for <mptcp@lists.linux.dev>; Thu, 09 Mar 2023 06:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678373464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgeAurw5MQ6tabjrQfM6Jio39u1LTtRrLhUhKbdYExw=;
        b=Cg0nkh6N2mnjRz9oTVqPcSePKZ79I3DFoF4oYbVoCbQoneyBkvdhLSvDYAoWoj+ygm
         QUWczEK5ebPtwC2CpLRzNAM5BpXz6MDMkQ22ipB8a8cufp2P7GPp/SfzWbDp2hhgQ9lN
         O7hSOmFAtCpo1po6Am5b53KS2MU/Sno8zilT1TY1kTUwjC48l6kLME6HZ4NHy/WUU+YJ
         wyf/LHSilpyCnkBaY9L7hX0gWhCauTZyubwK1AJ2gDAHBLAjTWWr5PzytSQTzanr79CO
         eHrF/38A6oN4JvMCOZQjt2A+88k3w0gSQWZ65EECf5s+TxC3mubzRg+sAgOaSh9tMbZ4
         DAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgeAurw5MQ6tabjrQfM6Jio39u1LTtRrLhUhKbdYExw=;
        b=p6B1RygNm5UJy/oGAc5AjijIRDdNFFKNExDSmATiveemRPQ72CtbANmLRsWCtVb1sr
         BoQCrl9ZlJ/aLhJQ6QTVJ/bxXO/rEZhfM7Qaew5qGbZgfZSiOobiViCCDGWNGO8MuLKu
         ydxtyM5bXdVtakxTXCd+4SrudtV5kE00vVpkll4y8+jTvI+b8YNcX84XIMTnjSW3NETf
         gVLvkoGMtZz7ADw9wEf4T6t4mvt+Wv+w/1t0hZnhmSfpH44Bb89XVc530uf7b+uNMfp0
         eU8cUyTI9jkSA0Bm9zys6GZSVqnyS0cnm7TNczle7DgCWvmh1frB0gSntOVEMrYsWQT3
         YjRA==
X-Gm-Message-State: AO0yUKWGofAX5NPvPXHzF4BzX/4s7QKNZwlB1Fj8TzcLjVzKGmOdM1jP
	dp1wy9/pEQoPe0EdV3/nKWZs8g==
X-Google-Smtp-Source: AK7set/94Yfw73tXkB/5sbOJy675nwgFppBnXZoL/g1os/ge410otddzBvv06nAljQJn1rFoSiNbeA==
X-Received: by 2002:a05:6870:8090:b0:163:97bd:814d with SMTP id q16-20020a056870809000b0016397bd814dmr15161728oab.27.1678373461384;
        Thu, 09 Mar 2023 06:51:01 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id ax39-20020a05687c022700b0016b0369f08fsm7351116oac.15.2023.03.09.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:51:01 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 09 Mar 2023 15:50:01 +0100
Subject: [PATCH net v2 5/8] selftests: mptcp: userspace pm: fix printed
 values
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230227-upstream-net-20230227-mptcp-fixes-v2-5-47c2e95eada9@tessares.net>
References: <20230227-upstream-net-20230227-mptcp-fixes-v2-0-47c2e95eada9@tessares.net>
In-Reply-To: <20230227-upstream-net-20230227-mptcp-fixes-v2-0-47c2e95eada9@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 Jiang Biao <benbjiang@tencent.com>, Menglong Dong <imagedong@tencent.com>, 
 Mengen Sun <mengensun@tencent.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org, 
 Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=mevXKVwguJYVDj5NKWsKg6dJCzPlEP7cAxuF4rctlYE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkCfIhuwuqoRrEHcNzQiGfZqVb0x2N6M0XyYmps
 ACVicEN6GaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZAnyIQAKCRD2t4JPQmmg
 c1d5D/9ElMBnE7hj2nLsVC/JHhBeGhtZgtA8SuE7YnP5mypX/lRaQU2u2LxrS41LX7WB2sC+r98
 sZXYmpxByWVZuYaKxRLYah2t/cT4Payeo3YALz8YusFmFvTH+XjD83L3RF74Tdar2HLxZO/ltbh
 IOwUYL+Q5kK9SzgMGcs3iqHDgLIPxXua3VIaoISTBGFb/IVG5NrnePIjX9DHC540aFJhEzbTNmP
 u13iD4qiUk35/Hl0CmOiENKHCFKPXsX3sB+/FhMg7F4U1COL+lpZlI4kIJFn8V+jYWj2+uZQewy
 YcNYyj5nX2I2dN09nvqKFRavFdu4HQ/s5+l2dD2Z08Lo+FQhJs3YTBVYSENI+c/yv6+UHF5Gtl0
 ujVKYf0QMQHl3biQesi7hQ3TKNH6ul7jflAKDBkhhMVsRnXnp/rCWTGKgKYc5MqWR4ZahAiasQA
 ERDILknXE8YWKXj0aoUoeYZusBm35XIeVHAQASkKUZi6XqC23I6RxHXQsWTyVfMf39Q8mvfxVct
 iVL4ZVpecMjlw9jYEEo60rbPeoPq7ns2KjXaF3mW/5sfp2434uVL8LoWAbKnGGVB2kiGZSij2Up
 WTCwCJJxWfc8wsY/2XNMT70Fll1AlS3UzIq1WzqXG+BFHQFwlJ88cGBzhLTNtUQkINroO0QvNSL
 Qi1YMRHJjDLp0Uw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of errors, the printed message had the expected and the seen
value inverted.

This patch simply correct the order: first the expected value, then the
one that has been seen.

Fixes: 10d4273411be ("selftests: mptcp: userspace: print error details if any")
Cc: stable@vger.kernel.org
Acked-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 66c5be25c13d..48e52f995a98 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -240,7 +240,7 @@ check_expected_one()
 	fi
 
 	stdbuf -o0 -e0 printf "\tExpected value for '%s': '%s', got '%s'.\n" \
-		"${var}" "${!var}" "${!exp}"
+		"${var}" "${!exp}" "${!var}"
 	return 1
 }
 

-- 
2.39.2

