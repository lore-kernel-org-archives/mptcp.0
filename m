Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8CE2C81
	for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 06:54:36 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id x15so67352064edv.1
        for <mptcp@lists.linux.dev>; Sun, 28 Nov 2021 22:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=W3PktXAhcqhZzlrBtFOOSs8lBkk7TDROUXDnu61+qcM=;
        b=m5X390rx+0xMFPb9HKKBvgM5FQl1phoGmNBy291CGiAxBs4YM8gQL6RLvXIhGF+V7E
         eNeJzNHc05jEym18tl12UUu/VI/eswju7ZuuZTen01ZFLORzCebu5ZYOV6/NmSGnza85
         L+Sd3dq4ZiYIuuwiNqBLIZww3UOOM7xzGp2nBkTCIHOTZJbCqMnQa0+2eFHJ3HYATMi0
         tJ1jxIjIHHyGT3nrwvQ+zz8ocggQOvuifSbqUsFB7byB4KW+cb2VvRgG35yUtlCJ1gxV
         9AfDEskxiuJGMmnkcbKhNSIw9aTu96eoNVsNerK9oGM3iiQVpTUJ//tXEzzqEJBck0/G
         zbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=W3PktXAhcqhZzlrBtFOOSs8lBkk7TDROUXDnu61+qcM=;
        b=1ReMcQ9l63+JxjE5m4Je+zAvpzJp8Q6Qzg31he6SgGu1c07Z2gEFngRET0h2LJj1b7
         tb7xkyQHB20MVivmIIFy9MObGsqmDcPSo7I+n95JjuMp0Tb5wmdqEdg2T6KDHUMpSFeQ
         WogYpDus1WkM8diqfoXm0cp4fMR4YTYLHtIjz0ulSgMl5fk4NI+zGHMGqPlF/a2LQJEI
         1S0IiVFtG7N+GD50IdLpVCWGhn/bToX4tdLpOpn9bcZhmpYdYSFbXny3xTEEHJNCq8s2
         Qf/GfnENGtDEV45ZUlUCdzFutWkV+d7PWO4t+ElFyBhnB8IrjedSJk8vcdm0nP6p8tfw
         Hc7A==
X-Gm-Message-State: AOAM5337STLU2nWW+4hZIXmUS81GDBqblMgsOwJncqlt1/W5tLUpxVlN
	mGrUzvIqVFHnnfzPqOh+7A9oRw==
X-Google-Smtp-Source: ABdhPJzlx+rY/FclcambRUKG5xZIm3RUq7MMep0StUKFah3HOIDVyBUxgxbW6oRyi1R+VjL3GssKxw==
X-Received: by 2002:a17:907:7d8f:: with SMTP id oz15mr55714475ejc.245.1638168874803;
        Sun, 28 Nov 2021 22:54:34 -0800 (PST)
Received: from [127.0.0.1] ([213.211.142.51])
        by smtp.gmail.com with ESMTPSA id w7sm8410718ede.66.2021.11.28.22.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 22:54:34 -0800 (PST)
Date: Mon, 29 Nov 2021 06:54:34 +0000 (UTC)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Message-ID: <45861617-cd4d-49e5-9a71-ad6c37805d14@tessares.net>
In-Reply-To: <9b5bc805-8f48-4724-a465-83783c7e14ed@tessares.net>
References: <cover.1637630218.git.geliang.tang@suse.com> <2ba9856233bd45ffe99f01566c2772b0dd12a501.1637630218.git.geliang.tang@suse.com> <cd39b3ab-b491-ee1d-9ba2-e47799d61e1f@tessares.net> <20211129041209.GA23777@dhcp-10-157-36-190> <9b5bc805-8f48-4724-a465-83783c7e14ed@tessares.net>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: send MP_FAIL with MP_RST
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <45861617-cd4d-49e5-9a71-ad6c37805d14@tessares.net>

29 Nov 2021 07:47:59 Matthieu Baerts <matthieu.baerts@tessares.net>:

> Hi Geliang,
>
> 29 Nov 2021 05:12:36 Geliang Tang <geliang.tang@suse.com>:
>
>> On Sat, Nov 27, 2021 at 11:03:50AM +0100, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> +cc: Paolo
>>>
>>> On 23/11/2021 02:23, Geliang Tang wrote:
>>>> As described in RFC8684, 3.7 Fallback:
>>>>
>>>> '''
>>>> Therefore, it is not possible to recover the subflow, and the affected
>>>> subflow must be immediately closed with a RST that includes an MP_FAIL
>>>> option (Figure 16), which defines the data sequence number at the start
>>>> of the segment (defined by the Data Sequence Mapping) that had the
>>>> checksum failure.
>>>> '''
>>>>
>>>> MP_FAIL could be sent with MP_RST at the same time.
>>>>
>>>> This patch fixed it.
>>>>
>>>> Fixes: c3b546f7292ac ("mptcp: implement fastclose xmit path")
>>>
>>> I bugged a bit when looking at your patch because I was not able to see
>>> the issue on -net nor net-next. But then I noticed this patch is in fact
>>> a Squash-to patch :)
>>>
>>> Then good catch to have seen that before upstreaming these patches!
>>
>> Updated in v2 as a squash-to patch.
>
> Thanks!
>
>>> But then, I'm not sure this modification is enough: in
>>> mptcp_write_options(), it looks like MP_FASTCLOSE and MP_RST are
>>> mutually exclusive, no?
>>
>> MP_FAIL can be sent with MP_RST in mptcp_write_options(). So no need to
>> modify the code in mptcp_write_options().
>
> If I'm not mistaken, with your patch, you allow MP_RST to be sent with MP_FAIL and MP_FASTCLOSE but MP_FAIL cannot be sent with a MP_FASTCLOSE.
>
> In mptcp_write_options(), we don't do the same: MP_FAIL can be sent with MP_FASTCLOSE and MP_RST but MP_FASTCLOSE cannot be sent with MP_RST, no?

It would be good to have a regression test making sure we have this behaviour and we don't change it but mistake. I think packetdrill would be very helpful for that :)

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
