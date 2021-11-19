Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D668
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 16:11:47 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id y13so44572460edd.13
        for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 08:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=MJi7Gr3jKFkXym3hs+B5yLqmOoSdF7ffa2e6NB6bWIA=;
        b=dhURf90IDIOFHlzpsmbuX1YUIIFTAt6CGw5bXEbo+dt0u4hWlLqDFR7EJse2Dq5Nuq
         UlbhLkBpYBoSEq92Xy9Y5wWIvD8UadE2GiA9ZeQP/b4Xc/FFkViThrGeq+Z0uxxpaCZ1
         vI++UznKZi6ZophAPOdOMzLsCPneTcQ6KJbUhhoEpAbzsp4bblhm6WNy+I0tT/oSAXwU
         GpuWx89ECHQm8tEnCuM5haqSGuZALUppJijtMwz/GaZuT01bPDpXwR7oEqMdI0Nk7Ysw
         +jFlPRWbftaNot0KQCwvVcB89AEJ24vM62pFxeDdGoCgoIeJz7ynPJ+upD3bF640bZUj
         7qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=MJi7Gr3jKFkXym3hs+B5yLqmOoSdF7ffa2e6NB6bWIA=;
        b=XlST8bU/tDeuBrDjyIH590i0+ECWPREFTisL/ZABIaXZGPSwQk1pOGiBpEXEPzRMci
         3WP0Iz9MuXHs816len126bgAOxfEPEIaLTH5WLeSAa5rc3PaUDXaRC5tU6ZebKQeOMQi
         l5k1QpXVC9nS87iyCrJfXyxgykNBBBz3gRZl2nv/bUAZCmvPwUYxCsYkCyNQv6bu6VCO
         hX65iLtGAwJZGSwyU6FcEISezSKUtaKzLR/l5BcXhM0lopgu3GiQQpZgnw1/C54DaKWg
         W+vgBx9RkkRV4o+WK1qeAVMTJqWRMviW9yTuAbDx+OC3YZoJDNXAp5LXftQ+RQAmaDrK
         jxLg==
X-Gm-Message-State: AOAM5325MfZ2AKWrd4lz++5fGPr78gromq1iO3m7+CLTBJZnOcmfU6Sn
	FGIloEAIFEDnmQ882PHLO4jHOvRuLYLSoA==
X-Google-Smtp-Source: ABdhPJx2KfHOcNGgX1cTGX5pVCtrMFeEfr1NW1N8shoJtbk/BI7kV0lYiM+syNocYvq36ffGaZ4Wmw==
X-Received: by 2002:a05:6402:2547:: with SMTP id l7mr24945745edb.301.1637338305688;
        Fri, 19 Nov 2021 08:11:45 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id hc16sm130643ejc.12.2021.11.19.08.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 08:11:45 -0800 (PST)
Message-ID: <75768482-92ad-15a9-aedf-15e6f052c2ba@tessares.net>
Date: Fri, 19 Nov 2021 17:11:44 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 mptcp-next 0/4] TCP_INQ support
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20211116134804.30090-1-fw@strlen.de>
 <af2bda56-ea65-cfec-8671-1b3605f66590@tessares.net>
In-Reply-To: <af2bda56-ea65-cfec-8671-1b3605f66590@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/2021 17:09, Matthieu Baerts wrote:
> Hi Florian, Mat,
> 
> On 16/11/2021 14:48, Florian Westphal wrote:
>> No major changes since v2, see individual patches for details.
>>
>> This adds TCP_INQ for mptcp and extends the selftest infra.
>> Patch 3 adds ioctls to retrieve amount of in-sequence bytes
>> ready to for read() (older version of TCP_INQ) and counters for
>> unsent and unacked byte count.
>>
>> Last patch is new in v2, its a more specific TCP_INQ test case.
>> See individual patches for changes since v1.
> 
> Thank you for the patches, the reviews and the reply to my question
> about the ChangeLog!
> 
> Now in our tree (features for next) with Mat's RvB tag (and without some
> warnings from checkpatch in the .c files of the selftests, nothing
> important)

and without "int queued, on = 1;" line in the selftests.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
