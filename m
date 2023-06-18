Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059D1102
	for <mptcp@lists.linux.dev>; Sun, 18 Jun 2023 10:44:11 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7624e71f0c8so28003285a.1
        for <mptcp@lists.linux.dev>; Sun, 18 Jun 2023 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687085050; x=1689677050;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKZfElqyGxtnmY/P27kKhglKiaXZfeKvu244lq5jiWI=;
        b=nJosfall3jQ74GKnLTzgcnFNuKI2hUZNN3mCKWSK9i6JR+iMyLsKOTHla4ax3scMOb
         h5mOu8WwXNZUZ0jZBBbAT2h3HU23U4QY16LnVSk4bjIwm8sIE2G7pS+OvsAluHCDDDuW
         MdVbvNqfEPQ1HN0uj2K6JG8D01DL3pBqI2xOMr4LrqcwXQb0F+l5ykbReSTgEYFJWDAf
         fmPLfAxr8wI4f9ZK2zhKRSEHGEzRToV44+wqfV26M66Oe1MRoyElUo5GqYpOS1D6q6+i
         oYFdioGLombVBRtt1b4fNLIPIyr3XBP9vaWkEoy4Ytav+U9C5xGpgppSwvV3JHKKph2B
         u8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687085050; x=1689677050;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TKZfElqyGxtnmY/P27kKhglKiaXZfeKvu244lq5jiWI=;
        b=czGkNqnnbxdSTThdb/nIQVQVvXPpesuRYUe7lMuWGZIq8E9gWCEZay1rsE3JUfSd3D
         xA/nptJTnYhUi7IyjWMAcHx7Ta8UKPnhAKXB4P8Nf4r9GI/8csq/RRmG18FzaefaS2mM
         /oA5jF4z1ZFu31hiAGigAVV8AMTqG6SLoevcGpcV/XCxr9zkbwl2e8e22ZqI2Ez3+oTT
         zf/Mm5v3/6u/Mx7D8j2YWqXMjmxTEMXKJZf7I5ZNSnLoQyzYHCrHF5pUlokk7o3lnY5k
         qMZLw/nImF88Jr7R2wxU60JedvG/3fN8QRaspQ/bI9nNlvt5TSj258B2pgDTHjdmaHJ+
         RFLw==
X-Gm-Message-State: AC+VfDxb225gCPJa63nXWpY1P185prIwau+y3QljlyWpueSWZyMhc5+D
	K6GSowHKUWjAkhJeIKXvcw==
X-Google-Smtp-Source: ACHHUZ7ek4HtvCPh60HALrerhiHkEGMVK9Sv1G7QOdCFa5pk8j+hVrzl5B5dEQ/U4alyQRiepdR7JA==
X-Received: by 2002:a05:620a:43a7:b0:762:4a1e:d5d7 with SMTP id a39-20020a05620a43a700b007624a1ed5d7mr3974989qkp.21.1687085050521;
        Sun, 18 Jun 2023 03:44:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.75.123.254])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a129400b007621bdc9d98sm1525702qki.87.2023.06.18.03.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 03:44:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
References:
 <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
Subject: Re: mptcp: Reorder fields in 'struct mptcp_pm_add_entry': Tests
 Results
Message-ID: <4ddd5704-ffad-73f1-ca88-47d27148b3c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Jun 2023 10:44:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Christophe,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6337047590338560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6337047590338560/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4929672706785280
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4929672706785280/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5492622660206592
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5492622660206592/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6055572613627904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6055572613627904/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9d878583e137


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
