Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A38AD30
	for <mptcp@lists.linux.dev>; Tue, 28 Mar 2023 18:07:13 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id iw3so12511213plb.6
        for <mptcp@lists.linux.dev>; Tue, 28 Mar 2023 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680026833;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s/RpMg7963eKSuwlUPUhAQsCifNke046rWDCIkU1QA=;
        b=LYlYvvIFzwSDnPnkSYx6goIEF0XI0uUOKDpTfM8TECxsxRKn2kT5ghPAK8/RhuDtZL
         sOtlXO2a8YFqE15C861OE6MMM0+y65fo+gE2lT62QHe9JLI2iXM/VyJSOGmAdkIuEJTz
         7VsvO0MsQC6hypi2MalHeMusM27jwDK3fG4rFmDPFgnu92oeqwTKNx1M8KCzySp5FiLX
         dxLy+d7b3vVRT9PTYelr4LmMgl5E0WrCtdcdc8bdVYa74dZdiH58Z/a5+4arIQLn2xaM
         Bzb+kkiismF91t/vOvoC5ZEAbJErxg4fMI08VNY1COJgdvuH6CCFcbWIAYf4OjZJyPMG
         4A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026833;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3s/RpMg7963eKSuwlUPUhAQsCifNke046rWDCIkU1QA=;
        b=20nYWemTnWwDpjfJVwnePrKM3kt5vw2AyzyckDeWZ1+XL1twYv+PssHyXq3geSDtGV
         1C+aOA7gwk0fyWmCujDGaGTKl5W7DPKESaNZosuJy+YXdUB7tZFgWDs3nQVz1gHLgxwX
         jeAaD8IEoRh51klwZ3PHGaF3KN7xEvSu2RDyJA65Tx+3hK+MxTQ42eOSPlUHxYPh49hv
         mDEgwcDPCOmYsLyvXTr//ZVXvgW8k1tKMmT8hZIIPBmIa5PQVVo8UQeyx27rbMU3R2HM
         byBESu1gb5Mqq/MSVOkFYaA4LetrrERodoPrYneIjBLey9c1/clyTfrjr5g8PKnN/7aR
         ZhJA==
X-Gm-Message-State: AAQBX9diZCLgJ18k9JOuPv5er8BiO0oRwNBhWErVjSOrx563wFKQa7f4
	6c/19jyLwAcrKuYvCk5Qyb6W97e1UA==
X-Google-Smtp-Source: AKy350blg6MFgNCs7Lh3BFxrSsNDWgdLBjmj1Ch60ef93IO+7evwCCoyVVagSv6MOqz5NevCfCa1Cg==
X-Received: by 2002:a17:902:f546:b0:1a0:6721:6cdb with SMTP id h6-20020a170902f54600b001a067216cdbmr18793349plf.40.1680026832928;
        Tue, 28 Mar 2023 11:07:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.244.145])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902b49400b00196807b5189sm21339502plr.292.2023.03.28.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:07:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230328-mptcp-selftests-userspace-sleep-verify-listen-v1-1-2a4adf550084@tessares.net>
References:
 <20230328-mptcp-selftests-userspace-sleep-verify-listen-v1-1-2a4adf550084@tessares.net>
Subject: Re: selftests: mptcp: userspace pm: uniform verify events: Tests
 Results
Message-ID: <a5406313-c3b8-e965-62e9-455d4d186f2d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Mar 2023 18:07:11 +0000
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
com/task/5618456821760000
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5618456821760000/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4518945193984000
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4518945193984000/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6744356728602624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6744356728602624/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5644845100826624
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5644845100826624/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/84382bc475d1


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
