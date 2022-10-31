Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72433C5
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 17:07:35 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso8441233wmq.1
        for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 10:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2M1IS/guLEsq4pq58Iz2HKwdUp2Kp9fvbnr+3NSisU=;
        b=KRb9zebX4/LflDIYWd6bCt01PSOb7Due+qd2GIIKKQRejZ0hYtnKW4+joNOBH2Tva5
         HPcl8e+92O4AVucy1PXZGAo3/Uh08EkSxyJtlHEBVU7kZk6KMoPuEcfPq5cWNuSPmDZ1
         bkQyeFi1vt4WMaHP/kyF1WdxuJYYT9cEZQK7gYWE9M8X6r7RzpCcbpRU7oRJv5FpuIwu
         DqeagiNQY+K9KPv/oiA9G8ikWPqk1rJlSx/HClb1ulmrYQc2NTGqD5u+741jD04jyUb8
         tzs1du4pmaQ+q8rE033p50yVrLqDvulvVXTHSuqI14LM6SVTZdHGvi/LCpGOdGG0oon2
         nseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2M1IS/guLEsq4pq58Iz2HKwdUp2Kp9fvbnr+3NSisU=;
        b=Bw3vFd4fauK4XMGnnUhF6jSJd+JRKXFiTirkbU7KDnvSBR0erCM0syXoWFu35NHl09
         dg4vlUQ/wpRW79dYUWVCXbJ6YEaqnuSNEvxEGL5RT//PY+WzROOLck63zEIOfmpCP8y0
         +2sGOEOvlqg0ryUdNsbMO+g6ln5E8sNuJbr+entmWXf3bvnUNsRYtsUF5abZztds802y
         rN7ilY5YSNX/OWP4YXNFOHDQTXdbeOWU7yaWlZcS6dNbkZvivZACaEubd9en1euIcP8m
         h+o0/DcQfTqqg4tB97tVMetzOhyECS2VN5CsX8Mz8cSwdJ3tIdzjZDhO7WuLpVzmAe2m
         lzyg==
X-Gm-Message-State: ACrzQf2VMIPYpqxhK0ZrquLs9PFXeCSYbuSC6g8tk20nI10QVYwv55ao
	YIC9E65nZq062pzmoCmth1KbeIiB2lQ7ow==
X-Google-Smtp-Source: AMsMyM65S/DnkTyX2Ds3sl+FrctC0ClkyUOuSoo4ay+BgwR5M2+APAwT53xRgMxFYYJTziyhi1zJhA==
X-Received: by 2002:a05:600c:1e2a:b0:3c8:353b:253f with SMTP id ay42-20020a05600c1e2a00b003c8353b253fmr8913864wmb.51.1667236053259;
        Mon, 31 Oct 2022 10:07:33 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id q4-20020a7bce84000000b003c6cd82596esm7677793wmj.43.2022.10.31.10.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:07:32 -0700 (PDT)
Message-ID: <b3f3c01e-4010-d5ce-970d-394711bcd0e1@tessares.net>
Date: Mon, 31 Oct 2022 18:07:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next v5 0/3] mptcp: add statistics for mptcp socket
 in use
Content-Language: en-GB
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
References: <20221007092922.13169-1-imagedong@tencent.com>
 <95cb50a4-e50c-3b02-a521-24c2d11341de@linux.intel.com>
 <b3346c1f-5934-4c97-e65e-c0983f9e45ae@tessares.net>
 <CADxym3YDfLuOjMUkUCEF-29YsXVJHGgB3PVkrC=o8vb3HWw8gg@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CADxym3YDfLuOjMUkUCEF-29YsXVJHGgB3PVkrC=o8vb3HWw8gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong,

