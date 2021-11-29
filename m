Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526882C81
	for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 06:48:00 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id z5so2083081edd.3
        for <mptcp@lists.linux.dev>; Sun, 28 Nov 2021 22:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=U37NcfO/hc+g40OB83z0ebQHKF0ohxd3at5vbByzs1Y=;
        b=sHC/Imx85sAsHHswY90Vn9WmBrutS1YE0sHsFhEnU727bx5eEAfl7FCthjjOEqUybv
         w0g/i21WQts83ShvyuGV/qnQC2djv42ev5laJAorDIB2lKWGYyNxvVSEPjuxe/Wz2o9z
         3eIdsdxClfB3luqPxgAdv5s+/NJRV0ZtLF2Dlmqa6kvzCJgzKPJspqGVajzqtZrdxKql
         hu+2JK5l837K/6dX4NV5pq9HK6vHZsjlj78JVPhaUB2cp/H0QGwuDTh1OUad2B8hOWwa
         fzNSo3xD9T+wagS7JuMRocEPRf0iKU6UECNF28Nfv4d5rfLLl5boqo8/WADrDTNTTXZx
         5XxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=U37NcfO/hc+g40OB83z0ebQHKF0ohxd3at5vbByzs1Y=;
        b=xA0gJPkifq8n9j2dLbyq6WzQZgnUQXnqqOjhs4BkpCRRTMOAKay8CuH33aeIWzW3xU
         Xov9vvHiCaImYX8Bg2X2zZEox/lmxZmQTKavlmeAe+3QJqSPuah514ll9H/sVSsfyiAC
         qZ5B5XvidSqGlFkYiQw65heELLBeahw9xvJHbpeyx2RLgBk6dgM/6UAv2+cWDj9l0s1Z
         mKBCrjPf4wPRPR2Dcp2/fhe60Y4Sdthad2HolvE1d8xD70sVAVGgA+NHz/vodRbZPQuk
         fBnLJwgGUcV7myokN95rhCow3amDa+mO70DwiLRkB8L3xKRaVRM7BJ0a25KCyArXLGmL
         fkyA==
X-Gm-Message-State: AOAM531S8p7vyBr1J7g11NEoNuTh/CmG84RSbwcxhFfgZxOiHkMGW5dS
	8JoabEC8ZAUEZXSer87ylao0Eg==
X-Google-Smtp-Source: ABdhPJxpqdxHfgoGagQfTwFKYbSmv5Pw+PUiauUu/Lj4+w/yn1aurWdO6ipbOT13jmapKt/T6VTCQA==
X-Received: by 2002:aa7:c390:: with SMTP id k16mr72145587edq.161.1638168479240;
        Sun, 28 Nov 2021 22:47:59 -0800 (PST)
Received: from [127.0.0.1] ([213.211.142.51])
        by smtp.gmail.com with ESMTPSA id dp16sm7492606ejc.34.2021.11.28.22.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 22:47:59 -0800 (PST)
Date: Mon, 29 Nov 2021 06:47:58 +0000 (UTC)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Message-ID: <9b5bc805-8f48-4724-a465-83783c7e14ed@tessares.net>
In-Reply-To: <20211129041209.GA23777@dhcp-10-157-36-190>
References: <cover.1637630218.git.geliang.tang@suse.com> <2ba9856233bd45ffe99f01566c2772b0dd12a501.1637630218.git.geliang.tang@suse.com> <cd39b3ab-b491-ee1d-9ba2-e47799d61e1f@tessares.net> <20211129041209.GA23777@dhcp-10-157-36-190>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: send MP_FAIL with MP_RST
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <9b5bc805-8f48-4724-a465-83783c7e14ed@tessares.net>

Hi Geliang,

29 Nov 2021 05:12:36 Geliang Tang <geliang.tang@suse.com>:

> On Sat, Nov 27, 2021 at 11:03:50AM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> +cc: Paolo
>>
>> On 23/11/2021 02:23, Geliang Tang wrote:
>>> As described in RFC8684, 3.7 Fallback:
>>>
>>> '''
>>> Therefore, it is not possible to recover the subflow, and the affected
>>> subflow must be immediately closed with a RST that includes an MP_FAIL
>>> option (Figure 16), which defines the data sequence number at the start
>>> of the segment (defined by the Data Sequence Mapping) that had the
>>> checksum failure.
>>> '''
>>>
>>> MP_FAIL could be sent with MP_RST at the same time.
>>>
>>> This patch fixed it.
>>>
>>> Fixes: c3b546f7292ac ("mptcp: implement fastclose xmit path")
>>
>> I bugged a bit when looking at your patch because I was not able to see
>> the issue on -net nor net-next. But then I noticed this patch is in fact
>> a Squash-to patch :)
>>
>> Then good catch to have seen that before upstreaming these patches!
>
> Updated in v2 as a squash-to patch.

Thanks!

>> But then, I'm not sure this modification is enough: in
>> mptcp_write_options(), it looks like MP_FASTCLOSE and MP_RST are
>> mutually exclusive, no?
>
> MP_FAIL can be sent with MP_RST in mptcp_write_options(). So no need to
> modify the code in mptcp_write_options().

If I'm not mistaken, with your patch, you allow MP_RST to be sent with MP_FAIL and MP_FASTCLOSE but MP_FAIL cannot be sent with a MP_FASTCLOSE.

In mptcp_write_options(), we don't do the same: MP_FAIL can be sent with MP_FASTCLOSE and MP_RST but MP_FASTCLOSE cannot be sent with MP_RST, no?

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
