Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B133C4
	for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 20:33:08 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id bl7so5766285oib.0
        for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 12:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvU9HxbC9w8iGkxuOn7UAh4NPyhuiDgKMv0FBDFMlaA=;
        b=akvujWpohPDljWHTVi3uwgpc07VFl8Sxb5rPwR3bJRwbTSnc/DstG/uO4d3Q43a1wY
         9vX4W+/USMMfoGhty3adVGlqHtGFI+X0LFOmbVCCRPh7CIwjPBV8pVYzO8g/KpsFB6I1
         OzSCuCk/nNSsEVvodQChaG3aaXlVdQjVczutYqlgRaJp6wFOSb0k4JbJhD3+j9UrJ85X
         oe7/K1Bw2ZLwEzuzZQCAMLVss56llI6b/dMpoK2o3OuNot7MBCHUlNjBNcdz7mINiiFK
         /pL00Wqu49r2mg6Ixh25akTj0F7McbgBNbau6MqPQPQAtIdKfk6KHivH62hQKVYYTg++
         0PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AvU9HxbC9w8iGkxuOn7UAh4NPyhuiDgKMv0FBDFMlaA=;
        b=KG0EtxD1bsud7D4fKxr1YPWeSa38+i82fDjf8goVktxiQYpjAv0dF6VoyiawIeMI2+
         UiyV+mx67CYbTbnAR38A6Djl3gIV/6+SC9TMni3eu4NEn0apfdtD87XKx+gLolMLOGfq
         RC1chzOz22ZROCUy1Mdns1kLw1VXPcDcrcLBmW8AorIwFC43uoG6EYZs5HbDQtUgZoo4
         H0EjaZW6dHEnMhRCkkxeU2XO3Bl1XQ8QVzkbK2CLBSN8O0tsdiQDHkriJ9t3QoDbOt9+
         npShdtpcLDWLGhiPzHrvrdibJmTI89d+kg8LEgQbBUR5DeyBKyG4Aot6AwHHKIKhoIk8
         dU0Q==
X-Gm-Message-State: AO0yUKUM4tZhhJvSXjH3IdO5+urOimIMXJkidvXg5HSrXW66NfGneWyz
	55rQ8HEA4XXHglg0AiyF9vvVELhESg==
X-Google-Smtp-Source: AK7set+WeitURAyVbNxyt0q3Mwuglln4van+Ti99sxvtNbITu6vpHYd4+zqP1BV+0SKfu5kxgPF1iQ==
X-Received: by 2002:aca:1319:0:b0:378:99e8:4ba8 with SMTP id e25-20020aca1319000000b0037899e84ba8mr2239522oii.39.1677011587214;
        Tue, 21 Feb 2023 12:33:07 -0800 (PST)
Received: from [127.0.0.1] ([104.210.133.19])
        by smtp.gmail.com with ESMTPSA id j7-20020acab907000000b00369a721732asm688465oif.41.2023.02.21.12.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:33:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230221-mptcp-warn-tcp-done-close-v1-2-d248242b29b6@tessares.net>
References:
 <20230221-mptcp-warn-tcp-done-close-v1-2-d248242b29b6@tessares.net>
Subject: Re: Squash-to: DO-NOT-MERGE: mptcp: use kmalloc on kasan build:
 Tests Results
Message-ID: <1805ac21-f6d9-6007-e74e-49af431f691e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Feb 2023 20:33:05 +0000
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
com/task/6730426857816064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6730426857816064/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6251718711705600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6251718711705600/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5094353555685376
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5094353555685376/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5657303509106688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5657303509106688/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f5aae4847e68


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
