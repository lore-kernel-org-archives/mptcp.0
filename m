Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE310F0
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 06:49:38 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id 204so593294qkg.5
        for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 23:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=5TlsKKdOAHUmIgPa1puH0AugFMqaIZdWcSiKWMrI434=;
        b=S3MKiQQqoqKYRwBZhvI1YBzBcjDG5/kjCNCn8ejV4/7zL4yN4beEPieMwIVpq0yoDq
         Q9uO6zmIBL99XsLwREhUbhGSjfiBULVq+pjTny8jvZzffMawjhZ6cZ8IdU8cKuHd5TIh
         HFYSdDdYyTOKWx/lQS0HQnJOke+x24AerUdMlcp8SSlVDzLgnbtCTFYrB2thClvoAZM0
         qpJbQP6mwogtKJuIovCSh/Bq9ycS01qJa+qPBUVDZhDBEK2uXLPdHmWBclF9iNoRLvwq
         nXUEyui9OHRUaqfb++QNXtmdL6anmDfR22AAUvQ7dy66lIYr1TpVwcAxA64LRjiAi+2M
         j/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=5TlsKKdOAHUmIgPa1puH0AugFMqaIZdWcSiKWMrI434=;
        b=1hYfxGCykeiSdmCSJuVf0CQ2bdKk9WjZR1isC5s3xDNrATdujj39umDTIYlPtqRvhY
         DT76bCqzk3ZUwIq7J3HcQV3EbxqWR1avbA8kAb1hzGxvQcJI8NW5WMNvMRqJOlTrIvUf
         QIZQ3gC0umU6LW2D1O11v0ODltw7xhu3R28Ny2/YzEfL5N3IlTJR/5z+VLjiZiAxu3Zx
         1Us2LeYurSFLUgIikFECqf/zlHv7FNJ8stTE0ie4o4K5LXpSnvmMdVL2r/1Si5i22PEr
         F2rG66iIpwje/bZsA6BaE+5CA3BGJIsgz8b3Skw3vF8TZdc8XAIhrKNf0hZZyXY729eo
         7eyQ==
X-Gm-Message-State: AOAM532k8dsK6slJfzStZ7oBt2Q9P6wCACo+8xlrI53Zf1WwCNn7EbOI
	HX2QGsocW7IOna4NYocoBw==
X-Google-Smtp-Source: ABdhPJza1yUUXnf2qJQZV2O8NiPh5ZgTc1aydKwL4HtmRVDXx+9nxWwrJ6PTTIVtGbfixhEmjnyAvg==
X-Received: by 2002:a05:620a:b92:b0:67e:b7a2:dabd with SMTP id k18-20020a05620a0b9200b0067eb7a2dabdmr11949761qkh.106.1650437377998;
        Tue, 19 Apr 2022 23:49:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.242.70.127])
        by smtp.gmail.com with ESMTPSA id d18-20020a05622a05d200b002f07ed88a54sm1460690qtb.46.2022.04.19.23.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 23:49:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7072b5ca4b8e6d710506a789c4e962c9e33cc54d.1650430389.git.geliang.tang@suse.com>
References:
 <7072b5ca4b8e6d710506a789c4e962c9e33cc54d.1650430389.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <6c37f1c6-0cb1-b284-375b-9e7f0ef7cb3c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Apr 2022 06:49:37 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6322146069708800
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6322146069708800/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag - =
Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/4914771186155520
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4914771186155520/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cd43e2aef03f


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
