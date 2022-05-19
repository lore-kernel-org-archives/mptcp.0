Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EEA7E
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 14:13:45 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id i27so10212830ejd.9
        for <mptcp@lists.linux.dev>; Thu, 19 May 2022 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Zp/Y8Vzf9itahOYjcOyC3LTGrec+oGBlVCeAhAtDwM4=;
        b=FwHLYG+1fSBo7jClLYjrrEJNRIz2AOq1KL/xfjkgC90Lr5lQohC4u/oXyRYbmLWnEP
         Q6jV/1v/zFPQvV9QaYZFRsEdh6/5vgdPeKMSzgCZP3SlJikJqNnHX89sbimWz0zp9LrM
         lxuTzk6dPaIzalqV5iSTKuE/hoJ0Et8itpyxTLMvsvPpmYv3hiJP903YWskk/HuaWWck
         B2MYAmlVetLPUbAxLDrVnOpCV8Uen7wurh4mAcke6z4tD66oHH6VzWiWBcIVzOQ95O06
         BUqs/Ga5A9XESVCVLLFcyo/HNvkEoZHSZN/SOjvHh4U+hMlOc0k16XrEr3/X61bejgrJ
         9hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zp/Y8Vzf9itahOYjcOyC3LTGrec+oGBlVCeAhAtDwM4=;
        b=EtaVWLYGER5k3B3IzQ+THbmpXuze/bwOmztSBx5wV8ytQZYNX93xKEEZDirItdAM9Q
         Xi33u1/KG6nBtRxvaNKL4CzK6Awn4kKEIYXs30WGWqcZ+6ihUpjXBqYPJeHnXZWEShGV
         fJP7BI3f0tJtbawWt4Slp1wzvMsvB2ACReBUkyubU3KO2m7ltVE5HVNKJxLJwsGctnaa
         JK4mNco+XZUToUERpnAJjRjPMa9A5rhYZaAORF9ejOf0TTaeNQIKP/Ic9qcFTwM3K0pn
         WOpZFw2RFzm5ELUGUzW0tkcSW382DoCYZxQi01h7eAREcnr2F8AyulMRUgwHuuXoB3zF
         1eNA==
X-Gm-Message-State: AOAM532jPys7OPIopgiMmy9wKsLqbgXc+P+EYMBf37ME7SbDpurWd9g3
	A0oPsundP1na0NEWYFuWjzYgkaqr5kC8/g==
X-Google-Smtp-Source: ABdhPJxNiR4Q2yWnra0ry70XRrBUAmpxUPZs45bovVCAKdkor0ATwKYCrVb7tix3eMnO6SxPUox79A==
X-Received: by 2002:a17:907:6d26:b0:6f4:bba2:ebbb with SMTP id sa38-20020a1709076d2600b006f4bba2ebbbmr4462672ejc.699.1652969623636;
        Thu, 19 May 2022 07:13:43 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:dd49:d598:4fbc:6d53? ([2a02:578:8593:1200:dd49:d598:4fbc:6d53])
        by smtp.gmail.com with ESMTPSA id dq8-20020a170907734800b006f3ef214e31sm2139694ejc.151.2022.05.19.07.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 07:13:43 -0700 (PDT)
Message-ID: <75e74b8a-b28e-008e-02e9-a75dc4b6e467@tessares.net>
Date: Thu, 19 May 2022 16:13:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next v2] mptcp: fix checksum byte order
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <595f104803a212df58db6d20f84947325b33a9d6.1652196378.git.pabeni@redhat.com>
 <349fa6a5-6e64-8bce-5592-6164941659b9@tessares.net>
 <314ab5c-3e28-4f49-3afc-82f01c6d2da4@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <314ab5c-3e28-4f49-3afc-82f01c6d2da4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 17/05/2022 01:07, Mat Martineau wrote:
> 
> On Sat, 14 May 2022, Matthieu Baerts wrote:
> 
>> Hi Paolo, Mat,
>>
>> On 10/05/2022 18:25, Paolo Abeni wrote:
>>> The MPTCP code typecasts the checksum value to u16 and
>>> then convert it to big endian while storing the value into
>>> the MPTCP option.
>>>
>>> As a result, the wire encoding for little endian host is
>>> wrong, and that causes interoperabilty interoperability
>>> issues with other implementation or host with different endianess.
>>>
>>> Address the issue writing in the packet the unmodified __sum16 value.
>>>
>>> MPTCP checksum is disabled by default, interoperating with systems
>>> with bad mptcp-level csum encodying should cause fallback to TCP.
>>
>> Thank you for the patch and the review!
>>
>> Now in our tree (fixes for -net) with Mat's RvB tag:
>>
>> - 5291df4774c1: mptcp: fix checksum byte order (with conflicts)
>> - Results: 128393ceec9b..35e8b300fc90 (export-net)
>>
> 
> Matthieu, Paolo -
> 
> I'm planning to send this patch and "mptcp: Do TCP fallback on early DSS
> checksum failure" to the -net branch on Tuesday - any concerns with that?

Thank you for having done that!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
