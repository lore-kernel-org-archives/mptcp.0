Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901D4699
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 17:27:31 +0000 (UTC)
Received: by mail-il1-f176.google.com with SMTP id f6so4773721ilu.13
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 09:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBux8Q6427RYhogjtGT+8goY1EJLIBcpnOHaXHg5LZg=;
        b=jbcpBUnkxZpZzK22TY+QO4AGeJ5EAr2teJOLLaAjEmJ3Ol/k+QHkGvCfecaZorPs0k
         1YrzAWCIrakKk/H0edq3ilSGOFuuq7XbZn72A17ceAPhZqLbpWQqbZOi90MlsGArT1ok
         g70umFDS8Mp3nA0cyBohyTfs1rKBZ6Rv7pscOsHwKs0llynDhV7erZS8FBKOQwtOCKN8
         uIuJUTejMxAAwJhAup6FOx97WpmxwyL7jNBlk8jOO5HZ9K4GVUPp57d/Yz8pJ3sbMUHh
         MStZvQPwm7vbu4pP4B7Ty8fCy0J0iUwkr+tt3Kn9e9E5o/G5N7hbuAJ1afX0gOet9/I0
         dfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBux8Q6427RYhogjtGT+8goY1EJLIBcpnOHaXHg5LZg=;
        b=odivTLNyGAuEjkW0PB9V728GrpazoOIU1vK0L4ooXEJbcMEfxatdDBihb460Gk3Vjt
         jEX0g09VfytGb276BCvaglsIKB9UHp36t+VriFNDNzvZoWywDugsAiqBpsxu0LUDEueX
         ZOqqqrMtpqsglPk6pRUXTStEEYO3PHdMLsnCAarfxGEgn5/066v1xW7OXtHz4qJXVSms
         1UMMZ+RNXsx2AnufmdcJFJ5MkhtQBZxDhpfBQAiLdYY3n444LahtCIhVhVVl4O++clrD
         9NAkxu+CYoOtVmYNUjjyEdHur7tmtcq2pNmH5oVejBufw+S6MlIL6aCs7BmlxWjIypUQ
         Dbxw==
X-Gm-Message-State: ANoB5plQN/QKx9a050/CmBJcyhKfbVTdwOV39o5Ug3goEqlx+AiFCk+9
	zYpYcx6w/GwElm94MFQ/9w==
X-Google-Smtp-Source: AA0mqf7Mgx2OrFE0kwisfNY4My+1eU8ydKJFUziMo9BELIspRXLaTMOZ153Og1Cfvr2HYCASXiBZLA==
X-Received: by 2002:a92:d1d2:0:b0:302:535a:6eca with SMTP id u18-20020a92d1d2000000b00302535a6ecamr12937963ilg.256.1669224451041;
        Wed, 23 Nov 2022 09:27:31 -0800 (PST)
Received: from [127.0.0.1] ([40.122.125.185])
        by smtp.gmail.com with ESMTPSA id o1-20020a92d381000000b002faf6559e90sm5886136ilo.51.2022.11.23.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:27:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221122034923.804955-5-imagedong@tencent.com>
References: <20221122034923.804955-5-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <c7c493ac-23e4-391c-8239-06fb63e6ec7f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Nov 2022 17:27:29 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6201775137488896
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6201775137488896/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4794400253935616
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4794400253935616/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/afd026792ca1


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
