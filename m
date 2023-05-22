Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADB14287
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:18 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f423521b10so41340925e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773497; x=1687365497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhLEa/kO5/W0DHYC4E2CGVdrNW1mmEn4jpfHWofA1sk=;
        b=e3Gmx+2FbX2MDaoHVksJzQMmY4p4geyjZLaZfMd9wamfwsF3cppQHQx7kyPPHE//+l
         bS6JSzNnuVGNlZYKnvmX/m43BiZXKf54Cp2105ezliC/DY9kPiLbvjq0AUZKFpNwEhnD
         44TmyDctFAkBDLa2yHNmAYtN+6Qwmc1OR9/gp/k2RdkbWVTLm8A0OLGg9eft3yDqRU/9
         LMrC3xn19msboJx0hgA40w924Kl4GboKcd/kSsCi/Hmh6vl8TPslGfi9hc9uv6yvB1Gg
         2zGqUrgwT9k+NV3JPLYTqoHwbHQg7i44D7reRE2mIglwhSnQKfdAgwaXTfIxann3OTlp
         sSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773497; x=1687365497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhLEa/kO5/W0DHYC4E2CGVdrNW1mmEn4jpfHWofA1sk=;
        b=X/lwLsxcAyrj9BJSlmod+2aGQEEwbMgAQjgRbau4hCOdl1WdI01AVleXaUHUuwpJ6L
         TOdYdnpCI9l4CJxozlbgRFcWeEo6JCMgMaiOJfEZR8kVMZDbRAesUjeAejCmNUk2y9C+
         /4UxfL/SMWLtrMrKpwAstTp9lcmfw/Kd/vvb70Yvedm7fuAA1FybNIj3oioj+E8nG+1J
         TdOSHykNACRJFN8PgPlJqSdIFuF0q7Wwfymz/TpezJqYnaHXog6kc+1/FeHOYkqgKrv/
         XG6+ilfnNjlsJeT3+1XzmJCMSE6uqrDdU1/4FUOhG5sjO7YE5cElZcRsNW0iJjJjxy+9
         NBuw==
X-Gm-Message-State: AC+VfDzJFUh9NXOtktt6Rvl+P5a/JlIkFd607MCkRXB55WOmBceh3gHA
	pKCQj7XQjvn0FxicJeCgIP+Tt+ASNoAUpKvxdAtztw==
X-Google-Smtp-Source: ACHHUZ65GV+MlunYSii+a0T/Lq40DMoDWj6SY7BTfxhEyFoAIdp9IenZsJ2dZIJPbT044MS5asTHhA==
X-Received: by 2002:a05:600c:d5:b0:3f6:2ce:caa8 with SMTP id u21-20020a05600c00d500b003f602cecaa8mr4098740wmm.29.1684773496685;
        Mon, 22 May 2023 09:38:16 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:16 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:40 +0200
Subject: [PATCH mptcp-net v2 08/37] selftests: mptcp: lib: skip if missing
 symbol
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-8-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=zwQFmS8uNzLeY09FTlLcmYGOdopDU9Z7GT/O9iEBClk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pveoEQJ2a2uQY5r8rHyCEOsKpWdIpgS5o+/
 rnkxiIlLByJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuabwAKCRD2t4JPQmmg
 c9h1EACZasynZRoatHfitsBpqfOv0TIwkGqW11bZr6TipehsV/UlATTFBtY3TWU6u9kKWE46zTx
 cvyDy2yDAJYsdiRTfjhkX0qP8XhcFl9KaWQFH3qv3w85Js5LEI7e0Ot1yqbqqX2X+n2s197ubfL
 OyriGc8GPEQgpfLijJNmRRxUNslhxmKEi8HLaqQ73pXw3w46XaSCjR4pJ9ESmTbpye4H1cl+Sts
 PIQbctOuSklew6pnpGhslCuMgwxIuhtvcjWqNsdDdr192+FJwzp4K9kbmuEDnh+pZ/Y4+FP45t8
 4ZLby2kU3+X7rgXTeFP5jlwb0SCIApV5Fm50MDFK/xZY/399lBQ9XPv2Mq53qbDdrKez9WTCkid
 iA36PQkwvYSw8C3Uu5QtUIaexStpd8LA9i2cdC7eb3ZFQ/a7qe13LfTwMguMmOQU2WRaIbStt6I
 twcDCYZyZwlX2TDGA53Oh/juQJwL+HrvE4DbtO3vv3vWphMPf6l7YlSCw9fKGqvunGmIvN6/s2h
 ZF8F/7kH+mJLxeWCTUqNJp2Yqw5nex5JX05g/StcOtIoHnfd23ayXougDzhNajy3TmcW72pX5QK
 9H6NjTrD9MFIAiY2Si6beOFvjKtmZ604nDvBZEhi8ysMMtgw5dTdiR2CzcdbFTxfebDCZsSwyPp
 2WKpnJWMoQh2rRw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

New functions are now available to easily detect if a certain feature is
missing by looking at kallsyms.

These new helpers are going to be used in the following commits. In
order to ease the backport of such future patches, it would be good if
this patch is backported up to the introduction of MPTCP selftests,
hence the Fixes tag below: this type of check was supposed to be done
from the beginning.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/config       |  1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 38 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 38021a0dd527..6032f9b23c4c 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,3 +1,4 @@
+CONFIG_KALLSYMS=y
 CONFIG_MPTCP=y
 CONFIG_IPV6=y
 CONFIG_MPTCP_IPV6=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3286536b79d5..29b65f4b73b2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -38,3 +38,41 @@ mptcp_lib_check_mptcp() {
 		exit ${KSFT_SKIP}
 	fi
 }
+
+mptcp_lib_check_kallsyms() {
+	if ! mptcp_lib_has_file "/proc/kallsyms"; then
+		echo "SKIP: CONFIG_KALLSYMS is missing"
+		exit ${KSFT_SKIP}
+	fi
+}
+
+# Internal: use mptcp_lib_kallsyms_has() instead
+__mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	mptcp_lib_check_kallsyms
+
+	grep -q " ${sym}" /proc/kallsyms
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	if __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol not found"
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_doesnt_have() {
+	local sym="${1}"
+
+	if ! __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
+}

-- 
2.39.2

