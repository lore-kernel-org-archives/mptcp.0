Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D09473
	for <mptcp@lists.linux.dev>; Thu,  9 Mar 2023 13:24:38 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id y10so1890006qtj.2
        for <mptcp@lists.linux.dev>; Thu, 09 Mar 2023 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678368277;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q86hisJJD3gIh8z5UbYrgj6eGR6htb+roMpXLMR44Y=;
        b=VLuq5AoQ9jiqvZcB69zrZ0uGwdeVSWNZmr5enHazp29v7o7Zblhg9povNvX2bjtF+G
         sEuwQEUUEsWh4sZ1jULuyfDmYEQJRRR1VHDwvHabXPNxvF8EIB3pjMKTgnxC5DsH9grs
         SaaaA1fb8xR4hbNhNP74+AP4zC8OaI5v0wFbCnXux8pUadfpuPBvnjh3ESMvOQFJHpEj
         DPj8kFyMT/8JlzHv9SqOW6uWXdloB7rC6uDbxSk/z+pw4/BaqiuUpha7lyv0LIitX0Vt
         k2y7BIkp3q3vmQVvkw5ZN7xsYa/a9eSG72smZPl2r42UJrehR+bGuwXaS9oX368DRUdu
         cpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678368277;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Q86hisJJD3gIh8z5UbYrgj6eGR6htb+roMpXLMR44Y=;
        b=h+d2uAm62WO9I+bqT/PZGCT/Nj6SPtimc8wIpwimOIWBKt5Sxehf6gduoisbXXIUKG
         eEPJoodnsC1AXFpeDRajJaCDJrPbK6Fw/F1aKNrG99Y3dgrwsyGaDSqHygXBDe/aSwnu
         GSKiivTC4a4YAln3NmFd3OHRuK8AH8NRVjsSV3JorwbycapdX1/YKE17+zQ1lLlijuWY
         GqLV3VAWVySW8e2RimRjp/7YXbgI2YUKoqLUEadgnPDPRWYM0XCx17h/tE3WmeyKNaJj
         XkfUkwlkX9ArSoYhQmlNrGwmdUbZ6MRFTGVHFWoydt06A1i3TNqwm+RwHfkxskMzazRG
         GEhA==
X-Gm-Message-State: AO0yUKV+rHk0pnr04x9gFQ1AmD3ucLQ/h47zrWTZ5h3iTQTvAVvnJI4C
	iuBVC8OC9/cbZAN4hLlFgg==
X-Google-Smtp-Source: AK7set+mjjUWceku6lxhQStvplLC06mE1m4gOYbdTB+iWVpb3JMvS31y/d5E6nZywrZuRAjYldn/7A==
X-Received: by 2002:ac8:7fc3:0:b0:3c0:3c25:1b9f with SMTP id b3-20020ac87fc3000000b003c03c251b9fmr2629700qtk.56.1678368277452;
        Thu, 09 Mar 2023 05:24:37 -0800 (PST)
Received: from [127.0.0.1] ([172.177.120.52])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b007426b917031sm13557082qko.121.2023.03.09.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:24:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4b8fae0280f74cb4678677a112113bbbc2b27d5a.1678365107.git.geliang.tang@suse.com>
References:
 <4b8fae0280f74cb4678677a112113bbbc2b27d5a.1678365107.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_info tests: Tests Results
Message-ID: <a4d59434-8934-c1fb-df71-0aa669d951b0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Mar 2023 13:24:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6237066632101888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6237066632101888/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4829691748548608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4829691748548608/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5392641701969920
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5392641701969920/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5955591655391232
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5955591655391232/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ee1cda591474


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
