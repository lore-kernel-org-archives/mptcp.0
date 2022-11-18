Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB729AD
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 10:50:03 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id h2so1649821ile.11
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 02:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoyNLxIIAd4VeEKQzJvL8cH0il0cjtHJj4c8nkvrp4w=;
        b=Emot9X1gC8g57DhMJEvloC/DppxMSS/K2Ku7/CWDp3iA+Pjofy5gm//V3SlebpKuuv
         RWNklT2K06yDHEZVanQbzToo7xhHqVh6K7pGNBveZaRyPrM/v9HlJ8pB7u84yPuOOzUf
         qIUQQEKTpIOIVvYcGT+smhzlpEgm6NyQ+4Mm3bmOdSJrpAVGFMdg0Vy+Mjo9hbRISHDR
         PZ7y6JQrVVfvLT1aJW1CXTJftYY93IunWV7ppxSH6vluBMGkHY2WQmv2jjDz6M0Pqr6A
         oXTIlPgS0i7xpJchouJ3ZuZC4MxwbTV8lF6sq5yKk0bFNeZfaadsWeuDdFMZS8Ld9ekV
         17Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EoyNLxIIAd4VeEKQzJvL8cH0il0cjtHJj4c8nkvrp4w=;
        b=GunZo9kV4DbX3dCbOuQ99lbbWDRdt+Mj2cTbrHgpoQzvChUJYobnTvww3j0N3PbVmc
         zR7s+IogB+BOJu/DxApVXsfNCUvrb5rc8CSy9P1tq7s12JeP63dvwIh9nF+f+P/qFuCo
         SbXdJObTOx7bikqw7wjVAGIGj71vhyGkaLMMrn4+ncY/PdD/P6MRy8q6xJ8GHJy3HzUX
         5J+pBIXp1E1HpbcdOw3WXyHo0Y6Zcr3SaQwDyUNsFzuLh84aHJ4e0FRplGvPqRice/Kg
         M+AS7cnPb2pIvYhMUlrqpZAFEESmw7Mm5JFdvnW4D1NhrLBixs+OjqTmwtSaOOT9lz5R
         zgAQ==
X-Gm-Message-State: ANoB5pnvTM+s1GAToT+ua8G7YziYr3381xpGeSg7CCBzGucNs21g3Dz/
	a+2LZ7RwEKyVFOkxW2Qaqg==
X-Google-Smtp-Source: AA0mqf5clWiUauiAHr7USm5jiAhyAEcfWlI9dHGz3dgY03qvBFu2Rlm32AW7rZ5aNC9fFXUvVG+/VA==
X-Received: by 2002:a05:6e02:cae:b0:2ff:774c:7b46 with SMTP id 14-20020a056e020cae00b002ff774c7b46mr2992128ilg.223.1668768602353;
        Fri, 18 Nov 2022 02:50:02 -0800 (PST)
Received: from [127.0.0.1] ([40.122.150.224])
        by smtp.gmail.com with ESMTPSA id e16-20020a0566380cd000b003750aa3c5c1sm1099747jak.31.2022.11.18.02.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 02:50:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221118083541.123585-1-weiyongjun@huaweicloud.com>
References: <20221118083541.123585-1-weiyongjun@huaweicloud.com>
Subject: Re: mptcp: netlink: fix some error return code: Tests Results
Message-ID: <dfc9b0e8-c7d2-db84-3c9e-a14991015a0d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Nov 2022 10:50:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Wei,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5978086596935680
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5978086596935680/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5415136643514368
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5415136643514368/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/98d62c34b343


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
