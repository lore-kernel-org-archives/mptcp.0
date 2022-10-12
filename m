Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45758F6C
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 10:13:27 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id y5so25052621lfl.4
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmlFFA0I7oWtVezwuth/y8OmQpu5ntKK2uOusMu9Mf4=;
        b=OLPwC7gGCiCoa5Ipn9K+nAQQIVrLnYqvke3Lqqm0b4JyBUJD6hrOjr6ADp7Q1hxvWU
         2adtaSV9rjJ+iVkMqhttDuSgT+DnNFOwuZtDBYv/y0UHGbm7+0q4/S7R0YztSaaeWiOO
         JEZ6vcublx/a3ZHcCLmqOitPise1IS4dJsJK2kRpKSJaCrP3OpaUEwkvrCQjJ1AgkxPA
         6g+9GuhRhOv1EIOwROdC3hiD5s1CRzpEU1UtCT/P5vH258GNz4OuSWn4X8WAKe6f/z1q
         lJg37zPdgolNSNDJfhrggCFRgKv6S8dSEUB4iZHbi3Bz/i6L3Q2wtD5tMiLgEfie1nwE
         +SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmlFFA0I7oWtVezwuth/y8OmQpu5ntKK2uOusMu9Mf4=;
        b=k9CZ4PoHVIdj5i7pygi9Fbh5aRpU4kANJsQHXVOmTs5L8shvRHXdPDrVGPfMjMHBjN
         htLe8hxUNdYdRDiCI/TU5xKlamCvVN9dWDmInGkbJJosj1DNrFcjKpKWlEi8lXDw380C
         UZqTc5rvr4zrqrTKwOfzXgqFTgoXjwjBv8SwWmsCxYrd/Y+/4rPd3zsHAqHyP4ic51qG
         fh4N7Znsyeyc3aEu0U/JTLq72gzWmah6t8r8wyRW72H+TTV6bMm5qbQey6awjgN7xk4/
         QD0WQKFRcK3ltxIoedDxNS6zXeuJz4gI00UU7xZNiQSnptRrFIpm42Xa3ruQMhte24PC
         ZvQA==
X-Gm-Message-State: ACrzQf23tdfQxathQSN6hNvrq7h9SuQqMaIpjCG5uY9wYZ3ITteGqn0r
	hGaI9rJJYPoRByn/6sPlgunKdGUB4pn6/4EavHk=
X-Google-Smtp-Source: AMsMyM7cnANgj6mWt/WY0RUiEfto/q450OQVNAdfMNhv0wVaQ1AJDYh3++2ew3A4N0G/mDvmtL8X06ZPznW08/FZnKM=
X-Received: by 2002:a19:f812:0:b0:4a4:1c92:2736 with SMTP id
 a18-20020a19f812000000b004a41c922736mr5454313lff.441.1665569605541; Wed, 12
 Oct 2022 03:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221007092922.13169-1-imagedong@tencent.com> <95cb50a4-e50c-3b02-a521-24c2d11341de@linux.intel.com>
 <b3346c1f-5934-4c97-e65e-c0983f9e45ae@tessares.net>
In-Reply-To: <b3346c1f-5934-4c97-e65e-c0983f9e45ae@tessares.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 12 Oct 2022 18:13:13 +0800
Message-ID: <CADxym3a0Cb2HwkFeQ_=w5fNBGa+WwoUumW3HMFJJAXmgkbFjAQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 0/3] mptcp: add statistics for mptcp socket
 in use
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2022 at 5:29 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Menglong, Mat,
>
> On 12/10/2022 02:53, Mat Martineau wrote:
> > On Fri, 7 Oct 2022, menglong8.dong@gmail.com wrote:
> >
> >> From: Menglong Dong <imagedong@tencent.com>
> >>
> >> In the 1th patch, we do some code cleanup with replease 'sock->sk'
> >> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
> >> use. And in the 3th patch, we add the testing for this commit.
> >>
> >
> > I think v5 looks ok for the export branch - we can get more test
> > coverage there and update if needed.
> >
> > Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
> Thank you for the patch and the review!
>
> I was going to apply it but I just noticed our public CI complained
> about the new test during its second test:
>
>
>  KVM Validation: debug:
>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join =F0=9F=
=94=B4:
>   - Task: https://cirrus-ci.com/task/6538547548127232
>   - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/6538547548127232/summary/summa=
ry.txt
>
>
> The useful bit:
>
> ----------------------- 8< -----------------------
> not ok 1 test: selftest_diag.tap # exit=3D7
> # no msk on netns creation                          [  ok  ]
> # listen match for dport 10000                      [  ok  ]
> # listen match for sport 10000                      [  ok  ]
> # listen match for saddr and sport                  [  ok  ]
> # all listen sockets                                [  ok  ]
> # after MPC handshake                               [  ok  ]
> # ....chk remote_key                                [  ok  ]
> # ....chk no fallback                               [  ok  ]
> # msk in use statistics                             [  ok  ]
> # msk in use statistics                             [  ok  ]
> # check fallback                                    [  ok  ]
> # many msk socket present                           [  ok  ]
> # msk in use statistics                             [ fail ] expected
> 249 found 248
> # msk in use statistics                             [  ok  ]
> ----------------------- 8< -----------------------
>
> Do you mind looking at that please?
>
>
> Please note that the public CI is known to be slow. Here it was failing
> with a debug kernel config (KASAN, KMEMLEAK, etc. see
> kernel/configs/debug.config file)
>
> If you want to reproduce it in closer conditions, you can do something
> like this to build the same kernel and run diag.sh in a loop until it fai=
ls:
>

Hello,

Seems there is something wrong with the self test that
I added. Maybe it needs some sleep between flush_pids
and chk_msk_fallback_nr().

>   $ cd [kernel source code]
>   $ echo "run_loop run_selftest_one ./diag.sh" > .virtme-exec-run
>   $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>       --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>       auto-debug
>

Thanks for the command, I'll try to reproduce and solve
it.

Menglong Dong

> For more details:
>
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
>
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
