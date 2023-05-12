Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B7261DC
	for <mptcp@lists.linux.dev>; Fri, 12 May 2023 21:10:07 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-38eb2984c82so3366427b6e.0
        for <mptcp@lists.linux.dev>; Fri, 12 May 2023 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683925807; x=1686517807;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYa86JlALFZhj7Xm+FxG9cgxp31nbwafUg+fMW+ntNA=;
        b=ao0jIBuuRru+z4z3Jp6Tl0fjX3zntNfPtrAuTRGNakrEQnBzl31e/IPBgOhR+VZAWS
         cqSB6YRQZ9myOgKu7WQgnG/M7/NO50fZpmdSMtUlrYcvHIMAmv4M/gzDeGBqqFCeTN4k
         50DhuGyqLKt2rZfZnaK2M90cPENdp0OSrso7TP7DyESxQNSLR+PPaf7zNMfuXtjwb766
         vafK+2eFFrxC0ohQkJttP/LvoVCfO/Xfo7Xmwt4JWHO4DeSgG/zk/BKEBP+5ZtHts7iy
         1mrfyNDcIfP9YsghVIfkXBOE4fP2JJAv6tBmwekRwipHcxXa6mjIiXPgFtiYr4Z1oTjE
         xXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683925807; x=1686517807;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pYa86JlALFZhj7Xm+FxG9cgxp31nbwafUg+fMW+ntNA=;
        b=iFK82T0qbXUA4a4ligLJaxYO0cXLsSOCWi8rUd29F7z4ObR9Lawfm+8ooD4yEzzugM
         E4cI5wOKcaecjYIAuVjA+quGRtfzP52z+7J+6igT8znqMXsELvGqSwWDxcecxw3SL3X3
         cpTII1NctGmbvcnOJYhgJ5tVFE8Ncyf8QyOP+ZX+sIsLXVu0AKjP0qGHTpFfERGO3a+f
         XziCvaAAH2jxpBnvI9M1lEkhquoHesVbU8qsc7UPZp9t8+AANXrLZDkLxE1dg+PxvIKO
         CAJ7pl/gl3NlSDSdEQn74SRVdUQwgQ3JAJbXz70dn6W0ddZHeXLD0wCVBh3mYxHx/cKj
         SaBw==
X-Gm-Message-State: AC+VfDxI3W+85k+XI0/xFhDQiLmr0awEnw9zdkMOItVqJ9AuiM8wbQXg
	PJooOoYsJbzMFRdtmnoUpg==
X-Google-Smtp-Source: ACHHUZ76ZylVnPY+epMuDTJUM5MW8sFqsikYUbZktVQAI29ci2flMtdiTAPmwya35HOIZgvr7wh3rQ==
X-Received: by 2002:a05:6808:903:b0:38e:909e:86cf with SMTP id w3-20020a056808090300b0038e909e86cfmr7609699oih.32.1683925806988;
        Fri, 12 May 2023 14:10:06 -0700 (PDT)
Received: from [127.0.0.1] ([70.37.167.50])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6188000000b006a30260ccfdsm8751876otk.11.2023.05.12.14.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:10:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
References:
 <ea1b196b90f42f6308cf82a830ac7ba5536d803d.1683315117.git.pabeni@redhat.com>
Subject: Re: mptcp: fix connect timeout handling: Tests Results
Message-ID: <484d1027-60e5-efb2-bf0c-8620c2fa61d3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 May 2023 21:10:05 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4891499171676160
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4891499171676160/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6580349031940096
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6580349031940096/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_add_addr packetdrill_fastopen =
packetdrill_syscalls selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/6661833889677312
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6661833889677312/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6017399078518784
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6017399078518784/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0314f7031af8


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
