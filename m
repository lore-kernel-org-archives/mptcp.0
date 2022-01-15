Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AF2CA1
	for <mptcp@lists.linux.dev>; Sat, 15 Jan 2022 08:28:11 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id k15so42658574edk.13
        for <mptcp@lists.linux.dev>; Sat, 15 Jan 2022 00:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qQvjtYJnair8dYWbsE2VEk0ErzZgsKhQNkvQLWR9Ko8=;
        b=0916dFpO+uHN/Oz1mt4slEOrn8U3V30kJ2z9+YXLphYkkL5Wn0+vEGPqhArtgL0dBi
         sQPNrY5N4xfPUk95gzfduWiZnTqVQoY92IS0bv+seSRjIzxMuWFiLzfKfamX8eEkrg61
         Kw3/5N0hWplLcYtkhDEGzappClZsa7DsiY/rO34UckrIG+3MR5yB4/LAl0NcNR8iyJwh
         Vgj6JEuWgFpv7yTIEM01s5kHce1Z503b9suDvVSvTGdMJmG3Uc9R2JiMM1HUf3I1KdSx
         4dUmZ5TFprgXexETaSlUte2iSQ7EFHQJi+ivxrLqlUprEZWto//s9tCpFuysEqgldI+Z
         Q3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qQvjtYJnair8dYWbsE2VEk0ErzZgsKhQNkvQLWR9Ko8=;
        b=oGRB5UCwfijRFEEDLSE7J9vOs5MnfLTys9+Ot3FzfnReyqmRre0vw/rCE3EXq7fzUm
         O8lIANfFGyInqoATpoSsA7rC5ii7X1Iz0XyVG3JJulauvK7lFu66m/Pb7jsXBv0JHOV2
         b4FC9kWoOJY+rUUbnOShuS+Fi3aft2tr+8voITnRxJ2N6p1BQ2LLBsVLzZeMW/TPICCS
         X7G0u1Nl6WLWjXRZwbPn2/ZVuKjWYCJxWKksagUItc9Kf0k4ztz4qxt2Z1OimdgVRw3/
         fTvOd7tT974bJl0VEFDaED8AK6yc2dAzZC06mSyH73iN719zCgPGvduayOX+1pU+Yj43
         UVhA==
X-Gm-Message-State: AOAM533wu+6BKPAgj4utLRZ9P757cDZqybCf93CZYPDvfpUVU80zxRZP
	xtlh3imhxeEZXacVAvMDfxrpLdWYCqEr+g==
X-Google-Smtp-Source: ABdhPJx30bM13VZrlkptnoULYnPLAQArnDSLKJUtM3H18WQf8slJKdUD6LqzWl3LiJNVG77JjYKRbQ==
X-Received: by 2002:a17:906:a109:: with SMTP id t9mr9954034ejy.718.1642235289582;
        Sat, 15 Jan 2022 00:28:09 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:cf21:fe3c:ba3b:a234? ([2a02:578:8593:1200:cf21:fe3c:ba3b:a234])
        by smtp.gmail.com with ESMTPSA id r2sm2391761ejg.17.2022.01.15.00.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 00:28:09 -0800 (PST)
Message-ID: <f33bb59f-c8e7-308a-7076-22cb99bf15c1@tessares.net>
Date: Sat, 15 Jan 2022 09:28:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next 10/11] selftests: mptcp: add wrapper for
 setting flags
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1642154579.git.geliang.tang@suse.com>
 <5fdfe3efa18f141a43ec07a9b01d5b679d1a4a4b.1642154579.git.geliang.tang@suse.com>
 <1116635-2b63-9d78-54b3-18c97890b88@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1116635-2b63-9d78-54b3-18c97890b88@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Geliang,

Thank you for working on that!

On 15/01/2022 01:55, Mat Martineau wrote:
> On Fri, 14 Jan 2022, Geliang Tang wrote:
> 
>> This patch implemented a new function named pm_nl_set_endpoint(), wraped
>> the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
>> argument 'ip_mptcp' to choose which one to use to set the flags of the PM
>> endpoint.
>>
>> 'ip mptcp' used the ID number argument to find out the address to change
>> flags, while 'pm_nl_ctl' used the address and port number arguments. So
>> we need to parse the address ID from the PM dump output as well as the
>> address and port number.
>>
>> Used this wrapper in do_transfer() instead of using the pm_nl_ctl command
>> directly.
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

(...)

>> @@ -587,11 +603,13 @@ do_transfer()
>>                         # The minimum expected port number is 10000
>>                         if [ $i -gt 10000 ]; then
>>                             port=$i
>> +                        # The maximum id number is 255
>> +                        elif [ $i -lt 255 ]; then
>> +                            id=$i
> 
> Hi Geliang -
> 
> Given that we control pm_nl_ctl (the default tool creating the output to
> parse here), this seems ok to me.
> 
> There's a risk that a future version of 'ip mptcp' could have a new
> number field in the output of 'ip mptcp endpoint show' that would
> confuse this script, but since the '-i' flag needs to be used it should
> be obvious that the output of 'ip mptcp' needs to be examined and the
> comments explain what's going on. (So, the 'ip mptcp' parsing is a
> little fragile here but in a way that's not too harmful)

I don't know if it would help as the output would be very different from
pm_nl_ctl but you can also use:

  ip -json mptcp endpoint show

'jq' can be used to help with the parsing.

We could have a pm_nl_XXX() function already parsing the output.

Or we could also modify "./pm_nl_ctl dump" to output data in the same
json format.

But maybe the current version is enough for the moment.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
