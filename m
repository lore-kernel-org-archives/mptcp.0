Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4CF101C7
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 10:25:15 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-666e6541c98so1456357b3a.2
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688120715; x=1690712715;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7s/nQgGYue/c7JOQuifXRV9tQQ3+HxoDCi5KosKM0c=;
        b=JIfR6d++boz754kqdngiJf+s8O1R24piMQ+huLAl7wIXLJOXukfwIqbum1KDb9lbqf
         DLXgaIzN/QaCNKxtsm5PTCDi+flQs5FHpu2vn+6GsjRSwRc+jkPN0+TeTs+EgfUZUA6b
         TRlhoI5UbiChl9HQUnMhy6+yiD1RZIz7mh2mZVBv2j13f8VI9PRj22dvIODFN+PozKD2
         yfIm4QXmGMXbmAgufhAD0MxBz5nbAtEFYFNWSMhdN7BnXl3793Nyvu4xkQSfK/1EuwEd
         4H+wag3YmfqFgRsW0TaT2mMpLDfW8pPozrQZkb20UdNqmLLrTX0PlZxf0oIt5qg+Suvt
         0xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688120715; x=1690712715;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7s/nQgGYue/c7JOQuifXRV9tQQ3+HxoDCi5KosKM0c=;
        b=h6bIgFTdwz8IJuDKLx8aQ7ofAIs/QeWPUtuOW/FZGgzfctsNe8jpxWwuRsyhVczZcC
         ynZYA86519+WjyNmoZJA7IsPqYcjRa/ZjBv+YHL+HxfUfkcpClAOHR+5pWwbytlUjcZd
         I1giNXCyGF8ZYy6zYU/aul77nG7o9Llc3SC9+auwjbFHOkJbbU4o6Mgs+usWva/TkKWp
         sXwutEhrNl0+8dNv/DO8T5Na3RqaeLw6TdqLWwyW+N7ZjT1qfprdjW1LccTwr3WOnXdX
         d/UdEE+mNp6s+c5wiRqDJt/9oB/16hIJbP8OIWE1lYqXytb6ZqBIY8hr7uaqYHFInbob
         ftng==
X-Gm-Message-State: ABy/qLbe8c+JmeN+Ft+ZrsMobFtJhkiTCiEFfRG767FsuSU+evzmTSfe
	jZWqO4gsB0PfMIVsa0QZPg==
X-Google-Smtp-Source: APBJJlEvRMNLpYcy8pLFChmc1DRJ5sP4ozzyIQlXh0BxhbZsSLEKyjZdi1PC6SXsGnBbfDnvGltUlw==
X-Received: by 2002:a05:6a20:1005:b0:129:6cc:921d with SMTP id gs5-20020a056a20100500b0012906cc921dmr1964028pzc.54.1688120714820;
        Fri, 30 Jun 2023 03:25:14 -0700 (PDT)
Received: from [127.0.0.1] ([40.83.243.142])
        by smtp.gmail.com with ESMTPSA id t18-20020aa79392000000b0067e985d2526sm5226460pfe.149.2023.06.30.03.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 03:25:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d0352b2b949544ce4b87ceeec55109fe22f1fc26.1688092826.git.geliang.tang@suse.com>
References:
 <d0352b2b949544ce4b87ceeec55109fe22f1fc26.1688092826.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add speed env var: Tests Results
Message-ID: <e596772d-244e-26b6-b799-61548b4688d6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jun 2023 10:25:13 +0000
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
com/task/6734880143310848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6734880143310848/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5098806841180160
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5098806841180160/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6526733881442304
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6526733881442304/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4535856887758848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4535856887758848/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/85388c998948


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
