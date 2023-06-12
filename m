Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10EAD3C
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 11:17:30 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-3f9a949c012so37828591cf.0
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686568649; x=1689160649;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiVBNXCJXdhbpylgojzFJ7GdUY/5GDfGM7oQysehiso=;
        b=JjeuwU1QwhPhRWp1U14QcNvYxy+zomYU13NKruYffp2m0SnCqzC4nm5bbamuYZTZAj
         Lga8pLIRlPWremOGDwZrHTdb+nNJuD+7iccL8SvJf5gzQ3OiWpw2cGkMkjLuahbjzVMh
         C75S5lIDNaZyrQsteniHnz75bA9kHl2XIxZ/vx0/uSV/jxuDXKKwL2RG9oHtKpmXTQeY
         2jra2+JDTKAtoimeqIYaGKmH6rThK70yCd4Tu3N2KuQLn2MrRaf9VvD1iGOdJiG21YXZ
         1Kr5i21yGGpy3bn/d3yKHGB97oAwWDdWpEcMPhv8+sC3kJFia4we0+A+/BWA6TsbuZX4
         PeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686568649; x=1689160649;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiVBNXCJXdhbpylgojzFJ7GdUY/5GDfGM7oQysehiso=;
        b=PJc1yfI2gPIzLwzdgyUdhsj51Yr1Aa1LlT0KRPKq/Jw2ebaH9w2yzQsLQstO37Oq2S
         QMIaiE1cC1NoiGUpz6YhADrc8J+ooIi6lT+/szIre0urLNDj1x9vN8KmLb8w0/WGWm14
         jNPsngkBDqkpAT89GBLa1moRP9s7F+7qu56A+4eH+4rUr56inDfSWNr4scjg2n78Euug
         6/Vud0pF0t8GcwxZc+pyqyKq1SNqewHMIQhoWTOs7NfYwkUTam+NU9ATXtG5DFbQtCmW
         YyAzEpXitHdi7J82g2U+19iTy5gBimighvM52fa2z87Ia21vwggiYjs35VbpUtF4LpeP
         uIMg==
X-Gm-Message-State: AC+VfDzqKq+dHW4QWr/l4HCsjmolssy6Qv7SYgPdCkutt+tnxJhjYIAv
	g/S9bgOdAJrBNExh/vGZjg==
X-Google-Smtp-Source: ACHHUZ6SwEf3u8WRu+6IsBeaUO0IVJBJON0khN11j43yeVKWcgY/VGGq130VsvSoNayqlKl0RaA2JA==
X-Received: by 2002:a05:622a:1493:b0:3f3:91bd:a46d with SMTP id t19-20020a05622a149300b003f391bda46dmr9956275qtx.8.1686568649600;
        Mon, 12 Jun 2023 04:17:29 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.203.202])
        by smtp.gmail.com with ESMTPSA id h1-20020ac87141000000b003ef5dc13bbbsm3312569qtp.85.2023.06.12.04.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:17:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c840f47bde581fcf910f24df6d136293618ba1d6.1686564758.git.dcaratti@redhat.com>
References:
 <c840f47bde581fcf910f24df6d136293618ba1d6.1686564758.git.dcaratti@redhat.com>
Subject: Re: mptcp: convert netlink from small_ops to ops: Tests Results
Message-ID: <c4800207-3ade-1bed-5c83-25afdd102dd3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 11:17:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5362070888120320
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5362070888120320/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5784283353186304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5784283353186304/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6487970794962944
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6487970794962944/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4658383446343680
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4658383446343680/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/597886de2562


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
