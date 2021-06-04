Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656D70
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 19:34:55 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id f5so7394096eds.0
        for <mptcp@lists.linux.dev>; Fri, 04 Jun 2021 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hstRiTMj7tzRn2qay7CXUHvg7gQqMhhnQtWo0eDvNFI=;
        b=fguaH+8lBsdk+MhQ/92SbvGjHwbn1qbMK3tSf7W0HhkwmOE/K3OSj2trcgnzr/4AaU
         GyQtnKvKQPtXKeqpNTOwotRvYU6FBUf27dqGnaAoUtBK3k5yFVxPP3XGFGp+oMOBvXiZ
         0GCBb/QuFp+THwULckgKoibdoWuMyKtS/QkoJdBn13TjbaD1xZp3Qt9lNYmahzh6S5G8
         kQ39L3kXCD3Xdzt4hS7bJnzDIlL3JQH5Zu9wFLICCZjYIe9EjAVw3Tr5jy2ihRSrq9Ru
         D0yy8NxMX1bne4M8GJlRFcMTX43QLK/tFf1OV4ZldyDQCFj6YoLfzJIF/OBkMjz1FDcv
         6npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hstRiTMj7tzRn2qay7CXUHvg7gQqMhhnQtWo0eDvNFI=;
        b=csYBDs3GvOtPL+NEaz5vdnRADnEsi9IYbRMRVHwqkPOnlkw6MD1NkfGKx1mHw92/zV
         P0u3zu3VrzcXbX2muI2JZFf1rgIQ5bAVetVJcx3f7teIlMmY0SpuroOR4S5OnlK4vAJn
         uOFhRlNDC2/QocBteQeV0gSg3NYtW4ATDRfN8RGMY9G36D5QpGwvE+FFU+1QUav5QkW4
         30sSYivZrXnCDLsifkqJwERRg9EXEt8/+QTSIsrQt+fIS85v4g3CU6vhCR6OhPqXgX3Y
         0/90U15FGEHtPdv9RIvycDhV6oKmszVZBqCFzjBCOU464z1OL+Nc6MWjiJjUpBlkXGkw
         egLQ==
X-Gm-Message-State: AOAM531bdUlAfoJR0JA+PRSxWP5fQYa2RgDivoG/lbw7n8929QabjpSK
	kSgvqfL8zLN0uoIFfS6BVDAISJKzqaQbBLGF
X-Google-Smtp-Source: ABdhPJxS5/xnFnaJzeQZQf7BZ0AWfiF+C2Et3GJ9JZuSmirb/Sg1BkWm2aDfTe78mziOwy/Gx8X8kA==
X-Received: by 2002:aa7:d85a:: with SMTP id f26mr6352271eds.332.1622835294034;
        Fri, 04 Jun 2021 12:34:54 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c047:d46c:d45:3868])
        by smtp.gmail.com with ESMTPSA id f3sm3696443eds.59.2021.06.04.12.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 12:34:53 -0700 (PDT)
Subject: Re: [PATCH mptcp-net] mptcp: try harder to borrow memory from subflow
 under pressure
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <bc6471c8f7444b89e7e5f6c8f7713972477fda36.1622045437.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <260c6ca2-014c-a1c9-696b-ec2293f8d02f@tessares.net>
Date: Fri, 4 Jun 2021 21:34:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <bc6471c8f7444b89e7e5f6c8f7713972477fda36.1622045437.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 26/05/2021 18:10, Paolo Abeni wrote:
> If the host is under sever memory pressure, and RX forward
> memory allocation for the msk fails, we try to borrow the
> required memory from the ingress subflow.
> 
> The current attempt is a bit flaky: if skb->truesize is less
> than SK_MEM_QUANTUM, the ssk will not release any memory, and
> the next schedule will fail again.
> 
> Instead, directly move the required amount of pages from the
> ssk to the msk, if available
> 
> Fixes: 9c3f94e1681b ("mptcp: add missing memory scheduling in the rx path")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review! (and sorry for the delay)

- fa92849db4ec: mptcp: try harder to borrow memory from subflow under
pressure
- Results: 809268f427a5..119541ecd3c9

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210604T193342
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210604T193342

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
