Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0146B6
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 23:07:03 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id t4-20020a4aa3c4000000b00475624f2369so1348076ool.3
        for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 16:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=fU5qdCf4e7FkC+oZ1SqqSyPlY5Vnq9h5Aqg/ogcdjqc=;
        b=REei57jpfsB05kriftLSrdGvLrdlMsey/RgBo2ErVFrkZzpujvxr0GsQL0r2lPJCSo
         FpC4hQrldWngoTqlg6eHsHaaax2EBjiTi/LkocHtnw5B9xK0TqnyWGTLSdhUzCEUE24K
         iX5tBzknsaQMVtBTNGvE8ZBrqk+RhfDjbkv2yTWajaRWOH9xHc2eKx1Hk0XFyBpHy2gz
         TpzzrMNf+wEi/4rptXgK7GA3u3AFwP7xdVKHC4PLMQwsgBzgZBU1t6MIwnTA1cN11Y+8
         4Ok1woujLkkR5SwN36Kn2u6DGWXlhLeC6K7iReOUjm4gusGj9Ylvdu/WJMYglGzfPlTh
         TOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=fU5qdCf4e7FkC+oZ1SqqSyPlY5Vnq9h5Aqg/ogcdjqc=;
        b=24wX/2WeG3CEkXHJG7EG7Vijn/ocHELFVukX1IyGAMueHN6DR07WTO4chGfQ6xE/kL
         W+raJL+tiGlziVKCAZ3XOblygJY1unZQOOgFyNUONn1bY2n97SXHMOvMisIBh8amIhQs
         ZP4xJYFNvUmrZ+K3YbOsK8eXKhMSQ+y/enh1DiEUz9DfTtRCdYhYJRtMslvgx9XvbMWb
         J5vi+HIpr+8wmx3q/pSgYfXSSJtWHoMAa/PB0sRT2TrXqF/4lThz+sdDegkwyOvZ7pQg
         wmk5KCQK2kIIWhFo6+I9SmUzEQ/MP1jixfgg1DdZKuRnNM+uowaQzXKvFqC524pgL8Wz
         VkoA==
X-Gm-Message-State: ACrzQf2A9ZVyO5C22EEUvRtY5V0ayE03t5iACg7FPktxJetLAB7FrYta
	4mjH4TG/LzgISlimM+U23Q==
X-Google-Smtp-Source: AMsMyM4XUDpjTzjHBUGl0mTeqAGjMBtmheBquQq4uLYOV+lZmfcUCr/AksalY2XXd+toC7LjI1egvA==
X-Received: by 2002:a05:6820:1354:b0:476:7bd3:ed30 with SMTP id b20-20020a056820135400b004767bd3ed30mr1493293oow.66.1664233622154;
        Mon, 26 Sep 2022 16:07:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.165.24.90])
        by smtp.gmail.com with ESMTPSA id q2-20020aca4302000000b003514e125e12sm932625oia.35.2022.09.26.16.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:07:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com>
References:
 <870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com>
Subject: Re: mptcp: update misleading comments.: Tests Results
Message-ID: <8a1575fa-b620-2471-890d-0c90e4253806@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Sep 2022 23:07:00 +0000
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
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4956489147219968
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4956489147219968/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s):=
 packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6082389054062592
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6082389054062592/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2474bd2962c4


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
