Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A597EBE
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 11:49:19 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id h33so10833832pgm.9
        for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9a+oxLXlE6COcucM75ZVjk7jL59U0poKGXUK6h+UxY=;
        b=k9+Bs57iFc0kVSzUZofWaJc5OyTGG8OBG3IC42Ew1zzBXcn+UiUarxlBiuCVfKL+JO
         dhqIHCfg0+aoH5xYlG2cHyNlAD3pju5MOS7ZxUxdCyI1/woemmqcDe+MsQCQDvJCINtR
         PJ8JpQqANr4Kz8B8CLzl1WEit3EREDpQZ6ENy98JpyoxLFzt+Au/EWS7iVrv3Use4b59
         sACgbxtXJc1xLaHlnCvgIGXfXszXM804UujU5sjBR0du/b7aKmyFSbC31rRivgVt+bB9
         +aafyatcmcnp9mZqnB61QYwZTe75gP2Timv7qEBZFYIPFC+Zju1zqxiUKf3cDb9tH9iK
         XlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9a+oxLXlE6COcucM75ZVjk7jL59U0poKGXUK6h+UxY=;
        b=IKE/+AmNz7qMH1lqYcO2ykTXW/fouJIKMbF4x8cAfDOZyG4stb76UI5QmMW/34ZMol
         C5jiMZpoDu46HqooEQka7vrKkMOSnMw4/mTkXoXrMvAf1Q2DhD1wrj0GBlt7zjFGAws3
         nVJs9pS6GYNuUfBNfYu3gw0hAiJHDoKSr7iALCkd6PYrwNkLUxhpkm9c6yQOvpZKskso
         ryI0wVVMLM4DzsocBbUyYxW9w1uSQkylvTz79eBgrJIg+9pg1HbdYNBEpknETR5UujL5
         lEiwP6Q6tWBTxcAA0adksTom6DdIGvzugwfwfPhPIA1khuNP8yMhCiiws3spNf+rafyc
         jP3A==
X-Gm-Message-State: ANoB5pntmcWM0JrVldBJ6rloHT+2SlufJm29NtdZc28H7+X07DhPcNnL
	EK9e26CTawt4EA3VbbFDn2N1CFlwc7Vw
X-Google-Smtp-Source: AA0mqf6oK04jz5qmbYwmihewSTsY2oK3+MOr/ACKsq32Vow9tXT5eonhXeR0R4e/KgjTkynpqwDmtA==
X-Received: by 2002:a65:6e8d:0:b0:477:ee28:b8d9 with SMTP id bm13-20020a656e8d000000b00477ee28b8d9mr20964343pgb.396.1669808958652;
        Wed, 30 Nov 2022 03:49:18 -0800 (PST)
Received: from [127.0.0.1] ([20.245.94.7])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b00186c3af9644sm1255842plg.273.2022.11.30.03.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 03:49:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221130094448.4119946-4-matthieu.baerts@tessares.net>
References: <20221130094448.4119946-4-matthieu.baerts@tessares.net>
Subject: Re: mptcp: use proper req destructor for IPv6: Tests Results
Message-ID: <a339673c-e88d-7b22-e2e2-816caae5ceb6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Nov 2022 11:49:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5358507365498880
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5358507365498880/summary/summary.txt

- KVM Validation: debug:
  - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6484407272341504
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6484407272341504/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bc00aef00e2a


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
