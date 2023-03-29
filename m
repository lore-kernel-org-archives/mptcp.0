Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529591C3B
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 13:18:31 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id j24so15718795wrd.0
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680095909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKPxVaCaUrmUbPN8pDxVsYQqvlfNNsMMuNiMHNFMngs=;
        b=I08HrYuvl3jMYd/0bHRhClR9cSxo4toO0JsibxSe8ZG4oZN1Efbp4ErkSVExVOZa0m
         ng9WLaNb4UW7d+uckQPAh20tQZ2mNV1ROwCamxMDSwV2earWzVFzcLBxV5wWSvM4z79g
         lUs9c+9dA6Nihg3I4kWC5+GlirWu/8Btcj9bwJoaNZF5zgXfrJ0QBIax+buPj7xwj9pJ
         nWI9t24Ti803svrmkBJqX7zX2Yiwd/gac9f6dmJbBWE+b36zljCLHswj3CpYQHsxr/iF
         s1k7syHV52Kx4MwX1zeh06M/vsIkC701mACPC4PCr2E0k+ZEx6YvrAshAEDgUw8rVQqt
         JfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680095909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKPxVaCaUrmUbPN8pDxVsYQqvlfNNsMMuNiMHNFMngs=;
        b=WAnYbrSvFgvAGrvl6n6FhwXdheSdXfS1TsffwKGs4Gc4CAt8O1DEXU/2wagyNhDD0b
         JWJcnkzw/nmYNbTx3h47zCOuqx0vKEIktctOpjoZr7SXFrEcs6nFmQ1iqlvVO59wxi2O
         7+zNg7chea1WWn0D8B13nzqC8k45gVzFXC7z3tL4/j00r1q44rJhqZBxpaa8xDPRSjhk
         ydhUxgFEMGVJhi09W/RaCk2+x6reE47iSILmesr5rtGZ89W2Kd7AWXEqdC345XnxklO0
         fczDQKgZhpRlQ5M+qdoBB9ZLtQ0RJBGvnBVE5SzypvLMuB2e3bHnE8ykUsx6mC5rZ7Iv
         94Og==
X-Gm-Message-State: AAQBX9dSVWOwLches0rilaoYJkVRf00LbftywMOaouk+CbAPr2suf6Ac
	evh5jVaJO1jwCRS3y4syadJ7Iw==
X-Google-Smtp-Source: AKy350ZTckh/ZVYmyd5JDHrT/xYTy/l6TkQbHEcKsNdDam92v0o9NRdO53DAaLuPh0ygWIuxOOrY4g==
X-Received: by 2002:adf:e885:0:b0:2d0:835e:d73f with SMTP id d5-20020adfe885000000b002d0835ed73fmr16303657wrm.12.1680095909504;
        Wed, 29 Mar 2023 06:18:29 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020a056000120d00b002d7a75a2c20sm22933678wrx.80.2023.03.29.06.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:18:29 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 29 Mar 2023 15:17:58 +0200
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: remove duplicated entries
 in usage
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-mptcp-misc-cleanups-v1-3-a839001f0b05@tessares.net>
References: <20230329-mptcp-misc-cleanups-v1-0-a839001f0b05@tessares.net>
In-Reply-To: <20230329-mptcp-misc-cleanups-v1-0-a839001f0b05@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2642;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=Y+9qUJGqTfi5yFGOj9rCziZNuBnZH/yB4b9VFzBTrV0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkJDqjWGgRG5t6M8ztQsyYI9N+pnapNVlvCnHOj
 vVlJ0RzrPuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCQ6owAKCRD2t4JPQmmg
 c1atEACGHqvQLIsikNITid2+j9utmv7jfXUVeMVpaDihqFDtuCrXu1dCiLFomOAQPaBAqmyIu5R
 gwDE/9LEFtCtKm4ccLxP2v39ZGkjPjaq0uH58mnmrNh1AxfqbDu8OxUDyOnf8LyMKlCPWvqr5ix
 6M1yjisozYSDAa7st3jsOEkOOl6iJAZn4puS1utw662ksQEQpxJx2nEsbE/5w2dI3KPU2BZWVGJ
 g/rssBRGhmp120brOgZO0xll3R3ZooiKyQ/90hQh6/vmvZugCfcxPhRS+ZS24Shk4TR5VQYi0jf
 vDS3OsWz8RvrZTo/YssQlCnCI+A9ZOZ0rm1bYf8tJaoLIRX28BE3d2PAatZdWDv0Fpuzg/j9BBs
 UyAXwmOFQmUlMjoO7Kfme2Eiq1RzG5muwYPqNbpd9XVrYeXTLfqoa8ADwiDWz6fE22tqk0fMbac
 O6GV3Kz1a/Pj+0Lq8UebDb85sd31v6zyt3jkED2DCqSYcU4MSEYhzsOka01grOimzypPolU1DZB
 0ZAJwodlfuQgNQ3/U90jcGBs2JvBsPv/otiX4brs3GUNw9tsMKbFo5roMwduHxV1j7OOYdedQbY
 vwjN+5mStLygxlsbo4GpgIBlKZtuvNzhFPyWZo/Xun6yYWmNxZUEq+xPADxsml35b8S0fZfPOOt
 Gx7bHJ6m2L9bpaQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_connect tool was printing some duplicated entries when showing how
