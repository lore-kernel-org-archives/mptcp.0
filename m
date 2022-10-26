Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29357B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 00:06:00 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id d24so12452564pls.4
        for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AiGy2RMj8h3Xn+U/V3Tr7yj3dCLx7F17XJEFShq5cs=;
        b=aK3eouvQJ+VumIvUd350iX9yi5pkN2gfqYfqXS2mu9MyNhx7+R88+RpAM1NoaVPVV5
         gOAP5H3QaWuT1DjQMh4LscyI6Yd8U7f1IrLzhZn/J4qrqirm2y4BnQoXl/qEuOeMTmFN
         BIdf662NAbUy9XAHn0kVLz+IRMksm/aIhvEcr1SRO5F53IlavoyeBHh+kuu2WPzLpDW1
         3xq046Exv0JOXbvMtc16I+sfUive5slGmVTvFL0iDqYPvQ5j715x/iegBCogxF6puHbr
         YPUMH7E2+P1iPIko013jhdCpPTbVmkplDKoRM3dNDJpb76j1eRNQ1ZnRfTbOx/q8/EHs
         A0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3AiGy2RMj8h3Xn+U/V3Tr7yj3dCLx7F17XJEFShq5cs=;
        b=L0B8At4OH0c4/mQaa+E8z87aVCP8oW88doYWe7a/NtyiT0evjeixzFXQV7QsKeC2Ym
         DTJTidjCPDSSfQVffr+9z9WHOffh/GsrwdpaCNmj0akIUJr5Q3i9FHMUNJBxEkB39VHb
         dUwjYq+ioCZwFgxevd/JxbodekUxq8N4QQYTLOOPFpQjGXBx7XMLDT8IyCGiKjQVKODR
         +NnCHyJNWUI68xpWXBX3AlUgSnPVn/Yrgvo5KLMBBIYLYnutGjnDPigHcNOMNRk5BLY6
         9hOBe4O/9IsOC/ohgzGN+rIX0ixcodRRNN9L3XZYkmEEAqfydpeKG3PlXJt5OZk0KwJM
         SUqQ==
X-Gm-Message-State: ACrzQf0g9MwGje3Z5LfdI1TKYJuY5VUxC/rQa28gE7S1AvdW7Yf3vsoA
	B9lCrYxLviOAOCy4DOhP3A==
X-Google-Smtp-Source: AMsMyM4TcRGtfvrUB5vZB+DZp8vonnNXV9hUmnSnDHNQjJ4ZTD1u5SZ563JazievViBEHS3lUnQ5MA==
X-Received: by 2002:a17:902:e552:b0:179:e796:b432 with SMTP id n18-20020a170902e55200b00179e796b432mr40466323plf.21.1666742760057;
        Tue, 25 Oct 2022 17:06:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.86.164.159])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090322c200b00180033438a0sm1719501plg.106.2022.10.25.17.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 17:05:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221025032610.17496-1-geliang.tang@suse.com>
References: <20221025032610.17496-1-geliang.tang@suse.com>
Subject: Re: mptcp: get sk from msk directly: Tests Results
Message-ID: <17fdca5c-9d20-7e34-2e85-744f444dc3a7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Oct 2022 00:05:58 +0000
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
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5515831614898176
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5515831614898176/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6641731521740800
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6641731521740800/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/be4684093314


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
