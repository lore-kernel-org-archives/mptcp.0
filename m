Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD91852
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 16:20:07 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id y14so7310380pfe.10
        for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=k4JVt8T69GMdoG//zivlIP559v2PyGS7W7R5ZEO90/w=;
        b=f3D5QoNq0e7mn9gLmwCBMwEliVtiUKvBPKB25cxQPGI2NX6XhowJdEiFE+L9dQxOg0
         kctQJbU74parsh1cTiEuHATOT1bcPfKrQKvYUSM+hApUMF+H5rnOG7oMEUaP9AR2k/uX
         Ji7daIbpsus1eZmhwp3TuHSBKBQHrtRRRe2ddr1/HJnk1eSd+E4wUaLaRrkFiwWQ2LOD
         TZzryPP6aU1QDf9yD6vWKMJuM6RKg0Ak8qpdINVS8K4gHMe/5rMxn0/+mQQww8Vr/lc8
         Uc69HsmbigHk32HGfP0j+Vk97+8yrnXco/cLzydCH8M0i979V+tfL9oqio9F17iPZhLs
         tGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=k4JVt8T69GMdoG//zivlIP559v2PyGS7W7R5ZEO90/w=;
        b=PEKCSId6yFqPSohtzugmcIIyUJDuQHRM9pCDBUuJUD0Ojirg7v2Gu7oeEe6Yos8Ne+
         1xeSnA+cxQsXbtl+k8CK3l3p0VI6lFUP88sToXq1RfTKN3Lx/iMaERnI3sw7rrJNOaGQ
         6b/mfMaQ+HdlqWpzAY9hkGX0e58VRloNkP54jFe2MqDFuFZPgPrk1TJnmv4Lm7cyZ85+
         EsjHKkFuzGRCSbf1wCZZzPzRLkb9G0RyAZXn7KfJCrLoG4AgTLxKZUmBmb0X7st2txke
         lFOfuhWc0denUvlhZFonwFU2ll9vlPvx3nrXykooBcfcSg+FNG8odbT/SkgquY1KWV7w
         Kyhw==
X-Gm-Message-State: AOAM531AV+XHHJyaXsjzBVruM4yx6mMBDVIjDt+E9PrJTimVcDHNKwMK
	6u0b+o35ToRr3Qu8XAlYnER+0dFvdFDB
X-Google-Smtp-Source: ABdhPJwux4ezRz/f0GjZkyVxNsKYVpZqEyBD3z5h2EAA7iIE+aC4Za/PZ0p1dZuFeNpZQEf4l8na2w==
X-Received: by 2002:a05:6a00:1146:b0:4c9:ede0:725a with SMTP id b6-20020a056a00114600b004c9ede0725amr87190pfm.35.1651249206623;
        Fri, 29 Apr 2022 09:20:06 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.44.85])
        by smtp.gmail.com with ESMTPSA id k22-20020aa790d6000000b0050a765d5d48sm3570070pfk.160.2022.04.29.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:20:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f64ef5eff420a2bb55103bbbb52c9dd527411da4.1651247530.git.pabeni@redhat.com>
References:
 <f64ef5eff420a2bb55103bbbb52c9dd527411da4.1651247530.git.pabeni@redhat.com>
Subject: Re: net/sched: act_pedit: really ensure the skb is writable: Tests
 Results
Message-ID: <ba87b6b3-7d5b-9f5f-9a21-74bdca9778a9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Apr 2022 16:20:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5879453103423488
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5879453103423488/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5316503150002176
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5316503150002176/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/935cecef44e7


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
