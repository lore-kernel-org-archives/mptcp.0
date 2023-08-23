Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03CA92F
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 10:06:55 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-34ccc0fca24so262035ab.0
        for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692785215; x=1693390015;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueW+6KY+T2voxcT8+wzS26oZYPkdhTxTbSnFwTMAWT4=;
        b=eywhe1bldkQgb0u9Sq6WhDmjfRnGQNIVi1dBq7qxmBJQLEErIabZUiCubG/GeB296S
         sakjA6LYiFbSpQ9TuJ10h/MaLA+ZoIiENSZAG5qdubrTbvirT9E1itIdcUkbFqtDKvsm
         TdnW3NoeboBH9hZ/2xIxWk5YJPlGUrRyhjEagMI4I76Lgd/lBpC3yH+9Ge4lmrfa282F
         2nTGH/KycoIosW96UFn6l/SexeedgXawQkvO5i8aK2iEbmmv3yXOJOnt8XWcJiPjyViR
         AKIcVq/jAR9VtaP9Iq0itU8yehbMFzdRTKVxSzjet5TLO4TOPfe0IHn4PwKnmYH9nxzm
         u/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692785215; x=1693390015;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ueW+6KY+T2voxcT8+wzS26oZYPkdhTxTbSnFwTMAWT4=;
        b=K/T0h+UrwXapK0mQGPsSYFN34ghRik+pG1O8bErQRD44CxvsXhXhssDTcidU0xUtUf
         4e0NVueixxFmLz+E1tP12T96Z6QSuybz+Q1m3r1rM04YdXPCa7jKrK3fbwnCORafrr4P
         CbauA+o/rTlrxXuRb4TK1ZvYbVU00848qup7k+XzHTCcbXVCB4x0GTLCqEXWnUlGEP4f
         EjH0ReJY+phcbj+vv7CLWKkAVFp4d3yhsUk9CEN01/YRCUwUyYvT0O+GY4worS5hBmNT
         Sgt0HRr1JJGEMHOTAUakDZTzWARQW0Mrhow2ShQJ0MuYwgSiGaKctPvUJzO4XxxeKMrW
         TVfg==
X-Gm-Message-State: AOJu0YzSxvF+JSgDjthXyfieRytbBm5fGBOeOW7WBP107tRoqELYHIzn
	RA4uZK2HgdDc0PTKo5pjHg==
X-Google-Smtp-Source: AGHT+IFZiT0s2poQVV0affdlUdzeJe22QGkGhLFd4FZH7GLEZtnVj2sF1zleWD3NZCL07SMUHtOKRQ==
X-Received: by 2002:a05:6e02:12ac:b0:348:987a:fd8c with SMTP id f12-20020a056e0212ac00b00348987afd8cmr1861200ilr.31.1692785214670;
        Wed, 23 Aug 2023 03:06:54 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.154.174])
        by smtp.gmail.com with ESMTPSA id r1-20020a92d441000000b0034a92425cbcsm2310059ilm.84.2023.08.23.03.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:06:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <fbfa573423eaf6692eaf4a14a840cc18722c7332.1692779220.git.pabeni@redhat.com>
References:
 <fbfa573423eaf6692eaf4a14a840cc18722c7332.1692779220.git.pabeni@redhat.com>
Subject: Re: mptcp: process pending subflow error on close: Tests Results
Message-ID: <ef55f0a8-3045-41d1-1210-9d35cc03d6bb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2023 10:06:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5564860235251712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5564860235251712/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4544513444675584
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4544513444675584/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5670413351518208
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5670413351518208/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6690760142094336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6690760142094336/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e64f9b400ebc


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
