Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F117C3
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 09:52:51 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id hh4so6539043qtb.10
        for <mptcp@lists.linux.dev>; Fri, 20 May 2022 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=+rqyXBdnSLpPMY9yao3eI7/xBS+nrTaL67goidDegeU=;
        b=js8r9Us/nK4DQ3UrjvYUsittdpa80PSl6KXZWgOh++RxxNiZhZ5Hg67HDJiOnDwHfB
         vS8youMo8HMoUZupN3hPYOiEPE5qmxOwYsBd+Bl2mWqJvubhTccNO1WbQzIeRPbZOWw6
         x6nHKEn7iiRtB6jbXQbDt+BSB00PsW/qsx9XIvw81DRAD+3ovLf52LYKLUicadaM4EvR
         fTfJ5ieEtCEGf5ZLAksArGOvwX962/m9Q9W70/vy5SHT3mWYomx2WAc1b9yooslAw4xH
         erYHF9ZQ9MLm7j2WMaEX9wOtCymEuNQ7Qz5LhILroB1VWKUD+ryI9d/DEO4J4rFpw8wO
         pU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=+rqyXBdnSLpPMY9yao3eI7/xBS+nrTaL67goidDegeU=;
        b=mv+MBdZmoeq6YTa6VFI282YpQLW3g5GCn8f7C7wKuWGbFm1LFGjZ8CquSfud3MpzH4
         q1eT4KSddKotQ/8FGBkGU0ZpFMH+XvKVLExS1O6aUWYIRtQgH9yrSOj1RK0pgnlMtkz3
         XlhGTuzJExrOMxv4cd4eYYo1TA3nD5R/v4IPeguZVzT67T2Zp6QvijPCA+YelOKfKLZL
         nvrTuF83nPDQ+c9MQlY/nkxQ9Wnp/DrkunSIBMeTkKMvyBuWMQPibLZ0Lor4Am2/xgfa
         42gonFbTZ19nIFF6tvnN/S6t4vk7UffoBbyoMeMjKOcVls/C6ey6vKHBGxcVln1BBXHm
         3TIg==
X-Gm-Message-State: AOAM5333O8aI1lsnATgqNqIfwaSl/5GVhHL4A8oMCU/BVbCr3LV4jAch
	M1Pya+hSeu+jIsyRm+AM8g==
X-Google-Smtp-Source: ABdhPJzcOr+6jADuQ1KjSn/PJePz3a/c5Rl4uhriGzSWIarx7Lx/6JTZcrze8eDpXKo8teOtOAbI+A==
X-Received: by 2002:a05:622a:1010:b0:2f3:d8f4:6cb4 with SMTP id d16-20020a05622a101000b002f3d8f46cb4mr6854003qte.180.1653040370396;
        Fri, 20 May 2022 02:52:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.92.31.247])
        by smtp.gmail.com with ESMTPSA id 202-20020a3703d3000000b0069fc13ce213sm2913862qkd.68.2022.05.20.02.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 02:52:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d232fd9eb44b9e665bfb03dcda7863f428cad7d8.1653033459.git.geliang.tang@suse.com>
References:
 <d232fd9eb44b9e665bfb03dcda7863f428cad7d8.1653033459.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_red test: Tests Results
Message-ID: <6f1ee3a6-591d-88eb-47f0-3498c11b32a9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 May 2022 09:52:49 +0000
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
  - Unstable: 2 failed test(s): =
packetdrill_sockopts selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5160997752143872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5160997752143872/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s):=
 selftest_diag selftest_mptcp_join - Critical: 11 Call Trace(s) - Critical:=
 Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6286897658986496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6286897658986496/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/806258f333e3


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
