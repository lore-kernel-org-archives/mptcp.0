Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D17B
	for <mptcp@lists.linux.dev>; Fri,  6 Jan 2023 02:39:17 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id c7so1077505qtw.8
        for <mptcp@lists.linux.dev>; Thu, 05 Jan 2023 18:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHnWrArRL2lWKaQ+i5MU+rVbmewoZmaJpMtVSXM7Zgk=;
        b=ksm9ykdF07mcuOxJUhYqynHC7tre7kXqT+NY18oc29xsBDRCmeoD6yUDs5fppc8jyr
         dPW05AShQvZ1V/pudzppatoNgN/3ub3O8RRXpmzsB2aS71Z+mWVFyStD54MHJIT5Ea3c
         bTer06u6D6JAX5KjE4paJhrZDgpRy0q9C4TAc/wQ4waw4kG1E/4c+ACo/9ZGfo+clKxd
         FUJkdHIKBY1sAHBw0xVxU2nOeHXUXLWFMZv+fMIheUzT+16JL07rKJ9Yrqc+B5wHoNx7
         ZFN77HBShIQ/6ykj+wjySWE1/PHaGDKh3HACfk7pX89qsi+HTu7wmkeS1mir/tkxEPtO
         SHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHnWrArRL2lWKaQ+i5MU+rVbmewoZmaJpMtVSXM7Zgk=;
        b=OtbZrC+44JI1G/twITjpzG6blPpHLM7FgEerE0RimsffnzhKVHwJuoZJhvxb1IG+2B
         rNPVMqlRo5IKaKNT0k41h6M0Fay4xVjrvGkfYBizHSXZRhsVqoIDFuvrEZ/UfkJ0bBg4
         RvLaGBYN7k8MOBpVYj59h3Q6/21NCCjiOLFU2Fe+VH1PzdbZhJzzhBoInvJwB4sIa3uP
         w75WbhOwmH84gtvxLmo3KI1tEbVEGR2fl0bWUuTiMUPeDQyBTZCysnYg0mkxRVZwATo7
         ymXDQZJcuhX6nMzqwHx9dA6jMhYZ+KTqr+b3vgs082uXw6N9Lo0Hwg+XX32kbEioeoiM
         ahKQ==
X-Gm-Message-State: AFqh2kqhX3G1EeG3eAMVCc0j1t1iq2y4ocphYWPVWATumktFcT1tfhpH
	n6HJREI5SQVqygvcHZoM/bk42zWoXA==
X-Google-Smtp-Source: AMrXdXvUBRT/6L15v3Cjvy0rbYBtrGHcjnKFt0gQui70cTbpk4SNUeA1uQ1Iv8q5QofNpbjiwOf2Dw==
X-Received: by 2002:a05:622a:c:b0:3ab:b78b:c3cf with SMTP id x12-20020a05622a000c00b003abb78bc3cfmr30731908qtw.60.1672972756027;
        Thu, 05 Jan 2023 18:39:16 -0800 (PST)
Received: from [127.0.0.1] ([172.177.209.209])
        by smtp.gmail.com with ESMTPSA id s24-20020ac87598000000b003a7f1e16649sm22726957qtq.42.2023.01.05.18.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 18:39:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230104171526.1416746-13-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-13-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: userspace: avoid read errors: Tests Results
Message-ID: <d749aeec-6a82-5f54-afef-bc74c7189c7d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jan 2023 02:39:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5545190199394304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5545190199394304/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4630396525084672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4630396525084672/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6671090106236928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6671090106236928/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5756296431927296
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5756296431927296/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d15ee7ad18a9


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
