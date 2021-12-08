Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4ED2C9E
	for <mptcp@lists.linux.dev>; Wed,  8 Dec 2021 10:23:38 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id x6so6738192edr.5
        for <mptcp@lists.linux.dev>; Wed, 08 Dec 2021 02:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PwhE9uWmrp/iDjEdSM7cLt5R7Kkbd96Qt36oQGnoEwM=;
        b=SCkXB43YXk7sd0JotbOSsrPvhWsug/JDjtvZO6P6dMsJtWuTSCeSMbuur39LDlsAbW
         mzCg9b5tGkxWJJS6vGbg8xXcNe7u8t35EHkDdbnM8dhT2FxzLXzMzTI9f+y5ClEj2k8E
         itYmo746twuk1iZKR7yesCOBrY26AlOa+MZQ2Apl6UyYI8I8zsJpSK8mFgR5JWZ1Vtsh
         eXqB6IRj0C1g7bjeqce0daQTzHxx1ixUeNR7htxzdcotv1da+UwJjruQWYbiCk/qFg0k
         L6y+LxEkYQE6ONte0zcbXq7LPIkGWG7HpriXZgmpBSJNLsAo/UDbFxEvCQC9oQN829E6
         EMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PwhE9uWmrp/iDjEdSM7cLt5R7Kkbd96Qt36oQGnoEwM=;
        b=13Xdu+xK2eQFUAThGzKLn2UMOgpAd9cS2wEzBf674JRx9Vy0QQ8B1mVT4K/aO2MJ/J
         wqMKgeHhabUl8EGRFhR0wQRknq6ChcqfnMiLyHlTr1u3E/Ls0H2t5eWVlBmcElZuzAj+
         V7MuY8owkzTeJ1ADDDWngiMKCJF+r9n+yvfbPmdm3EqKw1BU692X4x1Y5H2QHEMNx4uz
         knqJ3EzeMeEgUVVJBTmPGX+j91bHqIaDAv2ds45bGsNsTtLb9JW0wzG6yNsPeIVIBn+Y
         0hQW/osrnrBK7t9i+XkydAvVvGkaree2eKB2jcxUVJSt8M9Rulqt+mWUQOcvH0Nf+7dl
         yr5A==
X-Gm-Message-State: AOAM5317HQGwbijLq1vijm2T/TgcLHer9njX63ydOpC8JDAbLYPeshDB
	NJ28NrTzlGPplg0XFjazIjHLv2OAeKQUNIpE
X-Google-Smtp-Source: ABdhPJwyvL0vov28u999JWqhoGCzVdAo/1IRXBaYviJAEEbkW/XdZrSCmP0GMnWtijtmUs3Pq8rQuw==
X-Received: by 2002:a05:6402:26cd:: with SMTP id x13mr18180263edd.11.1638959016889;
        Wed, 08 Dec 2021 02:23:36 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9dd5:a52b:99d6:b584? ([2a02:578:8593:1200:9dd5:a52b:99d6:b584])
        by smtp.gmail.com with ESMTPSA id a3sm1339364ejd.16.2021.12.08.02.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 02:23:36 -0800 (PST)
Message-ID: <c7c976ee-2510-858e-c075-25add945bc3b@tessares.net>
Date: Wed, 8 Dec 2021 11:23:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH iproute2-next] mptcp: add support for changing the backup
 flag
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cb2ddffb2211d6fdde7a8bf81879a3a83c620f00.1638542999.git.dcaratti@redhat.com>
 <8a517-d825-f27c-1fe4-4dceae4fd2d7@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8a517-d825-f27c-1fe4-4dceae4fd2d7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Davide

On 08/12/2021 02:59, Mat Martineau wrote:
> On Fri, 3 Dec 2021, Davide Caratti wrote:
> 
>> Linux supports 'MPTCP_PM_CMD_SET_FLAGS' since v5.12, and this control has
>> recently been extended to allow setting flags for a given endpoint id.
>> Although there is no use for changing 'signal' or 'subflow' flags, it can
>> be helpful to set/clear the backup bit on existing endpoints: add the 'ip
>> mptcp endpoint change <...>' command for this purpose.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/158
>> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Matthieu -
> 
> Since you already Acked, what should be the status of this in patchwork?

I just set the status as "Awaiting Upstream". Is it OK for you for
patches for other trees?

(Note: I just noticed before sending this email I already "supported"
this case in our wiki [1] :) )

@Davide: now that the linked kernel patch is in net-next, may you send
this one to netdev please?

Cheers,
Mat

[1] https://github.com/multipath-tcp/mptcp_net-next/wiki/Patchwork
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
