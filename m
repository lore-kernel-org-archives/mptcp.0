Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79CB1FB3
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 16:20:59 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id p14so44457pfh.6
        for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=/b9Sa8pKC1uY7kWLBMA78exACU2ZfadJ6zZ+W1rAkHg=;
        b=cXKXvtCG8/siJTySAQT0XgtYX/p1qF9EO4HROmYWjaG2ynM/7ZNTnsNrmKOBAWKvfA
         Nec+P5lnxIesLrhWj8sVpeTp9riQWMBOZDCX/dQkh25KJm8efZJEmjmsnVpHVKe6r3ux
         MWlIUEuwiNpX42u+oBY2GRNeSPb0UOKiIFjVLM/h5bi6bpisj9xhy8el5d0eCW98wHy4
         jcXykE/pbLgsYqxb5dRosd6VK+4UYe/zXxLVG8Y5z33jIW43vIhkmx0fv94yO8bZg63K
         v1+dN6Kn/B2xZfld64pbNuaaL++6F7nVBOJQ0jLsH+IpVb3JQtuPNrbWRpcxwHI4hswZ
         J8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=/b9Sa8pKC1uY7kWLBMA78exACU2ZfadJ6zZ+W1rAkHg=;
        b=mAjW12O/CTPIE+nlnDdwdlg8kaFFCbagtD2Y1p8Iqp5/cZrRY6elkdx1pX7zYmyn8A
         VQon3R48j1Ie+1TFgruEBecjqHqPcLvORoqpxjbEoeAJShu3geteL0oP3vYxd3dAh7cn
         8M5uSFNh7qv6g16jAIlneXoSXAhqgGkyUQXSl0kTVwE9aiLU4N2U3KhI1UahOf+gXTc/
         57HKO05n/2CjvvGqhsZDOLdJNOHWJOUzd8oy6VhHS1DPjuU7MKa33EfbFeXdKC7X9BQJ
         SM1G3g0D2W8OdUO6v+cVxQgzbgpXpWpcspljWvzM6wM1BsEm/CJsPpvGlLokBuZfxwOv
         G7yA==
X-Gm-Message-State: AJIora8B++xgK2yoe7LhcZT3nr+Uq/6VtKU2fbTcOT9sb5QQhF0YQKoH
	p0BTEWaG+NwZM2mpMVCOEA==
X-Google-Smtp-Source: AGRyM1vzcvNp5avAjzG3U35q7xG558fk0d46TSUdLSvSVili8l2MjQE1GYcxU65eeI4LJKO+y2bx2g==
X-Received: by 2002:a05:6a00:14c8:b0:51c:29fb:7b2 with SMTP id w8-20020a056a0014c800b0051c29fb07b2mr41388431pfu.24.1656001259177;
        Thu, 23 Jun 2022 09:20:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.237.171.202])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001616e19537esm8878674plb.213.2022.06.23.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 09:20:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9eeeda9e63480ed2ac0b01399a70a5c3e92d9816.1655995770.git.geliang.tang@suse.com>
References:
 <9eeeda9e63480ed2ac0b01399a70a5c3e92d9816.1655995770.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <82444594-c937-478f-2a06-dd3282e217c8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jun 2022 16:20:57 +0000
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
  - Unstable: 3 failed test(s): =
mptcp_connect_mmap selftest_mptcp_connect selftest_simult_flows - Critical:=
 2 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6417549658161152
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6417549658161152/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 4 failed test(s): mptcp_connect_mmap=
 selftest_mptcp_connect selftest_mptcp_join selftest_simult_flows - =
Critical: 2 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5010174774607872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5010174774607872/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4187f41ea008


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
