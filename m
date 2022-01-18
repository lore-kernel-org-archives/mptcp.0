Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487AB2C9C
	for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 11:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642505558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxIUZxKIctHJwL8z/L5myK/ubboYV+HhwGkSMX1RWeM=;
	b=DNSmUkZd/7CSh+S/AW+V1uEGxrJhJSuZvXrab9/QuZqzkqSJ5mkuJ41SOuF3dqdlEbfA5D
	d71PKVPPwazo5+UPs96Db/zzMtTQPRB68jTXEzcqMs1/+KDEYVlEcC4zd5Y3pC1s9q+VE9
	ZV+O54g87pTS6GV3DelXB04Kec08HOU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-gvufhYdFNGmDro1RqQCewA-1; Tue, 18 Jan 2022 06:32:37 -0500
X-MC-Unique: gvufhYdFNGmDro1RqQCewA-1
Received: by mail-wm1-f70.google.com with SMTP id p7-20020a05600c1d8700b0034a0c77dad6so1876048wms.7
        for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 03:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gxIUZxKIctHJwL8z/L5myK/ubboYV+HhwGkSMX1RWeM=;
        b=UWUhuxi8Lu3MBtTVQbzECXlBAcZO3wSuKBV1TIKnGGDZ/9+RlEuKecI9o5rAVd0uIV
         U4eaDht8B0W98MU3jh+GeaUrMvIo7SWsbmHNdlF0gc7Yz/EnDTx+tB1mxguk2fjpZoOi
         2reg891SUm6eOI2TYwBkJZnWuP5cu+Y31qoioA+W89fLtkkcHDi0TLpm7vCHHouT/A31
         0gO5LgocR6B6txjgcNsFnejpWIj+41OIs8RZU9Zj+Yt/Aro2qcQ8/J9RfHBGps2baB4Q
         7pI0T/gf8A1ZzmuJh96e6InXBhWylu9U/PhcLLBWZWUgJgJrzVCBxU/049n33AjbShll
         LyIw==
X-Gm-Message-State: AOAM531tBanr3wCbiozTwZkk8iVNFhGdmK/gO9M5KvUWDyFxfxjzNSr/
	t4OCPPYXVUBRA+aiKFwpVxV/2Q1oLygEdoZSug+lLoK5QOOaC81jjYmHZSb7eBXJ825z/t5WEMB
	FbaLHLTqLi99xKPc=
X-Received: by 2002:adf:eec5:: with SMTP id a5mr22941933wrp.125.1642505555848;
        Tue, 18 Jan 2022 03:32:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2Z2Ir8v9YbJpsV5b8zAGMUVsvQSlizXWz0r6NetP68sBK/YKLA/n6veKoloXDcOw314VKwA==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr22941913wrp.125.1642505555610;
        Tue, 18 Jan 2022 03:32:35 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id p4sm252431wrf.25.2022.01.18.03.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 03:32:35 -0800 (PST)
Message-ID: <3d46c2e7-40a7-61e1-8bb5-063bb608b26f@redhat.com>
Date: Tue, 18 Jan 2022 12:32:33 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 09/10] selftests: vm: Add the uapi headers include
 variable
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
 =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>,
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
References: <20220118112909.1885705-1-usama.anjum@collabora.com>
 <20220118112909.1885705-10-usama.anjum@collabora.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220118112909.1885705-10-usama.anjum@collabora.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/22 12:29, Muhammad Usama Anjum wrote:
> Out of tree build of this test fails if relative path of the output
> directory is specified. Remove the un-needed include paths and use
> KHDR_INCLUDES to correctly reach the headers.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/vm/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 7d100a7dc462..8dc428c8a3b0 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -23,7 +23,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>   # LDLIBS.
>   MAKEFLAGS += --no-builtin-rules
>   
> -CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
> +CFLAGS = -Wall $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>   LDLIBS = -lrt -lpthread
>   TEST_GEN_FILES = compaction_test
>   TEST_GEN_FILES += gup_test

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

