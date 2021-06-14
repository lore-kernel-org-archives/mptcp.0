Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF52FB2
	for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 15:54:39 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id i13so47191375edb.9
        for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RqIFDh2nl9ZpYHsr1jQFF9v3k4UD/O2jHnAsZHv4d7A=;
        b=RL1W/h5MIueFiXIeIgSgmm9zzulv0Y3ie3dA8cpAT8gRjwMj7tOLmO6sWcX67Yae9U
         NAcU42Qwmhbdi3C04EjqvvTmzq5uSMTX6sdpI6L4q7Z9kf31DabwYq8EkgO8rcSjk6NR
         0vLMjn0ZhgiQyaLPFGi1RZBuduIq5xWc5utBzgYg0kHsdXhFK2QU7xKyifQvMLcmKTv7
         zZ4Kzpg7pgcRftQMm2Lj3FhxqKHIndOp1a9M+Ki5NQeeVj7XC4HJwrXz2y3IerlQP6cx
         mG2bftE01Bjyqw93OTt8m0GHe3+tMsy0ZYuR6q99zy0j4YIUN7sB4HEipv62Vvo68b94
         y3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RqIFDh2nl9ZpYHsr1jQFF9v3k4UD/O2jHnAsZHv4d7A=;
        b=RgIzEHEXau6ieepvMw7CmNnadgjQlhHV1oohgMUuwmALVKJJ8CJwFV8J19rS0HN8X6
         dASr35K/iu7L3jUZldt6pqgWSN64S0gatLUu7XcEXaCxCQgssfbKrNR8awlO7QNgZWRZ
         oNa262l8ESQ8Vhe8p5SRk4/n36D7gxuMCsQTMq2s6cTYlPhVqTSibQraVKCBNb07sDTB
         5RA0d7iF7yyd0rJ3lL5If42jVQFMowEb4uHUzmlUDymxcKNA0j6GTJn0fGMODGVSvXaU
         M8JFDEO5QR8sKcSaaFp+SZAXEyorb8GgHVPrKI6lOM1S/LeprBKXepbPrLJ+bULdf8Mw
         JURg==
X-Gm-Message-State: AOAM532PmMupyRHG5fG7ZlyWJtbX+CNoIcyEV3chALbkcpWFLrXr4QRd
	A20fZwdTQ5tkCdmi6bDgkige3dgcW3r8xG6/
X-Google-Smtp-Source: ABdhPJzCnLJjP/fOuskDntQhwx2qB8Ssi1t75ni26I1zwvzS26PB5jaGPqQuUdjAJrO6ZODcO1zmUA==
X-Received: by 2002:a05:6402:1513:: with SMTP id f19mr18489754edw.235.1623686078235;
        Mon, 14 Jun 2021 08:54:38 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:5d72:7de9:b502:1367])
        by smtp.gmail.com with ESMTPSA id g8sm6051586edw.89.2021.06.14.08.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 08:54:37 -0700 (PDT)
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <4582ad38-e8d5-e639-1ebe-688727329f51@tessares.net>
 <c8d3563b-4495-b151-645f-305e4192c2c@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: Checksum support: default behaviour
Message-ID: <eac91c93-e4cb-4196-6daa-c9711606aa40@tessares.net>
Date: Mon, 14 Jun 2021 17:54:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c8d3563b-4495-b151-645f-305e4192c2c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for your reply!

On 12/06/2021 06:05, Mat Martineau wrote:
> On Fri, 11 Jun 2021, Matthieu Baerts wrote:
> 
>> Hello,
>>
>> With the current checksum support series from Geliang and Paolo
>> available in our tree, the default behaviour is not to use this checksum
>> feature.
>>
>> Should we eventually do the opposite and have it enabled by default?
>>
>> I do understand this has a cost in terms of performances but this could
>> help detecting nasty middleboxes, i.e. the ones that modify the TCP
>> packets without modifying MPTCP options if needed.
>>
>> On the other hand, I don't have numbers showing if these middleboxes are
>> rare or not.
>>
>> But also, the main issue I see if we enable the checksum support by
>> default is that we are no longer able to talk to servers not supporting
>> it (<5.13), no?
>>
>> WDYT?
>>
> 
> I lean toward leaving checksums off by default, based on what I've heard
> from community members. It sounds like large deployments haven't seen
> checksums catch many problems? Some actual data about the frequency of
> checksum failures would really help.

I don't have data but I asked around and the checksum support has been
added for middleboxes like Application-level gateway (ALG) or the ones
modifying HTTP to add more content, inject JS, etc.

For the ALG, I know that they are needed for NAT, e.g. for FTP to change
the IP/port inside the payload. But in this case, I don't think it is
supposed to change the size of the packet, only bytes inside. (except if
we switch from v4 to v6?). So in theory, MPTCP DSS doesn't need to be
updated.

For the other cases, hopefully these middleboxes should inject quite a
bit of data and that should be somehow visible for MPTCP to fallback to
TCP. But again, I didn't do any experiment on that nor have data.

At Tessares, we usually control the network between the client and the
server but the situation is different using the "wild Internet" :)

> Your last point about connecting to older upstream kernels is also an
> important one. I'd rather keep it possible to connect to those kernels
> using default configuration options unless it's too risky to do so.

Yes, that seems to force us to keep it disabled by default. At least for
the moment.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
