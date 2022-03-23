Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9E66A2
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 16:50:47 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id p15so4047891ejc.7
        for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=TSM9f1S5xVKjNBWTOWu+hDXE+uFDnwjT0ajxrNbz3QU=;
        b=pbF+0FUcxlx1i+DIB1VboccsipqyQkNE/x5AXpPYDAhF6PzCo9Q8yFNaFgeeV2Bb71
         9BejpZ9N8rHriTYqolzPpfVDt7wYCj0qDrBl7SrrNEW/JNv30B4gsP5upJ+olCdpC9ym
         yHN2EjFbhFnr71j77qry6/ZoXK3HLIPO/0eF9ISI6UuCLgq6w9a/Nb4xI0dSzQ2lGVqG
         Tw5jwSxWQ6CB2Ba1X9YhLxaaVExhfPAr5uM0fgXAPY5Wy/tXdKaRXu3NXjbH3GtAaBXv
         a4DKUZYOPdj6XQH3EOtGoWN0nP7BjkNBwd1v2QmkASXL2y1UgJvribhiD59sDoYIW9Y8
         yQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=TSM9f1S5xVKjNBWTOWu+hDXE+uFDnwjT0ajxrNbz3QU=;
        b=aVgqnyBXIm3fJrS6pPxCItQBCJPKtD7ar3617mJmB6yPZnn3xpwmiIhVBWzTVM57EN
         ottRKIJgHK/tASkz01J9uzpkjgGFWqhMCIqV3NzbllViWm6lF6CCrOcL7iSG/tXVmEPm
         t/agfsoOEKHF/i6aGcMRTlW0UGabSZKzHNYlXfE3z8wgpnbSoiaHHWAG5VWVykyAlXVD
         b7Ou8yla05TdIvR7FVd7d+s/f2GCS1WW7MAzHvlsC0DK765IpXepYC6kd1hX4Cf29vtb
         Ok04S7eeJj1QB+N25ztJSLCeB1Ti3Mivv2R/CTsGzDr5R6ag9cuJ6SqgSICxnPtDQyTk
         uikg==
X-Gm-Message-State: AOAM532UyV3DTaofTQ3woGqEjPTKkaU2upLK1EPQyKjPZ4uDDKpKtumB
	kJTW5lXrLIIbFBbMrSOn84kv/s8+VvNydJ9s
X-Google-Smtp-Source: ABdhPJwID5/s+D4rOVSBYh8UgMM5CIo5WqutoOos+Kap5Y2GY0a6D+lKGgd1byZRVATeIq34eimoeQ==
X-Received: by 2002:a17:906:3a4f:b0:6cf:86e0:586c with SMTP id a15-20020a1709063a4f00b006cf86e0586cmr1006495ejf.626.1648054246039;
        Wed, 23 Mar 2022 09:50:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:bdd:c0c8:5d83:86c4? ([2a02:578:8593:1200:bdd:c0c8:5d83:86c4])
        by smtp.gmail.com with ESMTPSA id g10-20020a056402090a00b004196250baeasm201270edz.95.2022.03.23.09.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 09:50:45 -0700 (PDT)
Message-ID: <3f864428-c3a1-d0b6-cf74-fb3210997dcc@tessares.net>
Date: Wed, 23 Mar 2022 17:50:44 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v11 0/7] add skc_to_mptcp_sock
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1648025307.git.geliang.tang@suse.com>
 <2a05164c-4247-af3f-a3d7-19153314a64a@tessares.net>
In-Reply-To: <2a05164c-4247-af3f-a3d7-19153314a64a@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/03/2022 13:48, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/03/2022 10:09, Geliang Tang wrote:
>> v11:
>>  - merge "check more values from mptcp_sock" series into this series.
>>  - patch 2:
>>    - rebased.
>>  - patch 3:
>>    - rebased.
>>    - add 'Copyright' entry as Matt suggested in v9:
>>    https://patchwork.kernel.org/project/mptcp/patch/d6d33be9899118c5f542a6ce43f868d4e9e2766b.1646745228.git.geliang.tang@suse.com/
>>  - patch 4:
>>    - add test__start_subtest.
>>    - add some 'Copyright' entries.
>>  - patch 5:
>>    - change monitor_log_path to static
>>    - drop bpf_trace_printk()
>>  - patch 6:
>>    - use TCP_CA_NAME_MAX instead of strlen(val.ca_name) in strncmp().
>>    - use 'sysctl -b net.ipv4.tcp_congestion_control' to get ca_name.
> 
> Thank you for the v11 and your patience!
> 
> I already applied the two first patches because they have already been
> reviewed before and they were causing conflicts with latest BPF changes:

The new patches, the modifications compared to v10 and the Squash-to
patch look good to me!

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

@Mat: also OK for you as you also reviewed the previous versions? :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
