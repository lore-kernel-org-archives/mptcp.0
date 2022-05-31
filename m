Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF68180
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 10:39:55 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-f2e0a41009so16348604fac.6
        for <mptcp@lists.linux.dev>; Tue, 31 May 2022 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=r/W+4wu0FPGI6yoI68QFRnEm53LzZydcb5eGb+oeO+M=;
        b=TiTLkVFtU+8wyFis6P3sVwEtLLxb0X62Lixi3C/D/wa/Y4kVOZlvMu7chOMwIszV48
         lWS16rzpoPBtaZnHQ/Z7VLZCwwebXgZW/ZRvZaG+p+MpAAKWb1GWDcdxFHh+dICIFO0L
         LQoPrnCQLgMjaDB8k6w0J+9etz/ac83RjvpM3Udeebji/u/HlbjRUbS44QFLqM+lYmtb
         DKBTZwXN2hZicnSqT70JpsqVAdpVg8v8l1CGTK4okdyyHT0y0cBIAth6v3O74jhr0hqZ
         7TEuvqVNyTpKItHNNgNfXV6ye6uf7s+KlJg80cEazzrq69N4uroJCZZMbaCDbPPaT4fP
         /xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=r/W+4wu0FPGI6yoI68QFRnEm53LzZydcb5eGb+oeO+M=;
        b=reSGpXW4vu87APKEEEfawbIXr3hMe2Ym1tb1akdAD6a9kqhjXf4tXFwR6yrKASBbDN
         ppK5EXVgQjQVavZP/Xrk/tH4WWXBbXqA0ZolJ9iKUtblM2neTHarrOCZ+rePpy9/PQZT
         KdTGzsiLFCviv6M95TDtJKK7HX26DczTH4Gjcjkb6cqp4Egge/IjHdfLCvZzGpoy1+nA
         EPkn45k2bzb50kCoqjZH7FnLJxJNkp/kONMFpQC7YC9D1s3332/vTusdecIPEVH+cQXV
         7YGm5HnIWEUByl/7JcObgKLyruZUinXXaLfRPeAvqAew/OHwC7PACy9ipt/bTMIrtFWE
         wIgw==
X-Gm-Message-State: AOAM531ap7fwdkrMy0XL8PwXe9oFg839KctTb0Dy5mOeT0BR5TQ5vOgq
	wNTAKe2Gz165DNvWX1pmdvoy8PHgSmzI
X-Google-Smtp-Source: ABdhPJwIabjbCFc8jAte1zjQGnBkyYCOJzecmG/9AfGZsfnsSj67aF+1JNqzYknMUF2E0qnGZ9YoEg==
X-Received: by 2002:a05:6870:e749:b0:f3:6646:be47 with SMTP id t9-20020a056870e74900b000f36646be47mr2441385oak.219.1653993594385;
        Tue, 31 May 2022 03:39:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.236.143.232])
        by smtp.gmail.com with ESMTPSA id eh6-20020a056870f58600b000f30837129esm4533903oab.55.2022.05.31.03.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:39:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <31935db8f3291afbea6e5dc057f63032ed6f259a.1653987929.git.geliang.tang@suse.com>
References:
 <31935db8f3291afbea6e5dc057f63032ed6f259a.1653987929.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_rr test: Tests Results
Message-ID: <715fc76f-0d43-4b30-a19e-720f92d9d70b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 May 2022 10:39:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4799661683769344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4799661683769344/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): selftest_diag =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5925561590611968
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5925561590611968/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c91606f830c4


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
