Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155829B2
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 10:10:45 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id j15so7842532wrq.3
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 02:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMwxaj6aIOfUm4vBFihhfooLIqSB7kfwrWeCfwwtFcU=;
        b=pj9EbH7v3HeqfGDA3Lt0O9UkVbBlTgnpg09H/BncD2fVonWX1g2KtYSRbivjXotOJs
         0vr1AR4yA8RV9PIsn4sY6M1TG8GhoXmDSQjuTX65b9Y/q5aXmL+E3mUIbvyxwV76kA0m
         h3Ca4g2rZOVfR5yXpUVUIpthqo2pm3Za2PqtSYkLmkw+HMONVZBsH9tiLSm1CqqCjoVb
         9lWP5MNG2cF+/VRHYAoSjsNX473zMpbN3FE07SYOmfF7HyLsdx/c/TUsFIOUWNKWFKaP
         4O1VhcFZg5H6aThAjCYTFwycXZy8Rrifse4jMXMUjZYwBJHvLSXlu99PAxUMR4fivzwj
         5hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMwxaj6aIOfUm4vBFihhfooLIqSB7kfwrWeCfwwtFcU=;
        b=HPhgN3bioPOtOcs0HGzKMgvaoqDxTt13nMzJxvbN5PGsHTdQFdokq2elXw/ZdliJuN
         eTipzI+F4zgylxwPLgt26cByEyHLIjlzYx0F+SApFFA/18bQFYrLhry9T364+aHHwQ9R
         6Vnl1qLgguGb4A7x7TdoLCF/SCs+cAWc599kQAw4F0vZYbqu6J5DoIl/2jrEkS6xT1/c
         mno9daRzS41+ZcoqEpRB/VPTPv1irU9KKnsSfKvegfZ4zcPOaWw+MZrXvj+lR8r4noPd
         Y3MIHH6Q9msejYWarMGZIlVbn/P4Xd0eZEQhk42jWrX2rJzKbDeKmQ1dgRLIyd4Sd6CS
         45Xg==
X-Gm-Message-State: ANoB5pmtG8Oqjwq8rZSVWa7vjoh9eDTAZX3dREgZkK+3C+aAKCFGzao7
	pv/I0cx5aD+Fsvw27AJop29rXw==
X-Google-Smtp-Source: AA0mqf7R2FIGFa+pu6/CYRMNDAWrddcfno7cxBBQTOKKta9wnYYa7RWDGVmzh+OTLEEnylVR8PLS4A==
X-Received: by 2002:adf:fd01:0:b0:235:83aa:a6ed with SMTP id e1-20020adffd01000000b0023583aaa6edmr3646319wrr.543.1668766243346;
        Fri, 18 Nov 2022 02:10:43 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id z2-20020a1c4c02000000b003cfe1376f68sm3998987wmf.9.2022.11.18.02.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 02:10:42 -0800 (PST)
Message-ID: <26bbecbd-bc79-e206-e3d7-bb7ba804a4c0@tessares.net>
Date: Fri, 18 Nov 2022 11:10:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-net] mptcp: don't orphan ssk in mptcp_close()
Content-Language: en-GB
To: menglong8.dong@gmail.com, pabeni@redhat.com,
 mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>,
 Biao Jiang <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
References: <20221118072030.3500578-1-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221118072030.3500578-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Menglong,

On 18/11/2022 08:20, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> All of the subflows of a msk will be orphaned in mptcp_close(), which
> means the subflows are in DEAD state. After then, DATA_FIN will be sent,
> and the other side will response with a DATA_ACK for this DATA_FIN.
> 
> However, if the other side still has pending data, the data that received
> on these subflows will not be passed to the msk, as they are DEAD and
> subflow_data_ready() will not be called in tcp_data_ready(). Therefore,
> these data can't be acked, and they will be retransmitted again and again,
> until timeout.
Thank you for the patch.

I don't know if you noticed but the CI found an issue with it:

- KVM Validation: debug:
  - Unstable: 1 failed test(s): packetdrill_add_addr - Critical: 1 Call
Trace(s) ❌:
  - Task: https://cirrus-ci.com/task/6018056502116352
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/6018056502116352/summary/summary.txt

Do you mind looking at that please?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
