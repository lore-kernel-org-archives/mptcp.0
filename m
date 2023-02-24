Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238EE539D
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 13:06:51 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so2633888pja.5
        for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 05:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR0tUCifSp8GSZ+Gb5yM8C0JA/PNXWxuZl0Y7dUqrvc=;
        b=oKBHsGeA4t8fe9MKf9lqTr2Zg7RD2GbEweMykNe33cGibUJtz9ewT7XTlpP8oll0Xt
         W6CeNXrw6EZ61C7t5tNatsps4RPE+eajEP96vEiUEFVOTSumVEg9Cg0Z58EFwkzAMxrP
         j2q2XKpIZedHIOUjaWtUSgxcGkUEJoO9PGfeYJxHW9eedUQcE2o0YOjo/D2nnrp2nKXp
         fVGxADp5EV4TlfQhd8yFLBsWF0ysHFZHSxwVVH1FuuLy2XvJDiGVqfdkgygV6XyPEWya
         JfPtFYM3jL8vfbMim+DQTyHDHB2nmj/U8x7u1djxXjgmdO7CMFpgK2lGg8mkjUfoh5PH
         eF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XR0tUCifSp8GSZ+Gb5yM8C0JA/PNXWxuZl0Y7dUqrvc=;
        b=bhCAArTDAzjjuVdc291oaG0uc75aIrOp7nDhEXr6wWdTr47Y2w/3b40Weqn9EouoAu
         WdB6l115GxmG1MALUKASDd4KiuigovnURKQsPuI0qmzRKgT8BZVbw30I99LfmbdBxtiC
         5EaE/4iJgZiUJIyJk88+IJeE5Ecac2snRfZALG/FIzJEjs5YbXLUNRZEf9fAJI1wVF5/
         XaKk5HxbQ3gz4dgV8KNVhBqJLPnCBOcG9qCh4/s2+K4drkYDM+poR4Ke+EW+YiW4nvub
         HDdVOssYjuYyoFioezDP/P6oGNSEEpESlxzwNL0srgj+lfoPzNFwHPboO2Yuz4/Z7Vas
         IiJA==
X-Gm-Message-State: AO0yUKVSvQjjbPPu0Q8sVzZAJRO7pxKsoYKz+9UAbjhnawIVl6sAECkZ
	nxvnDYpxio8uyG9z6qLac9WOmMI7eyOu
X-Google-Smtp-Source: AK7set90s+r86Ng9cstslPEtVQoXLT3wrr5Jb/QyYuc9OeGF2XWgkIJdTpAncw/4fq0fnecPb5xMig==
X-Received: by 2002:a17:903:2843:b0:19c:d309:4612 with SMTP id kq3-20020a170903284300b0019cd3094612mr2207899plb.6.1677244010535;
        Fri, 24 Feb 2023 05:06:50 -0800 (PST)
Received: from [127.0.0.1] ([13.73.50.82])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c10400b001978e84753asm1643177pli.65.2023.02.24.05.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:06:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
References:
 <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
Subject: Re: mptcp: fix lockdep false positive in
 mptcp_pm_nl_create_listen_socket(): Tests Results
Message-ID: <6fbe7003-6f4e-0c5d-452d-286d6438e78b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Feb 2023 13:06:49 +0000
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
com/task/5877425146429440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5877425146429440/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6440375099850752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6440375099850752/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5033000216297472
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5033000216297472/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5314475193008128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5314475193008128/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7f3a6a73c08c


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
