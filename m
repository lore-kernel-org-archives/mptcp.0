Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4F01642C
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 18:16:13 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so3111333b3a.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684779373; x=1687371373;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQtuiZlDg+gfdcAQdiN3Be+zd/EysRTUYXsR69ryhsg=;
        b=qfls+UwSyd0eyi9QQscSD5dX78T3fX5Wcgxq1oEFM36MAMsOE0T28fRnieI78dckCa
         oKjzjllrWuNsaHJiG3ld+GjTPLdTNk1Iei5geahKznskG84dcoaQGcBiIG41rh9umW7z
         alJX86NIyYgeCWZdK5zDCUGif6s2jgfvJk3p3UyLSTCez4RMa1fMQ9uwzLN8URH8awxy
         pRfky0+SkTOvmKRUlKBQgYRFLCzaf2mwj/9DA+FBYS6rhcs557YpS01/bmOqBs9NBaaG
         Snt1TDZckSJyt216CtBL7ClDfGHP9KMSe3w/HJdzi7Qi1ZGSuXMqO3yLdDxNp0nq4IB7
         839Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684779373; x=1687371373;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQtuiZlDg+gfdcAQdiN3Be+zd/EysRTUYXsR69ryhsg=;
        b=iDcUMRiqy89jBAhfqZ+FsDQZbAWkBgrVeQTrY37NW3tPo7pnOTvwM7nKkC5O8SIamZ
         atFiyCkiMwWOwz1ZVFz0M0Jan2851IdWVqjD3TqvH+ZJ9K+4BJo0FwtLeOkEKd36ATZC
         ZsXupX2oM9iv//SQ9dYjG77Rvaw8ndyGLd8Zklo+Ene2mj6WHZsD08NndVvdDExdhVu6
         JQTIi/0IU3V3Vi6AZ7mmLiEnpCCVacOIRB/IV8ihs6kcChF0E7k0GTdqOYMjMOU+Uath
         mv4phdOVdh1YroYbb48m/voaVat/k/tWP1c/nJxT7ltu7VNNrQtXFugzlk58McpBOglJ
         ejAg==
X-Gm-Message-State: AC+VfDwCewSwfuSBgfcFRBct+Uu+sI2oD7PT511UdpNgimi/o6xHxQ+K
	jb4ISQo8zyHRLesAzXkOuYkGLI7q/zxB
X-Google-Smtp-Source: ACHHUZ5/cQIigTmlpUKWBJDRljkQ1n8bY5YMhoFw3IQ4aNLwhVk+EFF4PTf3DbhjK1NkDivP/823aQ==
X-Received: by 2002:a05:6a21:9999:b0:10a:c09c:bd with SMTP id ve25-20020a056a21999900b0010ac09c00bdmr9591289pzb.55.1684779373258;
        Mon, 22 May 2023 11:16:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.133.128])
        by smtp.gmail.com with ESMTPSA id g37-20020a632025000000b0051b9e82d6d6sm4709220pgg.40.2023.05.22.11.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:16:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230522-mptcp-skip_print_link_becomes_ready-v1-1-9d5f28f19440@tessares.net>
References:
 <20230522-mptcp-skip_print_link_becomes_ready-v1-1-9d5f28f19440@tessares.net>
Subject: =?UTF-8?Q?Re=3A_net=3A_skip_printing_=22link_becom?=
 =?UTF-8?Q?e_ready=22_v6_msg=3A_Tests_Results?=
Message-ID: <bb84429b-69ab-c0ad-e7ce-3c5b517cbde6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 May 2023 18:16:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5210575714648064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5210575714648064/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6336475621490688
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6336475621490688/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6055000644780032
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6055000644780032/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_syscalls selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4929100737937408
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4929100737937408/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c8485501ba56


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
