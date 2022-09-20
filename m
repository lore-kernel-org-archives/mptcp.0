Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDD5A92
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 10:52:02 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1278a61bd57so3587346fac.7
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=xG+T7M8DTXHVwwGsapOUXTRcmLba0KHuD/0GvzYWC4g=;
        b=eAy9iWypAIG3sYk2/P6yBnj8eTtV+/LbumM3VGBTFIGeRMgwGHK+/KgWi8r3N6pOCu
         YwR33SPnnblovqTh3KNXp1IZdNhL97PBBIWRp5LeqaBKJRKk2T/yUxWIGB6YjuAADVZA
         6jbPQUUIRI76VBx6AtaOLQHpGe8hQbuXN1E7sskgu9nmBYkcHOzYwSMUgSUkfbbU3ZKz
         8U9x+xkPRYayBReHE3N7+CSFlSPMK+4KVUO4crrtLJtH30P9Cw5SYOymkbyGkoBWfgAU
         Nhxza5yeKRP6deLXvimk4xs+T8HJ8RKN+fRHaVZ72YwSyQyZOLAJkxBeTO9iFmFVa0j8
         lV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=xG+T7M8DTXHVwwGsapOUXTRcmLba0KHuD/0GvzYWC4g=;
        b=nN/z2tIKUvTRrAZ+qsA6VOKlomdljlOqFcX83/jxHQN/drwC3vezlCnf+HYosLvM8e
         2+tXmqa9QQZ6+ndols5TBoFgduIeTKjYNc70lmJkLY1WnnUmym+uiYV5ez7mOc+KAkPj
         pIXHltlWyKUJfXSnAUnq2o8tNp7VdUEcDmpGH/YDULrF42vHb6vP/D+YCwIditj2Vylj
         Sb7yOLUwC47UVT319H6zh07+pKtQHbflFihbR4s7umbaQcyDzyrr2jXLSVb5qCLH4c0o
         svmkIKqTX/HMoNR5fd/PsfjAWXV86bLeS7v4jlU0QKVHSgHjXhm84fbt9IDpSwazqJCI
         BRXw==
X-Gm-Message-State: ACrzQf1pouO+rQ25n2Y/Vm1UWZWD24Gjpv70YIZeDAzwuw9XTJllCosA
	tS6f2I+IDEpIX5YQ7joMRA==
X-Google-Smtp-Source: AMsMyM5z/CH/xrSfRnS5XXGXDNu/UpLRlCc0wdgEnmROB3vRcegGm99+1ZDfPfInFD4DvLQuSWjXCw==
X-Received: by 2002:a05:6870:5b90:b0:12b:c0de:beb2 with SMTP id em16-20020a0568705b9000b0012bc0debeb2mr1596657oab.61.1663671121747;
        Tue, 20 Sep 2022 03:52:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.165.63.14])
        by smtp.gmail.com with ESMTPSA id ba17-20020a056870c59100b0011f00b027bdsm745736oab.45.2022.09.20.03.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 03:52:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220919132156.3649522-1-imagedong@tencent.com>
References: <20220919132156.3649522-1-imagedong@tencent.com>
Subject: Re: net: mptcp: add statistics for mptcp socket in use: Tests
 Results
Message-ID: <60a66aec-42f0-cce6-5225-9a0afabb69fd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Sep 2022 10:52:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5455177229533184
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5455177229533184/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6511420769566720
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6511420769566720/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bc4142ce235c


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
