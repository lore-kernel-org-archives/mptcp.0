Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C464681
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 17:25:24 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id cn9so1380790qtb.11
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=weh0PitA7p5CKlaFu8m7Bbu2V5HtEB72iDVQiPD/3qQ=;
        b=TI8WFxYJSVGrbNASaSPPQAA+Qbl35hTpGvhlPW7loxCleFN8e61+qGj+9EV7st1jur
         jjm+VJt9fpmq6jlA9hexEcBs54tQevLPz1NQ92uLiBRz49IDxgfz4F9RnZvu1/8p7svv
         cQ8D64BArqRizoCx1PiZOxJTNXmkaEALWzYCavq6H68aV4oii3fzEMaZA9y8ThDOsnOb
         xDhRYEdYK17F7HWYJ4/B3152QzZ/4slayvuYcxHO7+8jFQCevUmJNNWLJcRokLEykvw+
         4aQZX2s15EK9X88f8L8l/2mUMCpHcIBf8qXYQhfgO0TYq9VYnI7Gz+/lz7C5XHuIVNkS
         6ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=weh0PitA7p5CKlaFu8m7Bbu2V5HtEB72iDVQiPD/3qQ=;
        b=A2lOYViSC6BD+o4BaZCyTSWspSbmFOpC0PQdjWk3+HLFxEa/3x946Q9CslRprLJBVr
         Az4zJW9X+sVcABTnoZk+B3qISihoPDuk38wvNoqtTIxYUaHQVdFNWT6WxQnyF9At1VHH
         kRkyBQ84Lo7wAFGmxnqz/IE0mxjxkEPkecDVSWy0c9Tu5Qkl0fqZX1qU6TO0JRtp1HaD
         cOXsPW7Uh6HGpYSBtzPn/WSXp1RD/DmTJsobMrxweof/W1KdYvjvKsVOpaP3Bc1u8Gt0
         stKX7Z1Hmvdf1fZC/LzeAlcFfS9Fvx9372z9YkyMK8/7gQ0XDBw08NhYocOVXx4bO+kw
         vlNg==
X-Gm-Message-State: ACrzQf1hkxi5wNDpW07nYgCsXr4nc9n9IDq2RZfViSJelitympUpd6HC
	dKEtK3Ye4AICPol+8I+1Gw==
X-Google-Smtp-Source: AMsMyM5vYD/rU1/BighWeT7qqR6yIAbB7r9G3GV73tEleCAXG0m3d3ClXZHvIX5VAhdN9N530qRhvA==
X-Received: by 2002:a05:622a:1e0e:b0:35c:fe96:e7c2 with SMTP id br14-20020a05622a1e0e00b0035cfe96e7c2mr1061465qtb.339.1665077123571;
        Thu, 06 Oct 2022 10:25:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.96.6.190])
        by smtp.gmail.com with ESMTPSA id h19-20020ac846d3000000b00392ad0b47bbsm93417qto.58.2022.10.06.10.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:25:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220930024607.128202-4-imagedong@tencent.com>
References: <20220930024607.128202-4-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <750f4610-5c82-f80d-8545-60616c873fd1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Oct 2022 17:25:22 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4902994138365952
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4902994138365952/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6028894045208576
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6028894045208576/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9efac8bc4497


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
