Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FEE70
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 14:23:04 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id dm5so3814680ejc.9
        for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 07:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gO+wkyl88U7wrEpXBSssSjK/QkADaF+bK+/sKvmsb0I=;
        b=npK3GkCZxrECb0R2wIZaHMCxhNVyd0Hia4KbQBn2fi9qWVbe3dCSmlEi4lfm9W8lgP
         zTKL9aJgsjNRD+JywCHJ4Y0J2bdm2+zpc/rfUjI8fan9w+Hjg6rro6SbwuGRBJI4kgm1
         9ysKSMiuHWxIBdmsUzIDqqbi1WjMdrJjs9LDawZUSyLc1g4xcIKdaDqISuABEqNM+pxz
         TjM3tpGZu99cAXLhtc+wVj8JZsphgaxB+fYRP/jLhsE0WB5uR6NwpF8kG9/eqMpPlZMH
         Zm+hM6oN4W3qAwilVEuxFCKbRzgfbgX/jocKa217QONHLbS6b4qQBxlaboo8CzrFjrnJ
         iX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gO+wkyl88U7wrEpXBSssSjK/QkADaF+bK+/sKvmsb0I=;
        b=YiKK3xHq7PsSUwSttbU3LgpSLLhO+pj9YJUCbwSH3MlrFmnj2ZvzYOiK30SJwmaQ1L
         KiFKfo8LThWck6u+xZc7hkmEwqUNAvTAzBAov1MwnnULXBrSAVC6NvOwpNRRNA/FmbS7
         lRwAF9UWSx2QLVxNW9csbX1kkG9clk7GSV0pVyBMWt7gxgG5ok1xz6ut0KY1NJYyE8YG
         XM7k4MPkw9tlphpIHCEet5wFJXMVNnYrqsh+nURkQPPhYNxwTjgeJzH9RY/K/Qwvh1I6
         18hqRglHJ4+y5UmweIRatseQWZPOl/FkCk6ey1GymDJ19LxtSoVY14oXmOogPl4l5ecp
         ehJg==
X-Gm-Message-State: AOAM531niikm0uvOx3ymBLsj/vkDusKSBsHunRoiIayR9jr8q24hzgB9
	+pv0GiPkScQRz6ahVLEoC5xTgICzKqeCiA==
X-Google-Smtp-Source: ABdhPJxU/tScrYjjkLe112qCTs/YQeS9KzDBLCQRRqQhThMy/cmhDzIkpoL9Tsvyyo47UZ/crH4SOQ==
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr9964953eji.386.1624026183102;
        Fri, 18 Jun 2021 07:23:03 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id de6sm818606edb.77.2021.06.18.07.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 07:23:02 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <4582ad38-e8d5-e639-1ebe-688727329f51@tessares.net>
 <c8d3563b-4495-b151-645f-305e4192c2c@linux.intel.com>
 <eac91c93-e4cb-4196-6daa-c9711606aa40@tessares.net>
Subject: Re: Checksum support: default behaviour
Message-ID: <996ded10-b6d9-e6c3-bb29-3150bd2dd284@tessares.net>
Date: Fri, 18 Jun 2021 16:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <eac91c93-e4cb-4196-6daa-c9711606aa40@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

On 14/06/2021 17:54, Matthieu Baerts wrote:
> Hi Mat,
> 
> Thank you for your reply!
> 
> On 12/06/2021 06:05, Mat Martineau wrote:
>> On Fri, 11 Jun 2021, Matthieu Baerts wrote:
>>
>>> Hello,
>>>
>>> With the current checksum support series from Geliang and Paolo
>>> available in our tree, the default behaviour is not to use this checksum
>>> feature.
>>>
>>> Should we eventually do the opposite and have it enabled by default?
>>>
>>> I do understand this has a cost in terms of performances but this could
>>> help detecting nasty middleboxes, i.e. the ones that modify the TCP
>>> packets without modifying MPTCP options if needed.
>>>
>>> On the other hand, I don't have numbers showing if these middleboxes are
>>> rare or not.
>>>
>>> But also, the main issue I see if we enable the checksum support by
>>> default is that we are no longer able to talk to servers not supporting
>>> it (<5.13), no?
>>>
>>> WDYT?
>>>
>>
>> I lean toward leaving checksums off by default, based on what I've heard
>> from community members. It sounds like large deployments haven't seen
>> checksums catch many problems? Some actual data about the frequency of
>> checksum failures would really help.
> 
> I don't have data but I asked around and the checksum support has been
> added for middleboxes like Application-level gateway (ALG) or the ones
> modifying HTTP to add more content, inject JS, etc.
> 
> For the ALG, I know that they are needed for NAT, e.g. for FTP to change
> the IP/port inside the payload. But in this case, I don't think it is
> supposed to change the size of the packet, only bytes inside. (except if
> we switch from v4 to v6?). So in theory, MPTCP DSS doesn't need to be
> updated.

There might be issues with protocol like FTP: the IP address is
represented in plain text which means it will likely change the size of
the packet. DSS mapping will no longer be correct. If we reduce the
size, we might take a bit of time to realise we will never get the
missing bit.

But we should detect it at some points and yeah, that's FTP...

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
