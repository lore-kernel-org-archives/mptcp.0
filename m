Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56E70
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:54 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id t9so2064186pgn.4
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1FSxqtS7PF9xexRlL82PH1RllDFieWQeN42FX4JflXc=;
        b=JRh7ZGaR8GIC2bj9MHCRD3NItHHJxFhe2g9c2hRjEegcG8YTCMgQ84tfC5tzZ9rqod
         Fb2jq860JVey4jj88o6psiNaXcnZhiMmRxPhjGtJlAp2J622NLWPSBhyyPdYp0IjPDCh
         tW5anx2y9gpkX6xTpC+MWhg3dnSpYX88QgphvYu19lSYy6D5BDwgQ0KbSO8KppEoEHpq
         8mkGv1DrNf8ptfM6K+tx+X/4NzgaT8TfxdpT82pTJzQXd5d6asUogP6ym8MAh2JUqiK0
         OgUE073ecBbKn7GvXDbkRvLmPLXKWSb6TdVCRghzL/j+CnnPM9phpmZadPEiOeT8JPUk
         yHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1FSxqtS7PF9xexRlL82PH1RllDFieWQeN42FX4JflXc=;
        b=ifyzNBtDsnQJiLPM/kPERXcOEyMfExK7enCKBwDUmg5pTAgWX3UrKDkBWkojSKnqzc
         yBAUlBV8i3i+Dh9zhxZiTMkdO2W1xvr2p96eAnBmdj9MLI3Els+WSGsZpMmNgSuxrSU7
         fcNIhh5lfVacjamIlWW8QibFskFvVNTmQmc6EMhCB4fRwtdq0Rn7mH3eW8jcKXwA4yOM
         /NZAVAHX0b73kBPZh26s7KrzkrHXsE/ivvyedYcVZdrO0woyInY6QvbQVvX1gostsGcb
         GoI7kACjxTKdmbIsMWxW+xI6oturKZILZz9KYTaU8M+hRtWZhkxX3rwYAEdXKHSauaAx
         t4Gg==
X-Gm-Message-State: AOAM531GrWslUsAnSRS/hRVpZo54zvPXQazh+RXRsF/qhQoYG8REVCzu
	ZT+wTnyxIpOcpjDbDOdgqFwVaXi3PViNOg==
X-Google-Smtp-Source: ABdhPJzygTKDeWyV1RPkSyMc1CjCtz4j3oueaVyG+K7U2raOwLHQb+IE/bQGDCoqEW/jBVJu4oJgOQ==
X-Received: by 2002:a65:654c:: with SMTP id a12mr32059815pgw.118.1626877913658;
        Wed, 21 Jul 2021 07:31:53 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 08/10] selftests: mptcp: print the fullmesh flag
Date: Wed, 21 Jul 2021 22:31:32 +0800
Message-Id: <66797ed318830e28cdbabf59011c0da39b9f6cce.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d40b7b32bc427e5d43fce298b60e1040398977ac.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com> <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com> <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com> <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com> <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com> <e9de213a59a066c6beaba2895a7c60412b654601.1626877655.git.geliangtang@gmail.com> <149236d46fe59a177a2f36a5c6e45941a1e0c2fd.1626877655.git.geliangtang@gmail.com> <d40b7b32bc427e5d43fce298b60e1040398977ac.1626877655.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch dealt with the MPTCP_PM_ADDR_FLAG_FULLMESH flag in
print_addr() to print out the fullmesh flag.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 115decfdc1ef..78e0d37d008e 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -422,6 +422,13 @@ static void print_addr(struct rtattr *attrs, int len)
 					printf(",");
 			}
 
+			if (flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+				printf("fullmesh");
+				flags &= ~MPTCP_PM_ADDR_FLAG_FULLMESH;
+				if (flags)
+					printf(",");
+			}
+
 			/* bump unknown flags, if any */
 			if (flags)
 				printf("0x%x", flags);
-- 
2.31.1

