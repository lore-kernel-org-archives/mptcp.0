Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8867A
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 07:32:09 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so16615104pju.2
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 00:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=w1rVZxIrTHGW1FTA+7gadkgun4vIECrBrfSlH9gxklE=;
        b=ZcbMNHoyuL2Zhaxluvsz1WaaJ//8SIWTxtS1d1aTF7OzOC8u+qeEqbmnKXAEaz8ZPv
         da5Z5YuvXNfQMJMe8PsNTMhOhb0xSnTL4/unZeczDwMLuHkfjn/2FN4pII7r+hgKascu
         ZslRjkBa2rBQaAWOydOb3XdPaUsRHaHKu9gLuzfLmSKi1HWJ+p3lFmaRlo+KklLnWwID
         EceRXvUKtDywSPxfmRFnFJQRGEZDk1LgLl5d0mJNSiH0StuvKHTuU8GosycaWnncPlmT
         7B7zatvRrQ1tmoM9kJHH5JF91Dzhfk+pgXaZbBeX+kDB9lvDEnhSWrj9ZK/FL5zeGfu0
         NE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=w1rVZxIrTHGW1FTA+7gadkgun4vIECrBrfSlH9gxklE=;
        b=FmZ15PGKbpsMpumgmtJjesqYeQ3ZGRQ0CA9kNZ+dpz3BmA1YAa5p+jwtHTLPaSRqLG
         LGlElK94j2Iil8Fi2Mctydbj9pj3fzbHfD50+a7KzDj2h+C6tABkSK1WPHBIm4INEG2W
         qTkHEu82ErL4VSMRfWn6GpGP+5qwxuGNtLzDMaiZpvEBIiy1LX/z9cprLeWj6vxK0K0u
         mUvNvUw3Rr18yRl7PrfdbR4e2pNQ7niwoqsOHpz+KCoOQ1UdMeOsqfbP7ue8GboAm2lz
         8+x3OpXlHvN2huTZddckTGFgUitWkycfDlk16J0cASpK2jjrCBqNjeW4VTjzDBa+SyGo
         ajbA==
X-Gm-Message-State: AOAM532gyzkbaJMEJ6B9AZmrzIkge/aO+QrecZ80+vNTvp0f9whThfr7
	lTTvvwjYpyuV04Gw83NRJ9U4RgRt9eyg
X-Google-Smtp-Source: ABdhPJzZRfQ/pQEJluKrUeKXq0Q9n031m7iPfWRa7+M4J+KqqRsQAwHssefDHwEcr3H6zIV155agpw==
X-Received: by 2002:a17:90a:ba15:b0:1c6:7873:b192 with SMTP id s21-20020a17090aba1500b001c67873b192mr18238674pjr.76.1652686328580;
        Mon, 16 May 2022 00:32:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.253.140.219])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001616c3bd5c2sm2215940plh.162.2022.05.16.00.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:32:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f625826dad272f44039bf6f8e35fe18196d5ee08.1652680232.git.geliang.tang@suse.com>
References:
 <f625826dad272f44039bf6f8e35fe18196d5ee08.1652680232.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_test?=
 =?UTF-8?Q?_bpf=5Fskc=5Fto=5Fmptcp=5Fsock=22=3A_Tes?=
 =?UTF-8?Q?ts_Results?=
Message-ID: <95850bd5-52d5-4b35-9263-7bf5b2de865d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 May 2022 07:32:07 +0000
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
https://cirrus-ci.com/task/6527744526778368
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6527744526778368/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4698157178159104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4698157178159104/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8a0cf206bf21


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
