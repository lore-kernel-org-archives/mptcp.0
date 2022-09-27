Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0579D46B4
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 16:49:05 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id i17so3404166qkk.12
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=2C2KTfBVdy9AHk0rjIPsLLWcEtnlQnqf4Ioq5tqUjY0=;
        b=CKAkRIUSKTmn0FSd8Fuv8oXe90hTRp5NzK51uOg59PxzMiQZmBhrv+8pwzLHIQtFzr
         Mk8tSJaDmNSAQj4RTyakH/eW+89lvPs6BOcA4zmA9LAzGuK+VWVlqKCncbNJ3HNlcMRd
         J70BCk8ndBuVkll9A9deWQL5Is+ry94jT5k69Mbe8AQ4mySpQPGdAyZJIFHYbDH9vi33
         S02C6sVLmkl/NHj3MTnjVFvYb9F2Na+Oacw4LIiO6Nf4/sqME6R8qAIsRDbvyEGv0CXa
         OdAl6kzcnNUDAYsCnS1x6U2ikAoD1/C3boyWlEbR8zAJXz5Trgv9KMWazYRyjHiJwLGI
         BXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=2C2KTfBVdy9AHk0rjIPsLLWcEtnlQnqf4Ioq5tqUjY0=;
        b=rnCr1Sk94hMyy3KZaaV1Tf4MfnYbG/5lDmYybDjV1ckpPLxVv6x03o0NU26jz74UEd
         TwY84mlLNsThpi1YXRPxMV7g758bQIB0+4OhaE82VwAAfjc62NIwTlNb9na0vXqo3fA7
         ZTiTE/ZH6fAb8sDkkUrmawbVl/ndpxgHx5Ogh4uN2TQMSd8/Ge6EYTVD4Q3LPuesAltB
         oI65ohIioXUC9UU7ZMTf6LGwQK1Sq+xTexBywYk/DvcJ8AcBMhlNJcaRfKXp2H/2iZDH
         nso94euwCPL3VxtjAS9JKsg+ZHKp3EZVXS20faQ09xIqMHCAg5lqUry+F2V6smCPGi/q
         iOsA==
X-Gm-Message-State: ACrzQf2oiELtyF8SuhY6mQcoieMTDh/BoS92GuDgPTUqeXoZxzET7eLm
	gPq1S2pBUMXij5Prvf8N/0wcQA+dr31C
X-Google-Smtp-Source: AMsMyM5QaoV6amqH9u5m8mSBV3QaIkYdPSom6gma+CX6Zt8I3irQtMfkj37gYDSHy2DYZQssIpXc7A==
X-Received: by 2002:a37:8a87:0:b0:6cf:3ee4:56e0 with SMTP id m129-20020a378a87000000b006cf3ee456e0mr18111795qkd.200.1664297344875;
        Tue, 27 Sep 2022 09:49:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.246.4.134])
        by smtp.gmail.com with ESMTPSA id z25-20020ac81019000000b0035d432f5ba3sm1102154qti.17.2022.09.27.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:49:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220927150306.1552795-3-matthieu.baerts@tessares.net>
References: <20220927150306.1552795-3-matthieu.baerts@tessares.net>
Subject: Re: mptcp: add TCP_FASTOPEN_NO_COOKIE support: Tests Results
Message-ID: <c8d5e28e-a92b-092b-6791-5e417271f391@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Sep 2022 16:49:03 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5116179571277824
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5116179571277824/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6242079478120448
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6242079478120448/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/15b58c1eb2c8


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
