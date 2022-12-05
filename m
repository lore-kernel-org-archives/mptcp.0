Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D815CAE
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 23:43:17 +0000 (UTC)
Received: by mail-io1-f52.google.com with SMTP id d123so3236768iof.6
        for <mptcp@lists.linux.dev>; Mon, 05 Dec 2022 15:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP41oRG/mIEEMDmbwz7fdCrHRCcgHTPTehO9e6+Fszk=;
        b=eZIR+kwCceDbKaNuTVL4MjYM/o4sEPsyPJYb+8gGEYanmcps5ZuIwuDRB4O9T+I8q5
         4T+B/ibbr+IF70WGBLkEFASdCv5+9NqP12qtNa88lN+SzxinO/qCPIWbis6GdHkf7Dpe
         usfv8fZZAo2G/aOmfVYiiDD/GeODKDkw12zfBqp24vfkmoTdUCKU/Vb8I63qTZ8HrAIq
         do/nVEFN/OTSBJfpW4HY3KoPJ3Qtm7oSMB8jphbU5tG9rcfaDMab+HvfH6+OF/G0irrH
         6KbK7+j87LCoJUydWcfXPsJtC74oa1lKYhwMkY+F1IyhB1VOL6fNAXgnV7hAvMY+bgoo
         rX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sP41oRG/mIEEMDmbwz7fdCrHRCcgHTPTehO9e6+Fszk=;
        b=AK1sHQNQMMUF5xn4N+W06V6WmPCJiv16hWphJlrPMSgzJrU/VNb/bl/8ev73GNe9B/
         sTWevE6Xmr9kaRtyC6kFONUBLZ5/lW2AaVWEqemJrJvRBj/cDDmsyn+n0dfGVEdsg6Ix
         CsL6lO7UbzjqDZqytiZyaumT0LIQhU1UzKjoCwZFXwLdvbUsHr+4iuQjj7ZmYi634FxW
         gjgHNcpGxnqPd0h5WUaM9cKWVV+jl6eXM/NOCssQVVFHz/Y6voCWnKzCMsH3rCXLczzn
         oAjZXPZtM4m3r7T1bUyY73SzHjEKF0mP+J1zLOATzsxkjblXjQaeUqw3ujYwnsKWH78P
         CGag==
X-Gm-Message-State: ANoB5pkkhai9lsZzGKPTD7hUH0aCqZLw+M30H9M1F+QI0kMPK0NTLv7e
	b1oyJjCxsZIwC2PVEG0zqe1mOUb3ZfO4
X-Google-Smtp-Source: AA0mqf4sY5In07vIwP/Nium+CwbnVbAFJyFyFG8wyvzAySfl+VZh8rTVgySw4Apg/c36n69qTsotGw==
X-Received: by 2002:a5d:88c3:0:b0:6d6:5fe4:8212 with SMTP id i3-20020a5d88c3000000b006d65fe48212mr39370826iol.180.1670283796796;
        Mon, 05 Dec 2022 15:43:16 -0800 (PST)
Received: from [127.0.0.1] ([40.78.154.87])
        by smtp.gmail.com with ESMTPSA id a17-20020a056638059100b00389e336e92fsm5972678jar.75.2022.12.05.15.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:43:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f594fa95592f25434e24f0d16033cda1af9ce2cc.1670272505.git.pabeni@redhat.com>
References:
 <f594fa95592f25434e24f0d16033cda1af9ce2cc.1670272505.git.pabeni@redhat.com>
Subject: Re: mptcp: fix deadlock in fastopen error path.: Tests Results
Message-ID: <94524b3d-1fa9-fcd6-362e-feeed365bb08@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Dec 2022 23:43:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6132225792540672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6132225792540672/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5569275839119360
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5569275839119360/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6695175745961984
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6695175745961984/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4548929048543232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4548929048543232/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e79c85cb40c1


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
