Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704502F2E
	for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 14:41:10 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id cw12so496215qvb.12
        for <mptcp@lists.linux.dev>; Mon, 11 Jul 2022 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=eJvJ5XOmkQMGPnybtAk57i9ZbdFoylRwhLwM2/AlVOU=;
        b=j9H7tb9fQXU1fIWHL/bUu9stVcqBiXP8dhAawFnaMsxbC2kapL+n/TBi9DiRgRU8b4
         vfsW4bTC4MP7mcHbmWVHlIMfphbbLM0KTPwNsQcm2Q86kCsSSU8+uphn/Q4onjaacTQr
         RNFmJBphhgevV+Btt7Q+UNwgjxW6BPcMobgOq3U8JYsMjSoTeTFkS73WcIK8netnNAk1
         E2cg+LqHMVEzp+xhYzZxF9cJBpj0PUzHw2y3r31fyJHZUGfd/uDvcKHriT7xy7QZ69Gh
         KXanDQRg8iqatPyKx5gBYO5fFx35IsDR5E0SomeLlnKB6dvlg8FRF2kgej+U0ZMWWHDE
         NTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=eJvJ5XOmkQMGPnybtAk57i9ZbdFoylRwhLwM2/AlVOU=;
        b=p4bxqUo68JqPRaIQnpWd+4E66mGEYETiGnFQ29umoRCni9P98zf0jRshwAMaQLb71a
         CeF3rj9XU65JfBg6tjm3avsHOTrQEtMYaArEwL0e+DcDObmvMoE1J+Y33b9vlvfNVWVg
         G5hSLyrb31oeZ6j/0WJuxcD95Q0n51Z1vk+XLPkvdA2GwSsMvvAZnb3+qdB1/TUrwkwE
         yt0YuqPN5z3rzwIRRHBPSPPIjC3p5wENU4j2ERaw6Lwoen6WAdJiOaKRGIGz9eaEklvi
         6iA6dkLc9HhOCEXsashEan7d1mT+VjSWwdDT6RfEGJ3ukNiwVMoKw/LVbciMOAK1Uv17
         W/8w==
X-Gm-Message-State: AJIora8RhvOpxucJ4xAbj0+WQm288jWdkfdl9wuQAViRzyj5HYKwmhxn
	6vYUL0ZtG4icFJlUo2QNEQ==
X-Google-Smtp-Source: AGRyM1sxKvMSdqT4hKYx4swzYv1rp14rt2vB275mbrs7JjsvYnlgsoj0/ieU5E46d0uJ29TT3cRZLg==
X-Received: by 2002:a05:6214:2465:b0:472:fcc9:1dcd with SMTP id im5-20020a056214246500b00472fcc91dcdmr13949116qvb.78.1657550469278;
        Mon, 11 Jul 2022 07:41:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.168.8.93])
        by smtp.gmail.com with ESMTPSA id bl29-20020a05620a1a9d00b006af45243e15sm6632757qkb.114.2022.07.11.07.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:41:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220711130731.3231188-1-jolsa@kernel.org>
References: <20220711130731.3231188-1-jolsa@kernel.org>
Subject: Re: mptcp: Add struct mptcp_sock definition when CONFIG_MPTCP is
 disabled: Tests Results
Message-ID: <c65825b7-2d9c-4f49-ee75-426d7d59c50e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Jul 2022 14:41:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jiri,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5307521400307712
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5307521400307712/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s):=
 selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6433421307150336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6433421307150336/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1d9ed6cb0b33


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
