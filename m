Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E907192
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 23:27:22 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id q190so4301912iod.10
        for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 15:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZTEk3udUpSEZvYvsFqVINkQGZXNkvgKl9t1pj8AMkw=;
        b=bK5yC2GPhErD9WdId0Lr9rfVwnllgcdCOjePxECYoVtXjkzPOyejksggYa1ERb5Hq3
         Iw8J+FbOTBO042IguFVSqvAec0FM4r0110m17cpw5w9FzCTMOtoXJjKE39Y7F4in7DoF
         HEc+j36pMQTKPHmaQ39EOvZ+UUFU9uXjDuseWz2iesUNGM+tF3WZeHEW0afki8H7lytK
         FNvF3VPRuVzjRB58qIeB2HrRr9XfWlx+TInJRPi/Yy+JNDbgu5l0Bc2Y2w2Lft7Ecpd3
         zfRunIhAJkygDKFpqPQch2K7Eip/K54WTz5g0gptaTbAGCf7Vd1g6glFKLmNtqoItwRQ
         y1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ZTEk3udUpSEZvYvsFqVINkQGZXNkvgKl9t1pj8AMkw=;
        b=nz2jPX/IFt0yu5WVFnSfPX5dymBdk3RAMrfAyL5fcSvzvqI4g+4GpDLdJHHTs+SRxh
         cdwtj+T0e13Qxz31hcNd5Xx0l0Bvtr+jL31Sh/65Lc5336VVpv5KlVqpmg7c5drDDgud
         V2QnXtbIWSJhr+DX22vp8K7U6fW2Byoe1xXKVbH0RqAmvDyTjWzs1juizrHGp86bxKbb
         buRgNGhURG+xzARu5VDFM8L/JfXhdGK/siG/O+9fUpDkEGz5VSm581yas9NcN7qUfLch
         7X4iWGTGLQ62Db2UGmqTwQJ3tYF1+oQOm1tp1pghcKtsp4h3RX6NSljR8QPDJvbEkpoJ
         Rlug==
X-Gm-Message-State: ANoB5pnXgg+3r6bvQhjDSB0GIAxx4MQ3WNAMVuQcmIlvaOds2RUCaZHD
	be4rRFaE6KNqrDqDlr0vQg==
X-Google-Smtp-Source: AA0mqf4znKvEwd2NcIKJSJHoDXyJU4+IcRm0MBqBReo34DZ0SGTBxvK07S8wxZVB2nPyFfkcmNZnlQ==
X-Received: by 2002:a6b:c815:0:b0:6e4:1e29:bd42 with SMTP id y21-20020a6bc815000000b006e41e29bd42mr2497071iof.5.1671060442067;
        Wed, 14 Dec 2022 15:27:22 -0800 (PST)
Received: from [127.0.0.1] ([40.77.123.113])
        by smtp.gmail.com with ESMTPSA id q25-20020a05663810d900b0038437cba721sm2153277jad.7.2022.12.14.15.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:27:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d6f04d238c8a797899d6cb543a43f75e544221af.1671054577.git.pabeni@redhat.com>
References:
 <d6f04d238c8a797899d6cb543a43f75e544221af.1671054577.git.pabeni@redhat.com>
Subject: Re: selinux: Implement mptcp_add_subflow hook: Tests Results
Message-ID: <46af7f85-3769-ec6d-057a-acc75f8bcb9b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Dec 2022 23:27:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6429528191926272
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6429528191926272/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_mp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6148053215215616
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6148053215215616/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5022153308372992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5022153308372992/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5585103261794304
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5585103261794304/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e34e1ddf3ddc


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
