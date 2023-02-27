Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447679E0
	for <mptcp@lists.linux.dev>; Mon, 27 Feb 2023 17:30:02 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id bx12so3901090wrb.11
        for <mptcp@lists.linux.dev>; Mon, 27 Feb 2023 09:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXsFeSYXhhebwYsbMFUFO6H/liA5A1XnJx5Vo1iUzXc=;
        b=jiVVUh6ZHHuKpGgbeAqEhbPiahxX+jfZWSAjgEXV8ubCHO2eeD3cm9dO+ZMPTOo+0v
         c4Zm5N40uRAJ4i98u0ChAFvGiXUCcdFBvVCqxsB6131UdLT8Cq8ob/S0/UCBi3Z1FCWv
         GWFT7FXNdspyMXNozScqtQ379CI964ap5nyUewPyzOajMluOjP6wrX+JjZ0R4j89RToF
         IplencS/rDEOm3RBcw2swu5QGQAyPM5Jtoq569WrQTGUD2dpxFMPc6wdkBcP9Fjytr/I
         BzMyL0AJjTap2JgXMqrDICHxy4+wD16ZCyUBB61BIc6JmfsF0dvc8mHF8jhdUNzXSZ3k
         bhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXsFeSYXhhebwYsbMFUFO6H/liA5A1XnJx5Vo1iUzXc=;
        b=EaB+V/y3aB1VOE3deTc3LSctE5CKXvE5JNZQAxl72WSjdStexgi/LS8qjXsm1J2Ly5
         puzBdf8fX0gMtJ4fIEpxtQKrLmrQjsrKVZnlL7BVw7STlMQyFPcpxxF/Z5obxGtD22rN
         bcWg5UDabHtbrndBzbvJjJlU/J17FYgHfmM6HwbvEwYNyRPWTvnjPTjvA4NtzqdcPVQN
         HIJ7Cb0lcXsJscYZE38FV5nLqkqmBV1pL4l/OhlIQ7DkJ7yT2jtwMnHiFQZGG2XvRH2Q
         1/Q308qDU+lTN5kn2lkcYxwZnk38WmurgO8hMWdACw3Z/1R7S9xsnCvPUGsqtoh6xVI0
         Qkfw==
X-Gm-Message-State: AO0yUKUTBFtltTFqddnsXVyJE/1s8zdZiiUTNGjbL+sgBgOHxF/0Lj0S
	sZgFIcxwR8NxM7zrOeG16o4Rxw==
X-Google-Smtp-Source: AK7set+GD+WdRwGtNhuSqMvqcdGrq1Sd6/n+McpoTWgTeywGeLxJqtJDYSevMGIS0lbn1/7OP4Bheg==
X-Received: by 2002:a5d:4905:0:b0:242:1809:7e17 with SMTP id x5-20020a5d4905000000b0024218097e17mr18569252wrq.6.1677519000848;
        Mon, 27 Feb 2023 09:30:00 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d6a41000000b002c70a68111asm7763689wrw.83.2023.02.27.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 09:30:00 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 27 Feb 2023 18:29:28 +0100
Subject: [PATCH net 5/7] selftests: mptcp: userspace pm: fix printed values
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230227-upstream-net-20230227-mptcp-fixes-v1-5-070e30ae4a8e@tessares.net>
References: <20230227-upstream-net-20230227-mptcp-fixes-v1-0-070e30ae4a8e@tessares.net>
In-Reply-To: <20230227-upstream-net-20230227-mptcp-fixes-v1-0-070e30ae4a8e@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Menglong Dong <imagedong@tencent.com>, 
 Mengen Sun <mengensun@tencent.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>, Jiang Biao <benbjiang@tencent.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org, 
 Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=u14VopBS7eG+GMQE/e+myn6drxPOU35I+54NgBvgJVc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj/OiRvO1nGXreLTk1oRKPUSKUwo3sjBg8CHxXj
 F8Jh9Ior+6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY/zokQAKCRD2t4JPQmmg
 czLTEAC66fH926z1SBI5/RVMdkXuHWcrSbzqIIAesibSfPKAd89A72IhbHffWOhgnzvfpsbG6YS
 7bWsdjYKS4DN8bvwYeoRDGPnul0H+PdaIr2P0DNW9Yewqkahkcq5fPlZvbHnz8daq5yVK63CFwg
 T7/R8aNz7484dT+yiLKjVPJSpAA9lt+kXrqBIDag+nxh3jy85+Y856hMRif3Jqq75c37+QxE3Nb
 9Swwp4GKoDBV/kmufiXgIBi2p6XC6aC6FBucSeQr3PcZox01SxcTjnOBgOqJJ0ONGaPVYlNrCUP
 O7gHIZN4jpMBkRdd3K/hNcUtncIwOSJK4WOTyKL2kKBupA3VTy3SBtQqwK3dVHDcpnOBYhrsbX3
 w7t9rGU/pOucT7fRnAoZZCrWIDCuNVmDN4KmoEShDzItBhnHdA/gyoc/77qYpWc2eh05naGu7yr
 qNY9Hg5Yu6bghEG83vUNOaFwHg9gSDSAMJ192GbViaEEsEmRuDJh8heC5bdytdU44ln+3OFZUjj
 /smLEYPqGpUnHYbFiXTYAikWsg1lE5XYATp1Zu4GUB5fSOi53eFSj3G4gqmpOKTc7iwcn7cRmpx
 ny2YtCYVVWLmB7Wt13LEMgWkyEYhcCkJawiNEvokIb+GGTXO4bppiBHvfRxyfAP852JH9kLcR6i
 S9gTyG1YrdUdv9A==
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
2.38.1

