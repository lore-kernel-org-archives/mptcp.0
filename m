Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB73C23
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 16:20:07 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id u10so29990579wrq.2
        for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y45IN1p7jDcdLTEG5d1ZFNaCtf8FNGYpqLZgaQguMb4=;
        b=lvIiY9xRkUGiqtrGOhgcGarkesxxZaXWKc7aYgFWKp49FWY7o+qHfR5jY5TykF8vzV
         +SmFbLuZ4J0929yOORGoqHilN578sYzo8ABSiF47CT3e8uO2qZVg5Tr87dgwhOoVyrif
         1X/qpstNJnTlZoGwShToqhugv7lY23jDEmj4d26jGrppg/FvqWOdXC5uS/xTcymlU5fz
         F7ikXUUVGr/53uu+GQtFwLTvlVYPmb9R0lyHJtJTO99DiIpDtOQ0shqHzsBOw21SM/dT
         koc+G5wfm6+b2G+GODwcanFVjG/DxhX27QGe//frk2yx61n7gwGYf+N0nf9cO2RLoGHW
         ubuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y45IN1p7jDcdLTEG5d1ZFNaCtf8FNGYpqLZgaQguMb4=;
        b=yhtHVax6ftXVWKxLU9f4VtQon5K6RbRWtes/ph2gjnCD7oLLl3sB+Qx4lf2eGulPLM
         poppoxtya6yg0b29z1aJNf+Y3n1EgSFpO536MVYg3fss2//I9r108UMz4fQGrSJHKhde
         WueAj2cKvlDQMDFAmfddFhEANnONUBILlzw9yBxuq8TY9edDmAASw5VycJMILAIIm+dD
         ncsvZK4rCbg9kxaj9q+05nYuwmcFADETUXdqpzxRPpSqWafPfJAKVQTv+x2EoOrjpkUF
         CMElnVObfVTVTYYG0cl5BSl1LU65MjxDZsIfoQQE8OrdoMdwAL+4FkwuQ33WA+Rzde7O
         /lng==
X-Gm-Message-State: ACrzQf1VXVNSRXZjda6Bd+tbf1Xt0IznseZ7PiObNmTvgnfkjIbWhx3o
	Q0hKveSAUQqMAkGPjUbvJKY9iwlxmsFtGYXAy+0=
X-Google-Smtp-Source: AMsMyM7uSaYVyevVViFOextGhxofVZi3Myn+QXEEdajIgCWw1/3dK60S+955klkBV+wA0dsPWPD1Ig==
X-Received: by 2002:a05:6000:18a:b0:22e:c396:6c3d with SMTP id p10-20020a056000018a00b0022ec3966c3dmr5794107wrx.499.1666196405595;
        Wed, 19 Oct 2022 09:20:05 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m1-20020a1c2601000000b003c452678025sm433717wmm.4.2022.10.19.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 09:20:05 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/4] selftests: mptcp: run mptcp_inq from a clean netns
Date: Wed, 19 Oct 2022 18:19:38 +0200
Message-Id: <20221019161940.3178393-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=koKMylcJ9U7MGM1RP5VLKQdJI5kuJ8sQYdC80COXmqY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjUCODzhfY2mHmlII9vJa53FXuZ7EqL7f3IrTFJYt+
 PA5kWzmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY1AjgwAKCRD2t4JPQmmgcyG0D/
 0Zqll1PqWsp3vAclZgunkdazvnl4ITKaqMmkjn6kAAsNI44uPE6IBef4/rcLlWaP7coBcTJE4giN6/
 WBaVOfiIQLXdyKr7Srb8tIA9SF9l74DMk4TEyvoZGaQuVlpK4dLWdz8tqk72bZhGhAijuK65es9YU+
 q1iT38Tyskapv1I0hHBWk4SY5x8sAraYDU+33n+CP1dgyMPnrLgYAguogmXdEQZbeLgNu6OJxq/t8O
 GAfGp2DP2WZ5AD9/gC493oLDz9EyFxNkPaVjjBBZCakVZj0JNEG6beAYL5eRbNaJ7JCiF6xQtcdglU
 le+YbGhe+xbcFtPbSS1eVm8pBXa+w8AxXuwajc7XSSCprNDkaDxiOfOWdUd1sUl+5hcBKoKuflqoXr
 zcQtfsm0ZKpXYRhDHLMsreFTupTCkh+wT4O9KKuPLmzh1HMfaIcx7LbQEFV2UKPqL5rYHwCWpPGk01
 levQKbrz2z9pp2QzDFwVLqk7S8Mh1F+Pq5o6gRSJ8uzBUdIwpcuJtAi/ipOp0GmQL8WxVYUd/SiOrN
 emJkhTLLzlbaR92OAAzvGCyqCkcmFLNynzRgEmIaZnu2LK9I1ekNDkpwApY8meS+nLsPsmm9Miic2W
 VWZqDJrVTlw8OHQdt7CBhQR5/jadp2pukrzf/F2XrVkm7khpPsz/mh43e+FQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

A new "sandbox" net namespace is available where no other netfilter
rules have been added.

Use this new netns instead of re-using "ns1" and clean it.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 80d36f7cfee8..8a83100b212e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -282,7 +282,7 @@ run_tests()
 
 do_tcpinq_test()
 {
-	ip netns exec "$ns1" ./mptcp_inq "$@"
+	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
 	lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
@@ -298,9 +298,6 @@ do_tcpinq_tests()
 {
 	local lret=0
 
-	ip netns exec "$ns1" iptables -F
-	ip netns exec "$ns1" ip6tables -F
-
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args
 		lret=$?
-- 
2.37.2

