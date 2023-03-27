Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DDA57
	for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 10:24:16 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id s13so4724102wmr.4
        for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679912655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWubI3gP1geg1ucxdfNQCa8sYMENfAIXdm+9lJqXCzI=;
        b=PNV21uBRDJfTwQH7Vwf0vcXBpBoxXBTJH+0rwfYzLf2DVyhsztwqlQMKUzYCVTPzt0
         GwrfIyClcqqJu6toj58ZI6DKgtk/jlIwjLkW8Et8J7XSmoIfG6EPsDuirfsuqpXHZRZZ
         nLUtvroz9DgsidvAji4iULOjN38T8wqZl15SZHCF6tllb3UmfNUsCg9k7AnAuGeH/Dsu
         ChWVPplrQZhhc0ChJCVn16n9lbRyFhWWJWExC1kN9ranLc+uLhdiEdsIi5Y8UtjBpNMv
         aSrzUE2IQ7BlqzXf2qntbF7EA4UGScCdAYk0moIv0IEku7J+6PaWKPpeAgLbdcycOox3
         2/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWubI3gP1geg1ucxdfNQCa8sYMENfAIXdm+9lJqXCzI=;
        b=AZcQTANeBkID6l0mu+D0j4DX8dbeSVh8OjbyDIdQ1vqnUNVlxadoZ8IC8ca6A3tdDS
         0cLZi9EHpSBQM+P/JjPAjUi8hZAtbzVNAeIy0jSeXKZVWVmqpB7RmU8Pc75PpCK7BM9J
         XwShgsKnoXTOSQUAZqHgPZ3va5GVT1/XXFpknBRD5FU4vsQL24q7O3pZWsc+pyQNmiYa
         6HDTEjNDcGG68V9Sq1sI2IapikKsxBCX6usADqukujqo5h5eOKNrJFdGL9aU1nS6hwum
         IBnJ1OxxmGYu/bVYd3OZXpbzDgMWUOQmlUTmeEWhku1NYSALj/DPmtCeLa7TtngIkFZ/
         vypg==
X-Gm-Message-State: AO0yUKX/zVdrrpthx77TdovDnuQv9C5F/A1Bydw7IkTwqDbyEtpY6wuB
	gsnChp2EU0/7nmgb9fD5olErLQ==
X-Google-Smtp-Source: AK7set/LHrrHKvycuCGsFkWMFMwMXWVreY0rHRL6wPMEyq3mSsYeibttvymmsg0e1CVsEgnvh8PJ+g==
X-Received: by 2002:a1c:790b:0:b0:3ed:9ed7:d676 with SMTP id l11-20020a1c790b000000b003ed9ed7d676mr8956528wme.13.1679912655025;
        Mon, 27 Mar 2023 03:24:15 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003ef6f87118dsm2220615wmq.42.2023.03.27.03.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 03:24:14 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 27 Mar 2023 12:22:21 +0200
Subject: [PATCH net-next v2 1/4] mptcp: avoid unneeded address copy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230324-upstream-net-next-20230324-misc-features-v2-1-fca1471efbaa@tessares.net>
References: <20230324-upstream-net-next-20230324-misc-features-v2-0-fca1471efbaa@tessares.net>
In-Reply-To: <20230324-upstream-net-next-20230324-misc-features-v2-0-fca1471efbaa@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=740;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=So4mzRtrXIJRD2ZN6IwFIBWGw9rUyByeoDq6UPFlPB8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkIW7Nftig6dQW8wQPUwWwTL4dEEUFiMDCFXMmM
 AYxC3OduUOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCFuzQAKCRD2t4JPQmmg
 cyYLEACsMh05r743SrrQahmb/dASG/nnePWzNUsHtLK0EDrydcG1E9pyIvThKLhuxmJBFkdfA8o
 uRgJaFQhLi/mgf9J1kurqnKVo1cT76lY3cQRHufXp3+k9+DY9q0MOn4O2P93f6z/JW4beuRsguf
 FTWSpUW1iOJdfL21R0zDeMO7Hi7g1bqH5TRyGtrM8/k7bS962G4mcpvxDwLXSxzDITvRagbU41N
 czNiY+0DpnyQrFOqTnMDoKXmBKar3V9IfCgggGf0BYNMTLSs2qv+lg+EP7FS7w9VoadoZZRlt8l
 f664x47KJL3kLfoi3QF+V/LaezEht3+crr6CqpBmDiPrrWgFvI2IKf9WPW75kgJvDnoxZ90/a3D
 0pkBBkQlcKraE6LG0tmkA+NajAVmNcaUaPM+nPyRdiR3o3WiJeKZrGwnjC1xU83CEYOKPyH+5S+
 n7Mcnq4QA398Eoo0gBjfn8tn1rErk2kG//CN/U3My/TDHZdk9zUv9lCbtHWSc/nJPpvonQAPhjR
 xd84HucX3XqHgGcUDCiut0aX1wyzS7TElWQg/Igxh/IsXQtGzEjJjQ8mejCycN3sKJ7yLCE5gc5
 24YWYVX0fqkNI0Qiu1gbMC/H98YQw3JDPiH9zz15+oK93+ygI07nhcoyOCCuOJtqzIjdSlXRMR/
 SUpG0vr0HCja/ZA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

In the syn_recv fallback path, the msk is unused. We can skip
setting the socket address.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/subflow.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index dadaf85db720..a11f4c525e01 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -821,8 +821,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
-			if (new_msk)
-				mptcp_copy_inaddrs(new_msk, child);
 			mptcp_subflow_drop_ctx(child);
 			goto out;
 		}

-- 
2.39.2

