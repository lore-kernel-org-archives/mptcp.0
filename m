Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D82912
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 23:17:46 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id j21so3452878qkk.9
        for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 16:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpPDQY7DmC36sLY5KZuf7+6oIOeSbv8muTX19rd1OrA=;
        b=EIKqj7nGqM/CgYPxWc2DyWcIJCCOiHtLAK4/2d0nX8xDBhGCGTTpa3M/aS2BMQL1oa
         wqmSKGrr8mqu64SPZDw15+ha9kULDYG7jNCqG+sVlRHxsJSh+scRKrkciad6JKHeOZIC
         DomQtuGo61a5z9p0uVlm82f1ZDuBD2ZH8LZ0BVGga+Se3Om/F685tXyCGUcu0zYwBWf3
         If8bBwQbjq6SE3yYYy48GejkLMP2ugQRbxMLhNiWHV8wsksVFN63OVIYZ/HxTdXPJ0We
         5v1zfiHyBi+M5yvxfv/vbmZo3AvH2VRNfBw+BRqz6A00oFDnTyPEzN+nWAEq1Rwu18n0
         mbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpPDQY7DmC36sLY5KZuf7+6oIOeSbv8muTX19rd1OrA=;
        b=DQtes4nkYot5iV/E3GTLzrxTMcqefOnxxVReZjuhgoXPcPWKe/QMzNzoPUc5B/1j3o
         PWkVZdu/p+5xYcrm2T9uA+GVjXuqTDDMtRyYdh/BYFE9LX7QKD+M+5ylILNVWLdEmPIA
         FWzcXdBPl6GUhxjHfCahygIzfhButA6SbFoqAh8ZT6Kz2lEbpdIWmB7X9JtIk7zz1OZf
         dKXLB41OcQHciVh6HobwK/fIccCBxxtTMPKT5a6+QsxbgQ2+vcnUED7nSANW5ahfMI/J
         eGSM3Ix9PRrSfpCVa+Bdw8oiSYFP88JuRRLiqre0B6ZM4TP6a1cMsAl6gHZRmLcCDN9w
         W86Q==
X-Gm-Message-State: ACrzQf1AHN/QRW4C0rQqjUjBm89V4CYZqldY9C5mat6d758E2LisfasW
	wqcmJ1DS7c2Df1lnUkPzjQ==
X-Google-Smtp-Source: AMsMyM5gnx1ed5dIKJXxyED6ELQy6TemT90M6bRiKeTevs6ttc53YlyCKul0g9SXhobtvW2gLCwtYQ==
X-Received: by 2002:a05:620a:343:b0:6ec:f4b3:e3c8 with SMTP id t3-20020a05620a034300b006ecf4b3e3c8mr212270qkm.225.1665789464965;
        Fri, 14 Oct 2022 16:17:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.10.148.210])
        by smtp.gmail.com with ESMTPSA id b13-20020ac87fcd000000b0039a610a04b1sm3079788qtk.37.2022.10.14.16.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 16:17:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2abed554f2050c7626dede74c92a181506a92682.1665779933.git.pabeni@redhat.com>
References:
 <2abed554f2050c7626dede74c92a181506a92682.1665779933.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: set test-case parameters consistently: Tests
 Results
Message-ID: <a4d7da89-5ad7-e750-e3f2-d69e11818200@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Oct 2022 23:17:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_mptcp_join selftest_simult_flows =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5519911765147648
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5519911765147648/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5536100100866048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5536100100866048/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0d89219ab621


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
