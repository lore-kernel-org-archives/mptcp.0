Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB71FA4
	for <mptcp@lists.linux.dev>; Sun,  5 Jun 2022 15:41:46 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id 62so10057113iov.4
        for <mptcp@lists.linux.dev>; Sun, 05 Jun 2022 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=WPywuIA3LIDIiYmVU/ZGBDmR0vh42RitsJ4kRm/l3C4=;
        b=oWg9FHZmxcySg8nWALXkU5LH+785chYL3hXWSCD0+QlBldwhdtAXxZmrtZpmF3wCCb
         IHTFSRsRKdLDSdBxl8zfD+p6bogPjQm3vtLPMeiQZl6Umzr3DaHWS3Wmr3bIIoIbvfOI
         /2CBJZr2o1MCJD4H6RhZthCNwVg7fSJ6L6L/hyRA/vtdOaQ/by0ZYlU8bF8316wwCFVB
         zmilG/DTapFhNWZCQhO2NUGoHEwyzZ50LirlWKRn0pF/zCVfQ7UoZFxXbbzGL5JlZ85c
         suOju4j2BUFDV7CTS3fr0tjkcqtS9h/Xg970kU3nSxAgrNIllIVGDMA0EC8G9pZ5QtUe
         rKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=WPywuIA3LIDIiYmVU/ZGBDmR0vh42RitsJ4kRm/l3C4=;
        b=rCsOU1f54UMPY/iC5LgP9BBgkNm4HZ708ntpgWwz24I/cw6WIR0+/mwX/yymMsncIl
         GmoJz7nSvZg0yQvV1D0/JqzrFfVbAvjUZ2aATKKF4DbozmIvy8iFkRxaao0A8fgT7Vga
         mBrrBha+4rKQWNbEDyYH/sSKvX1XuYNNORJQ0Jb/DfJ6oquAmU0c26uekBjKWAH5UbC+
         coJbbkmLPmZJ7TgvQz6gALqbBgIKsAxSX5ZYP9EsBew1Ibo/uyBQTd2Rx+0glG4jPWBw
         hYgzE+0J6zcmhTRWVbYRIIBGrnkPV00NUJlkr6ljc9VIWpHRWyCuqf58O6GIfHtU3GZ8
         s4Zg==
X-Gm-Message-State: AOAM533wpWq+s3Hbj8gGa6dK8PLA03tAzLpyzwRH8k59CJ1Kl0mAZ8pu
	efoLMwgNJ/queQqKLPvwQg==
X-Google-Smtp-Source: ABdhPJxx752DO943531QijpLci7prU3Mnh7ZmFLhD1Rjda7HMUK5SeBarCRVesLW1vDjPlUw90DVBg==
X-Received: by 2002:a6b:cf13:0:b0:668:bda0:f300 with SMTP id o19-20020a6bcf13000000b00668bda0f300mr9262777ioa.89.1654443705953;
        Sun, 05 Jun 2022 08:41:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.67.217.154])
        by smtp.gmail.com with ESMTPSA id l24-20020a026a18000000b00331a82096c2sm566317jac.98.2022.06.05.08.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 08:41:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <dd9799cf2ef5365fa38bdd10ae831034b91d1d38.1654435294.git.geliang.tang@suse.com>
References:
 <dd9799cf2ef5365fa38bdd10ae831034b91d1d38.1654435294.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <31e318dd-7bf2-eda8-348f-595c2066b4c2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jun 2022 15:41:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5542041579945984
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5542041579945984/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6667941486788608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6667941486788608/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a242888c8f2a


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
