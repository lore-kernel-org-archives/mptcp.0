Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233C7B
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 12:29:23 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id u14so26736971qvv.2
        for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 05:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=PZWkBn+C4D+SLoC9d4gzl7rQcTL0BSdLg0rs7KFi17Q=;
        b=obffnQ0O1EdbOBdHT7VQbRmY1ZN7sYZDOfHvXu+xgaIK+k4KOy2um+Ry+aQ+VWvGlC
         Kp/+8OVtwOY4+jTkj6HIlZEDBsWRuoFUA75KuyZzg395Kvf5rjBA5YSwsR/+kwIOsYlN
         Ml0V69WDn15I73UpE6C65N8mETVh7QYS74sVgzZ+pEmu8khnVSGOqWFtxvdPqIZPVxK5
         dUiRzpaoxb8rkGlLf91YD1BHhGEh5MDcPMNfeU/ZA7rgXTbpwyLb0cLl2+pa2oeOIHNt
         7SZThqJQMC/7vWlLaa/2Y9oW3iiFy2EC4fRiFRsWCPP69ZwokJGTPnisxVp+E/mnVh2g
         Wi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=PZWkBn+C4D+SLoC9d4gzl7rQcTL0BSdLg0rs7KFi17Q=;
        b=gpepP6m2xFP2+m3Asvegz0gnuPuXKm/nTfJNu/EAl+3sHDionDeLYE77IWeRztjJ+z
         GOOqJK5no9H5YjdSceXABeTCGLTMs+KJrrEfX75c614BDbrNGZIAZ+2w1p60vXUMYD/3
         2PF0PVwLeXqifFY3E/uKsNqjeY7XSMnvmYbv0jrzV7aZOCswlRfi1Dz8633SzzobYXkZ
         JETxpl6oTSdihNIqecKrDxEL4G0XRFG4gyMLXj7u2obK+2FQ12PsA1CcHwCPD+1la2ya
         N9hlBz7scz4+xVt0i78xZo9YWeyPBgEwPM8fK7jeRIXUbMoSQP1rfIHwXvnnYCVwZ2to
         EKzQ==
X-Gm-Message-State: AJIora9NSMQMgQVuG66BuYf5tFdc0DiIX0ZDbJbjzwTOuJ44ZBhvMRxN
	vBaRxvYevc5s+p2nfCKjPA==
X-Google-Smtp-Source: AGRyM1uxsoYvCPwNBpMnC+Ek3EADTlZFQdO53RbfGNojUyAOmU94Kitjaydco9j+vXKVyro2BoLHCg==
X-Received: by 2002:ac8:584b:0:b0:31b:efad:e020 with SMTP id h11-20020ac8584b000000b0031befade020mr7037019qth.425.1656592162248;
        Thu, 30 Jun 2022 05:29:22 -0700 (PDT)
Received: from [127.0.0.1] ([23.102.108.169])
        by smtp.gmail.com with ESMTPSA id bm9-20020a05620a198900b006a73ad95d40sm15039868qkb.55.2022.06.30.05.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 05:29:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9ab93a02e7bf2ea1b2cfd40ce9e2001970d2e890.1656586148.git.geliang.tang@suse.com>
References:
 <9ab93a02e7bf2ea1b2cfd40ce9e2001970d2e890.1656586148.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_Add_bpf=5Fmptc?=
 =?UTF-8?Q?p=5Fsched=5Fops=22=3A_Tests_Results?=
Message-ID: <9586e143-55c1-a077-b7a7-785d9dbef087@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jun 2022 12:29:21 +0000
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
https://cirrus-ci.com/task/4559693640105984
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4559693640105984/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5685593546948608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5685593546948608/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/62923bf20fd4


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
