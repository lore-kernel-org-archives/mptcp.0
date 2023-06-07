Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D8154B2
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 18:36:52 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-543d32eed7cso1297078a12.2
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686163012; x=1688755012;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Mwt0eOdU76ZwhKFeIb4R8hl5qDY2wmM4S2riFNLThQ=;
        b=HTAuXIQYG8OBIY6y+CUle3RarDmLnP68jRAgGTajIfU2OmnN02GkEV57IQAb/YeRVp
         jsXzL8a8OsYJdNG7mlyY+rlPnisPY5+KqyUFHHvortrwMxTz9hhsim4Bk2psCe1nUJZu
         xGxIrvJ66aTryOVlQC6WXzAnZ7FIS89bOPAfbU5gvIhaVekQzgmd08+fAgo5BPMcn6Uf
         Pod5zVo+BzVy9yusv8/BdmOAzxhUg21xkQL8+rN28yQXkZnPegyekPdE+CRKzo97cXWu
         u6uiQSwiEYJ5QgWM37GZxR6ltK4Wtvoxj/Ennb/iLar9RMGorl7oIu2gr+CyaSW/Xr/a
         E9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686163012; x=1688755012;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Mwt0eOdU76ZwhKFeIb4R8hl5qDY2wmM4S2riFNLThQ=;
        b=MEr1gzPBifZFhus6TzvOf3h07aE4mjL38tbrai7RiIyvtTiNp6KgbrVP6By+Q3/blZ
         UB1DF8Z9P6TQb7/hsX892nnpd503FRFPAI6IYu4dlyoYzFpfNESJkNlCm5ARnb6Eg5UE
         BBRjoKYQenrlSP9+X5y5SBKOAqhtEdIrKgBah8/2NETwLgcye16JN5h/8ttNLhLH2GOT
         Qu0BsPS1pGbrTJB8KQqnoYQiImxSFPSukWS+M0Oy2HNvngostkY5j40dao+t33eeS3jF
         h1ouXhSTUHirkn+hWY88bn0gAeAKb6nrDdozIZvlrH5VDZVQj9+O6biwfrftKafte3nd
         KqdQ==
X-Gm-Message-State: AC+VfDw8tPj9lCnEKzW71CPhkSdLjdSX1dLGrbZgBKoDhnT/SQ+/WkdM
	TGqt53VNxta9wt84QgZvrA==
X-Google-Smtp-Source: ACHHUZ7jwNnnC5Jc6t3ICH0vsIqUyQd1JucJuSyVpyX7/HWAddIDMDE6u1zTMRiK9JW28Rd/SiROdw==
X-Received: by 2002:a17:902:ea0a:b0:1b0:66b6:6ae5 with SMTP id s10-20020a170902ea0a00b001b066b66ae5mr3500600plg.61.1686163012284;
        Wed, 07 Jun 2023 11:36:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.61.181])
        by smtp.gmail.com with ESMTPSA id bc2-20020a170902930200b001a95c7742bbsm10809024plb.9.2023.06.07.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:36:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ca4ee22bcb340d3c07778259ce6c08b4d39e89d0.1686155634.git.pabeni@redhat.com>
References:
 <ca4ee22bcb340d3c07778259ce6c08b4d39e89d0.1686155634.git.pabeni@redhat.com>
Subject: Re: mptcp: consolidate transition to TCP_CLOSE in
 mptcp_do_fastclose(): Tests Results
Message-ID: <129c8ec7-2b5e-7eb5-bdc8-2ed0a075280a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2023 18:36:51 +0000
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
com/task/5914394824015872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5914394824015872/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5351444870594560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5351444870594560/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6477344777437184
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6477344777437184/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4647757428817920
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4647757428817920/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f2b50e12329e


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
