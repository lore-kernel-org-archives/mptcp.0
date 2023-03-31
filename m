Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96AC23BC
	for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 09:58:04 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id r14so10592632oiw.12
        for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680256684;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owigx/FNxPeXJhldYPHN1NSn17qk4fDjXeoyJ39GHqM=;
        b=Y+JOCC70NtT1vaQfU4RM5/IcE5oNZY08GWv/nmZ0yz0ISiQqLyhMG5BkG208ppKfvI
         YJ1a4RQzGSa+uZrk+J3RZS3GgIQi7qdq2/97cQWEK5Iphf4Xi4ksZRHC25hxGgat6n4m
         SIq5w6jegbEGhrWdNyqfCuYFiLGsJmQmxjKuqBzhLK6GoLgeXjagTEjqAG7/sq/YyiXS
         BD9jNb6VFXd925ErekOOxZNY/a2B7xcrUyXfFI5mjkbptWjIE06ZcmLZMK5RypW9zXi+
         xbD/HJY4REbTDPiSBmaqD2TW4HjWvHbl9KShhU3tqgqbdMrLEqBumGu6ulEloVlgNxkt
         3ywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680256684;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Owigx/FNxPeXJhldYPHN1NSn17qk4fDjXeoyJ39GHqM=;
        b=0xpQFk2ZcCHa5h/zrbBZTDTCRdGL5ZKKtfDUtjFRYcvm3O9WW/Y26l95mvnok/v+n2
         PydjfQL3ZQjF8MPh/6t7WZ8lWmf84R9sG47iKh3K1Hr7570cYJVlZczJ+ffQ5NXxdNW7
         cE/XkxMZq+zTQh7VnRawEidMSO4oDvjA0I2prQiGwWoJu5x2Bduztsmd93FlX1LhKNkN
         WRHoTPVa5+5f2JXkJLfz1/qUonPp3VblnKirpxfMkJ8Bqatg9Yag6JMVs1mE0sDSrt0s
         TZuiGWaVZgpCo/BOtrjyXqVynncpWWBZUWpqnXxC6uHtndQCyM6DnQjXV7Me/qKhy8cX
         XfBA==
X-Gm-Message-State: AO0yUKWNOzzgaxDliKWcP56W0opsrMmzHxOJoN//9rLkeFwhHM98lCd+
	JZEa2IBm5/zebmyP/nWOEg==
X-Google-Smtp-Source: AK7set/Ef+M1CsafiKf8jC4Um9e+q/bxZLygNJ8ZDqlLSvEEIk3jyaselqz8wS8JVRyA/MlMKS3gHQ==
X-Received: by 2002:a54:4806:0:b0:383:c51f:81d1 with SMTP id j6-20020a544806000000b00383c51f81d1mr11404753oij.52.1680256683961;
        Fri, 31 Mar 2023 02:58:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.65.246.136])
        by smtp.gmail.com with ESMTPSA id r126-20020a4a3784000000b0053732f1acd2sm661166oor.5.2023.03.31.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 02:58:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0f4d10f41b5a51353cc4738d6b5d63b9aed8b1f7.1680252220.git.geliang.tang@suse.com>
References:
 <0f4d10f41b5a51353cc4738d6b5d63b9aed8b1f7.1680252220.git.geliang.tang@suse.com>
Subject: Re: mptcp: make userspace_pm_append_new_local_addr static: Tests
 Results
Message-ID: <360f617b-28dc-7cc8-baeb-c06e08aa33f7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Mar 2023 09:58:03 +0000
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
com/task/6574828866502656
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6574828866502656/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4745241517883392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4745241517883392/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5308191471304704
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5308191471304704/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5871141424726016
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5871141424726016/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b93961e1fd7b


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
