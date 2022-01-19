Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086CF168
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 22:35:28 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id f21so20037821eds.11
        for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 14:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O2Z9yctDCU3gTCdFxkuOTOOVaEio5IQFlKJF8LaggTg=;
        b=mmd9J8gXsSomU9UUNBvOuBXVlSzYbQO+nfTxl/OBRbHYFV4RvXKpHULSlKe3BzkhZs
         6tnMwcMq5t47+WNrTTdvtUf0JBg67Wg0aCNi0CJ8xmjiX4vXLa4IlrmJmPXilREu3Yui
         sp2/n7hwAxPyaFgHFq/KT7AU5Jw//TYUZKz/mzHMmN4UbT81SY0CQggRmIEk+Kt7SCKl
         1gcC5o5GXI7K0Gl30ohuE4FaUyf+Tk6L3fF+zoki/vDtHdBawJSTEcBCjU73AxFTJpPC
         L08WNim15+swmDr/BBQguYjDZ5tzZUIY6Y3wQds1cDMm36GA6ezOwNtkI5hA+nPvzBX0
         aSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O2Z9yctDCU3gTCdFxkuOTOOVaEio5IQFlKJF8LaggTg=;
        b=iLpircuoGJapqI2kQv9F9QDj6VznVQnCW4ktETr5wMGK2LJALkf7AKIP5HNs/aqhRW
         k//IRN1pikedumO0MTIJ4Qh/T40dn5A8fgdH69GN4tL6Bz7YDxkIP9If6+CXnfsdRjjQ
         is74QxJgppUBfoXtb8F1YLBnYCAvSJ1UbGTeNl0+0sTEKz5dPtuqbhryZCmRr363cMdU
         pIhdvJ80qZW7TbZt4p/bnaqisqcrGYDOXsedbV1hEByK0UyVpzesYibHHOvKX6+QRevW
         4p8mlAv4rdlUcur3yOTwPZRyDYH18ZGu1J0LV0NwBvMRc4bpiofl03msKa2B6BH0XxRa
         U9cw==
X-Gm-Message-State: AOAM531/E1vzZxQjfST6d9uW8uXSMbCEspiiuVNp8H2tLWuBmuHyhFNx
	ZmPSNwGpgARHnrCYsuLEZ/ZNEA==
X-Google-Smtp-Source: ABdhPJy1AOJWUgAkG9M0ApWVefQgFqlCHwuj5r6BLJ3Us7HRCzcOtwDzV/+W0LhRJLALaHoMOwEgMA==
X-Received: by 2002:a17:907:60d5:: with SMTP id hv21mr26331732ejc.456.1642631726887;
        Wed, 19 Jan 2022 14:35:26 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:f030:6649:6eec:111? ([2a02:578:8593:1200:f030:6649:6eec:111])
        by smtp.gmail.com with ESMTPSA id o14sm403138edr.6.2022.01.19.14.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 14:35:26 -0800 (PST)
Message-ID: <853cf6e0-7890-90ef-b98d-d78bee0aba9e@tessares.net>
Date: Wed, 19 Jan 2022 23:35:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 08/10] selftests: mptcp: Add the uapi headers include
 variable
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 chiminghao <chi.minghao@zte.com.cn>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>,
 "open list:LANDLOCK SECURITY MODULE"
 <linux-security-module@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Cc: kernel@collabora.com
References: <20220119101531.2850400-1-usama.anjum@collabora.com>
 <20220119101531.2850400-9-usama.anjum@collabora.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220119101531.2850400-9-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Muhammad,

On 19/01/2022 11:15, Muhammad Usama Anjum wrote:
> Out of tree build of this test fails if relative path of the output
> directory is specified. Add the KHDR_INCLUDES to correctly reach the
> headers.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in V2:
>         Revert the excessive cleanup which was breaking the individual
> test build.

Thank you for the v2, it looks safer that way and it no longer breaks
our CI!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
