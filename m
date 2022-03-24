Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8A1FA1
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 15:49:03 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id f3so3988119qvz.10
        for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=spKD6x9VORspPnRB1lQpWXAgwM55hK6mlX7ZABczFKg=;
        b=dBdfuPPztx1E7hPGNQgBbKzxtrdSA2rQyEVSZdHLC04VXE8F07RkN7nwXoqDKyIRQ+
         tdx9/6ZvrABC21LMonfh3JQ5iVlinHdWvIFbZsJqqfDUS6uFujhLzqzLRgaoV5MhT4uE
         lrfnj40EsgYPrusNNVrIPpSHPDFPMWmDzYlXx0hdaF1ROy+r6HatTH64dcyzdvJD8xzN
         1bUubjtdu/RJhF9m+VzQ8FpYqvxNVl+ukink1812kKMn6j7sM+Cvp1PsRsH+d1fPT2v1
         YyBA2QuB9wKGCHZgLAIXAajDw3tzgLKWbfZC/eIHo/z5Dq83X57iTP5Vy+Z1qtcovcW3
         iEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=spKD6x9VORspPnRB1lQpWXAgwM55hK6mlX7ZABczFKg=;
        b=qUB651vba5dnQVmj6sUqBxzhP5yqKIi6Wgh0tbAwNSS0uezlXAjxX2oWJ6ZsvNBUBp
         y3E6YrXZx8UzEfpAtz2D36jYdTSg2KCIP7Ox1UrzFBbHHaJoIoiloNPlkF5ZwL7yeaRT
         jNKuzUPVWQzUAyj53jEPcRvn/kQviQcU/9TcdHlfJ99/K6yLcI3eefgmioKw5gg9Jc0C
         UhseUzpBjYXVgIdPAsc4pwUKGcRUxixSwoIHu/Y/hy4ZIsJslG9OqOUBH52iWrfDBLve
         laCnLm+I+3CI0KUzAZEsuAiD7m/I/xU9QSH3729RLdKE7pRzbSkq4MD8Qew/1WOTIZPf
         /FGw==
X-Gm-Message-State: AOAM533/dP+RDkM8c3J8iIWcGmyeKzVDso1LOgS2XFi/CGeNbrkby31m
	kvWaGMbamrIXPc65RAzHZiRPN6d6OQ==
X-Google-Smtp-Source: ABdhPJyQRsfHE2vICoy+uz7klUn+2SmnVEodjn9GhVeiHlDmjwnU3CPQprbNSZ0gKwN0ZJ7WgRJRsg==
X-Received: by 2002:a05:6214:22c:b0:432:6b2b:95d0 with SMTP id j12-20020a056214022c00b004326b2b95d0mr4780467qvt.63.1648136942224;
        Thu, 24 Mar 2022 08:49:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.122.150.71])
        by smtp.gmail.com with ESMTPSA id i18-20020ac85c12000000b002e1ce74f1a8sm2797702qti.27.2022.03.24.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 08:49:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <873b153faa28f724668185f9c3aea2c2e4bdc442.1648128255.git.geliang.tang@suse.com>
References:
 <873b153faa28f724668185f9c3aea2c2e4bdc442.1648128255.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: verify first subflow of mptcp_sock: Tests
 Results
Message-ID: <10f66f21-de37-84bb-e01d-7e6e82eda4eb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Mar 2022 15:49:00 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5025009943969792
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5025009943969792/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_sockopts selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6150909850812416
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6150909850812416/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/261123c9bf65

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
