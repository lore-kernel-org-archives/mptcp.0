Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527F5154A5
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:40 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-30af86a966eso1539837f8f.2
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542599; x=1688134599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45rPQI/9dNaIGMULDiqTcAf29bFiYvpeNsOMPZL5pEY=;
        b=cWBPxD/ieKtU7WLItc9BlVNplJ4ovMuSpQkxArtqwe4Q4QW46hhqVpVA4Qrd4t3xxn
         w6Kran0VXQ/a/FBjiQYkJo/vosGrEmgskPBrO3kMVxt+aDtHRneuJSBBsPTWxdHEKuD7
         EDII2s3SqoJrWxyd+2CYgqSZhSUA2okbI6Ww3siqjS24+GrYKwMi0TFD/8V6VxMlOc29
         uu9sa47MfN42qOmEJ4U7oFLWCGn06b31iDkrpOJS5zK/lITwEpXcnI0HmqMEK1dVDRI0
         mTaZR8/AEPNxfU23k6BarB/Kt6iU/wgrpUb5HEvNWUm2va5y/eGyhhp/OBo5vcG82f4t
         TQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542599; x=1688134599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45rPQI/9dNaIGMULDiqTcAf29bFiYvpeNsOMPZL5pEY=;
        b=ihyISihRUAUvny0kZMMz1Cd8K8qYDd7lMy4oc47RwARXW3k6T0xkO3EmYnqDv7zzTI
         V1wTz1KHEhPIm+Dk0MphWmSMhN9lT2SNfxRQidYO5qVi+GooU/Otp9h3/H9xYJZ7FGxk
         QixFraZonkLKRfVK3/rxiLwU3rPINurAtGEtuZfAz8Xs3PKrXyHs6Xioa2GJw+tC0LLv
         cX9UdwtFIqXuokZ9OXQeDrzSfNbtdnhuNNT1xSZU17+b4vp+fBwn/XmdOab69nBxKOKp
         JdTUnJn1kkL9uzPknhdxGLR3M2XEt/8Q14AgvhWo/XItiR0aEjGm5rDzhB2lMpqfGx+q
         BwNw==
X-Gm-Message-State: AC+VfDwZdSb4QcO2LMYdeMu68p/x806arn4KOZqeSST/yhNURznN1RWa
	pxkyKugKRXodIDoXbe4rCzACng==
X-Google-Smtp-Source: ACHHUZ4eohhyQ65cNXs7mY3ydDpfNRlRcf+Po4H/6cU6tgcubcrNgivGe/nWZDQ6xAMGLRzvMXPWEw==
X-Received: by 2002:adf:e84d:0:b0:2f2:9198:f0f with SMTP id d13-20020adfe84d000000b002f291980f0fmr4129915wrn.10.1685542599197;
        Wed, 31 May 2023 07:16:39 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:38 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:23 +0200
Subject: [PATCH mptcp-net v3 03/32] selftests: mptcp: connect: skip transp
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-3-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=ypKINRNPSgiidO53mhT21I9MFGRM+pvUXFVtqBFF0zE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCRXEWC7EPDWBeJZz7bHT5ieKw++g5BXoKW
 eRI7Qt0ZgmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 c5qnEADRgvvYoRDYdmxpSi7bQc0ul8u6wISUjtlIE+EDhCG27P31EwJIcKlZhHpzUrp0OwQNqXW
 x2/EZvHFt4X1y+aGYlpHNFLTJp2clOPEj+vDOTwT51lX4G+G+3VZ4XXtDcTH92c74VPjIyxjuPa
 w7so43wol2xgaFcIrIE2JPdfgtvFiggOyChKq+10wzQFFfgj4yTEqkhAWhFD5RbX8rUiJNSKr/d
 XHrKR79mBZwYbPOQq4uFcvAzdKUPxLG+anTLs0sTunuTAARhNUHiUvplo4tdrb3R93ID0DNbxSx
 RRVwvWV2Vaz3OdWYLR3HKlKW3o7R2BwXgf5416BPC4nXC9+H7GdCwSCB5t63lYEaVYN8bGowF2M
 e8n1BvXejOShyLERawRW+npho6KFup/v1tgnXTM05ZRCHcKYXUgI+R4mExOJn7oBDjFKLibq8F2
 Sjh56XmKvrmxw8Fe6CD0Mc6OyIB/MlfdBJ2QNb76x7xG6QAx+saWq4Ulak55/eMDnTzh11ZupVr
 g68SBC9ALq0k9DQ/iwnf4Dk75/Pw+42Mld9gO8VN92RpqE7BVkpCc4n5OGWbyfbeSBwobh0StsE
 w1O5jVYBvxCsty9WvGLZb0vF8F4aOEeOLkwTDX9yHt7/jiN+qO7BBD//iG56dzH38iAi891Hq8A
 RgyZioLkTMQUlRA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of IP(V6)_TRANSPARENT socket option with
MPTCP connections introduced by commit c9406a23c116 ("mptcp: sockopt:
add SOL_IP freebind & transparent options").

It is possible to look for "__ip_sock_set_tos" in kallsyms because
IP(V6)_TRANSPARENT socket option support has been added after TOS
support which came with the required infrastructure in MPTCP sockopt
code. To support TOS, the following function has been exported (T). Not
great but better than checking for a specific kernel version.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5fb62e9cd3ad ("selftests: mptcp: add tproxy test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v3:
- s/TFO/${msg}/ in the INFO message
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c1f7bac19942..f9c36c6929cc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -144,6 +144,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
@@ -695,6 +696,15 @@ run_test_transparent()
 		return 0
 	fi
 
+	# IP(V6)_TRANSPARENT has been added after TOS support which came with
+	# the required infrastructure in MPTCP sockopt code. To support TOS, the
+	# following function has been exported (T). Not great but better than
+	# checking for a specific kernel version.
+	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
+		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		return
+	fi
+
 ip netns exec "$listener_ns" nft -f /dev/stdin <<"EOF"
 flush ruleset
 table inet mangle {

-- 
2.39.2

