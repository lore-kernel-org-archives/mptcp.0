Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779A3222
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:41:39 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id l5so12853469qtv.4
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=13TDzxq/4e7KV1tyuFjBVTPuJsqOz69YvrhHx2UEPP0=;
        b=mX1m7/tpE1qfo9xvjtrCk3hAyH8n+Z2JfZN0SWe2/Ym1GM0PiBu1TJL7GOcQY+QA1h
         u6+C1htNS+yivLzyYKp0FVeHoQ9mvYHSfiHrDCUQSTyPI4+qMBclBN4wloh+vsoj5UIC
         H0UnF+hYsc9FpNVM7A+6QdkE+tfrWhMZhEPs0Fpk/v4ZIPTw0rx8ydt8aiSlZST94ggW
         8NWjAH1A57GSBBYXEfIXgDgY6bmgpBtVuv9cz9US8aKNhMT9D/GW97eb85Fa3YU0PPZv
         NlPbtvTJNpHEI24pLeaoxUznia0Ugm99gJ+/bd2gznxHJUhtJeyKuJl3zxvBq20hNQ5p
         +l7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=13TDzxq/4e7KV1tyuFjBVTPuJsqOz69YvrhHx2UEPP0=;
        b=WwrF31kOVl5EkooDiWUL/unFSY/qdAxjXiJTPepq9dWKIShN1P2clNpJ3UOwaSa8Sy
         N9Ixbbun7GRqi7aR4LWJuHJiD/SgsZfNqIL2wdn+viVYqjYu0hPX6NAa7VnQCErylG0W
         CD3UBOSbwSpBUA0TgObX9Q8V5qq3WZIv2ubi2F34coS4vwCLGrQAS0aCIC29iuhVzpzv
         FWXYQDJZ/hFMnYNKOsiylUSZd9XMu0MZ+GojS4fmBqxmHGi6SD7NO+wGRhvY6qi9q+Cd
         oLbje6K+JdVs/vtLmHmgb3hj+qFfEwNPzk6CfFPXOo+WObUDX3fQr4Uc3KOw1xYigwh6
         hUVw==
X-Gm-Message-State: ACgBeo10qeML3+MhI0pt/Nftye7P0u0g2BebkiOABhSuEWkxzqinKM4+
	508Xzb4vGctYdAeLVAYDeA==
X-Google-Smtp-Source: AA6agR4aGGdJz84lEhT13lU7EAP9YzMhLuogFeMg0F0IzKEzOYxDPxghoLvf9D1KITpNzhoceyHWdw==
X-Received: by 2002:ac8:7d92:0:b0:344:aa94:4798 with SMTP id c18-20020ac87d92000000b00344aa944798mr7770019qtd.511.1662644498682;
        Thu, 08 Sep 2022 06:41:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.7.132.7])
        by smtp.gmail.com with ESMTPSA id bl28-20020a05620a1a9c00b006bc5cdc890bsm15893768qkb.77.2022.09.08.06.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:41:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220907111132.31722-1-imagedong@tencent.com>
References: <20220907111132.31722-1-imagedong@tencent.com>
Subject: Re: net: mptcp: fix unreleased socket in accept queue: Tests
 Results
Message-ID: <4e6d3d9e-1f1a-23ae-cb56-2d4f043f17ae@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Sep 2022 13:41:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5981233187389440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5981233187389440/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5418283233968128
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5418283233968128/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aefc08a013fb


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
