Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8E23B7
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 13:22:09 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id d8so12318371qki.13
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6qmff47Y6nLwVesOzGFbj9ylsjeEGmVN092Z4E+9qw=;
        b=ZVR5gumnmrNeUe/wOjJjOmfz3i5kKlKOJgqSDAeeqy+QUV33VvP0DK9hlYrpQY5jiF
         AOODPRjvEJSt7A8a75UO+TRTukfxR0bVYUWCDmm3+LA2bm1G7cLd6195fkUvC8tfyZwa
         ZC20eKeiXSH9M4riSjonaoq17o492/SE1sUKSYgJny+R4fyS30SEjEvC/0L6RT+jKuNA
         2aWJ0yFrvPhsRzGKwbFcwlTfSvXsgJqGqVC4swNXJTnNZebpjnrfLtp9xr2yHIwcwji3
         Ss4mCQ57qhWINM/mX+CP7sWzhv4jz4IRRwBU3zt4bepn2Vp1p1VXhmYWKO/c3E0DrgQA
         TVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6qmff47Y6nLwVesOzGFbj9ylsjeEGmVN092Z4E+9qw=;
        b=lqFONHDp4PVLrHwc4UOTmJ2IExRBxFKCJIkl44Wf1krov80NO7G7ZLr4NUMrOkx+fL
         EEYbJ+31//cy79imoojzJX0ya0Mpqqh0LDg2vR5/eWJFoox3QaOeMXowmf0vTfan1vl6
         wZsI6TG5pPQ1KELumMgYCHbAAPNKKCffCGTt22cLPn6BKKbwupXLEo3cKx08EtClhStK
         IB9tsLMx49aiLggHCr8B2Bw9VTFJrtO4A3TSL5PlP7o/ZJqSjFjP0uLZkvL2rZkNEBVk
         2ZOVLUn9O7vnqy3XzlujPIEYOvVy8bFwi68D7E3woGs7sVRjCnQm0XptPM45sHAGvRkR
         ywZA==
X-Gm-Message-State: ANoB5pmuJNqlupC2qizWhtX53tp3LfrzpjGNbHSuvhcGZYoKLpQDFz3H
	s6EuZAMnLPCIY6IO/ITdwQ==
X-Google-Smtp-Source: AA0mqf6/Uw5RKrSESrTdMstvqlarR3TIqaflWYYw6mHWxd4q2vHUXg3f1cf4Pe0WluLUCsvryrFezg==
X-Received: by 2002:a37:a87:0:b0:6fc:26a8:4ee3 with SMTP id 129-20020a370a87000000b006fc26a84ee3mr4585804qkk.148.1669209728126;
        Wed, 23 Nov 2022 05:22:08 -0800 (PST)
Received: from [127.0.0.1] ([20.22.244.111])
        by smtp.gmail.com with ESMTPSA id bj26-20020a05620a191a00b006fa313bf185sm12059626qkb.8.2022.11.23.05.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:22:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
References:
 <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
Subject: Re: mptcp: fix sleep in atomic at close time: Tests Results
Message-ID: <646f862f-a891-dbfe-4611-acec2aa268eb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Nov 2022 13:22:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6329217620115456
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6329217620115456/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5865717434679296
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5865717434679296/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cbc71d5d8b05


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
