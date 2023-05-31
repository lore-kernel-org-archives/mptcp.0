Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C7215495
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:44 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f4f3ac389eso5449695e87.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542602; x=1688134602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRdcnAYRLQ3c0s+J28sFDIiH5JEZCF4I77YILf6D1KQ=;
        b=CUKG8wzaqZHQyf+/AdgwcT86u7NwES5XlE3alIh7oyB2mDWnb1eGBwgSc1LAt7IKbW
         oSRK/oGry3RH+c9zlzTBlXe2fINcTKnsmnZsSdqUGrXV0plyoSWMZDgcbcRx2+8lRk56
         e75nzrIx2kZBbAqZh44ZrDow9+5c17NvgZiAD+K58r6QSkgEj3aqOSs+J0vXrHKmg+DU
         uZycIsIb64i0uJ88Patutzi4eszII5EheEF5DIFciYukbqsUKpPJOODuiUe/+YjIqVCi
         gMxJmYAx84p+mAhZsAi+hPpp0kqDu0HtUkEKwC+kbjZKiWcL6pdBgMSPqjh7BHdY1h5r
         6O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542602; x=1688134602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRdcnAYRLQ3c0s+J28sFDIiH5JEZCF4I77YILf6D1KQ=;
        b=XhpJBeFeH3lVKFezsa1vDh88/hPP59DUSqSRqzw5yxRppOxxs3whv2i2qZtiMTF/dk
         aKUZSo9LwtXrsdaP1f3jO7THfDvVKbcyybHxaac3tssO3VfOK302lkIGOK+TzXTQaPT6
         j999Noi2j6raNMM2ax47OmquCJ9N5hfdz53jIYnXQ7Awq4rPCfLBQUEua2JraDprdvL/
         nzrHS3M880iJOf8SWV7rxjX/FOVgEdYMAiVZzQ96FPb4cPpItUzXGuCsp3qJSvVdVLBs
         meyvwjqzeSldo1qXxb7kpcEpPthOX/LyVWNN04fiVv8aZtUhm0apwTd67ZvbOSP9HPQt
         pPDw==
X-Gm-Message-State: AC+VfDzDcDBJg4n9eHq0Rvd9CNL+TOmfrP0bGKDU34pVfv/r8d/pQ9w4
	S/x6rP1Y7OwV9OQC1FVChLMK+Q==
X-Google-Smtp-Source: ACHHUZ5JU/I5m1IdLtj2q4xMCdLEJpxFpkH7tzVRRMW8wRzoLMui+EoKf+a4raG+8gqg9N+vkqHPYg==
X-Received: by 2002:ac2:4919:0:b0:4f3:7c24:1025 with SMTP id n25-20020ac24919000000b004f37c241025mr2922013lfi.26.1685542602163;
        Wed, 31 May 2023 07:16:42 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:41 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:27 +0200
Subject: [PATCH mptcp-net v3 07/32] selftests: mptcp: diag: skip inuse
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-7-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=3jTbimzQize+d4RXaNGIa2DEkBgDmaDPaIBUUhQFATY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bCREPjnQyttj0K8RKc6Drw1D5gmMramrcik
 sVPc1HmEJuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwgAKCRD2t4JPQmmg
 c6BPEACScteqGPii48w6ALYWfClRNTChKp2iQi/Q8BWY49MOsMXjtKWNgdeuguuwe4y/ob/DpDe
 rs8Fi9jnpAWiivm0FjkhqRvxDJ53Pc2Os2e4fyoZjyiEwv20eYtNbEslJ8FD5lPzixFZjbmXpsd
 qwpv37wFUM+d8toWV9Z48JE2UVJj5dhfmM1j1CrV/XwmUCI+Xao4zVbe0C9y983kE5y13XoKulX
 ZE+M1id19hEVhz/9JhxaAAbB1NTZLqvoCuF/cm86r4Lvmy9IvPh3G/+O7MTwZQFLqcFPE9c4KLt
 XTNovi60aX6XzmHaqVakCmpd4YdgHzfqSd5r50TqRYGbV47GtIQ1h5tD/NmUv/NW3v55QzPGAaX
 lKVy1bYlYhO7D3XPFnCxI8a1b65bBiPNJWNZJ7QUel0KWEAJ0RFH2NEGaHs8qzNVbsVzSptOOXb
 hL19xlxDLG1Yr2+wOuphC8d2zLz3hNVlPqNnEM2B93vYHHJ5Xzs6q3Mq1vJLrD51yhlGLvusgYv
 5Un0JSlk3VvZ8rZ1OmcAlMjUngqL15jXS0X9gB2ZyIgK96M0QXNutx+RIU+Vm9aIqw3S4TJgfyj
 tDiEP00Y7HIA2JkyZ6fmZrnb6eK6fvhJf3UWBcqvqbB72UjlD732d4vLvlDix0qUtj15omId67X
 v7NL2szbvfD1l2g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the reporting of the MPTCP sockets being used, introduced
by commit c558246ee73e ("mptcp: add statistics for mptcp socket in use").

Similar to the parent commit, it looks like there is no good pre-check
to do here, i.e. dedicated function available in kallsyms. Instead, we
try to get info and if nothing is returned, the test is marked as
skipped.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: e04a30f78809 ("selftest: mptcp: add test for mptcp socket in use")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4a6165389b74..fa9e09ad97d9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -173,7 +173,7 @@ chk_msk_inuse()
 		sleep 0.1
 	done
 
-	__chk_nr get_msk_inuse $expected "$msg"
+	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
 # $1: ns, $2: port

-- 
2.39.2

