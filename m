Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E78F62
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 20:27:45 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id a27so3876927qtw.10
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 12:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d0DctbZV4B3Ol8JZkkc2vNOfAUj2jmDZ4gSsuVGKSQ=;
        b=OpukZMJ1A2vs77Drgyj46To4lQmiJeux9v57AzZ2yYPeRMzKsFkrU+mm54bSmX5RBT
         xpgAVMf+BGwJ9UC694IT0TTWXaPtIxviS7D8r+9uCM4jSwa20BoTsZ9Oa1/Xyzp19j6h
         qqSZIfEd0uToRACFpTY05suQbkiecEA2e/jINA3XahoFEUKHYKpiYgrcWGZDzVYoZPXs
         QDTnCOTgFdHPWb4hcDqbWoRAgL+WWEIBQJq1VPt+bMAZSVuKlj6yvtxgSqdewQNX/A0V
         fGd1nGtF4e4xisEPjZQIMB4nuMoKRovQ6t5QzE1Ptx9m60jB57hdZPurV6f9s7LnvYiG
         0+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+d0DctbZV4B3Ol8JZkkc2vNOfAUj2jmDZ4gSsuVGKSQ=;
        b=LoBdCvHDQ74LF/hq2cg5Su4DWFNZbbyQfvtTk+tpRyM58LhMPAhRNrT58svF7Rv3db
         wV5qH25YOiecpzGKYJr1Sa1pg3AZ0RqPWx8FvOiKD6Nh+sswBLRcAJ4h6rFgFEY4a+b1
         Z2syKoTT7L+RrpslO6ZzX5PJqHCvtY2sTcHzTVC4iM6aOyRAxnCM2qkjKXEWoBD9R+qB
         DUdkiEd4y8xOItEY8LPOVTPxb7XMCq/Y4u947+jO10rz2WkqMiQ1jmbdjDPrXYj5lSqK
         tHqF6+SHTB5aGh5Vn/ImVvM3BNOOyWxqCfpvm+yjxMm/OBeIu8Y7pfPTx99GLYdvTDNP
         6Z8w==
X-Gm-Message-State: ANoB5pljQrII4ezCkJWEi0mW5JpMCwPZtzCuVPDgTIpTRCL8vYlX16LV
	t/UD3Zv7z0sBQw8N8s5lRU/WnrnRmFum
X-Google-Smtp-Source: AA0mqf7xrjaGt9t+zSvb9Ikz3ypfra19ljLpYifemhN1wYasrHh4AUg9767ACpYiqW6loCiz6Tk9rQ==
X-Received: by 2002:a05:622a:1e0c:b0:3a5:9022:f466 with SMTP id br12-20020a05622a1e0c00b003a59022f466mr8234016qtb.110.1668803264448;
        Fri, 18 Nov 2022 12:27:44 -0800 (PST)
Received: from [127.0.0.1] ([20.119.209.165])
        by smtp.gmail.com with ESMTPSA id x30-20020a05620a0b5e00b006ec62032d3dsm2988257qkg.30.2022.11.18.12.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:27:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221118182506.6226-1-kuniyu@amazon.com>
References: <20221118182506.6226-1-kuniyu@amazon.com>
Subject: Re: net: Return errno in sk->sk_prot->get_port().: Tests Results
Message-ID: <ef553873-e4b9-64de-f1df-5882e06eea48@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Nov 2022 20:27:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6597844069515264
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6597844069515264/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5194679124754432
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5194679124754432/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7b46793b7793


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
