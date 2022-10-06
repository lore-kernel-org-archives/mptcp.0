Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3554690
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 17:53:08 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id 195so2527473pga.1
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=91zUy0kS35YgR3zDXa4Ojs6QXwwvTyyv4T130sW0FnA=;
        b=Lzybb2H361MzImVfd+vtiA1EpxCsqHc3yRzCW5/Evm3tlNIV4ZIeylveFQzuRachyw
         H6XIJmF1OcDNzNqCz3T9g/HQLKVrmqW1mOJ1c3JG6l3dVCwktkDM4FTwd2PrZTYd2smL
         oFhGCx4BLnVKxtTOnZnWU7dmQbI2WRaSm5MtZzyzOD2pB2tASbegAvOLjlPDK9plH/pp
         c/ZYGsi5tTnHK3LtxI9GhORUtCly3fW3l8rKGl4kY54+huG39BpllsrEE525Q3wQgUaf
         Sz0wTnA7CyiiqqH7xQhirqnO0937i34JttGxjabrxvpo6UQcS2xgggc5AeVTvOwlNZnB
         jyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=91zUy0kS35YgR3zDXa4Ojs6QXwwvTyyv4T130sW0FnA=;
        b=1TMnWP2dk+cnXFksSoQYvnNJ6DJfckY+iQCMzmTSfGuLqFV1Y89JNcnjEriOCztDtI
         EyTATdyCAELebSqdqUTXOmntQnSSYf9GTQscugW9CElvSejc4f4gGI+pTLTgMQXr2S1D
         7y3fH4KtkLKAnk7l5Gzi3jrVfa2qUFIhDuhy62zHCiWXIzZzIg4BwHUSw0CuAIHi9CGa
         Hk3W+OlREnJ8mQypZa7kCm9E12UN4PGRV8yyph9JqHNbMv+ZXnb3XlIAJ94nhuj/Xo1Z
         pUNBlF+fpydxuppdGym7GP1ohT9P06C7HqBqbU8pi7te59ATLuX85swbAsa4HXtf73av
         wnCQ==
X-Gm-Message-State: ACrzQf3GBrmlpwqZrxxl3HUeQ5SL+HfZlpHVZ7OjVTFBqgIjvVCMvuZL
	6GShdL70WFXX2RfWzppE/QiYD5avGmTv
X-Google-Smtp-Source: AMsMyM7RnTh/LdJe+yW1EDpmshVGunvVPr1Rvfb7pI61KlMKqje0hkfUai9Lgf/Z6C2SYKj8VHQiVA==
X-Received: by 2002:a63:2d81:0:b0:446:8d24:c90f with SMTP id t123-20020a632d81000000b004468d24c90fmr889520pgt.160.1665078788351;
        Thu, 06 Oct 2022 10:53:08 -0700 (PDT)
Received: from [127.0.0.1] ([168.61.78.76])
        by smtp.gmail.com with ESMTPSA id o2-20020a17090a3d4200b001fbb0f0b00fsm3124776pjf.35.2022.10.06.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:53:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ef567186b9f3920e2043d85a585a4db957646d34.1665058389.git.geliang.tang@suse.com>
References:
 <ef567186b9f3920e2043d85a585a4db957646d34.1665058389.git.geliang.tang@suse.com>
Subject: Re: mptcp: multi subflows retrans support: Tests Results
Message-ID: <ac2652a4-5206-16fc-e504-75e454776735@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Oct 2022 17:53:07 +0000
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
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5053437011296256
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5053437011296256/su=
mmary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6179336918138880
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6179336918138880/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/acfdc20f458a


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
