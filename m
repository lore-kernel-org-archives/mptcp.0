Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC928E1
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 18:36:45 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id f5so11922265ilj.13
        for <mptcp@lists.linux.dev>; Tue, 10 May 2022 11:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=tpSqHiWgdUfjgYNMyiGnI7xEwEjz7ZHwUAxC1naA1m4=;
        b=EIHMR5yuogeIBfp2U+wN3ufPrteWTSrmymOYaOwSCf+5ZbOrpSxKP2VMHdDg2aE2cR
         qanbw4EXOvhNdiZMdTAkn4Y53P28InJUOhdxRYFB8fk+WzIjFZkPnL5qgbdQDvUEaokH
         8XgoSrVrTROmsP2Nbe9atK0lNtebwSeWF7iYOWFLbCg/Z8Gj3lAtw9WKTK8LjGpEwQHj
         sfa+aQ9hvocXNoqNvQbpO7Y/owJnyNrLPFSJAtC8tfpvyIZrvE5fLJpAM1qkqrMD1wk+
         lHMikUCM3E72hRu6ZcsRRU6En9Isddo1NDfr+hzQxpjBB+hHn/GwypBjWe/od1ZlBNI4
         +Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=tpSqHiWgdUfjgYNMyiGnI7xEwEjz7ZHwUAxC1naA1m4=;
        b=Ui88TJlhkzmvYMBRc9ERfWGPVFNkFYBmn8dGDuxdzoje5EzAgL68vW2yaX0vY1juFc
         wWwzBS0wW+Ce+C3T4zu4dWxedHlaC58Fv1QSffefUuXwmO0Fxw8Kd5TJrqL4f2fQGI1k
         Gy5T8FZwSBk+eDsN1r3guPaqvI3IOD3pM0MHHmcjfyNdwJrei+UriqSV2LU2Ltyey+js
         pIixm6mzY7yfugmyyXR/jdZ+qpo7YKO785Pb/z9hmBb1QHd+NsC+uCCVJMucQb/HBG21
         /ow/evHnwOcMARmLnEj6r1r6LsKxPxqpfOY4rBCXdB1HUNtw5s5OgnK12iV5Aqid8OwR
         huBA==
X-Gm-Message-State: AOAM532M21AffBaEWZbm6OjD5pEDbA1GYbgmGRdzNouGDMo6zgo7IOja
	2YTmp891fLZGK804577nlg==
X-Google-Smtp-Source: ABdhPJzu/pELyhYcT/paWRA9loF0AOhvrLdo8bFcSAxgfN/+JX27HRkRhuxvJqm9HX0k4fE6HYRBsQ==
X-Received: by 2002:a92:c908:0:b0:2cf:8084:5e21 with SMTP id t8-20020a92c908000000b002cf80845e21mr9208387ilp.255.1652207804609;
        Tue, 10 May 2022 11:36:44 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.128.31])
        by smtp.gmail.com with ESMTPSA id d12-20020a056602184c00b0065a47e16f59sm27123ioi.43.2022.05.10.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:36:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com>
References:
 <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com>
Subject: Re: mptcp: fix checksum byte order: Tests Results
Message-ID: <cfbceaf4-fd14-c7dd-08af-9bf7e5d8ad45@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 May 2022 18:36:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5103936225935360
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5103936225935360/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5208863484936192
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5208863484936192/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/eb65d5350700


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
