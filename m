Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3097E
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 08:41:18 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-78666f06691so25128339f.0
        for <mptcp@lists.linux.dev>; Thu, 03 Aug 2023 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691052078; x=1691656878;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REKwF+eIfIKFqfd7YkVwOQ5rVERMykDTfeW+oKuk6Sc=;
        b=k8pgkdfTv8AvwVFghaVYoJlVHoDH7rSWS8rlEdfuI9PLqZ7z4TifGan+4Eae3+9ibx
         x9ZdbZ5zA2mh0ARyqIWM4HBm8WYX3O3BoRWtEeFrOmZUmSo+U9+m6ZOEWn8nWamI6kOy
         4W11HpgAMn5idBw5tiG8Xx7bXnwx7hBoRk1rtPfRvJdmirfbatXkiOkCq0+z7iHvsAY/
         X0/sETbI5PpyykCBlwVD9ZLCr3NciKnwAvOcRzLkyPQMlPaiyX2WU8quk9H/mtrVBKKd
         HB4c0NczuPXEhijOw8huUVwg2SOQiHyuLpGno/l5GiFmo/8PWUV0r7TVjnLK9tSoE0tR
         mqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052078; x=1691656878;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=REKwF+eIfIKFqfd7YkVwOQ5rVERMykDTfeW+oKuk6Sc=;
        b=bL5NscOX+DTa9J/Mbvz8KI6dvQ4sE4+xChv+Bhwm9Lfst5qL7o4h62UL6V2+hphIsW
         IQm5f52xKjKHI2IS90tY4hxhBWCTL9dcyxFxIZMZ23ufZSkW6i9lGn0RAtX6afkDK2kp
         1DOAwRvQuLxCEtxcGaGCz0dVcmDdelRdajnt/6c5uswLuDjb8srQEtgRsYECQLdjS2lW
         OT8ynmiJAceg1ncO/lkUqioPFFxZd5+w74OKpK0+IU7ACht78nUiHAzpiiFsSd1ybLD/
         nQLBR5Y/COczxPQxvW054f3vgeohPTvuq1xL/RLWSTUjdxVPHdC9LzCub2pSTRaafCKf
         4t3A==
X-Gm-Message-State: ABy/qLbtq1GDWZVRBwE8/19qBBgSH8Jre/pzBOMUJ1xhT32xBlQSkBUO
	xPU6Gdadqfti7Uj7aepORw==
X-Google-Smtp-Source: APBJJlEY9IYh4e9DmgalnmhSHb14R3xBk3KP++7CemAvtkRI+RaZDExtWHJQovvreQxsPg/tc5G0RA==
X-Received: by 2002:a6b:6018:0:b0:785:ccfe:b68f with SMTP id r24-20020a6b6018000000b00785ccfeb68fmr17358857iog.4.1691052077909;
        Thu, 03 Aug 2023 01:41:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.89.26.210])
        by smtp.gmail.com with ESMTPSA id o7-20020a02cc27000000b0042b1cd4c096sm4852525jap.74.2023.08.03.01.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:41:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Xiang Yang <xiangyang3@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230803072438.1847500-1-xiangyang3@huawei.com>
References: <20230803072438.1847500-1-xiangyang3@huawei.com>
Subject: Re: mptcp: fix the incorrect judgment for msk->cb_flags: Tests
 Results
Message-ID: <c434ec9e-3ac8-1a23-5653-beb72c6ac3ed@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Aug 2023 08:41:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Xiang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4591732650672128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4591732650672128/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6280582510936064
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6280582510936064/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5154682604093440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5154682604093440/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5717632557514752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5717632557514752/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/82019bf873cf


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
