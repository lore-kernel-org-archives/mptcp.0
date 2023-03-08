Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D462B
	for <mptcp@lists.linux.dev>; Wed,  8 Mar 2023 04:23:03 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id j8so5029335ilf.4
        for <mptcp@lists.linux.dev>; Tue, 07 Mar 2023 20:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678249383;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UN0/kBx/wUyOjclU9pQgwxc1cnMPiUkPpHHDRoogp8=;
        b=Xma17Xf27sMGtM0st3JknBPVIOVqR+JWVUYuk5BN17pmR8cSQz9KiDRhIQ3yEbvw6r
         tTmLGCVsGuQho0iEVYwfgPSIBRFS3oiXLxUCAAtRff0SGMkuDEjKJCisx7UMVDFg4h/4
         97pqzymrZLcWIVBY8VGnR36MEo/HgzjUWufbd/jw9DDRRtvln3KZKXmq1SrXfNNlrw0H
         qHkJlf7IaypgeHwsCBDwxx3FQheNMTBZfrY3zyYOp+ARh6jC7r9iz2JIE7EjH89Aw6hq
         Ds6WTd3U2APjFg6IajsVVZ3tFxxMxIzLYn13m5p80zMEiJDvaxOyey0Q1/GYYucjvXr8
         hCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678249383;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/UN0/kBx/wUyOjclU9pQgwxc1cnMPiUkPpHHDRoogp8=;
        b=nDRBs0fD8vseLRm60fgFzVCLiPW2uJk+OgEYM+z4ZMbKN7GbPSCD9TdrZASzFYBHOd
         kKplBEFm2lezdGtTxDKFssP7RETcabNLgqUqhX32KlcUpsHKVcW2LDxhWXGoui05uZrL
         nUCrqWCvl9MKSAVfHDI4i8jeYmYUdmzWvv5dMd3Se19q4+94/ci2N/046df5FOUJCalD
         h15Vpgr8oDyy0xsuCd4zT+ozrx8HCY7A0P00M2KBSu/Q5diefbBTSZ98FJzG5DtKIPX8
         AYmzE16QTXrDx5rxXrr76Y+tlLP2SVhxIOdCNLU/BtVCD2+14pLWewjISrTVwXTWUJQD
         qjBw==
X-Gm-Message-State: AO0yUKXNAAJQ5xBw4i/swcFCoyD+UXA1uNd46ii8i/vwoFJawxvC5rD9
	UDqPm5cNBJ1g4kMvfdVDrA==
X-Google-Smtp-Source: AK7set/6crhYoOxNZt9DRQ56Sl0tUM/F8sxvl1PKaModRwwGOvF5TIAuXzifYc5dOrnhmwU/cV+OIw==
X-Received: by 2002:a05:6e02:1bab:b0:302:a58f:38ab with SMTP id n11-20020a056e021bab00b00302a58f38abmr12480576ili.0.1678249382823;
        Tue, 07 Mar 2023 20:23:02 -0800 (PST)
Received: from [127.0.0.1] ([40.77.123.112])
        by smtp.gmail.com with ESMTPSA id p21-20020a02c815000000b003c4e1bfbab8sm4707043jao.44.2023.03.07.20.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 20:23:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230308033132.20581-1-geliang.tang@suse.com>
References: <20230308033132.20581-1-geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_info tests: Tests Results
Message-ID: <caa84168-e6c7-9e65-a133-3997a44934cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Mar 2023 04:23:01 +0000
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
com/task/5939782551863296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5939782551863296/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5376832598441984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5376832598441984/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4673145156665344
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4673145156665344/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6502732505284608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6502732505284608/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2b14103c8fe7


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
