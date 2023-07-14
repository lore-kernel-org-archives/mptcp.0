Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DB81C
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 02:46:48 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b895a06484so8760185ad.1
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689302808; x=1691894808;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByHqNtO/7rUh7MNI7yN+sZtdgsDQVTqpjpI3CwbSenA=;
        b=JwIe30xhoGDKnP8CT1FtwhxBLEEd4q75cbWf6QKfvMiW3JH4+tzj+RDAZyyhAVWXY4
         pHD7lFFrWZYUCe1G5nbu/QVo9AnZKYaPEJB9Zj4lnKqkZc3+Cx9kGcqcZnPIqz+1zoFm
         KnpBdqX/WyUOO7ksG/XhELObxd7KkaeduvKEctkB3/RqlAh7ngcscwhDdz02SQstHmT7
         Gagep8eTsf8+Cx7t4qbCaMq41ShLv51Tcx8XauT/VnSD4JyCk2eXJviSR91lCIWqSFtI
         i613+CmYSn3LhfQ6YtD2uMKyDTaw6CtEUofqmfBP/r4HDw1A+T8OU/kED67YNzSHc5Je
         mpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689302808; x=1691894808;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ByHqNtO/7rUh7MNI7yN+sZtdgsDQVTqpjpI3CwbSenA=;
        b=cW4aYRXYs1KVV66YFC67K7uX3HPBQKoqxXLa1cpHs6mBM1InJyaaSRqWo/nmYwtpJQ
         fnzwOxvlDPjk5ekfr+R1R7p/wT/CIkJkHQ/ua/keqP6ZDpmF8kWjNOlZaZVdw5eR08Rq
         0/6y/BMzRY85/bA6DE47r/JJhMmSbAXDnpkOoXQd4/ePhaiieNNNPEEoh6tl1qR6N/Mi
         TRiw5GdVmyG2xWpvDFiCTgPB49q2ZO1CpOk2T8HPXUKWaJl3WYs/UGY4tnSkVxiNwF/B
         CynM/EJNVp2wVYBKxmwHhIPpZ7n/+sAmMtWMwGyqBToQHpFnzr1Nvw1JP8gWOESffAr1
         gobQ==
X-Gm-Message-State: ABy/qLZHJV83yAvSVMKdNFq1vi8QyuCQDGIerNdNS/8CVZH5Sm2xucW9
	Rp+viuxVGtNNdZldIyNttI5FuP3l5oui
X-Google-Smtp-Source: APBJJlF4B+JH5KbmgYtODl2pSOF8WoYK55zwF0OGvKYeGN1AsqPlsSQ5BVpoddt1k/KvcVBPE9y4gA==
X-Received: by 2002:a17:903:110c:b0:1b8:a3e8:51d0 with SMTP id n12-20020a170903110c00b001b8a3e851d0mr3035333plh.45.1689302807642;
        Thu, 13 Jul 2023 19:46:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.11.215])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902e9cb00b001b882880550sm6588798plk.282.2023.07.13.19.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 19:46:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-2-eb9582b8e24b@tessares.net>
References:
 <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-2-eb9582b8e24b@tessares.net>
Subject: Re: selftests: mptcp: userspace_pm: unmute unexpected errors:
 Tests Results
Message-ID: <7a6838ff-5a3c-23b4-7a37-a47013daad41@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Jul 2023 02:46:46 +0000
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
com/task/6042680732418048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6042680732418048/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5479730778996736
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5479730778996736/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4776043337220096
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4776043337220096/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5081948087910400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5081948087910400/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/eee505968adb


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
