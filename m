Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE457B
	for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 13:00:59 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id h21so12622212qta.3
        for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc;
        bh=57GPZ3aNGvSYZlPb99Ohd+QdfAMPDUPCL61u6BVZJ8E=;
        b=iRmXDymH6xaZeM2RG6o+WDhHVCsO8HfwgVqKA6JJTHblaXacaEkCGIN/+kvB2ocFzD
         lEG3RhmBq76nwsrSt9FAq8ZIbPp1K5RERiAFGNzR34yjz16c548tEdCXVs9rbcXtkqS9
         hQ7faly3bnGzkt8XO8qEEw6bajyUcC7FAML6QpDG+3gnpCrVKa5yUWGx5+g6dbgXwCRH
         HtxSDdST+vPlSApvk6QF6L6hUC6D3y3ZZ8NeNgzqLdeADJ9bTyuuCGHLZFBKnzTF/3O4
         A4wCjH7utGvnYuZxc8LiRW8w+alEeIURH1lR+30UChBh54eo+9gVT+NdXcNdTHfPACSS
         Ncfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc;
        bh=57GPZ3aNGvSYZlPb99Ohd+QdfAMPDUPCL61u6BVZJ8E=;
        b=d+5Fx9Q9O7QTva9cg8hFZMMZ0rdulfvvtB587fu77YZLOcSzdi6ppTl/GwiGMfviha
         u/jd21mGfZ424W0pr85fCp1Bp4UsEgotsRUJEnl8ceiEK+zN911RtGRbZ5C0dlFlvI8S
         mhbvnij0gdsMwguCPFweCMCavn4JggwfvmN1O9rERDE7ARBDCV1h05VqvmnLgEma4JVC
         GCpg20QeXbvQH6ozTun9Opo6wFZORNVfOYyWmprQYct4lHUtPGKC28c/Yw3xgFOAxbee
         e65BMFdH0Z8HkQXm7rhyNZ+gCZ9XxSkT94Ar/3nXYttOlFT66i3MnRamw+WCK5LzzsYo
         wgbA==
X-Gm-Message-State: ACgBeo2SgYxKsISJhyI6E/PjXWZDTZ/Zr7eTHudzL7KCMgxkqt0unbFH
	x0QHgPd57CVFncgJE6GBeg==
X-Google-Smtp-Source: AA6agR6rledW+DcOGdsD3yy3ZOndq0+4PY0tOFcmDJn1c+1eleULHzXSmDx6tAk18yJcap7zkgknyg==
X-Received: by 2002:ac8:5e10:0:b0:344:6932:6c11 with SMTP id h16-20020ac85e10000000b0034469326c11mr23935210qtx.420.1661346058464;
        Wed, 24 Aug 2022 06:00:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.110.53])
        by smtp.gmail.com with ESMTPSA id w18-20020ac87e92000000b0033a5048464fsm13348568qtj.11.2022.08.24.06.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 06:00:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cfe4fd464d2e7701008b5e1b39030b74f3e9a606.1661339834.git.pabeni@redhat.com>
References:
 <cfe4fd464d2e7701008b5e1b39030b74f3e9a606.1661339834.git.pabeni@redhat.com>
Subject: Re: mptcp: never re-inject data on a single subflow: Tests Results
Message-ID: <a14a630e-5611-d0dd-2138-451b23c3119a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Aug 2022 13:00:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4563343720579072
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4563343720579072/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s):=
 selftest_mptcp_connect selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5689243627421696
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5689243627421696/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a85c4255a43d


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
