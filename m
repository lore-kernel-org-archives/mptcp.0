Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FDD4A02
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 14:12:02 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1280590722dso4228903fac.1
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=MU8NVDezngtMcYxfWGbO8xK6zw5LI59RgeRrL0ssZTU=;
        b=Ai122U2txCK6Pxf7+ZfyDlkNBVsqv2AO6pkPBjK054Ch1ws0KNSCvLUXPFcntbxP4h
         gsQOTdBrnj97ARJZ+szyKTA1MBij5oI1TwqiPH3eCJpHGbI4DpO+nc2sEWZVNHgSaeZi
         4NWHJUVOMGkw0IGXRGwdIDUIUuf7c5ebh28APOTsDswdYCOQQGS4TFjkrj70Qqzl/T5r
         0kPbg1b3YSo9IQJlklBxAPwOhFWgT82hd8CHMQvc53gK7gS8vC1sVoWaGPFj/z7J5Kns
         tc0ZwxiZGVLECfln42MBQIScgP6E5Jo0gVikURJDJfxjE5exOP642JMfp9zMCYiHDwSj
         yzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=MU8NVDezngtMcYxfWGbO8xK6zw5LI59RgeRrL0ssZTU=;
        b=GE8DDINtfRTDdlm8JdH54b7HhMnT7BCqhGBI7Q4HIn+ceSjBO5LB0lLnUr3lU1p2rU
         TvnsonGCPFGtvsaim7khq8rpEfZRYL7mYafAKonxp7yCu7drxjnHNIzq7DNSHw67/36p
         UUKAOaaCsjM/z/coOvQGATS6dhWGFT/dPZXcI8kpmfbZsnwxZmn1D/kmEYJIDW7fddTT
         lBoVaQIviUygLbV7i1y/Scnv3FxpqF30nE2nEpONup/HAfwQF2YN6IpAyVudbDmavNSC
         qghg+fZXITwUD6M9ZpXX/SToVuFHBJ3OXS4R/bVNow0ZePAyamynwp/lOK5GF4bNrTbn
         ktLQ==
X-Gm-Message-State: ACgBeo3nuYvqJ8XnzzYvy0k8p2DLGFSNMGD9jVg5seVFZ2+HCicKR5sU
	9er2o79qx2CdoyzM1B/6HA==
X-Google-Smtp-Source: AA6agR5+vt4tMZKKfk6pf+bqxe1nX5Fq053ck/FiHB7KdRSdcdGArzwFlJ5ijCnA6sXFpQmybI8KSg==
X-Received: by 2002:a05:6870:f595:b0:12a:e232:68e4 with SMTP id eh21-20020a056870f59500b0012ae23268e4mr4408428oab.155.1662732721837;
        Fri, 09 Sep 2022 07:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([40.74.242.27])
        by smtp.gmail.com with ESMTPSA id r143-20020acaa895000000b00344fd6af70fsm303275oie.14.2022.09.09.07.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:12:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <48ba286b429284accc457e34c6580efcdec593c4.1662725968.git.geliang.tang@suse.com>
References:
 <48ba286b429284accc457e34c6580efcdec593c4.1662725968.git.geliang.tang@suse.com>
Subject: Re: tcp: Add mss zero checks to avoid divide errors: Tests Results
Message-ID: <1f8942ce-3575-5665-c41d-46d72b6efb72@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Sep 2022 14:12:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5840132505862144
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5840132505862144/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5277182552440832
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5277182552440832/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/20ce85e9e5a6


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
