Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E37E9
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 06:36:56 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-e5e433d66dso5598870fac.5
        for <mptcp@lists.linux.dev>; Wed, 01 Jun 2022 23:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Ix+DuVBnGBxPs9O6oGgqPxZTWW07Mx5GazOP75bXf9Y=;
        b=ko6EWk4IYcBdSotNSjAvhO0SD+fg//UwtEFUV4sZbgcWmXMWLqHEnF/gczGKC4eT6b
         QlDYWr6OqH6Nje8zb7GgO7A66dmLd94SCAzZ1mCtdLoMzKlmMYcaEpccocCe52rd7vb3
         FC/Ir4hmMEta5hO6as2qdrOTu1qnVYBMJfhW/eV5vmnfw0acAiOaTYERsIKfOk3B7q9H
         mcx1L9t0b+BQXyeETwF5yL7gZ0rx9DBc0B8Y4nfwGgdRmQ2nExGtv+UzSEIv43+E9FzC
         OmTJBEfN/WuReJmBvPFa/3+EvH0kwKjdVVjd5p3qqpvnIiUXMMx4fh9KU9DCabQo1KG9
         vY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Ix+DuVBnGBxPs9O6oGgqPxZTWW07Mx5GazOP75bXf9Y=;
        b=XxYwevUB/kqbvaKK/8QhK8FJt2T17bLBwuZr2w1ZYlFZFBUb1XJS4jsu4Pj/PEOo+e
         lSSkCG5BbNvDvmT2lT6a59uAhLQwyXerIoBZa90HZkeLBwu4xJ2bbTGfnfK1l1bkNAzD
         V5v0FcDiSzOmlTVuErDkF1/FC9q8SCrrK6ANs6y0IH5ibbfgAMC4FQl7mg4Jqy/UsgWG
         SCuNlBK6RFQv5CRe3ltp+KZVKI9+XJr2qQ/3WJDj61hcn/GICCtBJpOxj6KmibQJl/Vh
         UWzgYYO8m2BOyclVAYKcrIBtVIkBGFduRL9MqUelo6Lsmqz+1HChi/aUCImH8K3PfUIj
         vQkg==
X-Gm-Message-State: AOAM53305W+eQIGPvkTqGC0htsexPbWm2iVGXgaYLKqnxt6ETn8KpYAp
	XnLAg/4yKoaFlUZjzLUAFw==
X-Google-Smtp-Source: ABdhPJz5TGPbdSOYaevIMnLHToZ5nSvGLYfaNSaC5telG9UydbpxqVBzIluLNWDo70QIbCgG0rLNHg==
X-Received: by 2002:a05:6870:d581:b0:f1:82de:958c with SMTP id u1-20020a056870d58100b000f182de958cmr19121857oao.27.1654151815736;
        Wed, 01 Jun 2022 23:36:55 -0700 (PDT)
Received: from [127.0.0.1] ([104.44.132.28])
        by smtp.gmail.com with ESMTPSA id r15-20020a056870438f00b000f34a989923sm1670561oah.28.2022.06.01.23.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 23:36:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f26165cd8b5d4380c16b4d13607e219e376bdb19.1654143895.git.geliang.tang@suse.com>
References:
 <f26165cd8b5d4380c16b4d13607e219e376bdb19.1654143895.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_rr test: Tests Results
Message-ID: <c9b4b22e-4c66-4cd1-e044-b18c211d08f0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jun 2022 06:36:54 +0000
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
com/task/6186355024723968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6186355024723968/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5623405071302656
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5623405071302656/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/09f1dd4b0a46


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
