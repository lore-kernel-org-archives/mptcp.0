Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6D320A
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 08:45:42 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-31c7912416bso4406009f8f.1
        for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694421941; x=1695026741; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8Os+ccxFcLC/nWUEHWIyafSrKC5iJz6umLpT+gjds0=;
        b=7FUKp1/QQM2l0hzK7v2MpOcndNkZANmgnBkHX0GyyrOSJZgNIWrYaHFLIhwtzH127U
         yk3xRDtRzDhccI/ttnhHJ5Nk5JKNYMNb2Ym2tSFhy/C/gW1u/HI4E1p/EQFQiz2ieRmQ
         fgD+pRSHsxqmh4vOy7KVGzxSy4H3TxV+SsBIPSf2iI4jKnY5FZDFDTfThSjf28yG+Fhq
         4ot3wHQ2c0O7eOB9ide5sqU3i0pggRXy4BsWQQgA+SGRF4F5oos6F9X76/hb+oAqQepc
         004S2ed4wjY1i4M+RrB4Xx6Oo9yy7ytzgz6W6oE7ZUDBvtOUMtK9jc8Zd6x2xoI3WDhu
         hUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694421941; x=1695026741;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8Os+ccxFcLC/nWUEHWIyafSrKC5iJz6umLpT+gjds0=;
        b=wp11TN/BBwGrE/+lUAuzKE3KPmvl+UV6Ax0weU6+0oG5jX2SLb+ZWbomZsrI510d6s
         K8lI9XAwusLMgNfpqAqTinxglZ7O44a5qimFhW8xsPIdQCQjelX3Z3/BHuh7JLxvh5HP
         r1Mi+pmjx7tYsOQsMxq52d2jLR9H0jXeaKw6qsVl2xmW30NJBa9BuwaY7wGste/9lcgF
         E0wxNVfrJUD3yXTd06q1yzxFC/BjQlCBXO53FXqTYqeuw8MxnE7Owj5DuGbxPwt8sjkX
         xBCIPLeRVyrhuf7UjEcSdofw8GgSAiXXR33ik+qmwu1YPrLC9HNWQVyeMMg1sqGQVjy6
         otjw==
X-Gm-Message-State: AOJu0YyuXmFwrtHZJWkLzfWoj6s5H76fS7lP8rAzUMERkl4DPrjB6pbi
	3oqmf/It6rIFe07uNYsv4R3EkQ==
X-Google-Smtp-Source: AGHT+IE6vfWs8RJq4ejyhIkaJz2CyXvCQ38iPtTwvC1IvO46sqDU0WhKKP6QtbQ1Mr/5XFS61PUd1w==
X-Received: by 2002:a5d:6109:0:b0:315:99be:6fe4 with SMTP id v9-20020a5d6109000000b0031599be6fe4mr7840565wrt.69.1694421940847;
        Mon, 11 Sep 2023 01:45:40 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5589000000b003141e629cb6sm9316913wrv.101.2023.09.11.01.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:45:40 -0700 (PDT)
Message-ID: <be858164-11cd-4ead-814a-27bb1f4e2d31@tessares.net>
Date: Mon, 11 Sep 2023 10:45:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2] mptcp: add a new sysctl for make after
 break timeout
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <dfadc0c4a9bf4649c01e09d675f4de59eb409f5d.1693841118.git.pabeni@redhat.com>
 <b7703287-9e04-4c9a-93a6-b50c2020c5ab@tessares.net>
 <5c4d5eefdae7992aae4a321349ec58aadbc672d9.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <5c4d5eefdae7992aae4a321349ec58aadbc672d9.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 11/09/2023 08:17, Paolo Abeni wrote:
> On Mon, 2023-09-04 at 17:58 +0200, Matthieu Baerts wrote:
>> On 04/09/2023 17:48, Paolo Abeni wrote:
>>> The MPTCP protocol allows sockets with no alive subflows to stay
>>> in ESTABLISHED status for and user-defined timeout, to allow for
>>> later subflows creation.
>>>
>>> Currently such timeout is constant - TCP_TIMEWAIT_LEN. Let the
>>> user-space configure them via a newly added sysctl, to better cope
>>> with busy servers and simplify (make them faster) the relevant
>>> pktdrill tests.
>>>
>>> Note that the new know does not apply to orphaned MPTCP socket
>>> waiting for the data_fin handshake completion: they always wait
>>> TCP_TIMEWAIT_LEN.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v1 -> v2:
>>>  - add the doc for the new knob (Matttbe)
>>>  - fix a couple of bad/strange indentation (Matttbe)
>>
>> Thank you for the update!

(...)

>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>> index c46c22a84d23..36e389326073 100644
>>> --- a/net/mptcp/ctrl.c
>>> +++ b/net/mptcp/ctrl.c
>>
>> (...)
>>
>>> @@ -141,6 +150,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
>>>  		.mode = 0644,
>>>  		.proc_handler = proc_dostring,
>>>  	},
>>> +	{
>>> +		.procname = "close_timeout",
>>> +		.maxlen = sizeof(unsigned int),
>>
>> (just to be sure not to miss the idea which is probably not interesting)
>> No need to accept negatives values and use -1 as a special case not to
>> close "subflow-less" MPTCP connections?
> 
> I would prefer not adding special values. I think a large enough close
> timeout could be really indistinguishable from "infinity" here.

Indeed, fine for me!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
