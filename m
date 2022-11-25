Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342C2C9D
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 14:53:34 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id i10so10863757ejg.6
        for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 06:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EFff06ZPWvMugPv1oGkzCMjn3exnmvPO5ZopKVqGxE=;
        b=ZdMgw2ulIoLy8bQMTc05YZeiaiODzqpcJbOAZ9FyR4XkdNaxWedPT6wQH8ABlIcg8v
         wmqsyD31pi+ehz+htkS5WyuGDDPhBAVrL2mhyZPPtC5AY0wtkaTsk93qB0FMVe9gLFsj
         DtS2cLwvlqvlTu6NcYSXDRmCvPiXaP1G21449VRWJXebav44m5VfvbW6rGhWhUb9wxtw
         Y9bQlEXvSNKMCOOMonqy3UhaxpIMQv4RSMazhGMbocypAHdiZqPJ6UYpYiK2EB3WqK5t
         k/XixxCYEiFbw8FXwRrlrS1PPxsEV0iu1IBYoy/y18oGN77kCsdAmotK4gZNr905uf5S
         sW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EFff06ZPWvMugPv1oGkzCMjn3exnmvPO5ZopKVqGxE=;
        b=gA7S3JqUzxlLCHVsodoW7U6HHkfKiTPB3rYBpZVpFNbZpehR9ym98J09RW90y8dU/x
         4ECOibcLI0QuRkFLma4YOGP0zJhzeledzHVyWhCZ7UGfaeCLUt5FF6QZvsTGLg7c+T2V
         xi/zJDf/k9y9UT3qJXyXvdXm7jt1cG7wjeaVcXLjkTTef9nEEl/tl/rylfmnwM/JnvOu
         RH56vZbk99UjU5N8vOFo8WJ7W6qpRsATxDhDBAnGk7nXYBbVTcZaUyJj8azpNBm3b87w
         jpKmcuC5yGLSl2/3OZ/2ppD16PN27qaZMvS1n+cZFUXUg9jMddsBpU5fRaQFi6VBC6uI
         dCWA==
X-Gm-Message-State: ANoB5pkuQ855wWqVzNsolG/BtZqfqS9vrxZMfhbwZ/w+0DzSYXDSoLzx
	c/2HOXaiGHEMqZZl9bjrefwTWFkcgwYh6VcU
X-Google-Smtp-Source: AA0mqf48tTUOC5r/AqPgEo682k7N3JnxnfnbkAs/gDCHHvu2yf5yKFgf+49GmPjUqost/g2ltI7c1w==
X-Received: by 2002:a17:907:8c05:b0:7b2:bb8e:702d with SMTP id ta5-20020a1709078c0500b007b2bb8e702dmr19359792ejc.432.1669388011845;
        Fri, 25 Nov 2022 06:53:31 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id vt4-20020a170907a60400b0073d7b876621sm1628215ejc.205.2022.11.25.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:53:31 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] mptcp: add support for TCP_FASTOPEN_KEY sockopt
Date: Fri, 25 Nov 2022 15:52:57 +0100
Message-Id: <20221125145257.123844-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=G1Qlh83lmcktMkwl0nQmArvRwPvRoEuUFSeTQcb7F4M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjgNapfdYKiCISue0z9JxPh9/PenAP503rayW6MD/J
 KqV5+PuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4DWqQAKCRD2t4JPQmmgc2GaD/
 9aaY2JICnsxuY4I0s/VxQWBTQoqGBJTQZGEfwrK7JUsEzvZPHSUHCMqGFAyL/NJo6eVcisg0Gf8pVI
 cccDwvvgJjv3xUFv1mPRI3Yz13CV5g4rg/AAAIgkVs3KzyiAnkXR72hoOiPWChd9keE5ydzIRcU9Xo
 48s+fuLNeUn5noBEQVYqVLJ7hRCbfIfcc06JL1mGY2jPxMohq9AsYdjK+zpBZ8c7zMYRKN+GtHTYnc
 Nkw9iXLl4vcWGkTK79LSVTJ8tHTiQm2Wy16qdGlgHOl5o0+z9Z9YWsWFrIzTJJEG2gOi5k2fh6DHkN
 IG1cy8XVV+FrRqyC2dhrwg7rZaV4IupZ/vfbJ2Y8wYKFToLaOnfp3WZTgeYW0rozp5aPOUWDvX9Ctp
 Le1OcnCD6MCBIVegy1K7dTJiVPN5t9ayz4XHIw5g22XMda9DlO0jOzq13z3uHy+rJqWI2kBr98lxjO
 1iH14rFGfo9FzLuZy7Qp7aTA/moHkP/EX4WpmkYCfInCqcDTLDp6vhhwGiAncubuhta39+c6reCujc
 wYUiqTMJmikdJt9VFeVouqL0Cs1lEYdxXso80wgc6ORz6OtLKuuWLThoDbztSdn+6L9PxLRECaLDf9
 p5W6dzdR2aY0D+bK6vmfefPKxObV0xmHU31VgLxyoN6HYriSM8qXFfPi6sfQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The goal of this socket option is to set different keys per listener,
see commit 1fba70e5b6be ("tcp: socket option to set TCP fast open key")
for more details about this socket option.

The only thing to do here with MPTCP is to relay the request to the
first subflow like it is already done for the other TCP_FASTOPEN* socket
options.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    This has been validated with packetdrill tests:
    
      https://github.com/multipath-tcp/packetdrill/pull/106

 net/mptcp/sockopt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index c1bca711c35c..a47423ebb33a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -561,6 +561,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_INQ:
 		case TCP_FASTOPEN:
 		case TCP_FASTOPEN_CONNECT:
+		case TCP_FASTOPEN_KEY:
 		case TCP_FASTOPEN_NO_COOKIE:
 			return true;
 		}
@@ -570,9 +571,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
 		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
 		 */
-		/* TCP_FASTOPEN_KEY is not supported because
-		 * fastopen for the listener side is currently unsupported
-		 */
 	}
 	return false;
 }
@@ -804,6 +802,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return 0;
 	case TCP_FASTOPEN:
 	case TCP_FASTOPEN_CONNECT:
+	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
@@ -1170,6 +1169,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_DEFER_ACCEPT:
 	case TCP_FASTOPEN:
 	case TCP_FASTOPEN_CONNECT:
+	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);

base-commit: bc1626baad5a7db698ca1ea9212fe3f6e45181f0
-- 
2.37.2

