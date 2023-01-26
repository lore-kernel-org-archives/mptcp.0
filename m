Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8E2904
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 16:38:04 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id o5so1688023qtr.11
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 08:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msI70apKkKFoq8oOSJlkTPvFPr7YSGzlvwUtb5u0dJU=;
        b=KGpPpm5X+UN6ntUFTjpLMx9Tcs9R+MOrZxG50Ee1o/KFEKJCj7U9azVNwyB0L/YsUn
         oJfX1dp6W8xOeTvG7nn+YNgC3JptpYJpvzMoer60jZu8zVyTPGj1oPnn2C96CysciKsJ
         wUox+RB5xCJXiP/ODu7+wz6KxmyL3pPwbMg1uhbqwrFUTDVFSzqhO/s2iThTKxlzCHaP
         dAmj5S8+XMjHpmM768i9a6ywkLOhSBnjEUjb8BzUyMELv764zbg9NBYGV3jf4SbCwBjL
         gvcDAK3GDW/7A6NoAbJBeF6RVOYge7bBZHX4Xbv45dLDm6POszhMoiRoDj5nOJlNZQSf
         vVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=msI70apKkKFoq8oOSJlkTPvFPr7YSGzlvwUtb5u0dJU=;
        b=XiGLvWJmcXn+lC9i68Bg3FQUi7ku51d8Pc4kyyIOz4XHf88Mxo7VKMzgSOrD+A8f/N
         u+6vo/9GFvql3zRtTdhgPSmPRK6i9GBYBEotL117a1+DmTnWSSE85nlv4KHWSYBlSI0r
         bbsII48yR4L27GGjXcmB1jgkRTCGzWRtr+UFYw8oqOCFoKmrlDPZyvCkBeTPPoONPBlF
         SP3Z8tzVdRU1Z52eCjxQt4dClQdH+a2C6uZxm8tU5ZHs7FLxc1uOivy8Wk6TfeaIv4bZ
         yfmRhGDa3zfefvI2tAF7bxRlBdavG9sR+X2ZbEsAUCR5brrmzZRqOWAa+y1zLpxkRphh
         JT5g==
X-Gm-Message-State: AO0yUKWO4d/oTmp/RvbX1ZhC4lsGcHHvWpjhc07CzulQI3kxg7rRWnkG
	AWLEFqp1DxwU6h0KGB3/mfuGsopFWfQoePI=
X-Google-Smtp-Source: AK7set+EBNLN3D/X5bALPY3sQrUMusZBM8/pLVyNacXgGDIaCLIPoRCDKBevMTT8NshKAk1WgldmfA==
X-Received: by 2002:a05:622a:355:b0:3a8:2d6:521e with SMTP id r21-20020a05622a035500b003a802d6521emr11851540qtw.37.1674751083249;
        Thu, 26 Jan 2023 08:38:03 -0800 (PST)
Received: from [127.0.0.1] ([104.45.204.163])
        by smtp.gmail.com with ESMTPSA id ej4-20020a05622a4f8400b003b2ea9b76d0sm997956qtb.34.2023.01.26.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:38:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1f0aa2feba9240d202a087e60013c6ff8039897c.1674747837.git.pabeni@redhat.com>
References:
 <1f0aa2feba9240d202a087e60013c6ff8039897c.1674747837.git.pabeni@redhat.com>
Subject: Re: mptcp: do not wait for bare sockets' timeout: Tests Results
Message-ID: <a5d933ba-7ff9-cb61-7c8a-4ee83c6a0378@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jan 2023 16:38:02 +0000
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
com/task/6644295248117760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6644295248117760/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4603601666965504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4603601666965504/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5166551620386816
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5166551620386816/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5729501573808128
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5729501573808128/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bb52e8434e1d


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
