Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446AB2F5B
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 15:24:26 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-39446801ca6so597186b6e.1
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684337065; x=1686929065;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWP39Ni9Ka3tD6/jhsXpoR4l44czIbxqxGWmfHBfIdI=;
        b=AFvf+SEtua5M0SaEv6xqgmwQvJ6SxuIa8x6VoQ9w/LbL4GYXbKjPadsyfwXOmkDE1X
         ao4FNN1pP3GaajVx0QH6FCLXMA7Wxdtj5suAD4O11/1E/Sj5TGHoE8p1Vjyr1e/1I4Bk
         NX9xXm9whxxTtzxIm907RLyUidBXBOWkKkJwWbno9XMqHk9waK1YRYS6prdjJ75GTzcS
         DmSYYscvioRlhHrWiPzJ0icbvBCMVfQ035KwXWs2tatk7gTlB801lG9IzVfxjFmblTcH
         BZMZQW4QZcyI8q4MwWc2YATWkVFmV0w+1wga1RBf8OzORJ590CPUupNB9y38Dap5+QGB
         g7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337065; x=1686929065;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWP39Ni9Ka3tD6/jhsXpoR4l44czIbxqxGWmfHBfIdI=;
        b=MNNHBWKlT8DzYGXcfgjph4vuzl0yJTLMeIWVp+PeCn9yBXvENGhaR+rSLN9Jibuf8L
         JmDKPuFH+oqjWS969QmbObJcKq0Zn8fY1mYTgQ2v0tY9Iz0MF/ME1SG5Xplfc+tEIjqD
         PMYDXiW5YFL6Wp/QQe9ubdlBAYOKOmu2LvjWj8dXWLc9kPzRhx73sNW/8nxf0wLeeH2+
         7aKIeTRpxV/t2sarBEAOAqCrVVl2tB9LZ9AK9CJPaF5ae7BJuVp7rpR/bvorDhr3+L60
         v9OqWV++KTtvCHQtqIZruZcnbLFCiRztCUJx1y/pvnxmy99birPVR9VhH5UTwto3LRdp
         b57Q==
X-Gm-Message-State: AC+VfDwyLiJ8AX0/HnpiUB91TShBBOA2rZjgup6Rq2bWWSd6e/GTP9AE
	VJ9mCL+RLayrIIZojEG28eaM7ELGLdyc
X-Google-Smtp-Source: ACHHUZ7QQQEg2bvavkvo39HxMMWFRZvMt0LlTIODaVFgrUQf0CV9AjIzD91UtoGcdso8FDaQwIngdg==
X-Received: by 2002:a05:6808:278e:b0:38e:7168:697f with SMTP id es14-20020a056808278e00b0038e7168697fmr13070605oib.20.1684337065180;
        Wed, 17 May 2023 08:24:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.174.130])
        by smtp.gmail.com with ESMTPSA id l11-20020acabb0b000000b0037832f60518sm10159514oif.14.2023.05.17.08.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:24:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1bcde6c0ed5c841a2eedf214d44742d683c85cb0.1684331602.git.geliang.tang@suse.com>
References:
 <1bcde6c0ed5c841a2eedf214d44742d683c85cb0.1684331602.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fred_test=22=3A_Tests_Results?=
Message-ID: <07622b73-652c-7998-77cc-f3e3a68832c8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 May 2023 15:24:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5767691659640832
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5767691659640832/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_dss packetdrill_mp_join =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6330641613062144
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6330641613062144/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4923266729508864
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4923266729508864/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5204741706219520
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5204741706219520/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0c3e05f46646


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
