Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CF7481
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:07:00 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so7565180wmb.3
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6T4ITQ6VrqMaf4A8qiEEE1po9Iz8GqgNhD0fmXqjIp8=;
        b=63cq6Fna0h/v6aVVMCqKNBfc/BArHfp/1C2EVuGoRFzTKFM+1fbfJ5S6VhTcoPRxFY
         96d75APOgL6hhE1l2B0rqv21WftNfAvaOcs+cRDUvwKgLfYuQnCOc2X6uEJhVeZ8+1JS
         voPd6s84+ZwLMRXMuDx/T7qvNhCR8RAjsQOKFIzrKvdA/Dr9hhaWhG73x0M5uunHYF0d
         o57oLtDwbzrVGfjLUoZRif0DYV43H/JrrKv1pBHY7DO8i/fytwJ+MgkpTD98vmfIhGjV
         aRpHfYF3db3R6NDoNJ6HJXKvvXH30u1w8zYq2R3jGLur2xSnRN+NvPOLTxUsF6LCxGJT
         G9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6T4ITQ6VrqMaf4A8qiEEE1po9Iz8GqgNhD0fmXqjIp8=;
        b=4Banpm58ofwPZm+WAjOZAgeU6pUuVo6MGK+/yG5wda9t9lb6qSx0UImo0K/xj3ulDD
         t76kwB3ENWjGYygYsIMht/V41H1AORXFnBYk1ERxG6OsBsHIYN83FEQMriux/xd0/Uo+
         tl1ZE/90XATo4od+DSMXVZn1MXktXkHG63csslcwKL8A7C/5GhJoJe7EPVVjTBy21fKo
         Kghzh23rve/U9io5rcSVyfJ8CO/s7zNygsBpa3j7RZ/obAyi7m8zag4wU9y8B6sAVdoB
         y70Z1g5f9qytHhXRx6jV8+3FLXzwU4ooynbUVU8QrUZifWdwsceOspk2eNjYz9gXPLpp
         HWkw==
X-Gm-Message-State: AAQBX9cifIP2geMuCqDQKdkzE7PYp3pYSHAXlQRdDGfKUoXntKaS7jhA
	b84o+IOFik+uuyh6uWXgga2W6Usb8ULoWQVaG6k1Ew==
X-Google-Smtp-Source: AKy350Ywjz8KMIUiC2wCIDn0GJKmm1FOSOMtpD5a+fs9JdPw/HZEs6fyeooGLpsJVj4zUFokDB4P5g==
X-Received: by 2002:a1c:790c:0:b0:3ed:2352:eebd with SMTP id l12-20020a1c790c000000b003ed2352eebdmr1894479wme.11.1680887219221;
        Fri, 07 Apr 2023 10:06:59 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:06:58 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:43 +0200
Subject: [PATCH mptcp-net 09/13] selftests: mptcp: connect: skip TFO tests
 if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-9-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=6Da5V3QdQOYkkuNlrTEVIEYHtpe8EqDFNSykl1afZ0M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2ruxOxu2LMthzKRl72HKWzBIqClVjG2U+bA
 WCbPRl8yWWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqwAKCRD2t4JPQmmg
 c9IgEACARpD7rWaNtBjsvpdk4cc8lKBeI+ykMQ/PeQj9dErnw72Kns0RCAFd1+vgmbx8ZGlWnQg
 menyWh+uj3koB9vedI0be7Y8ftgYMgIxeSTOilKGSgd1cy6QWWUavjfbtA3KJ/rCTVS/EeoCurR
 Wp1aerH3jUhktHrE6FAIdOHSPvLURSnQ/2WYkAKKvMLM/9cJjNHcWdkv7oy4qYfTsv380+3iasx
 jAUnNsLIiDfR2SqTRR+8mApdroW0t0rP68VZVgPdH0PIobv7AKNoDyfzg9BsscGEhpbkBk2DNOP
 82mW7IvSQJiIKMb1qI6WPd4z2bD+sTIrmi8whWrbW1dNLAUC7iP9F/sKzM6dDTNJfsA1Y5veCIv
 Sy2qKavjBYEdFop4DVQaTilj5GX3YMIUEhM2xHskxGem4pbvMtanwO7aNtwQ4qKJa+r2Oa866MJ
 VUjj6zQecECSZgOpe2a+Oee92mi+cPyl/m/AMvdecreWK5DEQoZ23AgdxEWUVENT1qdrQnYP61K
 D1HOVjgck3MX8CR4B+4ZsvJxFpdgaE+TSRQYwUbIpByF2XycLDizXG/e2sWgx1schgWCuumSKPQ
 4aiNDtQUJB2zNwhsj/GB4xPh5sbTWrTuN1MKaa9ZtggCj7gwaWm/jT1i4k/f9ylJpTN4g6/987z
 JiCClwmfUD17Z8g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is MPTCP FastOpen. We can skip these tests if the feature is
not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c1f7bac19942..03a9a3519014 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -144,6 +144,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
@@ -767,6 +768,11 @@ run_tests_peekmode()
 
 run_tests_mptfo()
 {
+	if ! mptcp_lib_kallsyms_has "mptcp_fastopen_"; then
+		echo "INFO: TFO not supported by the kernel: SKIP"
+		return
+	fi
+
 	echo "INFO: with MPTFO start"
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1

-- 
2.39.2

