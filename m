Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822A13ADC
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCDIDTEV"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-41cb615c6fbso467371cf.1
        for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 10:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701282340; x=1701887140; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu3u9fp2KdoHKU5KANRhp16b1xH4MvLb9lj7/d5f8Cs=;
        b=eCDIDTEVq2LhBE0K5nLtw5vOrQFlkdUKPKbKjX6pr5H6fZdzQ1fliqXEW9H8F8XZCa
         vWJC1Sl3iKWRXdcDEQUrkhjjgugptdWlm6F4YllzjtHEtcNd+pl3OYIbBQ1fdZPpDNeP
         0jzD+OlChyywHqEh1sWJsRwc0n1+7MyPmC8NyAWNSEy4mLdGWwwo3ic+ED2wOcI0W8Qw
         4foinYz3VwKSzQaEEjy223DeSzlQGDA5AuloN0uM2dELXRDY9Bz4Gke+t5TU//9GPdr3
         aBjai6kjUpq64gOrKD5eUpTPliPaxlforXauNlXoWUHUS8Wv1c+VrrUql6JzGuIn/asc
         ikPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701282340; x=1701887140;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vu3u9fp2KdoHKU5KANRhp16b1xH4MvLb9lj7/d5f8Cs=;
        b=rzQZZNKUXLghtz3GXYdtEcnzsGSIiaF/hwAP7usao33zp5HQixv/iXE6dZpvtXoJVC
         rfqZEQ+SB0p3RluaxJezN6aXsmIyHYQRpwLLHjVGCRCTwWfxab5dtdIfzEPofW/2gRlS
         zxdtv9VJSnJBWws8/7OY60EI21epRt1x4aE1qckRnRYK2ZKJFvhcxQ4GnzA6K0BYP85Z
         wjUS3kHZrZfUnnP9rFEoKDcEujPVsfHqi3UQ+WprU2vVU0uOngcFIJfim25CMRPEtZe3
         5Qted3etU50uUrckRlhLcvKckxoKhfPsczBJeb3zfLY2lM86b3AIZAai6q7Dt5/I2NWe
         ag3Q==
X-Gm-Message-State: AOJu0YzczldmgY5Q3VmzJm94p9X+A8thoEyEI0P5XlgQT6B77NzR8o0v
	oHPIunIN2dx1CaTSuxW0gA==
X-Google-Smtp-Source: AGHT+IGppPFq9inXYkPf8loa8vU5iWsHgPQ0EkQWgQngoqfG7SCOiaxOSZmZqjx8FaPC0zzanQF+IA==
X-Received: by 2002:ac8:4e8b:0:b0:418:af7:e001 with SMTP id 11-20020ac84e8b000000b004180af7e001mr28093257qtp.41.1701282339942;
        Wed, 29 Nov 2023 10:25:39 -0800 (PST)
Received: from [127.0.0.1] ([20.51.198.149])
        by smtp.gmail.com with ESMTPSA id u8-20020ac80508000000b00423b8a53641sm3264806qtg.29.2023.11.29.10.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:25:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Maxim Galaganov <max@internet.ru>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231129113403.157953-4-max@internet.ru>
References: <20231129113403.157953-4-max@internet.ru>
Subject: Re: selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE:
 Tests Results
Message-ID: <6f451ca2-a29a-feee-6a21-10d2db824ae7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Nov 2023 18:25:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Maxim,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6232258219081728
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6232258219081728/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/4824883335528448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4824883335528448/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5950783242371072
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5950783242371072/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5387833288949760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5387833288949760/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/887f8cf2a1b5


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
Bot operated by Matthieu Baerts (NGI0 Core)
