Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148E7E
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 15:02:57 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id cl5so4725763wrb.9
        for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqwYadvirUTIoAP/uUlVqNQOrgabgHNjk446znykzsA=;
        b=VdVbU0OPAr5g9WRoHLQbldxjAuQCWOl10KQucsyuqpg2IRGmmX989xzcIHw7CMDUI/
         ApCFTJcUPGSWjQ3DWyPMf5Bof5IvWD5tVFyEt7l9GZIc6pn2GdhEKonY4nuddlspOpql
         bHRdOljAEf4YsVcpM8iwPjOJBegY2JJLRJ9uAH9FLlIaLVikPosAQ7gxGk4oEHnBr81k
         N2o/N9+beec8lHg5OjJFy5XYx4J+hW8Gwp1HZ8/N5Zs2f7ip8rGe9Q5y/3q8AmiSFjp3
         UtWqb8qZd4gGfFEeXRPBY8sNNsAQg2zkTBvcjzrvLqbVMl6QBGS0zKDdslpbocFPdy5L
         szDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqwYadvirUTIoAP/uUlVqNQOrgabgHNjk446znykzsA=;
        b=CfZOvDHW1dWvVvMXPmRZqPYsyysgOiK9bEbqoTjveQ+E5PV9n8CxzU3VkG/rjN+1JE
         EI/5g4ZnwTU9qI25HedhDcHEKQktHzcHXwcmcAls92iCqPsHI+42brBut7gUBFDzAZts
         9PwKIXZmVhGCRr0bNMeWbg1Zs5lu8j4CeMxsn1HmqmcgfnuZmXYPZPWCN8CKx7dz5/qi
         W1u3dtqFwDKK2qyCW/jrDwt7mt4T91xYRCjUGLjw2QfEBmOPoks43pbWv7A2Bn2sec4z
         II/oO9slyn9Oti5+yjYi41YoCbnna6juiMec3l3HNnP07ii1Rl3NI8BuUakS5okxizPu
         moGA==
X-Gm-Message-State: ACrzQf1U1yQePssaydekhFdfNjOQLgQUkxaCn90BhAc/zOpHiDLRqKIO
	AKZ7N8wj03coBQA1jM4VwXVYOmDerE2sHA==
X-Google-Smtp-Source: AMsMyM4gJrAXt8mh9mClik08TR966rEshmODXNgBeRSrAXFiUAxKJBp13VU68bTBsM+GsnXM1pObZQ==
X-Received: by 2002:a05:6000:1e0b:b0:236:8a6e:8d with SMTP id bj11-20020a0560001e0b00b002368a6e008dmr8275507wrb.20.1667228575109;
        Mon, 31 Oct 2022 08:02:55 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id bl19-20020adfe253000000b00236576c8eddsm7397330wrb.12.2022.10.31.08.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 08:02:53 -0700 (PDT)
Message-ID: <9e501292-c3e9-6b3c-9457-407df7fa43ba@tessares.net>
Date: Mon, 31 Oct 2022 16:02:53 +0100
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
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <20221022133528.31996-1-geliang.tang@suse.com>
 <2c99f83f-4e2a-9205-7690-2cdde6f2a335@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2c99f83f-4e2a-9205-7690-2cdde6f2a335@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 25/10/2022 02:15, Mat Martineau wrote:
> On Sat, 22 Oct 2022, Geliang Tang wrote:
> 
>> 'time' is the local variable of run_test() function, while 'max_time' is
>> the local variable of do_transfer() function. So in do_transfer(),
>> $max_time should be used, not $time.
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> 
> Looks good to me, thanks Geliang:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Should this go to -net with a 'Fixes' tag?

Fixes: b6ab64b074f2 ("selftests: mptcp: more stable simult_flows tests")

If yes, I can add do the modifications when applying the patch, no need
to send a v2.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
