Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E47B
	for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 21:14:17 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id c24so478831plo.3
        for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy6bPfUUWnHqt8M6qg+lbMzsHksyOgr1Wqvtibo1tBw=;
        b=MFnZJAvICNGV5+xken1XUInadwkwOHMaijybYZw/XuCV0R2epaFWbvaxdZ4A24D/ob
         f62uW4ob0+zjAVIaRGagLDNgn3aNbccXv+S04i603nAooewHCn33+KZYrN1DIMc0lALa
         oZJK0zQcmg+N68VboxAV+1HvYxWHkjA1VBCC5hGezf6BOP2rsdZUlOIP/gL0j1fX0giu
         DYd9FBitdrodtX7E8jnt8y4+CuSo2AZo+Q14O8bLNos5bD8wgLbRzk4r5ZODDYbS6FR3
         oAh9o0HtvI2pkY7eG4ucz8USGxMeHD+TcShMcf8rK1a2iWcdEhiwTvGYrwpN325di6Wx
         6R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uy6bPfUUWnHqt8M6qg+lbMzsHksyOgr1Wqvtibo1tBw=;
        b=UkkVYu10AQoQznm6I9ziWcBqScuCB3dPnyScomz3L8+zdCwzi3CnNHApxLh+QdLcoa
         9qLjl7tTE+ehUNFu/FTC4/scgfuJ4ec9keTwWlPCtr1W70Lv5Qns9a1+vJrZNtKUdSik
         GMii/w4LeBRVSQn4Px1nkiez0noTdjzZx0G9/63dUrk7561gxyV4Ql5FKQldaW/qHThj
         3W7gpFdoGZO0yBahiwe82IJUADfehjbDv/O9+mPqy/UTXCFdYSczTVHmTrhokVfLt6DB
         Pze72n22PqzakMugT9kDfGz178w75p6ClWbF/XYn872RSAA6RRZ8Txx7ujsqVo34Zvg7
         DLFw==
X-Gm-Message-State: ACrzQf1lH1EwdH0BzVhqm7xW+hhwQOBO2q+7tH+j0bK1dSAvTc7o1ur4
	dF0mhfeTaPGtPFJxg5D+1A==
X-Google-Smtp-Source: AMsMyM7/Cqve01P43uepks525JcYir70GVEhsGDsnINotTeOeR2UBjM3D6/QGflKdKaiSlVDoI677A==
X-Received: by 2002:a17:902:ea06:b0:185:3d64:8d55 with SMTP id s6-20020a170902ea0600b001853d648d55mr15663216plg.7.1666300457226;
        Thu, 20 Oct 2022 14:14:17 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.166.164])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79ad6000000b005625d6d2999sm13755441pfp.187.2022.10.20.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:14:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2dede94e742d8096d6ac5e0f1979054ee158d9a8.1666287924.git.pabeni@redhat.com>
References:
 <2dede94e742d8096d6ac5e0f1979054ee158d9a8.1666287924.git.pabeni@redhat.com>
Subject: Re: udp: track the forward memory release threshold in an hot
 cacheline: Tests Results
Message-ID: <796796d4-883e-1489-eace-2884ed20fa0d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Oct 2022 21:14:15 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5317274872578048
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5317274872578048/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6443174779420672
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6443174779420672/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/31ed4dad9833


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
