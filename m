Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB77E
	for <mptcp@lists.linux.dev>; Tue,  1 Nov 2022 11:54:58 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id j16so23190210lfe.12
        for <mptcp@lists.linux.dev>; Tue, 01 Nov 2022 04:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NIMftf3sRNdYqM5SNRz4VVFBYBtZ/YYPJB4+EamxaKc=;
        b=dQGHNEkA/VRtufzjbAnxC12v4gYGxi5miSJMCQaDegO13jz7WPvDpk67VfesW2S3MP
         msZIk3s/yJZ6g2UL5WvYA41Vgi/FuY/wp0i3vOrkIEr5t8KI1rG7rIQMjTcgr66czHhE
         yE8bzGc8wn+RdxVqufzbmixBsnOsyZ4PbsVtRruFWZYxvngRILQBJ1rkoBpyEYLr5DpG
         eIuCdthHES0umti1De89fOxv/9m5FI00YE11f3A5/A8PRoMf08jPivjc00IFk6hKxcW4
         cVkfmXItPhhQqyu2Q7bTdGd0e7zLxHb1JX5zl8HRhejvDPE3Y0E7DVYrx6b6+q8cDnqk
         D+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIMftf3sRNdYqM5SNRz4VVFBYBtZ/YYPJB4+EamxaKc=;
        b=bGM16l5bnEKbJ2Z/TzQUU031/iAssXjYpF54KVS8RwwnTx6HykeSyOC8E1wsfcWYaY
         YTAFLeZSxu5T1dQ5VeKV+IrayUY7gk2rpK5YshSX/owjhqloIWvloFyj8d0ncFu7Pehg
         P1jA5zTmkYDWXy5C9AT3tQM+W8Oxka/D1QRO50DlymWMbGeRdyNmJOGl2BP2jyrbehzD
         0olO/47Xq/bJVHowRhVuRCs3lPhoLCY+kMUysyV+a2uafFfcnImxpV4lWX0ZABcS7Kw9
         F8BFZDZF35V9HAJQGJo+/4QbRcOZaTbU73vPVqs/aY+n6jA3S084T1mrnFSnim9pzROl
         mzXQ==
X-Gm-Message-State: ACrzQf3fliuQbdUtiDPpOc3Ir/h9iw9Tlqywi7LmuM2kiJdSC3hqqwIQ
	MNOFcsJtXD34cl+7XG4MULQvvvdkI4UK1oarKs4=
X-Google-Smtp-Source: AMsMyM6ATGsFokTiJJxa55B9tADmQzmiLlkeUUtRKqIhteb/LfCsTz3o3cARG1m2+AHclbFANQE5TYqyK+bWtLgXX/o=
X-Received: by 2002:a19:5e5b:0:b0:4b0:2b8e:8a59 with SMTP id
 z27-20020a195e5b000000b004b02b8e8a59mr7785373lfi.161.1667303696511; Tue, 01
 Nov 2022 04:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221007092922.13169-1-imagedong@tencent.com> <95cb50a4-e50c-3b02-a521-24c2d11341de@linux.intel.com>
 <b3346c1f-5934-4c97-e65e-c0983f9e45ae@tessares.net> <CADxym3YDfLuOjMUkUCEF-29YsXVJHGgB3PVkrC=o8vb3HWw8gg@mail.gmail.com>
 <b3f3c01e-4010-d5ce-970d-394711bcd0e1@tessares.net>
