Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB413AC3
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 17:53:19 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51d9865b8a2so1067294a12.3
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688061198; x=1690653198;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0KGin8P8UzYHrXYBMI1TPdIZpCpfDKKBy+hYnlPAPs=;
        b=cRBzjDWpc3CXqZXyO6hu7pqs18O90f3zaE/AGHmcIbWPCw2GvtaNMBWmGgm3wINE4b
         QaTMcAjEnwNFYJKnA5R9EThsBJLa8wuqbxQMTYOw7vU1DWd8AQptIYk4ayY6drX9Phta
         tFtgFDI3cBD6ctvedlt2efoF8pNbjAp8InLdy1l6SO5rMFCD13TRz+Np8wmlWRWiQc9H
         kXi70pzrJmQ4wzaayLbrNWmgoo61wk/vito5tk/6eYMV2jeaB1f4YsgI1+VozKjYCzeY
         umrsTYYVRSEySY7/0B9dAup12JeRIQ3C4SyF2IPJVEMvfVJ+sZBCL1PKcn9jYk8LMQzU
         UY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688061198; x=1690653198;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0KGin8P8UzYHrXYBMI1TPdIZpCpfDKKBy+hYnlPAPs=;
        b=dJjGA9znJeA3MpTpVZeioAfntJsi2cXHdo5dRRMRq9q9CdQiBzY12y0M+a6ngcJYlw
         OUUcGAL6YI0Be6OCr/s3FriT8yTydEmu9ZPAA9iS7CRFTMgKYXa/fGffaS+plRoQ1NdB
         QqwvTNCWXI0VaTBiMF4MqvA4pc+3UxUAdjAnFrlkXlpHEo1lbyQiQYbkh8ND4B+HBiWg
         vl0cd2YjR8Iyyn6oXA6OLpmfzNBttqoxXCUEKfb/iC+/AhDHJMuGrzr32eDbkV2/3aN2
         LCtkxeoojKvOavEO0i3uwCW2SYrpiCO1ZochQzSwJQh2UAX3uTa/ZuXJJF9JZ3Wac5vd
         1DLg==
X-Gm-Message-State: ABy/qLZ+Fyx8yISbMOaUE8ypmPDsZyl83mNRERxrSQOpmXtUkHe9riO/
	MYY8ndz+ltxqtABax6hoioeMW1llw6/XisMMlhYImMLi
X-Google-Smtp-Source: APBJJlFGH5UypUdQxERI0jUmFz51fqpSmykcuTLw6FtI/XutedhwCS+fCkrWOy63RtAHid7hL1Tgbg==
X-Received: by 2002:aa7:d31a:0:b0:51d:d30c:f1e3 with SMTP id p26-20020aa7d31a000000b0051dd30cf1e3mr1676edq.16.1688061198205;
        Thu, 29 Jun 2023 10:53:18 -0700 (PDT)
Received: from [10.120.18.108] ([84.17.46.13])
        by smtp.gmail.com with ESMTPSA id t4-20020a05640203c400b0051ded17b30bsm36910edw.40.2023.06.29.10.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 10:53:17 -0700 (PDT)
Message-ID: <6dd48ce6-0673-9778-83fb-f5992e1876ba@tessares.net>
Date: Thu, 29 Jun 2023 19:53:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 1/4] selftests: mptcp: reset all the env vars
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1688045383.git.geliang.tang@suse.com>
 <b0879a1289735ff45305ec2a7d159666b7b5219e.1688045383.git.geliang.tang@suse.com>
 <833abcfe-9639-7bf4-49f3-ddc301268a62@tessares.net>
In-Reply-To: <833abcfe-9639-7bf4-49f3-ddc301268a62@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/06/2023 19:48, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for looking at that!
> 
> On 29/06/2023 15:34, Geliang Tang wrote:
>> It's better to clear all the env vars in init_partial(), to let them be
>> reset before runing the next test.
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index e6c9d5451c5b..b80c5e7b5a7b 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -101,6 +101,10 @@ init_partial()
>>  	check_invert=0
>>  	validate_checksum=$checksum
>>  	FAILING_LINKS=""
>> +	test_linkfail=0
>> +	addr_nr_ns1=0
>> +	addr_nr_ns2=0
>> +	sflags=""
> 
> I think it would be better to move the declaration of these variables to
> do_transfer() (or run_tests()) instead of exporting them at the
> beginning of the file, no?
> 
> You could do something like:
> 
>   local test_linkfail=${test_linkfail:-0}
> 
> So by default, it will have the value 0. But if you do
> 
>   tests_linkfail=3 \
>       run_tests (...)
> 
> It will have the value 3 just for this test. WDYT?
> 
> It looks better than defining the variables globally and resetting them
> elsewhere.

I forgot to say that apart from that (and it is also valid for the new
variables you add in the other patches and even FAILING_LINKS (and maybe
others)), the other modifications you did look good!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
