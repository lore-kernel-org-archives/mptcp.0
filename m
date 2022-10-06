Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB04681
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 17:31:13 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id c7so2418476pgt.11
        for <mptcp@lists.linux.dev>; Thu, 06 Oct 2022 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=3Yd8iUhPLd3HsZtTF7wUyiwcKaBoIvATThEzpbp6oJY=;
        b=DwOYqyNFuLvCvipFVRAcqEl0g2fGGPbGa6KkmkcODA0FMZ/7NHXEA4XVBgJrpgWNVd
         m2QctB760+gmR0uxb0o1C91/MyfktbWo9SYDkA5+oa8c3jRoa8TXGu8dcqstd438VPLz
         iG4hq7PIqRoUBBF+voX+FqXD3E2rBzrujmuB6ZiEHB7DGvrIuWd/AkdFYLY0RQB962/H
         MRW8LO0kNsIbrANh9gOsr9jhIq9c76eI8lkCMsJOqEe74fguS/SSo+xWQY/T42Q/SVmM
         cU95j202jGWOqdGfcWKigFsfDLbTZnGkzbP37y8rlbvDdblao324J2tD9+bx9eGStoci
         gb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=3Yd8iUhPLd3HsZtTF7wUyiwcKaBoIvATThEzpbp6oJY=;
        b=WoACiO6bn2P3vvADk70vm7gd8iPHlDuvCwaTa8pU2YIct8XypEx9tAduHJeEmz6AkO
         kgHaG8gIntDmbZ8kTj3huY2Rn7GK6vgTXZ8FUR6MmBpi5FJsWRm4nImo0LEX+pLw/2Fn
         Pq5gkIgKqbkT5PUL8TlL8XNq44yxBTB93VXe+WcpoWrxAHRw0/HwKgdx0lbP84Cletlu
         J8HfoBdxyPLrHLdnXWfJD+i/3ZpACH+kH+1Dwxka4d1iChFuf+kKfCPijZaI0GGgauwd
         lH+0x1CPAhTFXSxT/d12W/D1V9v4zr0n2vtmYt3WrCn8AWqdGIH7RXVYw52ZygvXC7YJ
         hVkw==
X-Gm-Message-State: ACrzQf2b9ML4Eema68kuHYCeQp707PIn+QPVG9v5+KoOwqMJ0ZAw9GEM
	OeMI7+I2/ko492ormaiOAH/MqCPxqnZx
X-Google-Smtp-Source: AMsMyM4qIAEojcMeQkspbNZuAGsUZhM6OiVPBtPEsyK+Wt+bYBkRmzGCznCTipwUqVeVZS2XhPWi6g==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr546784pfi.84.1665077472559;
        Thu, 06 Oct 2022 10:31:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.103.135])
        by smtp.gmail.com with ESMTPSA id f16-20020aa79690000000b00562303ff59dsm3615646pfk.48.2022.10.06.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:31:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <87648dd3192ed4fff140ba9767f7afe7d77d9021.1664547250.git.geliang.tang@suse.com>
References:
 <87648dd3192ed4fff140ba9767f7afe7d77d9021.1664547250.git.geliang.tang@suse.com>
Subject: Re: mptcp: simplify __mptcp_subflow_push_pending: Tests Results
Message-ID: <a97f157e-b7e3-9ea3-b746-c1d6f50d2976@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Oct 2022 17:31:11 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5589049061670912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5589049061670912/summary/summary.txt

- KVM Validation: debug:
  - Critical: 108 Call Trace(s) - Critical: Global=
 Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6714948968513536
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6714948968513536/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1e73e81ed3b5


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
