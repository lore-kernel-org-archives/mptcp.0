Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7867F
	for <mptcp@lists.linux.dev>; Wed,  1 Feb 2023 10:27:59 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id bg26so6437739wmb.0
        for <mptcp@lists.linux.dev>; Wed, 01 Feb 2023 02:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFWQqgv36uWFij2wrIbXPwzsMvNy5OU73hmsg/tl7Xo=;
        b=HQ+sQwcwDEIHUD4ERbp+Bl9i6qAnXYkNaZhatVKSy+NwNsZlnuudkPSc+gqmUBZeo0
         8Jz7oVit1L03mK3vwkzog/HmSPzeihWjQ6WbfRJ7pwGcmVtexmOGrP8f2x+OliSNIm8y
         Ql+6dnN6KroqM4goQOCyCX5YFkwORgKjnUNw7lQh0h8dtl9f2xuz0kgwEldtnDqIGgKs
         e+nPTKl6Ntac/sGGMWhh4O1YLWbfVt9cc9Yco6Yigs6dz19udw+YhMIrI3gww3KfHgWi
         i6/rdWbezE544wkZi980tgOHn/YuscaxehG+Yj1rOFRY4aq4vTp0Mro9WWvVb8nT8yVr
         qxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFWQqgv36uWFij2wrIbXPwzsMvNy5OU73hmsg/tl7Xo=;
        b=wbhOhl39QKTNbjF20SaAd8nYH3mFHDTfoJM98s2FbZZxLIDcbP4VQfts3m/3wC7+0N
         r34cDFeESXv4+aVxU6JywIXnNxsH2RRwxqkZR12ars3ztBovt62I5y3bgSMDFKJh4im1
         LKD9zzeKHNuBGFjJQPF3ftGctp52oTSVuCCjIpLf8CSyB17rOwHww8YlrLKlDc2ZAlxa
         BNcCZ6AnY5SO+b5CFlSYoMoG2LD055tI7K3RQ9hGxOQEWZwX3zdHrBSGjVkbp95z17Md
         5hJyBbUmFq9nEx0sdltnkhRMd/mJ226oBYsO0kGdydab6f05iNvfz4NmRkXZjnsSYcvI
         t+jw==
X-Gm-Message-State: AO0yUKWtGkNETwPgy/a8fgPEroXOhtdvMkb0Fk27+Sx4JcevoTYvompE
	l1ZoKGC/CtUMuR5jOkYB7QkFlVECByd5Tu2O5tWTBw==
X-Google-Smtp-Source: AK7set8SpyhT6cacg1cNM4wSZlECaOxzShhnNNlbPDOeamim3gtCecwpFZyMQpc0HUq2TbKI+KMCyA==
X-Received: by 2002:a05:600c:3ba5:b0:3d3:4007:9c88 with SMTP id n37-20020a05600c3ba500b003d340079c88mr1719938wms.18.1675247277853;
        Wed, 01 Feb 2023 02:27:57 -0800 (PST)
Received: from [192.168.3.222] ([213.211.148.158])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c44c800b003dc433bb5e1sm1311560wmo.9.2023.02.01.02.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 02:27:57 -0800 (PST)
Message-ID: <d6d7bac0-fd4e-1417-8b02-d81314c2f744@tessares.net>
Date: Wed, 1 Feb 2023 11:27:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: stop tests earlier
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
 <20230131-mptcp-issue-323-join-delete-re-add-v2-2-8de2421163c9@tessares.net>
 <CA+WQbwsOc66b+3a6RwCto4xa-JCoGt7gw_zGWadxMoWN=umWZw@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwsOc66b+3a6RwCto4xa-JCoGt7gw_zGWadxMoWN=umWZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 01/02/2023 06:17, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2023年1月31日周二 19:23写道：
>>
>> These 'endpoint' tests from 'mptcp_join.sh' selftest start a transfer in
>> the background and check the status during this transfer.
>>
>> Once the expected events have been recorded, there is no reason to wait
>> for the data transfer to finish. It can be stopped earlier to reduce the
>> execution time by more than half.
>>
>> For these tests, the exchanged data were not verified. Errors, if any,
>> were ignored but that's fine, plenty of other tests are looking at that.
>> It is then OK to mute stderr now that we are sure errors will be printed
>> (and still ignored) because the transfer is stopped before the end.
>>
>> Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 52484a7c286a..42e3bd1a05f5 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -498,6 +498,12 @@ kill_events_pids()
>>         kill_wait $evts_ns2_pid
>>  }
>>
>> +kill_tests_wait()
>> +{
>> +       kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
>> +       wait
>> +}
> 
> Can we use the existing function kill_wait() to do this?

Not easily: here, the best is to send SIGUSR1 to mptcp_connect process
to do a graceful stop. We could probably do a SIGTERM but still, in
endpoint_tests(), we don't have the process IDs, we would need to look
for them.

Also, we want to wait for the whole "run_tests" -- launched in the
background -- to finish, not just mptcp_connect but also the validation
part with the different "sleep" before executing the next test.

So I think we should use this new kill_tests_wait() as it is, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
