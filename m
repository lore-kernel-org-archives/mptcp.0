Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67515491
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:42 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f6077660c6so43369925e9.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542600; x=1688134600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYJ1GfD8UJAHyjP8CU/wIBAuMyFnUU/sDqHCbD08zQs=;
        b=qKK49whO66XYl+bkvV1KJAP7PJ9vMqsXqJlWGgP7G4Tpsz4iOiaSfCwILgVBXFsbxJ
         JiY4M5DbZ+W3suJiLHxsSiNzV4DowMHqdZM9GMIAqmCt5sAQNRsArlTgdjIH8ZC/jkYL
         Ky7p4uOVICjaN3107TRvTfJ927fPAXd5kEKVwxsO1dhkUQcKHDsBlT87XMyGc/IVM7Ph
         jxZ+Ynd+tzsfeklvLQpnXDlNfywvFhSOWL/vJEjGFBvPtlk60XLWd6dBWLGE9hmtbXrx
         tf9n99C26Z7JCj77/C9Wr3ZG12fpnm35I0q8cYBeBmwK/+qSaRXWYdVs62O/hFbHy2Sm
         ZbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542600; x=1688134600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYJ1GfD8UJAHyjP8CU/wIBAuMyFnUU/sDqHCbD08zQs=;
        b=ESijJ5N8s5ejoKG9NZCnGH2RLubh+CCaRAmzxJ1cB0NkFqwhNPVsBHHGl8R5gVzeBB
         ZMWGKVqIXDC6XRE0LsjoSS7R8dSLvVdxnTJ/GysTVvMq0jRQi+/T4cm1cjz9QFlo8zeu
         x8cW8+HIQWku17/hNC4dUg1QH2uIMmcMkBWDnp0xLiI8L2AikwH7s1ZnWnqtvdMWC1zV
         mHUKoLfW7yOamxvywOrP01R8sSJ8Buj6SYVxQm5hQzWTYmC00/XzYZi2A0NMAabOJim6
         ZW4bM0oI9ESJ3fNn5JxzSIjRGHBpk7UtgoJnRdgN3amIqzhXvgZ53ri8nPb9Vf7ail0l
         g8vA==
X-Gm-Message-State: AC+VfDwA+HHZW9b90OtlFArNymtEBuBALkVSZTcB3/W558XsEPei7Qw6
	lmKqybr0m92KxPDAfUAHCd5Jnw==
X-Google-Smtp-Source: ACHHUZ6ERh4IdNiUEdz4j1zm1ieVoiouzIrr1/w381kY5Ima0GQsr7mQ4JpmWQh1ZvpieNdc8kv26A==
X-Received: by 2002:a1c:4b04:0:b0:3f6:e73:ef1d with SMTP id y4-20020a1c4b04000000b003f60e73ef1dmr4186028wma.18.1685542600755;
        Wed, 31 May 2023 07:16:40 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:40 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:25 +0200
Subject: [PATCH mptcp-net v3 05/32] selftests: mptcp: connect: skip TFO
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-5-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=m8KzPFriAhpJRoDvd0anKObKTyLLxGf2U0AQaFYK16s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCfhgHPIjxY6GnJk7uWUmJug+hyOPV/q7Kw
 /aQ0lECWzqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 c7JuD/4jzBvIbov7riDUhE+rl6ZCME8Dy+CzLse/Z0gH6/LnSS/HhVwdFZeoyHQIZA8gR/HJ54Z
 i2JJP7HL6kYdHZ32XglOv2ZPGQBZreRR7MAdMuc8UhJF1UzMFKpR7ILz012nCfdOeBAu1Hy3BTG
 nYY9j7FUIjAgw8ol2rq6l8vTx7TIKKW1CY+y1N7DkzYlfc9e+KvYH+bQgxnuIZNZGnBgEJx9VFo
 qpNzkOKDmacA3nS+NpmA0oLwN42/Bpz4uHLy4xasucV0dgvAsM+xhY1xSoxvzM5H1WsP+kuNgj+
 ycVJnPQyyzUPYZvWLPmNLiy0YFVhNZu6h4lP2njyq2uLWF7/RPWbR5Is5a1bmUdQtxpiNk403YJ
 YQHoih0pZhDPA7r2lV7KdYeSYsjh1/gEsVXrNst49sZNoB0nURk1fV0RsPpiIc1iDfogB2xxiLk
 wSBKP6wyF9H/9Ckb9+a17NDAXtPPNqAaCiPXi0B3tepkBd8+Nii2mLHE90/V2uV4O/vsuGg4dCV
 uUxx6IFkIauN4IGbAMHh2U3TJyAutzDuSmi27L13wFRuXdtj4EWhcj8PgmH8E7DrEzGNGqOQTSL
 /zUc5V2SprAFwrCBMVR9Cl9dmHOdhSP4B0fKzyJGww/kvpj2AVMNVPXI/BbmPE0RZ61h3E/RFTO
 MtBYhv2V02Eg2dw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of TCP_FASTOPEN socket option with MPTCP
connections introduced by commit 4ffb0a02346c ("mptcp: add TCP_FASTOPEN
sock option").

It is possible to look for "mptcp_fastopen_" in kallsyms to know if the
feature is supported or not.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 895114fb6832..773dd770a567 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -777,6 +777,11 @@ run_tests_peekmode()
 
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

