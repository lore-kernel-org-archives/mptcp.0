Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F67107A9
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 16:00:27 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so22164845e9.3
        for <mptcp@lists.linux.dev>; Fri, 07 Jul 2023 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688745626; x=1691337626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ug/zyg7QTtmZV359llzk0qUpc7JObIf2czDUKOFfuzc=;
        b=ezNHVWRmON+S7I/PaG2ThIEEtnA5zZKbgGbBJz7krrAQvTrDgMbP0kyFgyH/qv1vyK
         wtT7vlzqOrb0cUzjlEUOdu+J1aNYCBmnEkPqfjWmp/BMpE5vLEjqs1wl0jdOGd48tqCM
         Wrh3pUiqpeOPz5FZYppT5XMqtjuYWr5JYmToG7a1Dn4sy1ZULCbAHrIYy9yZhBoB2qCn
         FTkrDAPiswoOT7aDdIYesWkxjTAga+YzkAStUoxF+hrGjStOqCyqmXC87srdtOupmEwn
         z4zpsbBIzH9Kh/maBm0m1ioTQcPzR/vEKRkGpZ5UHyYwoQSfiwSOegQ5Mm1+he+l9wx8
         djQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745626; x=1691337626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug/zyg7QTtmZV359llzk0qUpc7JObIf2czDUKOFfuzc=;
        b=VTOCyOBuHCVSnE8E74JLMeVxLS9ZHN/Q1iI6t4NjjB9K3LuTlaWSEvsJzWK3FQsmDl
         xQEu6/8QS9rnKrrho1vtaw9ZkOty9tGvL8S4e6BPidQk/fzQsGfAj0q+x3fTAqARSbWa
         3jbyW5IahOLp2OjIijIaNYt7MVPEc7sTZmpVrGFWm9Pgvf3Bhe1Xe//1VPLO7HOyk8F9
         EGoInHh+tc6LEKwEFr2dc0fqM9r9hrB17MT5OE+gPgzqQnLgorRX6MVbt1+E6k+jMdvD
         wiJj4l15cTAJY9O1SidgsgoRMN6ciYdQz6OBXi0hRIXcdfTEeMXyhIZ/AZZz92U1UghH
         wNqQ==
X-Gm-Message-State: ABy/qLbgnm2kmujgXa4IpZIPKoZs7SZ1tp3IMwyByYZRGJ0NQMG2zSeq
	3jh4LiYXDHkIW7yBZhvZMXwwOtTzcR8IrQO1lJL/8Q==
X-Google-Smtp-Source: APBJJlELClgw2KHfHQmhnIZQ1GZ96PGbUJZuZPHEUrDw6/CoQK5QTxHXEDSA5OZnYuFo7LNECstSCA==
X-Received: by 2002:a7b:c8c9:0:b0:3fb:ff51:1328 with SMTP id f9-20020a7bc8c9000000b003fbff511328mr2371444wml.35.1688745626068;
        Fri, 07 Jul 2023 09:00:26 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c108b00b003fba137857esm2829186wmd.14.2023.07.07.09.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:00:25 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Jul 2023 18:00:12 +0200
Subject: [PATCH mptcp-next 2/6] mptcp: sockopt: update supported list
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230707-mptcp-unify-sockopt-issue-353-v1-2-693e15c06646@tessares.net>
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
In-Reply-To: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=cnP8PAdTaVpKe5tWeuLP8jdG5bJlJpdcbL9GEMfAih4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkqDaXOFA8SaYB7GmcDza4G94zbYLY73QQIA7q9
 RN5OEvzKDKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKg2lwAKCRD2t4JPQmmg
 c7hhD/4gyxlt4JahkUZ95jp/ZoF6M28WaLAX+gPsISq2PyEhZbRfLd7qJiJiFyWTJE9PyzOm13o
 1jueP0cSJhMdecq+zseXjlwYUn+CwbaenJiDlhVD4asFQEyOFFq6DVBrjqkaUqYmsqqfNblUZfl
 IhNK/AdTPavQXJSYb23niQ8ZIwzj1sptIhcwtkXh6b4cOoGMT5shKBpLKzZ6nKnP27DQ8cXIJ6v
 ytUuNJD2qN7Uc6hBIQBofTwSjMBYmcUvNSuhHH0nJpmow62tfrIreNDRt3zMaIUzCR6wcE3/drI
 4Wkk9k5LZobgzGV03aYuLrdappP0tV2syuBgupdTc2bMQGPlwg+8iJwlr7ey7zcUHzzdWabtYHN
 yH5CCPMuPrh+0dv9INe++l1Yh9RzZyPJWtSy57NsFqtdhUQccseJcdGENKVuUP8iYRuOmm7r+FO
 jqCLOLrA88vl9HgdleRfKv2ygG/hy9mk0dYy6ByVuYrL+kPRDNFe6FW7pWdk0iDqTPALypmM/MK
 NutLe7Vykf20tIEtNdQssSRZxznH/3Jeq5fXA4iaLwR/8an6GAVPwYgmX+h4FVCT56nrJWs3pw5
 JkjoL80+Sb8466oC+WtQ8HUltMniRyBOnQy2TO+lL9Z3oKF03iI9+fOIi684BS4H1jJaorGOJ7H
 QZ5CqsXByF1QA8Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

IP_TOS, IPV6_TRANSPARENT and IPV6_FREEBIND are fully supported but we
forgot to move them to the "should work fine" section.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a46a00bf0f08..af1d30c8832d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -437,6 +437,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* should work fine */
 		case IP_FREEBIND:
 		case IP_TRANSPARENT:
+		case IP_TOS:
 
 		/* the following are control cmsg related */
 		case IP_PKTINFO:
@@ -450,7 +451,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case IP_RECVFRAGSIZE:
 
 		/* common stuff that need some love */
-		case IP_TOS:
 		case IP_TTL:
 		case IP_BIND_ADDRESS_NO_PORT:
 		case IP_MTU_DISCOVER:
@@ -479,7 +479,10 @@ static bool mptcp_supported_sockopt(int level, int optname)
 	}
 	if (level == SOL_IPV6) {
 		switch (optname) {
+		/* should work fine */
 		case IPV6_V6ONLY:
+		case IPV6_TRANSPARENT:
+		case IPV6_FREEBIND:
 
 		/* the following are control cmsg related */
 		case IPV6_RECVPKTINFO:
@@ -500,8 +503,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 
 		/* the following ones need some love but are quite common */
 		case IPV6_TCLASS:
-		case IPV6_TRANSPARENT:
-		case IPV6_FREEBIND:
 		case IPV6_PKTINFO:
 		case IPV6_2292PKTOPTIONS:
 		case IPV6_UNICAST_HOPS:

-- 
2.40.1

