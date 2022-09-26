Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C552FAF
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 16:52:17 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id u69so7091339pgd.2
        for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=91jRNzn30ZB5uwfFnc3Tyj2hJ/53ZAa7YDSOIenuUc8=;
        b=HeF/2hcH2PTspMN3h7Ud7SD3fRo04MblMtwz/dbpzfdt7yEkVbghaHU57C88rRG+bs
         TcFASIOzWPEK9sMMb5nicdBW/7x4ub1rGpdC2JAcRwv07uSFoprABQ4lrcYkIGilt+P4
         ZZ3RgZTMKLOQbIE0HvNjTRSPPr/52nZ2+6Vo7BWHrzNAtbrdNCNixsYnG1EcLL/kIw2K
         INELCMV8HRQ/hw6XOYODe4a9WEX+7iSOEWUHbrIzzci2NKiaIWZ64hF3ihx38T97rv1X
         Mxy9Q1pdU3Y43GXl3w+lEUbwKSodShMHbFAWkx9kwFJBgCJCx+XNI98XNjilf96lv/82
         GDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=91jRNzn30ZB5uwfFnc3Tyj2hJ/53ZAa7YDSOIenuUc8=;
        b=RfT6QaySBKXbs8w+VONfZGRi6Q0I9Sqg4hYRLw2ZvOzmIvIbAp6SL8n/zN/S0IehBz
         ogpEuALUulsiv/g+5H9kS0NEObc4swbavUqWCOVclvi7Cz4KZqxCd+0AQdt6t/FYe7my
         ThaPFZYqu20uZKvpDgP+ptXAhS1YgX+Htq23gWyix7H+xulhH2mE+gByA/EDBUyxeZ1y
         5suWhWxgJ0cucilbL+K3junWEWBdez+er65Fci+UX7UBQwXWrinvth/YT3KKQFh4SB0Z
         BRRx/gRw1K2A0PFUKuc45L/vWbrG7cF43sE8bPHXSFZy9EMzQoad3gKwNLwBXBhZF3ro
         0npA==
X-Gm-Message-State: ACrzQf1L2tecIugxcZCcAwRLuPGweV9bNXTGqC+IlNcnwXgRXDEqrTSg
	TZBw2Sy2EPy0ciGdaNslZA==
X-Google-Smtp-Source: AMsMyM6kmEeJxvhVNfN5hictDxY0yaJmedZ+oGJyKfhyjAmfeE2euxPUCd2ZWmYVaPxd3Cul8UPqOQ==
X-Received: by 2002:a63:1a4c:0:b0:43b:e648:a7a4 with SMTP id a12-20020a631a4c000000b0043be648a7a4mr20875404pgm.7.1664211137282;
        Mon, 26 Sep 2022 09:52:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.237.208.29])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b0016b81679c1fsm11437971plb.216.2022.09.26.09.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 09:52:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com>
References:
 <870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com>
Subject: Re: mptcp: update misleading comments.: Tests Results
Message-ID: <124c4d58-ad4d-9587-627b-4c56ce14df44@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Sep 2022 16:51:58 +0000
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
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6420352380174336
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6420352380174336/su=
mmary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5012977496621056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5012977496621056/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d9dfe29d53ec


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
