Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C02582
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 14:54:07 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id l4so1921913plb.8
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=9yhu4YiGJTBZ5ALiPZykFppiz5bfLA/A07Ug7yNuMlI=;
        b=YSDgtW+JUcSOPTmSqrCa2QIjiFuOmlo9KROtGZdieZrW+8WIAAlCWufmRpr0OuYZNc
         MaLoj9i1Z+G4r0P0ayepsMacaKPiJKzJddULMdlX0Uj9O0+GXl05Z9WSWgzCIG3LPx9m
         u0jXJVWwD/IUciKLuO5gf6VMjkAy7r5lwGWGCTX/qfPFj7aLJNe/Ip4YV3me6LBvBHXr
         yxYZHu6a9gN52im7B0fv/QJXPlCQokH14Ciq5KQ7nAbCYDqHXhwdC1rDrXQ5cIEu2D7U
         GiJOqKSYtVXV1Ij/kEVVBDyAajARO+XlLPHqh7kCzNwKuEhpnJllIzmr7s6Mt0n+ElKb
         rZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=9yhu4YiGJTBZ5ALiPZykFppiz5bfLA/A07Ug7yNuMlI=;
        b=LfrOZkUQt1xlYKzO+yGOjqhiKcBM5yasEmNCBXmFpfQWza4DDW4CqtdW3mMCmwE6++
         yqSgQM/ejBYKOB2zl13Jqfwae6eLWCAh2Cgy0LR3pbI+fR8SeC4lCuYz+c7k1apaM3Zi
         tt3xjnhCR9dGHKa1gymTDCxDc4MN1oDqvTrUc02jqGSriWBAnls+02/+eZbNz1XAwTzE
         EfR7Jwgjry7aUMO6Gbch8uZz2z96Gfpc0nyDK8OhmggWrxD5koZ4aKZ9Kk6mZD58ejdl
         xtaZrbWWfCBpoSvOIS6aMU7X9iu6kHoMWJg08evxmd5MMTWww2hxWT2LsWZ70cg1YpI0
         oyNQ==
X-Gm-Message-State: ACrzQf1spvact3iYAS3xqcfPvdpwlvADTedfXTOx6/iJo+S1x78OAKKP
	5Pa2ktg/Jx9vO8EsQkM13w==
X-Google-Smtp-Source: AMsMyM52PK7qAUjP9kq4l3n6MRkUFNznM4NRjvkeAkg9IGU+UiLLVfJall3UHTExdfeqDqL5BTMgew==
X-Received: by 2002:a17:90b:1d01:b0:203:2bda:abb1 with SMTP id on1-20020a17090b1d0100b002032bdaabb1mr10842421pjb.204.1665068047440;
        Thu, 06 Oct 2022 07:54:07 -0700 (PDT)
Received: from [127.0.0.1] ([23.101.205.78])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b00178ac4e70dcsm12519425plg.185.2022.10.06.07.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:54:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ddbb4cae497ea3df00bb82b238fdef63b8924fad.1664812609.git.pabeni@redhat.com>
References:
 <ddbb4cae497ea3df00bb82b238fdef63b8924fad.1664812609.git.pabeni@redhat.com>
Subject: Re: mptcp: factor out mptcp_connect(): Tests Results
Message-ID: <2d4dc642-f32b-c5fb-a3b1-e484411158b2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Oct 2022 14:54:06 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5080762767638528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5080762767638528/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6206662674481152
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6206662674481152/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/56fd8c59c652


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
