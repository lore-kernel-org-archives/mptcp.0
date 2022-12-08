Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54959629
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 04:51:04 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so255767otp.9
        for <mptcp@lists.linux.dev>; Wed, 07 Dec 2022 20:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlCqLX9vduju7scd3iCtibcKqgJaNRLN+4FtLWw4+Pw=;
        b=C3vmutY0jNgudDnr1yOumOHxYyY2B+43bAAopoyn7nwguuVg4AKPKwwy3JSObNzWXZ
         l+7sxH1YMTBjnzObnSJKFrjbJcoGT+4xYphsv4ZnQZIJLJ62EKLxcUhhGv3ulu4k9Tbu
         awfcnagXnZVvWxI2FU3g2Ft9ogABwO3nBb7qOeIOiznkQqEQuTSx+OYm8eQChK96CUVs
         xPYdtsS7JSRDhXp7DhOwzk+ZxPg3HnEAzw9dk6twJ0xTZtaUxmoNQ+bI+DGycbPqXZ6/
         jsVx+y+j+/MaiaLdbBUSy2STQAhM3VTU1hnYsVd55kSapDPu2P3mb/kl5z4MKb2HJvTk
         BpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JlCqLX9vduju7scd3iCtibcKqgJaNRLN+4FtLWw4+Pw=;
        b=PKfZG9cjEtVlokxgEFYG0B5olAAj+BQcDBnALo4gXN/aNZrSTB4O+O2rCpwowMQ4g1
         J23EEgI3fjyUHk6gsPthHieG44VdLAcQZ2NmgVQ6KVLb0OvjNe4RtH0P0PAp3en0UnZP
         Ae5zGauq5Ne6IabPbxWv2dBz4eb5xSZt5hQEBhkIh5CQnbHczvpJKzpYMk/HTcfMwhcZ
         pUHBduHtbIkqJAVDfvEKMfZTR+lFhlbDRom9Kf0cySirNELb/GRk+O52rP9P7y7KkWHX
         jgo36amqMx5aGl4oxz18iTj/xH2Y0szx+zWj+36UtJUs9T/j4guRVMuqP/ZsRqPoB9S2
         q5jA==
X-Gm-Message-State: ANoB5pnE3xlTarzNnfA9sc/HFgvFfJEZsvK5SB964BjOMknZMGRraPtq
	BP8JXu8DRZNdgbb3mtBlsw==
X-Google-Smtp-Source: AA0mqf5OWtjjm0C7tZS2RRLF8zVcnU66cWVn7jPTNwkRwKD6d6T8QecC8tPcUjNkj68ltZcbSPI82g==
X-Received: by 2002:a9d:4ee:0:b0:670:5717:f3f1 with SMTP id 101-20020a9d04ee000000b006705717f3f1mr581000otm.35.1670475063281;
        Wed, 07 Dec 2022 20:51:03 -0800 (PST)
Received: from [127.0.0.1] ([20.165.25.247])
        by smtp.gmail.com with ESMTPSA id d15-20020a056830138f00b0066e64c59bbcsm10998265otq.6.2022.12.07.20.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 20:51:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221208024543.113633-5-imagedong@tencent.com>
References: <20221208024543.113633-5-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <46cd8751-af43-53e0-4720-26cc38136830@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Dec 2022 04:51:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): insmod - Critical: 3 Call Trace(s) =
=E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5270512411082752
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5270512411082752/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6396412317925376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6396412317925376/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4989037434372096
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4989037434372096/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6114937341214720
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6114937341214720/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/27b157db80ef


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
