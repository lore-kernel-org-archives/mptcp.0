Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD147C
	for <mptcp@lists.linux.dev>; Wed,  8 Mar 2023 08:59:42 +0000 (UTC)
Received: by mail-io1-f43.google.com with SMTP id g6so6509211iov.13
        for <mptcp@lists.linux.dev>; Wed, 08 Mar 2023 00:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678265981;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRar02bvt7K2hEw60q1lBjTH98Rl47g4Ln/4xZs9SdY=;
        b=gvNczu3iotLHOB9lAvpUSVfJOsFbOcqGNccIK7FEwEw1w8+yFSnzmdEhKhMq98SvxH
         W3rvywPSH6319FL+REbhOFeIXOUNFOtpse39/d5FuifB8WT2CXuepCpaSS6S3yItV6y9
         zFobJyGVWPguC8t+098ZdtAAJ/XFd2CsNR7pXcsxnbwsusSTh22Jsp/m7sxi7u9PTJOp
         +BazWBEfkwjqm8LXcEDbHHiKJjAEIjDndSTDJZKo5uw8fc6kmoEyAFloQ2MY6CSG8ZuU
         NMXGRNvtZgpmRGQjo6pn5wiy5qvx5i7QAXZ9yd7abfbr1zF64G15Aa9f+7kdqTp9WEpo
         ulZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265981;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRar02bvt7K2hEw60q1lBjTH98Rl47g4Ln/4xZs9SdY=;
        b=YHIg6mGBlwdRq0EsmR1N5w4SRSUD5HmMtnjlbkbtoC+7lHD8wuDja5S4+NyTQ7jghF
         CVG65Xwb5es0FsxZH83McOecmWe2lLBWlCUflnIMHNvA8zxwSmJ0LIVziTW4sorIkISQ
         NFzuF6OrIEvI/oU4BGoealswJ/wNWzYUhLVBR/ZfQFqHi7NRODF0heKDyte4CuwXlzAM
         yeQsuC1lvVtiUT8aA0TU59W5m6Qh07cCNeWnMXY9xKTNG3ltFbqeGDSCMgWcKS29TpqA
         Z3RRaKL0fdHWOjQjeoqOzHtgSzMP4ECzpTphsgYu6AJh0NdkGy4iwMSOR1+vQMD0g5LP
         wacA==
X-Gm-Message-State: AO0yUKXtaRVMyPMTCeOhJ1hBhWNA6QWLzM5zRbnXNR8mPAW4aAzqut8R
	NITZbaRg4ntNMlSOzGbhtGpKb19Bww==
X-Google-Smtp-Source: AK7set/g15IO13au0fc/0io4PO3o6HUPZl6zPfAHi2BzjvcU157oeTlTk5C2GyzeljjGuciNjV33EQ==
X-Received: by 2002:a6b:7902:0:b0:74c:bb78:25da with SMTP id i2-20020a6b7902000000b0074cbb7825damr9722358iop.0.1678265981545;
        Wed, 08 Mar 2023 00:59:41 -0800 (PST)
Received: from [127.0.0.1] ([40.122.243.242])
        by smtp.gmail.com with ESMTPSA id o16-20020a92d4d0000000b003179b34916dsm4346535ilm.0.2023.03.08.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:59:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ee1415d43a29f55bef6ac7b6cdb2625b655f4b25.1678262695.git.geliang.tang@suse.com>
References:
 <ee1415d43a29f55bef6ac7b6cdb2625b655f4b25.1678262695.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_info tests: Tests Results
Message-ID: <af56ff88-04a7-12e8-7562-901791d44afc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Mar 2023 08:59:40 +0000
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
com/task/5581066346430464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5581066346430464/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5686619462696960
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5686619462696960/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4560719555854336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4560719555854336/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6706966253273088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6706966253273088/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a1dd5c2e7410


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
