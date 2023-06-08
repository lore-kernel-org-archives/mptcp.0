Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5243B3FA
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 10:15:07 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b04706c974so2766855ad.2
        for <mptcp@lists.linux.dev>; Thu, 08 Jun 2023 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686219306; x=1688811306;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSc/4RaHSyA60EdPfGdulCB2aceiGS7Aw7k5tGv+Xb0=;
        b=JeFjf7o5k5VwaqPOQC61LN7a494PpgOKzY1Qt29h9gooAhXNkkjEYYTSk+O3giPGwS
         bHtknJqYkkTNp/eRpNjCF6gIaSyXBkTHrimuDcgiFDLw/6OInUXqRnoqCTNhsOvBnpOK
         G6Q84Tuh1n9BAKaiAjr7eGERfFrYQbnbyk/wp+mnYwHzSoXoyzC/aX4dGTxc96qVjJbU
         nueLhrjgLEwT7NmhanNBnzqvK/zAiinqbO+sR7shVDxWsrnwn+MU+2Q5IMYd3GGq5GFD
         tK587UXkobT7tYadX/+p8SaMSnhkcEFzL2rMdbcs1FIhE+4q6B3uBlWAJEkGG+KYxtD1
         n0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686219306; x=1688811306;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vSc/4RaHSyA60EdPfGdulCB2aceiGS7Aw7k5tGv+Xb0=;
        b=XtWNAQ/GIXH1QFNNkQAwrUbynbNn9nU2yHw+b+i2muHbQ7u/do/2rqOFYP6GGzkWX0
         tlqNmPHbaPx0ta2OkZ6Hi1+gzli8pVuGUlmQD+8IInUZbYA6d0D4UjsjzVWUww30EJSu
         q6xJxcQM+Hbqq8MQnBdymSKx9oHCflZ4AXvHUFEnIIndT9wLiX8+BC7ghiDijFsVT8tD
         OZcjkvEKsFIObPzuKKBvMKxxXO2YdDWEuebN3QUWBLYBd+tpCEVlZ5cNLDoJ97e9ftY+
         TQiql+5RN56rQT1ouNfNRJevvWr9ipJ34wBCcGng6A6Ml5Djr4H41jVELnJcnYARKEAW
         vYlg==
X-Gm-Message-State: AC+VfDzvtnk+qalzw4thWuDeFqXjVJegZrQofny+3hcFFq9h1pZR9izd
	6i+sLzaAuSgQqafNW1lnIcQW3/Jt7yqM
X-Google-Smtp-Source: ACHHUZ7x6YiFlMhTp/LZRsud9qI6HcPKB564k5H5T+xK+Id/EkhuNHGwy7ir0yuRyDLb6gYWxllhrw==
X-Received: by 2002:a17:903:2449:b0:1b0:2b0e:d3ef with SMTP id l9-20020a170903244900b001b02b0ed3efmr8678919pls.55.1686219306646;
        Thu, 08 Jun 2023 03:15:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.44.48])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902a5c400b001ab0159b9edsm1053881plq.250.2023.06.08.03.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:15:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
References:
 <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
Subject: Re: mptcp: fix potential msk leak: Tests Results
Message-ID: <8735b747-ce3a-87e1-9f1d-7f14a4621d7b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Jun 2023 10:15:05 +0000
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
com/task/6219316832501760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6219316832501760/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4811941948948480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4811941948948480/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5937841855791104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5937841855791104/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5374891902369792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5374891902369792/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8579858a269b


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
