Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50722C82
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 10:36:43 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id e9so9287846wra.2
        for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 02:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NXZynFAC+ISRHWr7h+g/73of3AzMsGNlt7Oz+6ZpLok=;
        b=3kxPFE6gVs4F0kyFK5RUXtel7YOeg00wRO2AhvUltcfV7i/6+L4UFwDDNB4OFJGtLM
         1tNWcdzaMPk7FhoZzTPoyvjK2fo2a1PtSXUfmgZ+jEZrxd9+y/xdz22iezO3c1tXZSuo
         WOOZYNPOLxp4PdY64iSWnWJLvwMj/LdfCIXdnjD2gy6AI+pwFzMxFpEQ4TMq3pEahmBj
         trvDaP9HaZdQKrNM6ycJ7Wn9k0GdIEsQ9OH2ahMtbpNlQFBIJxcldjcn5Dr4Lycuxyf2
         +aGP1O3+xVLhEG/0LH9WUh6spV69DZYAhnERlEeHveC4Ic909B8kTTyiM1L5WrsTfkkz
         twAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NXZynFAC+ISRHWr7h+g/73of3AzMsGNlt7Oz+6ZpLok=;
        b=TrZakg3VA0gsUdKqW3A9+qwcNplC7dxP6XpK1v6SscXPgQfdSao/vQJyeJoNElAW3c
         iPChyrRrqLqAsKOycmvSiAKDRosniOziuwsQ2foAHjtRhaCJhjQ7Z+aJOedmvqIgGpsb
         wkJrtz6mixG8REHu7HEwTHKpHqYkvxRTf7+fO/+8OKkTaFqVysivHBNhk7Ihmj8+eQMT
         gmA4I9FKVpV44d4dbWSIi7oo2tVgX2oYAabfndG1GmcEdBRuFf9QAB+O2uYn6Qh1OL4x
         idUBLCoxrwXXqq5LlBDctTx7dinsqujh62lcFREiGfIcpJf5Xjgpj+Ep/mwNIJ01W2yU
         VBuQ==
X-Gm-Message-State: AOAM5335qai52JEXtd74VXXOvPMYb0UpFlMO4Gfgt/k25Y+UfFfz/lsS
	brRh0QTl07absHbVY0sSJpy2D1vCAA1Ziw==
X-Google-Smtp-Source: ABdhPJw2FmhDpoXd4KVNLUCUJ6gEo0hAw6WrY4mIXTJ2S12DNzobvr+8j+PcQK52UdOQ4BVmeLqZ1w==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr3476357wrs.534.1642070201919;
        Thu, 13 Jan 2022 02:36:41 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id a18sm2183679wrf.42.2022.01.13.02.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 02:36:41 -0800 (PST)
Message-ID: <8d549123-341e-c037-0313-8c1380807b21@tessares.net>
Date: Thu, 13 Jan 2022 11:36:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v9 5/5] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
References: <cover.1641804767.git.geliang.tang@suse.com>
 <a0f7ec766ca99a5f2e2aa27a358f45fc06f6cc78.1641804767.git.geliang.tang@suse.com>
 <ea44a519-11b9-175-cceb-abb69232abbd@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ea44a519-11b9-175-cceb-abb69232abbd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 13/01/2022 02:06, Mat Martineau wrote:
> On Mon, 10 Jan 2022, Geliang Tang wrote:
> 
>> Added the test cases for MP_FAIL, use 'tc' command to trigger the
>> checksum failure.
>>
>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
>> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>> tools/testing/selftests/net/mptcp/config      |   5 +
>> .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
>> 2 files changed, 107 insertions(+), 9 deletions(-)
>>
> 
> Does anyone else see the "leaked reference" errors when running these
> fail tests with the latest export branch? Looks like the reference
> tracker finds a tc-related error:
> 
> [  238.871372] leaked reference.
> [  238.872393]  fl_change+0x2db/0x2520
> [  238.873148]  tc_new_tfilter+0x6c4/0x11f0
> [  238.873959]  rtnetlink_rcv_msg+0x49f/0x640
> [  238.874798]  netlink_rcv_skb+0xc4/0x1f0
> [  238.875570]  netlink_unicast+0x2d5/0x410
> [  238.876364]  netlink_sendmsg+0x3b3/0x6c0
> [  238.877155]  sock_sendmsg+0x91/0xa0
> [  238.877890]  ____sys_sendmsg+0x3ad/0x3f0
> [  238.878684]  ___sys_sendmsg+0xdb/0x140
> [  238.879354]  __sys_sendmsg+0xae/0x120
> [  238.879947]  do_syscall_64+0x3b/0x90
> [  238.880683]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> It doesn't look like MPTCP is to blame, but I'm curious if others see
> the same.

The public CI didn't report that:

  https://api.cirrus-ci.com/v1/task/5851145250799616/logs/test.log

We can see a lot of TC warnings that still need to be fixed:

  tc action pedit offset 162 out of bounds

I guess we need to change the test to send data mainly in one direction
to avoid all these pure ACKs causing issues with the TC filter and
probably causing the corresponding test to fail.

For more details about the results from the CI:

===== 8< =====
Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/4725245343956992
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/4725245343956992/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/5851145250799616
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5851145250799616/summary/summary.txt

Initiator: Patchew Applier
Commits:
https://github.com/multipath-tcp/mptcp_net-next/commits/274e87003fe5
===== 8< =====

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