In-Reply-To: <b3f3c01e-4010-d5ce-970d-394711bcd0e1@tessares.net>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 1 Nov 2022 19:54:44 +0800
Message-ID: <CADxym3a9cAmG+UN-hWRyzGzMYt8JA5RWKCL94Jq=P49unbu9qg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 0/3] mptcp: add statistics for mptcp socket
 in use
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 1, 2022 at 1:07 AM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Menglong,
>
> On 28/10/2022 05:18, Menglong Dong wrote:
> > On Wed, Oct 12, 2022 at 5:29 PM Matthieu Baerts
> > <matthieu.baerts@tessares.net> wrote:
> >>
> >> Hi Menglong, Mat,
> >>
> >> On 12/10/2022 02:53, Mat Martineau wrote:
> >>> On Fri, 7 Oct 2022, menglong8.dong@gmail.com wrote:
> >>>
> >>>> From: Menglong Dong <imagedong@tencent.com>
> >>>>
> >>>> In the 1th patch, we do some code cleanup with replease 'sock->sk'
> >>>> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
> >>>> use. And in the 3th patch, we add the testing for this commit.
> >>>>
> >>>
> >>> I think v5 looks ok for the export branch - we can get more test
> >>> coverage there and update if needed.
> >>>
> >>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> >>
> >> Thank you for the patch and the review!
> >>
> >> I was going to apply it but I just noticed our public CI complained
> >> about the new test during its second test:
>
> (...)
> >> Do you mind looking at that please?
> >
> > Hello,
> >
> > With the test command on my computer, the 'many msk socket present'
> > always fails, and bellow is the log:
> >
> > # no msk on netns creation                          [  ok  ]
> > # listen match for dport 10000                      [  ok  ]
> > # listen match for sport 10000                      [  ok  ]
> > # listen match for saddr and sport                  [  ok  ]
> > # all listen sockets                                [  ok  ]
> > # after MPC handshake                               [  ok  ]
> > # ....chk remote_key                                [  ok  ]
> > # ....chk no fallback                               [  ok  ]
> > # msk in use statistics                             [  ok  ]
> > # msk in use statistics                             [  ok  ]
> > # check fallback                                    [  ok  ]
> > # main_loop_s: timed out
> > # connect(): Connection refused
> > # main_loop_s: timed out
> > # main_loop_s: timed out
> > # connect(): Connection refused
> > # connect(): Connection refused
>
> (...)
>
> > # many msk socket present                           [ fail ] timeout
> > while expecting 200 max 0 last 0
> > # msk in use statistics                             [ fail ] expected
> > 201 found 0
> > # msk in use statistics                             [  ok  ]
> >
> > Do you have any ideas?
>
> The test "many msk socket present" creates 100 listening MPTCP sockets,
> wait maximum 1 second for them to be ready, then tries to connect to it
> and check counters reported by 'ss'.
>
> Could it be possible your environment is quite slow and it needs more
> than one second to have the 100 listening MPTCP sockets to be ready? May
> you try this patch please?
>
> -------------------- 8< --------------------
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh
> b/tools/testing/selftests/net/mptcp/diag.sh
> index 515859a5168b..72ff61f5dd99 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -150,7 +150,7 @@ wait_local_port_listen()
>         local port_hex i
>
>         port_hex="$(printf "%04X" "${port}")"
> -       for i in $(seq 10); do
> +       for i in $(seq 20); do
>                 ip netns exec "${listener_ns}" cat /proc/net/tcp | \
>                         awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ &&
> \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
>                         break
> -------------------- 8< --------------------
>
> (or even with 'seq 50')
>
>
> Or is there something limiting the number of sockets being created on
> your side? I see that you got 60 connect() errors, maybe limited to 40
> somewhere?
>

You are right, the qemu that runs the tests is quite slow on
my computer. With increasing the 'timeout_poll', '-w' that passed to
mptcp_connect, etc, finally it works.

Meanwhile, I figure out why the test failed. On a fast computer,
the mptcp_connect with the '-r' won't exit after flush_pids().
However, on a slow computer, such as qemu, it will exit out of the
'timeout' command.

>
> > I suspect the failure in your tests has something to do with the '+1'
> > in 'chk_msk_inuse $((NR_CLIENTS*2+1))'. I add the '+1' as I find
> > that the 'mptcp_connect' with '-r' won't exit after flush_pids(),
> > until the second flush_pids(). I'm sure if this opinion is right.
>
> Mmm, flush_pids() sends a 'SIGUSR1' signal to all pids but:
>
> (1) it doesn't wait for mptcp_connect processes to be finished: may you
> try with this patch please?
>
> -------------------- 8< --------------------
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh
> b/tools/testing/selftests/net/mptcp/diag.sh
> index 515859a5168b..4ad70ead3bdf 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -16,6 +16,12 @@ flush_pids()
>         sleep 1.1
>
>         ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1
> &>/dev/null
> +
> +       for _ in $(seq 10); do
> +               [ -z "$(ip netns pids "${ns}")" ] && break
> +
> +               sleep 0.1
> +       done
>  }
>
>  cleanup()
> -------------------- 8< --------------------
>
>
> (2) I think mptcp_connect might not stop in some conditions when SIGUSR1
> is received. May you try with this patch please?
>
> -------------------- 8< --------------------
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index e54653ea2ed4..596e3344d5af 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -586,7 +586,7 @@ static int copyfd_io_poll(int infd, int peerfd, int
> outfd, bool *in_closed_after
>                 char rbuf[8192];
>                 ssize_t len;
>
> -               if (fds.events == 0)
> +               if (fds.events == 0 || quit)
>                         break;
>
>                 switch (poll(&fds, 1, poll_timeout)) {
> -------------------- 8< --------------------
>
> If these fixes are needed, best to add them in (a) separated commit(s).
> I can also send them if you prefer, they are not directly related to
> your series.
>

The 'quit' is not used anywhere, which also puzzled me before.
Seems it can exit normally with the second method you raise,
plus the following:

@@ -692,7 +692,7 @@ static int copyfd_io_poll(int infd, int peerfd,
int outfd, bool *in_closed_after
        }

        /* leave some time for late join/announce */
-       if (cfg_remove)
+       if (cfg_remove && !quit)
                usleep(cfg_wait);

I'll add them in a separate commit.

Thanks!
Menglong Dong

> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
