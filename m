Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067783D79
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 09:22:33 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id ja24so3956330ejc.11
        for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=smksqtPDRxMzPChwu6QV5PzkvEaBAKcPxJJPLD3Sf2U=;
        b=MbPPZOm0Sjdwn2Bt9GMJh2EL7Fyc4hpxnxDiZS4J/5iKNlqeiA0i0tRxllZWdCp/5l
         a5NWD6XCvGAk4hBtJ5M1WrNiqL3K989pc49BjcqmDzA3RHHk+KfOuBYNSK+BwWiGSdB5
         76I2RjI3k8wKjUKQahMZiFdO2wPti4kK8ZmeSQ/Vz8JstRFJV9K1NyNYR0x05B/K0IvV
         n5pmr4++DudQROiDVXYAi1v9LtyZTiOLZDcDId50qdEwS/igSarvNFTtu13WMKzgrjYt
         DntKTMgZDNd0tRjZEA6W6NDW3/KJeGRBI3TtnrokkutpnVXdvidL7f8BqfvFYkorsKzT
         ZNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=smksqtPDRxMzPChwu6QV5PzkvEaBAKcPxJJPLD3Sf2U=;
        b=vsykba/6NaA1jeovFl3h08aoKBTUEIwDGxo9/WsaNVNs2IHtdvi5FoIHEOiotywO6G
         FNsZCc8KynjR1iIxZr4wZTvKhJdDn60TzapYEqlMe4FWOgyYSNzJyEcsdtkcoJFQ5dF2
         1MPQC8Kcx6wuSeujFE2eIXJb+FqX+eatqV/6x6wRnlxM0/H9vKCc04qwmvlSg2kFetUu
         rj7L0QuNODqd5UMk0k5ac9mUIVLW8ncW/42iEnNHy7Hr2nwEAAU+fu1OUj6F3hF/zox9
         K+A27s5Bceb0FAMsPUaMgcGarh4DAt8qkP1z2jCUQ5jS1UZ28oNTOH23qD2atWY+4gbM
         aJ+A==
X-Gm-Message-State: AOAM533ycuHGrEveLuic32OmZOpY5qiQOGuy+gEfAtH+ekXu4/Ixcm3K
	PoMV1Cy84fnIPnWnBB49AA8fXZo0TtwoaQ==
X-Google-Smtp-Source: ABdhPJxSWine4RYdK1UWFCxe1wt7OjC945xk0QwuuEf0nulOTZW0kiA3WnO6G2nZVcE8k4i0tRCttg==
X-Received: by 2002:a17:906:3117:b0:6cd:f81b:e295 with SMTP id 23-20020a170906311700b006cdf81be295mr3229629ejx.511.1647508951832;
        Thu, 17 Mar 2022 02:22:31 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1150:b408:6e54:b32d? ([2a02:578:8593:1200:1150:b408:6e54:b32d])
        by smtp.gmail.com with ESMTPSA id sh31-20020a1709076e9f00b006df6faf3500sm2109579ejc.51.2022.03.17.02.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 02:22:31 -0700 (PDT)
Message-ID: <42689a87-1939-07a6-d824-4ecde16d50b6@tessares.net>
Date: Thu, 17 Mar 2022 10:22:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: mptcp: expose server_side attribute in MPTCP netlink events:
 Tests Results
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>
References: <20220316190747.634325-6-kishen.maloor@intel.com>
 <e2b531cd-2927-ad69-81a5-c67b689fddf5@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e2b531cd-2927-ad69-81a5-c67b689fddf5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kishen,

On 16/03/2022 21:55, MPTCP CI wrote:
> Hi Kishen,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal:
>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>   - Task: https://cirrus-ci.com/task/6221660377317376
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6221660377317376/summary/summary.txt
> 
> - KVM Validation: debug:
>   - Unstable: 3 failed test(s): selftest_diag selftest_mptcp_join selftest_simult_flows 🔴:
>   - Task: https://cirrus-ci.com/task/4814285493764096
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4814285493764096/summary/summary.txt

The errors in mptcp_join.sh selftest are suspicious:

  echo  [fail] got 0 ADD_ADDR echo[s] expected 1

We can find them with and without a debug kernel config.

May you have a look at it if you don't mind?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
