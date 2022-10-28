Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E294C1C17
	for <mptcp@lists.linux.dev>; Fri, 28 Oct 2022 03:18:18 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id d6so6177965lfs.10
        for <mptcp@lists.linux.dev>; Thu, 27 Oct 2022 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0JNxXqFGbD+NdAWIeQTIJKzoNC6cQWx/Pw8zFxTfh0=;
        b=pRq/Y4nO69E+odJuf31YTkIeUuTVqXREKbFy1RBsSZBH3zfOFLTJoPExe4SzJhkIdM
         GzrF5aDWU4EdQnWC8RMPW3TJMJZgw4sDNrWmzTyhzrlxMxALXuHvc+mjQJXY36jSbfof
         3Zx1wfyuxAPZ0F6OpofzmZbiu1Y49Dqlg7zMrUuPoW4fzt9hS13uJDZ0t7/d0kbXPCRE
         cqHYZTFPvYgripFjnwsrqbLvQMnUrRoTKIZYYSOa7q1Zq563k2phQW153tJio2aDwioM
         oCvoQ+RyZy/JQ5fqm8uZiWOq5y5N5io+H+f8w4GLECKYLSFwPsitPEFEioZarB1kfDxl
         0h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0JNxXqFGbD+NdAWIeQTIJKzoNC6cQWx/Pw8zFxTfh0=;
        b=zCLFNqovuhFakXns3bu6C0EBN2L2jDWDzVUPQtz1vr8uXQjO+iBF8xCegD89Ye4nS9
         t8Y/tq4eTGLZNM5dnhZGq0aOzzXUDC7WI3LR8uIWQxl9QeHpx1xIz18MgCISEitvUfi6
         DbxtVJ0pUyTIcrqs6Glh5yjVzF/vhhvgU/OGQh4Lat5171Be48IcE8u8zkl0VEAwf6lY
         6MJ/kdVpaTlI5RagqwJKVtavGtrSf/KqSwUhTsWdAIdb0OD/qmENp9c1cflSQSqbePMm
         0YR64MAu/dyyuouG2FaEAhMazrCiD3ibFJlV7fxgVeYhbun9YuayyJddqNTharmgbeRD
         FFhg==
X-Gm-Message-State: ACrzQf1geZvMIhQpJuPENKZdBmzuc4KkSucADLEcARVlpMYuu3EKCH4b
	sCh77pdosGdLcrmj/LO+QPpEQU2zDRgTdqO4MXY=
X-Google-Smtp-Source: AMsMyM4MqdTorACbBUBYSsJJLkwh3fXEapjzHHfg3oGVrOhUL+9xBjgna52DCiSQHZtigMZIM6luuIirCsMM2lyVhjQ=
X-Received: by 2002:a05:6512:2290:b0:4a2:aa4d:b281 with SMTP id
 f16-20020a056512229000b004a2aa4db281mr21740554lfu.616.1666927096663; Thu, 27
 Oct 2022 20:18:16 -0700 (PDT)
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
Date: Fri, 28 Oct 2022 11:18:04 +0800
Message-ID: <CADxym3YDfLuOjMUkUCEF-29YsXVJHGgB3PVkrC=o8vb3HWw8gg@mail.gmail.com>
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

Hello,

With the test command on my computer, the 'many msk socket present'
always fails, and bellow is the log:

# no msk on netns creation                          [  ok  ]
# listen match for dport 10000                      [  ok  ]
# listen match for sport 10000                      [  ok  ]
# listen match for saddr and sport                  [  ok  ]
# all listen sockets                                [  ok  ]
# after MPC handshake                               [  ok  ]
# ....chk remote_key                                [  ok  ]
# ....chk no fallback                               [  ok  ]
# msk in use statistics                             [  ok  ]
# msk in use statistics                             [  ok  ]
# check fallback                                    [  ok  ]
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# main_loop_s: timed out
# main_loop_s: timed out
# main_loop_s: timed out
# main_loop_s: timed out
# main_loop_s: timed out
# main_loop_s: timed out
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# connect(): Connection refused
# many msk socket present                           [ fail ] timeout
while expecting 200 max 0 last 0
# msk in use statistics                             [ fail ] expected
201 found 0
# msk in use statistics                             [  ok  ]

Do you have any ideas?

I suspect the failure in your tests has something to do with the '+1'
in 'chk_msk_inuse $((NR_CLIENTS*2+1))'. I add the '+1' as I find
that the 'mptcp_connect' with '-r' won't exit after flush_pids(),
until the second flush_pids(). I'm sure if this opinion is right.

Thanks!
Menglong Dong

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
>   $ cd [kernel source code]
>   $ echo "run_loop run_selftest_one ./diag.sh" > .virtme-exec-run
>   $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>       --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>       auto-debug
>
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
