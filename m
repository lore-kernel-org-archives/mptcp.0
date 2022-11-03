Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA66FD6
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 13:51:49 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id bk15so2822267wrb.13
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOTytAqe6igfoMs/zSwPDVKmi9bS6Wj3Hy1i6TxhTaw=;
        b=gfG9/uE9BDj4i+CNlmrsgCm+zftwCk4KrNwLL8SoRhjEBqMK76bFbzLtgClkmKHrXq
         oiQ/3f9XGTettAX63URT99nNpz6KAkkFRsaNWbcX9FlYUguH6Ri2bbm5Az4IP7zCDDBV
         ejhx4BPwq87RZng1g4gxkVPstMjjdniKnD48Uy2Ppv81ERXeh2Ul0BRhbo7G2ddDbD1c
         +0q7PkJl0P2qlos5ciRn5K7CeHFZ2ZCIliJNUkFIYv0NXMtqfLlGOiL84aYKuyeo/TyJ
         HwbgbmVGlMbtaMY9Okm/BLHFgu1beyxvAT3t5LRTK7ynKyR3fkYg5inxp+qbqnKBpYPZ
         pnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOTytAqe6igfoMs/zSwPDVKmi9bS6Wj3Hy1i6TxhTaw=;
        b=xjofWn/bSxUksQFgi4MADIoEaAETYa54yqxSfr6XFnMrBxQj/q1lwRo9DYDUzhRYuS
         h+KbFghAgS0r3Fg0vXabvdKC9b2jt2euRhRCgyb7o2m188YPWDLiY6z6qbkbBHFJR37Z
         9rrEd/scHsOeg46W2hPB1AZF7qpE/hyEoBSVi5+dHGnJOTb3BNXVLTqwEISGKyCsukrd
         tv9LDaxsAHnxkhgcdazQ6/18nljV6/KXf8kn8uJpsIivWiqztUQAg5autItNV+HupmZa
         /REligRDFZzjprcnuK7wo0vazst3mAMmipQ0BQqx5dnINLIrm4akvvuIQhnpAekHewND
         NhNA==
X-Gm-Message-State: ACrzQf3B7oupry+Byw9x9sutqqTwoui/ylkevUFhDUgWpQUzh9jlMCz3
	hU4o9o3WugFJHw6BoevoiDVRE3eUILyS8pN3fBo=
X-Google-Smtp-Source: AMsMyM4CdatOs/CFd+gK77U21VewW4Xy+MFPSmS7i1GMiiOOGpT4m6uwuB0Ael2BkYr1Pj1RPou/mQ==
X-Received: by 2002:adf:d1ca:0:b0:236:737f:9525 with SMTP id b10-20020adfd1ca000000b00236737f9525mr19030145wrd.634.1667483507416;
        Thu, 03 Nov 2022 06:51:47 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f4ce:89a5:47d5:7afb? ([2a02:578:8593:1200:f4ce:89a5:47d5:7afb])
        by smtp.gmail.com with ESMTPSA id q2-20020adff942000000b0023677693532sm940752wrr.14.2022.11.03.06.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 06:51:46 -0700 (PDT)
Message-ID: <6077d103-d67a-3c19-8bb1-129ba5293851@tessares.net>
Date: Thu, 3 Nov 2022 14:51:45 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: use max_time instead of time
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <20221022133528.31996-1-geliang.tang@suse.com>
 <2c99f83f-4e2a-9205-7690-2cdde6f2a335@linux.intel.com>
 <9e501292-c3e9-6b3c-9457-407df7fa43ba@tessares.net>
 <26d6c1ad-f4c6-49c6-49d9-aba1aafd8b45@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <26d6c1ad-f4c6-49c6-49d9-aba1aafd8b45@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 02/11/2022 01:11, Mat Martineau wrote:
> On Mon, 31 Oct 2022, Matthieu Baerts wrote:
> 
>> Hi Geliang, Mat,
>>
>> On 25/10/2022 02:15, Mat Martineau wrote:
>>> On Sat, 22 Oct 2022, Geliang Tang wrote:
>>>
>>>> 'time' is the local variable of run_test() function, while
>>>> 'max_time' is
>>>> the local variable of do_transfer() function. So in do_transfer(),
>>>> $max_time should be used, not $time.
>>>>
>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>>
>>> Looks good to me, thanks Geliang:
>>>
>>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>
>> Should this go to -net with a 'Fixes' tag?
>>
>> Fixes: b6ab64b074f2 ("selftests: mptcp: more stable simult_flows tests")
>>
>> If yes, I can add do the modifications when applying the patch, no need
>> to send a v2.
>>
> 
> Since the old code works, I think it's ok to just apply for mptcp-next.

If this patch helps reducing issues like this one:

https://github.com/multipath-tcp/mptcp_net-next/issues/310

Best to do it in -net I think, no? But I don't know if it helps reducing
such issues.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
