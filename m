Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37962258B
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 17:29:50 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id v12so7536669edc.10
        for <mptcp@lists.linux.dev>; Wed, 06 Jul 2022 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Aoah2ndbF6Inska83dQTY/AX2sAew3cQ6wtm8S3FPiY=;
        b=zh/fSY/EMcGfVDjGB5uBuz7CFsXaSePsjVZ8fguokfUQ5OvQ3KGFmJQ4ci4+LVNfpK
         9+qAIA2MwrOI/SXmRJmMg23hvdY6VJIWlRM67UpyUXClOWaN/jTXyrGsE7YTunBHb3a/
         w9nQQJvas/EQP/BlACTR0YQ/jk1UjvnvP3bFDVOg6G1Kog9mbAwHK61iFL0JEa/BKkHz
         Z2yrcBPJyRRH75Eq6GsGX/v7MaqzCsF5TJv8VO1T3by1Ygdwko7KX8n7SA3l92e3AN3/
         fhGaLyD5UYnelpek4NmNaPzsNwMQIT1/Q527NyQi4Snp0FfBMmsRJ8aEJZ1IWd/Uzsq2
         oz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Aoah2ndbF6Inska83dQTY/AX2sAew3cQ6wtm8S3FPiY=;
        b=AdWYzUe7zySPFRPAp3WU9ItTyDBAqWyYwOIsqPa5s2hGq9yDP4v9wgQQVtpnmjzRTR
         53nnLcSf1VTuHM1W0pfRs0zRg1LgYd4LUrt/PbTBpvUXfRvAxI11yA/BM6lG3xRLh3rc
         8Gp7U1z6V3P60qSCkNbh3wnkFSTRA24bQElyaBWesZYbSJhEztFvH0EY3teuxvlsGYWp
         yFGi48wPqOaDS+a/hAbczvycpbkVkI8cJCTtlk2PbthNX3G0Nxf33gtdhBICjMeuVEOo
         t9t1jWKAUt+8i/UgZ0G8rfh1FNDCFsTb57duVLVjckFAzT2IrOcVzfwh8/VUOGa9Qbb4
         H1zw==
X-Gm-Message-State: AJIora+hvZKZBQ0RNPzGT59mJ5KiKRoyaK2VtapCbbBo2GTbtgHZQchL
	RZA0O6fxWDPrZJqaIatKs5mzny1UwsD1H06n
X-Google-Smtp-Source: AGRyM1tgsvh9hydXJchZ7rLZKi+AUDqp4DpRAF+ImGwviLPOVtwT5yw8HLsVzEbKNqKpiQUAMqw06g==
X-Received: by 2002:a05:6402:ea2:b0:43a:1278:533c with SMTP id h34-20020a0564020ea200b0043a1278533cmr30014381eda.77.1657128588246;
        Wed, 06 Jul 2022 10:29:48 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c688:fc49:57d7:6b4c? ([2a02:578:8593:1200:c688:fc49:57d7:6b4c])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709063b9100b006f3ef214e13sm17519558ejf.121.2022.07.06.10.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 10:29:47 -0700 (PDT)
Message-ID: <d6d93478-0f29-bb3c-65e6-c40452466b59@tessares.net>
Date: Wed, 6 Jul 2022 19:29:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-next] selftests: mptcp: validate userspace PM tests
 by default
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20220706091706.2679400-1-matthieu.baerts@tessares.net>
 <87fe9b3b-99c8-7529-27a6-89f0e5f1f7ef@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <87fe9b3b-99c8-7529-27a6-89f0e5f1f7ef@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 06/07/2022 19:18, Mat Martineau wrote:
> On Wed, 6 Jul 2022, Matthieu Baerts wrote:
> 
>> The new script was not listed in the programs to test.
>>
>> By concequence, some CIs running MPTCP selftests were not validating
>> these new tests. Note that MPTCP CI was validating it as it executes all
>> .sh scripts from 'tools/testing/selftests/net/mptcp' directory.
>>
>> Fixes: 259a834fadda ("selftests: mptcp: functional tests for the
>> userspace PM type")
>> Reported-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> tools/testing/selftests/net/mptcp/Makefile | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/Makefile
>> b/tools/testing/selftests/net/mptcp/Makefile
>> index f905d5358e68..48a99e1453e1 100644
>> --- a/tools/testing/selftests/net/mptcp/Makefile
>> +++ b/tools/testing/selftests/net/mptcp/Makefile
>> @@ -6,7 +6,7 @@ KSFT_KHDR_INSTALL := 1
>> CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include
>> $(KHDR_INCLUDES)
>>
>> TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
>> -          simult_flows.sh mptcp_sockopt.sh
>> +          simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
>>
>> TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
>>
>> -- 
>> 2.36.1
> 
> Thanks for quickly acting on Jakub's note. Might end up sending this for
> -net too. I don't think it should conflict so where you put it in the
> export branch probably doesn't matter too much.

Good catch, sorry I forgot to change the tag to mptcp-net. This is
indeed for the -net branch.

> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the review!

Now in our tree (fix for -net) with Mat's RvB tag:

New patches for t/upstream-net:
- 31cbb91049dd: selftests: mptcp: validate userspace PM tests by default
- Results: 521c161b5a7b..13cf255865b4 (export-net)

New patches for t/upstream:
- 31cbb91049dd: selftests: mptcp: validate userspace PM tests by default
- Results: 16136c6f92f3..6f160bf9e599 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220706T172635
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220706T172635

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
