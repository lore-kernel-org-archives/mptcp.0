Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0EA7C
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 15:14:45 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id g23so16260827qtu.2
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=ZHSU6iwu4HRUqDxUMSAaE1Kza+Jdm3trneH3dQ+QlvE=;
        b=YtoP3irZifzV2jjkzlAsvPeEsfOyWzEDxtFPQr50zRdvldtFnZwGt2m5ayvSpPu8XO
         XxNC1s1LMKNvfXPefX939eZz6yntHqK7Om1rquJZjWGR8fMaDqPGnY779EZ7lzQQrGbQ
         uUj254xYd2dfZVftMa0vt+whnkCRBW/Y3HVUd41pMKEE47uOvGQxycMfyevdulFROh2Z
         Slqo1tVruUjvuJwm346py4Jrz++g1/NJGdBsdo9BCLo4hDgVqONRijUo2loEzrzaCl4x
         ckL81wNAdcHNgC1MJjmdSEfZG8lMlczvBh9DuYQ0LYZK0HfG+HiOV1/4G0sYRVMelZR4
         ifxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=ZHSU6iwu4HRUqDxUMSAaE1Kza+Jdm3trneH3dQ+QlvE=;
        b=cu5u9lV2PDITpJzkJmfFGKac6xYyd/VXH0llEL64kNs/LXxvsNl7RqkkUeL6zR4fj3
         Mk/RUafSY5KfIE2dsUdKw9XawsT8iRySb8xAAM7DBfQZpvFyn4N3ZptgJxPahjouHA9n
         y3KR9tbyY9RW89oSDHJnpfY6Dwzkr+4579BaCtqqlxJR0TJS9w8+pcnAWZ6/LC8K/2vH
         y1skZ5gYrb2n0TkTZ9ETIOvLE4kBzinWZzT5EPiJYyRhgkG38vWH+FFN0PnLUJ2bD7xj
         jLfXnZEGFiA+UbCDyqF+3qS01KgJn1vl2Tk8EcLMYLO4H5gCLJzInAO3ESlTAK5CBo/E
         oENg==
X-Gm-Message-State: ACrzQf2t3Q13JkdWdY0Q6XZNCt3PEjvICdqOYgaMzdDxn1qlU3ZK6WdT
	KeTjQWhn4o2ZBXMGKuN4jzyPq814v85PLyA=
X-Google-Smtp-Source: AMsMyM7Jbmh/apj6VX8v+C0r8ZAbJNEFOtseQZT70w/bL69CqnvHN0kLGwPu2r59TYbWizjG8oZgVw==
X-Received: by 2002:ac8:59c8:0:b0:35c:e115:b18d with SMTP id f8-20020ac859c8000000b0035ce115b18dmr7741808qtf.123.1663600484404;
        Mon, 19 Sep 2022 08:14:44 -0700 (PDT)
Received: from [127.0.0.1] ([40.71.89.84])
        by smtp.gmail.com with ESMTPSA id 66-20020a370345000000b006cbc00db595sm12495255qkd.23.2022.09.19.08.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 08:14:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220919132156.3649522-1-imagedong@tencent.com>
References: <20220919132156.3649522-1-imagedong@tencent.com>
Subject: Re: net: mptcp: add statistics for mptcp socket in use: Tests
 Results
Message-ID: <a62f843e-c8a2-4408-dbc4-3921a51009ab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Sep 2022 15:14:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5623681228472320
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5623681228472320/su=
mmary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6749581135314944
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6749581135314944/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/02a3d2d88e79


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
