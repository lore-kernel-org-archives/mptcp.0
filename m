Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2F2D255
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 16:29:42 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-75ebb3d57d0so200909185a.3
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686068981; x=1688660981;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub2sZYdyecj8H/U6nmdb8E9E+3RWfmTE/27wBz+6LHQ=;
        b=JTIVZYu3qer3tgYjDwk7K0eTfcEcwhu95gI/Usc98FNN+l9LY8ihjZlutnimX4CCn8
         +YvM4iiWXIjNJ4Lbr+yZO4BLnZL213J/0sSi1sTDDrGD5D3IoW6PT3hWVRefwmDao0Ah
         dWKu2tfpjdvhlld1iWnOlUAhTp3lvfZhwrWnXN4+E3g3E4CGG3aAUBlk5u8V846K5EwF
         AfNkokqfBjTxX1djA5zwEui2xOBWYpUuColHnqDU4VB4E6Rdq9LUqlgDDV3qJeREG0VJ
         6RW0qZ5QRoaLVMouIBboUMX7k2pnopy441XU9TEPcqGxWQWz3JzkRxmgsb8rh1pxgxP0
         s+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686068981; x=1688660981;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ub2sZYdyecj8H/U6nmdb8E9E+3RWfmTE/27wBz+6LHQ=;
        b=WwE0A7Cpt9qwRIfpOe2p25Fv7jqSKYjweJFLbWrczBHmNh6+8Bu4Ks1ZtzJ0UO+EPN
         WOuNA723wlozK47YsDmHtNH+II64r1p6E/sKfDMSA+IqudtapKvHQlQTVWF7z+nhPHjc
         7Fj+sjcY2l7M1zRDxAAR//N2JKJSAOXToV/Cu+JgNgRvzM0Bgbc+s1SYgePOjx6oRGqr
         Hv7WFhJ1jyHhjD2KVssf0GZz14zFOujxcb9nR70KGsaDwNHVG4SGDvpNM9pGyZ2PB84I
         dOZlpQrCIfYqukFvQ4dep6ym20LoBCbLhKp65d41pL7NEmtRsPf2HpFJ0ao8ga7O3NFP
         56NQ==
X-Gm-Message-State: AC+VfDw50jNgL/HEBVGaWtRvdmH2CtZ5WKMFQNSpAIwjkqLo+ZIJOTd4
	cGmaCv06RKiUxaNA4pAIgkTuwf6E6hiFmI4=
X-Google-Smtp-Source: ACHHUZ4/UNHv9rvFMc0bMSnK78U4MNpkm5/6H6A4jtDwxpvY3s7TbkLA2k2jCkXQ2vYyPHjqWkWYAQ==
X-Received: by 2002:a05:620a:490a:b0:75c:cc95:667 with SMTP id ed10-20020a05620a490a00b0075ccc950667mr260749qkb.35.1686068981348;
        Tue, 06 Jun 2023 09:29:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.37.19])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a15ca00b0075b17afcc1esm3327250qkm.115.2023.06.06.09.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 09:29:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230606-mptcp-revert-9p-features-v1-1-1d7ea4b3749d@tessares.net>
References:
 <20230606-mptcp-revert-9p-features-v1-1-1d7ea4b3749d@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Revert_=22Merge_tag_=279p-6=2E4-fo?=
 =?UTF-8?Q?r-linus=27_of_git=3A//git=2Ekernel=2Eorg?=
 =?UTF-8?Q?/pub/scm/linux/kernel/git/ericvh/v9fs=22?=
 =?UTF-8?Q?=3A_Tests_Results?=
Message-ID: <7010ca97-ebd4-db4d-4468-ddab9cfe4593@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Jun 2023 16:29:40 +0000
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
com/task/5398812588507136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5398812588507136/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4695125146730496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4695125146730496/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5821025053573120
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5821025053573120/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6524712495349760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6524712495349760/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f2c91962d1e4


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