to use it: -j -l -r

While at it, I also:

 - moved the very few entries that were not sorted,

 - added -R that was missing since
   commit 8a4b910d005d ("mptcp: selftests: add rcvbuf set option")

- removed the -u parameter that has been removed in
  commit f730b65c9d85 ("selftests: mptcp: try to set mptcp ulp mode in different sk states").

No need to backport this, it is just an internal tool used by our
selftests. The help menu is mainly useful for MPTCP kernel devs.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b25a31445ded..c7f9ebeebc2c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -106,8 +106,8 @@ static struct cfg_sockopt_types cfg_sockopt_types;
 static void die_usage(void)
 {
 	fprintf(stderr, "Usage: mptcp_connect [-6] [-c cmsg] [-f offset] [-i file] [-I num] [-j] [-l] "
-		"[-m mode] [-M mark] [-o option] [-p port] [-P mode] [-j] [-l] [-r num] "
-		"[-s MPTCP|TCP] [-S num] [-r num] [-t num] [-T num] [-u] [-w sec] connect_address\n");
+		"[-m mode] [-M mark] [-o option] [-p port] [-P mode] [-r num] [-R num] "
+		"[-s MPTCP|TCP] [-S num] [-t num] [-T num] [-w sec] connect_address\n");
 	fprintf(stderr, "\t-6 use ipv6\n");
 	fprintf(stderr, "\t-c cmsg -- test cmsg type <cmsg>\n");
 	fprintf(stderr, "\t-f offset -- stop the I/O after receiving and sending the specified amount "
@@ -126,13 +126,13 @@ static void die_usage(void)
 	fprintf(stderr, "\t-p num -- use port num\n");
 	fprintf(stderr,
 		"\t-P [saveWithPeek|saveAfterPeek] -- save data with/after MSG_PEEK form tcp socket\n");
-	fprintf(stderr, "\t-t num -- set poll timeout to num\n");
-	fprintf(stderr, "\t-T num -- set expected runtime to num ms\n");
 	fprintf(stderr, "\t-r num -- enable slow mode, limiting each write to num bytes "
 		"-- for remove addr tests\n");
 	fprintf(stderr, "\t-R num -- set SO_RCVBUF to num\n");
 	fprintf(stderr, "\t-s [MPTCP|TCP] -- use mptcp(default) or tcp sockets\n");
 	fprintf(stderr, "\t-S num -- set SO_SNDBUF to num\n");
+	fprintf(stderr, "\t-t num -- set poll timeout to num\n");
+	fprintf(stderr, "\t-T num -- set expected runtime to num ms\n");
 	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
 	exit(1);
 }

-- 
2.39.2

