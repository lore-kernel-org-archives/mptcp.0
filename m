Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D89154AC
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:41 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4eed764a10cso6461164e87.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542600; x=1688134600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zh2CtNcrzx065dAyI+yQ3vN4EuYizVeAOwsCoc6Ho/4=;
        b=U+UjEDVKbjJrYM+Fi1tccJGkC6q8mO0hTRSD9egjFynTKGEpgIEBFLNucpkKZ2pZAy
         P/NLDxFCGGfJCvFZXOgz6nmtr/xQpWNUyEe9+8BEteI/Q8txa0h37UzYAOPoFQWKtK3m
         LqfhgC34sL8hNMNxSBdb2p9yM8tZqivSl8c//nzQ+hxL9P6G1jiqvmv3JNbP3kliXDlg
         SlagLrcy5YmoZMPU0d0AGhbp9sBYVwB/YtOSXZImYpP4ILgpuxqqVnpSQOmp45eUb3Ik
         n47XGnr0/a7j/7+m5keVPp6dDt0ML/xX40s6jqfeP7yiirJ0O3GsRC/M3sskbPYP8weV
         GHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542600; x=1688134600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh2CtNcrzx065dAyI+yQ3vN4EuYizVeAOwsCoc6Ho/4=;
        b=brhAVZnSZtoXB80FBFQSZ//LXVaSApk4ptqHdBkL9aBKTPWkVz1S50PU2W6nEUhLwE
         IapcMVncMK+5RqsqEiJvCPAcU+BPAmXotQx/r8zIuTv0aBeV0Dg64iJGwcJG5y9rvqfZ
         l+sZ4YOX0LHBlSGTIyxYHzT62IsFLFWPklvG/rl/+K5FFrHUk3KY9jqY8q1f1nZj6ZsT
         EK2gYJUsvO9k6h1hSuIQUy3iKDDr1IGkXY31lBOXnjScHyufWKYe3ZtpvByKfKqUvtwA
         IkPp8nTpVEbOkAfXiKw2HmNSGw8AOH16hmp4+cNNsn0x7zjBz/ROCQzxnDip9m7+BXkk
         QMAA==
X-Gm-Message-State: AC+VfDxO14AKEg/3jyZoG9FZlCzKHsWNgRBdkfVa3jSem9APvEUc9ujZ
	wqgrn1Bc3fiNkpargZZ3dvTbUA==
X-Google-Smtp-Source: ACHHUZ4WKt/TyGrUfWeTjZtHFebDrdaUwLwbXPqHPiQzoHA7rJqqjQ/NdY0k2kx3BRH36RZoQHx88A==
X-Received: by 2002:a19:740f:0:b0:4ef:f4ef:a1cc with SMTP id v15-20020a19740f000000b004eff4efa1ccmr2924127lfe.14.1685542599948;
        Wed, 31 May 2023 07:16:39 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:39 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:24 +0200
Subject: [PATCH mptcp-net v3 04/32] selftests: mptcp: connect: skip
 disconnect tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-4-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=7ejq+BeGuBlgGpQDJrtyL3h+SHqC91HjQT8sw8ry60U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCqvbTjSc96wqstAU2j7EjdQH7vK1Aw2pon
 fQs2hbp7H+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 czj+EADg4KhaewiCfjet4lR7FRG9M7TWHCGo46oeAo+PIK3GlTJHyjN6njl+sX/zW9B6sQ0vBfQ
 9DLU4yTHcFCW3x1e2Zu1SVvUVXCWtfOB3dnvNlzENQujiFN6YZH+CWo0+9aPRYSvV5D+0j5Ux+a
 47Vfrx/JPD1TE5eUpCGu9wsOduHz9++TEkHX5ei71jLv3F+ohDTKIrehVmcAla9co6m1KWxpnTt
 /7E/FwB5rNE9TnntPnYsX7cF0+YhofdEAH6ZH64ESOiz9gmvPb85UCvtiUTGEoVMp3i5MjvmEDX
 rghC1ZEny0xui4Jw+gWCyVj6ZqDepU2Xn003wIStcoTYvMAQp+x9MJ/y/rkfC3EC+ksoCZCbO3S
 QN7gtlQczK799p6hhWfik4HYkopPpEVdpRPbKANwPFm/L+uqsmfKoQ5G3Ix31jCep7j0Zhl4UlJ
 73TP4cZjgpej9nmEXEqGLJNni4fDpjU26hal2LChWwe5fS0WOI8fEu+qRdOQijrPEBZ3AmfhMz8
 PalNSn6OaJ/aEKtjk5rr4wQAV1MG7BBIYPF7RMaca9s1fp+trJxyj2oq3ILJ9AsLuGPNluDZZlK
 mr9ZgOqwCEBC3trzJTCOSmCMjBsKIprX3U9SxQCUDZ95pyDz+6RT41DotafBRxTX5ENMrw5pfKd
 9xvq9IcraBBpqSQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the full support of disconnections from the userspace
introduced by commit b29fcfb54cd7 ("mptcp: full disconnect
implementation").

It is possible to look for "mptcp_pm_data_reset" in kallsyms because a
preparation patch added it to ease the introduction of the mentioned
feature.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index f9c36c6929cc..895114fb6832 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -797,6 +797,11 @@ run_tests_disconnect()
 	local old_cin=$cin
 	local old_sin=$sin
 
+	if ! mptcp_lib_kallsyms_has "mptcp_pm_data_reset$"; then
+		echo "INFO: Full disconnect not supported: SKIP"
+		return
+	fi
+
 	cat $cin $cin $cin > "$cin".disconnect
 
 	# force do_transfer to cope with the multiple tranmissions

-- 
2.39.2

