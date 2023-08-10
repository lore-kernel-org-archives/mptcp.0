Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB151E1AC
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:14:28 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so8933095e9.0
        for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691676867; x=1692281667;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Pnx5T+hp+P3t29yM1gJvyTdFZyBy8+oh2RnSpBz6z8=;
        b=6ffx01endTZldYXLk7ht23rwLZ/cfqHYn/SQsI3F9cKp/7a/xOtBEMVGWR50F8jHnR
         OpJi7Ps9lnd1okLvRcau8JukbYq4GzV4yQ+A7QFLKAzY6e7PjUIqR6/sHEKYXr1uIbiQ
         swNfDJIWvTFZGxn2sLnYPj/dSBezkhhS/DLT6PaDHf/ekcHl6+446Ak8caIVanDiP5Ax
         oAYt3ym0YuPh53+9dwl0fmqEfPOl0bahDFvzM8SlW+r3kMb5syv5/YeLBHbuC+suwFRY
         /huq7RmEATvWNNXCJ3ErJBLe5Yl6EEIti27uIxPnUO98ypH+MkSdXykJve+MqFd6HHuZ
         uD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676867; x=1692281667;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Pnx5T+hp+P3t29yM1gJvyTdFZyBy8+oh2RnSpBz6z8=;
        b=b7MIsO1TX4SvpBIobbnGeKN45SMIb2PJuAi55syFJ8wp7qmMAHv4lfWjhzkD9X8YjC
         u5cMwVEssKcn1SDHEgZtOk51vnYueOPI13ENnQfJFkf6gn4Aj9b9IXUMSwm2A6NCoOWf
         iHlVXWCUGHyRxN0BXll2V5MXJBZ8ece/kyfN6eorVx+KRifS7g+6v2oTV/5dm4q4gP8q
         DWGDd1Tfg1AOXWP97WragcQVPhrmOIJpBurq7MrTIeXmoAkK+5nXDiS8C9vJSdZSP9o3
         QeKKA88qtSeGC0v5xvgo03OIteyW6xzQx4h7lPfhHhowZPy1/IkAytrDd803L+lWKNwo
         r4Rg==
X-Gm-Message-State: AOJu0YysZdyHv1NNmhwEOc4sI1vwuE3POFp8lWnynZgcpoTnHJPRXouq
	6mtEkEsi2OxjnSxVfGJS+HBh0Gc3h6sLodQex2I=
X-Google-Smtp-Source: AGHT+IEdG+ilWCKi4qf+cO3YByEo0X+VzoeaHNCrL8yn+hGMdsAnl11+WzIaMD13SAlEzFCAOLm+VA==
X-Received: by 2002:adf:f803:0:b0:314:39d0:26f6 with SMTP id s3-20020adff803000000b0031439d026f6mr1967715wrp.18.1691676866794;
        Thu, 10 Aug 2023 07:14:26 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9609:9964:25d3:6050? ([2a02:578:8593:1200:9609:9964:25d3:6050])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003143b14848dsm2269215wru.102.2023.08.10.07.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 07:14:26 -0700 (PDT)
Message-ID: <14af2af7-5d61-4211-acca-2c9f40c46421@tessares.net>
Date: Thu, 10 Aug 2023 16:14:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mptcp: Remove unnecessary test for __mptcp_init_sock().: Build
 Failure
Content-Language: en-GB
To: mptcp@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20230809225918.21523-1-kuniyu@amazon.com>
 <5f6a198d-ca0a-6325-70bf-1dd68ed2b2cf@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <5f6a198d-ca0a-6325-70bf-1dd68ed2b2cf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kuniyuki,

On 10/08/2023 12:04, MPTCP CI wrote:
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.

Sorry for that, Patchew[1] automatically re-applies patches when tags
(Reviewed-By, etc.) are sent on the ML and we cannot control that. So
here this report is exactly the same as the one you got with your
original patch, just before I applied your patch and did the
modifications in the other commit. So you can safely ignore this email
and the next one.

[1] https://patchew.org/MPTCP/20230809225918.21523-1-kuniyu@amazon.com/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