On 28/10/2022 05:18, Menglong Dong wrote:
> On Wed, Oct 12, 2022 at 5:29 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Menglong, Mat,
>>
>> On 12/10/2022 02:53, Mat Martineau wrote:
>>> On Fri, 7 Oct 2022, menglong8.dong@gmail.com wrote:
>>>
>>>> From: Menglong Dong <imagedong@tencent.com>
>>>>
>>>> In the 1th patch, we do some code cleanup with replease 'sock->sk'
>>>> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
>>>> use. And in the 3th patch, we add the testing for this commit.
>>>>
>>>
>>> I think v5 looks ok for the export branch - we can get more test
>>> coverage there and update if needed.
>>>
>>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>
>> Thank you for the patch and the review!
>>
>> I was going to apply it but I just noticed our public CI complained
>> about the new test during its second test:

(...)
>> Do you mind looking at that please?
> 
> Hello,
> 
> With the test command on my computer, the 'many msk socket present'
> always fails, and bellow is the log:
> 
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
> # main_loop_s: timed out
> # connect(): Connection refused
> # main_loop_s: timed out
> # main_loop_s: timed out
> # connect(): Connection refused
> # connect(): Connection refused

(...)

> # many msk socket present                           [ fail ] timeout
> while expecting 200 max 0 last 0
> # msk in use statistics                             [ fail ] expected
> 201 found 0
> # msk in use statistics                             [  ok  ]
> 
> Do you have any ideas?

The test "many msk socket present" creates 100 listening MPTCP sockets,
wait maximum 1 second for them to be ready, then tries to connect to it
and check counters reported by 'ss'.

Could it be possible your environment is quite slow and it needs more
than one second to have the 100 listening MPTCP sockets to be ready? May
you try this patch please?

-------------------- 8< --------------------
diff --git a/tools/testing/selftests/net/mptcp/diag.sh
b/tools/testing/selftests/net/mptcp/diag.sh
index 515859a5168b..72ff61f5dd99 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -150,7 +150,7 @@ wait_local_port_listen()
        local port_hex i

        port_hex="$(printf "%04X" "${port}")"
-       for i in $(seq 10); do
+       for i in $(seq 20); do
                ip netns exec "${listener_ns}" cat /proc/net/tcp | \
                        awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ &&
\$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
                        break
-------------------- 8< --------------------

(or even with 'seq 50')


Or is there something limiting the number of sockets being created on
your side? I see that you got 60 connect() errors, maybe limited to 40
somewhere?


> I suspect the failure in your tests has something to do with the '+1'
> in 'chk_msk_inuse $((NR_CLIENTS*2+1))'. I add the '+1' as I find
> that the 'mptcp_connect' with '-r' won't exit after flush_pids(),
> until the second flush_pids(). I'm sure if this opinion is right.

Mmm, flush_pids() sends a 'SIGUSR1' signal to all pids but:

(1) it doesn't wait for mptcp_connect processes to be finished: may you
try with this patch please?

-------------------- 8< --------------------
diff --git a/tools/testing/selftests/net/mptcp/diag.sh
b/tools/testing/selftests/net/mptcp/diag.sh
index 515859a5168b..4ad70ead3bdf 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -16,6 +16,12 @@ flush_pids()
        sleep 1.1

        ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1
&>/dev/null
+
+       for _ in $(seq 10); do
+               [ -z "$(ip netns pids "${ns}")" ] && break
+
+               sleep 0.1
+       done
 }

 cleanup()
-------------------- 8< --------------------


(2) I think mptcp_connect might not stop in some conditions when SIGUSR1
is received. May you try with this patch please?

-------------------- 8< --------------------
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index e54653ea2ed4..596e3344d5af 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -586,7 +586,7 @@ static int copyfd_io_poll(int infd, int peerfd, int
outfd, bool *in_closed_after
                char rbuf[8192];
                ssize_t len;

-               if (fds.events == 0)
+               if (fds.events == 0 || quit)
                        break;

                switch (poll(&fds, 1, poll_timeout)) {
-------------------- 8< --------------------

If these fixes are needed, best to add them in (a) separated commit(s).
I can also send them if you prefer, they are not directly related to
your series.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
