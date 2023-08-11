Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193D2F4E
	for <mptcp@lists.linux.dev>; Fri, 11 Aug 2023 22:47:49 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so1750545b3a.1
        for <mptcp@lists.linux.dev>; Fri, 11 Aug 2023 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691794069; x=1692398869;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oBl2NpajyOTKKnoIEkNfa2gSGwsakevjBUfqjSjTAU=;
        b=KRtOoON5mqWlFolfbVwtdAKdmtEzwXExl+IKKY7/gcHd29ksWzomJUYsXCCTRiF9rE
         +px7be+PYqnoRwI9PCCrcvwWzZc1Jk6seMzj3VM0kas0ubPk9ZkonhRjBD4/jybT7+RH
         O4rrFeP10V7U4PKmOYwsbfqg3IT6ZhugE9Y9pP3j0+TP6BfxWYR9Up/qL6btAcTBaIWm
         01DJekkCEj+q8EOiMEhyU6b+3bd8tlYU4jeYIwBClhfKfEulVKqSecGwAylgno2R2NvJ
         uyQJc0Dnm3cJLu4zOqqkyL+9WzrOST1VNoTt19opNVO4LnYemPDdxATOZDVjssXNGuLU
         Bbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691794069; x=1692398869;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7oBl2NpajyOTKKnoIEkNfa2gSGwsakevjBUfqjSjTAU=;
        b=fOQ8y5E4ZIn+RXhVIhcbp6dKIHikFQBFTUhg9XY3omgcWgc5T70GCE9dmQXMKWXDno
         HhS7cI662NakDLGAWjDb4+Ag7/708YMsiePgPlIc+M4AKfqKHNrk7vmYsheUZHwjP9ka
         HVybdUfF86i6WbdpJOOxL0o9ijZuPRoySlyM1X3JFMZrbt9PRh0/HyQf8hq+Z0R4biUm
         SVJRae2pbhA3piC0DtxbwBLruKKGr+44PNQjfw4EapNAuXkQ7OOJVlcAbYoCi0yTOCyG
         ydqGBrjQE/2TkFENoIubJDNGibnEFHBRgvR4jCnqIhNuEDXjnQn60YPqQ29x+9XvDXNg
         f6hg==
X-Gm-Message-State: AOJu0YwWWOFP0vsJjnkhznBMB3J5GawfYS7aFqCytNV4AE6VU5TUmt7c
	N7ITCsC72mT562Z0uc4F3OL5xYYjpQ==
X-Google-Smtp-Source: AGHT+IHbEdhEwl8aOf9UNnzSUjgkMWQHmYiVPZN2ky/XSWKQV+CgEkTPzi5INCI16dF5x2JIo5Mb0A==
X-Received: by 2002:a05:6a20:1585:b0:125:928d:6745 with SMTP id h5-20020a056a20158500b00125928d6745mr4418753pzj.15.1691794068788;
        Fri, 11 Aug 2023 15:47:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.43.81])
        by smtp.gmail.com with ESMTPSA id d19-20020aa78153000000b0063b96574b8bsm3815809pfn.220.2023.08.11.15.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 15:47:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230809123120.11764-1-geliang.tang@suse.com>
References: <20230809123120.11764-1-geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_remove_id_0_subflow_=26_address=22=3A_T?=
 =?UTF-8?Q?ests_Results?=
Message-ID: <fc611a3f-0dd5-d292-5738-739822b1bc50@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Aug 2023 22:47:47 +0000
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
com/task/5693089235337216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5693089235337216/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6256039188758528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6256039188758528/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5130139281915904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5130139281915904/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4848664305205248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4848664305205248/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cf8622126093


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
