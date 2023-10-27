Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D337C8F
	for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlp1ZA88"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b2ea7cca04so1369352b6e.2
        for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698424895; x=1699029695; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtSoaW8pnPbIJCtBt82p+BnM+OT6fzlJkvcSYilPgbY=;
        b=Rlp1ZA88OSPFzhH/3IQoez2I+dBaRXiqY9BxkLHPcliSo/KEASkLuTw10glC/okZCB
         AkrkPWc/LSCVL8nN3iLpuJrmJLuEO41yIbFOwZ9QFNfTCl0blwNmt4EsDlzg8L1IoJUM
         CsyXA0Qo0c1URl3/f+aWVPOEv/uhhPG7yYf9kTinKMC6RIOFTIJtCG1/Ut9AH6DA41nV
         SW0JFNuOE4aRHbrY1MkBl3bWB0/MCYeKu57KNLPXVecXXOQnIAtRUqGqvkDJwzKnXkQ1
         yiaENCKAO1/cQmX0InpBk5sjCmLFe7lIHCh6VudkYjhdzf48R2HIDyoCF6fpAqRpFKag
         7E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698424895; x=1699029695;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JtSoaW8pnPbIJCtBt82p+BnM+OT6fzlJkvcSYilPgbY=;
        b=fRz6AJbnuUrRjWCFFCrSCy9aNI2SPkZ/cb7tPSI8zLcAmGIGSYRA2fErJvlKftfG6w
         18bnTR8k7fuTipXq6NXLmp8owUdDlZrE5V8NqNTNzyn+jxc08+/P625f2glaFTWZpi06
         hGYNLkzR7DDoDd3jYu67zWEUpsd7QZyWtMPM9iPwb9UknEbaEG/XdE1GsdlRTXMySseO
         S2eSN3EaFVyyVpyfWpOtUbb6wydMmJzSjHWL4PJPXaLiS/wpZt45vUSamoYf6UAhbSnJ
         TBDLZrPOnKN5ppTUbOn3P76g+zTW6wWbNhnj+UD9IEy1U9z7thTIJB4DcX5cBZYw5EdH
         Moxg==
X-Gm-Message-State: AOJu0Yz4LgQIFTeE7m92Gi2UlViRn2X0QSyF2eNPQoGtnmw6byokad3H
	FWuWKKXg1k2ovNesFq41i5f3ZDjcZw==
X-Google-Smtp-Source: AGHT+IGC0YcJKFb40t1N9wQwB6IMzrQAUlHJLZ68jxYOF9eEHXE0H4ILd/TWFgT4juq3VBJj7IOdmQ==
X-Received: by 2002:a05:6808:96:b0:3ad:f5b3:844c with SMTP id s22-20020a056808009600b003adf5b3844cmr3012032oic.18.1698424894899;
        Fri, 27 Oct 2023 09:41:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.79.15])
        by smtp.gmail.com with ESMTPSA id t30-20020a056808159e00b003a3860b375esm347342oiw.34.2023.10.27.09.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:41:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
References:
 <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
Subject: Re: mptcp: deal with large GSO size.: Tests Results
Message-ID: <733f6935-066d-d1ab-5bd7-e85cbc061b9c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2023 16:41:33 +0000
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
com/task/6054814614814720
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6054814614814720/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6415959792025600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6415959792025600/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6220357317689344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6220357317689344/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6343048695644160
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6343048695644160/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3ec0ab8000a0


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
