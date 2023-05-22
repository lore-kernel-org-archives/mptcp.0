Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5C134B0
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:19 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f475366514so43354985e9.2
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773497; x=1687365497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEgubpTe0iMk2Y0x635Sh1tu3Yp7tTcDKUk4XBatN/8=;
        b=bbj2m8repgz62UxtA/h75kYq+zOC1ysdrm1HKFIwP13OOPzq7i0IhK0+NBAcQ+Kyl9
         uqmbOgCAUAQykqZq95DWvI3SqIWUXyfzI+CWjgDC7hdY6S2H+u8UGxaey0FJ643gEScn
         EE2PxzYiPKeBksgdd1eJAcv6VypseqimnBQaITsHqJ78Q7ODZdkMb2LLgd3mKBLkUKrh
         JFq1aKGujwzmHxZHl/j02p0BeKlJWfDZAmM62qpIB6VgrdlxAWfs0Q0XMCeg7UuCLnzc
         TqqMZj8Kn3cd/N0uX3iuxOgPcpqwg3sIxiVRnH5NCn5AoXEwc0XeOgYYeH35hWz6HPv7
         JVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773497; x=1687365497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEgubpTe0iMk2Y0x635Sh1tu3Yp7tTcDKUk4XBatN/8=;
        b=gbmZ/GHfVpFtmTzD8Hd24nnOk+ZWIvf/F/7j3uNFMUU2UHc/i2SBf+VjXDiJZaKw8M
         gIABc5fFByeSi8nMSRHuZ7vOeciqdVnqXII5oX/JEXc5UlNaW5zsvMrAQI9PdE0dEm55
         GWo4db9JrfDO+murGRAHBBCH/RUR4G9zYgIO9T3UG2Fx7rDIkJpDXrzUt1e079SMfNqO
         8CKTbO1h9QNZiW+eNkAB4ZznX5DcQTKbzMfyXZjyUFcalyqZq/z2c93gbNPgYhNlOJnd
         6rb57fDE2sG+cpF90YsfFMUjlf/qjAMJ2b8DUljrjhpP0Ski/NIZr21tuHid06BHqFoL
         uwhw==
X-Gm-Message-State: AC+VfDzWy8YBwKaD2qW1iIH73fwz7NLWxsMAzViqmHqYIjFIeIaPQ/q0
	/XRvBpBz6m+OGAOgutI8jMaQCnV7QAIZqDnPha8phg==
X-Google-Smtp-Source: ACHHUZ6HjMQkU9HoxCeROulkJ2qB1B5ZGlUNuAtp342z9B9tv8RqsGJdNWsGAOEUlbNCNTyZklCPlA==
X-Received: by 2002:a05:600c:29a:b0:3f5:bc8:e395 with SMTP id 26-20020a05600c029a00b003f50bc8e395mr7744909wmk.11.1684773497620;
        Mon, 22 May 2023 09:38:17 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:16 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:41 +0200
Subject: [PATCH mptcp-net v2 09/37] selftests: mptcp: lib: skip if not
 below kernel version
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-9-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2361;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=vTEMlDL824svwN87AbdIrhgcQZqBRcfgVW7ZIJmFDzs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pvea4aqoEGSSc84NxbOSPufjNd6jX0lezFL
 kON+r9y+miJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 c7JdEAC794sXCTdLdWY7uD86n2EbRAR/So/OLgEzyLcs05ynkk5erARgc3uVV15EVwXr2B1qupK
 qrDOWqi9EslD00eO9CDGeeFxajh5FmxivpwbF2UTCe1D1jfR43dfS+L6rwYgefjZ0fmq3p+GkM6
 deufw4xhFZh6LukTQ9MS3tlwGA4HxzLzgdiyyfABkxHsbM5YyEVVdV5jOdZHpkLhVRCWsYl6Bpo
 /SiGCFCT4kToHlk69o5M6zDaWicqlB55dMGC4ZsYJJikBkx1P3tOgg5IZS1+/97vsHwAY7IE98o
 k2Sp7srz1/xeM4soZSQHPzSRNIBVKM56k81KYpRg7YAiVfOSkPKjQSzZv+eJiakBp2oENH5C6pn
 zl2ldqgXju6ii1xA06lMaZx1bM4qpZ/8rfCHGPhsJxksGSoObROYssyJ1f17eofAI3i3NWFMc9z
 B5AlQ5l8JQWSyByO36tlXxga/ola/f7vqaJBt+i9P7hduSc0qu3z6khGTClgdhUx5uLoFx5yoxG
 FIDRQjt2EtA9tOlSdEi7xLzsK4jlZ2FLQUB4W7VLbuaZweLgIzAL5GWFO/kMS9Rbs2DaggiDwFF
 WW69kyJopJHialPJIdtol5HCSIPcXvmWoLjjdg1I0Vc0ekUr0PCfS3+qf8SmKoVIKxIGB/IXr8F
 qg7n6/XYvaJnUpA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

A new function is now available to easily detect if a feature is
missing by looking at the kernel version. That's clearly not ideal and
this kind of check should be avoided as soon as possible. But sometimes,
there are no external sign that a "feature" is available or not:
internal behaviours can change without modifying the uAPI and these
selftests are verifying the internal behaviours. Sometimes, the only
(easy) way to verify if the feature is present is to run the test but
then the validation cannot determine if there is a failure with the
feature or if the feature is missing. Then it looks better to check the
kernel version instead of having tests that can never fail.

This new helper is going to be used in the following commits. In order
to ease the backport of such future patches, it would be good if this
patch is backported up to the introduction of MPTCP selftests, hence the
Fixes tag below: this type of check was supposed to be done from the
beginning.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 29b65f4b73b2..dcfe5eb6f7c0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -76,3 +76,24 @@ mptcp_lib_kallsyms_doesnt_have() {
 
 	mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
 }
+
+# !!!AVOID USING THIS!!!
+# Features might not land in the expected version and features can be backported
+#
+# $1: kernel version, e.g. 6.3
+mptcp_lib_kversion_ge() {
+	local exp_maj="${1%.*}"
+	local exp_min="${1#*.}"
+	local v maj min
+
+	v=$(uname -r | cut -d'.' -f1,2)
+	maj=${v%.*}
+	min=${v#*.}
+
+	if   [ "${maj}" -gt "${exp_maj}" ] ||
+	   { [ "${maj}" -eq "${exp_maj}" ] && [ "${min}" -ge "${exp_min}" ]; }; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
+}

-- 
2.39.2

