Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801E9614D
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 17:15:43 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a8so4182658ejc.8
        for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qmjm5ZTNvQKm6KvoaEwG1h8elVmk32UMJfP6p8z2hUg=;
        b=6PbuG1d5AvlHzfV0WScgOLj3qFmWfpxQrAGPe0xF6g5/JYMc3TW26aLAJ3+Y7MJn2w
         DpjXWx2bpvAe9vgV/Ku+Efmd87QmHa0m9YVv1YqM8dDSIw9ZKHU3J381ljx4GOTxxzvs
         FSzAi6VKeDaIvkRSygG/0ukOZF47qMrVS9VV/HVR3lvqI7bGRFmF1FAHYY+42a8SmdwM
         yoolfwgam/qcd4/uvRQw03KQToVjX2/7zzELPE4yByFEaTER9q0LmBM5EqZFxkjn+pp9
         70seZAanL+j+tEiAtNk9B/jz/L9Odo/K5lJOK3wraHmshxYqRKCW9cyV8Ncv0hCXAE7/
         ZhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qmjm5ZTNvQKm6KvoaEwG1h8elVmk32UMJfP6p8z2hUg=;
        b=vh23VE1nPw7ma6dDbdNkzPCo/brTYMK48C0DEVt9npO2DSx+O3Lpx0me/K5a9JF+1q
         66LdnBVMq9+qY6ECPa3ITmteQ2lFkoAHcCxNFtYXdAxRqiKpFLLaCc0Vf3iyaqinv0Dw
         Ut29TEjc08YtPopQzgoUw/3V3f/ZvLdvsLfUFUn+ES/u21DcRIMRijLPzLO60RStkjXh
         BUtQxyqY/6qjdOtoVJzgRIlG/WJHb/Kdf43ca0igl7Ik5cJRluEBdivKHCpGH3A0+TpH
         m3lzbXSCzDv8wr0PeievEwDhif517k639sZJZ7ZLbSLi6jhHq4q0f/7xdRRsmz+07gvF
         F/8w==
X-Gm-Message-State: AOAM533YH+coWmBn/+oK2ZjErIM4l0/aAbbSGpUSF0shrUrxKcTVftlq
	KdOtJMFLxGpy7diuplYAG/j4mg==
X-Google-Smtp-Source: ABdhPJyqpYyOZd0o/+NF8ohMHED2m+meiRzGZRCKZGC00ZnvqTNU0v58+rijsEcN7Zr05DLeFmEU7A==
X-Received: by 2002:a17:906:9b85:b0:6db:ab80:7924 with SMTP id dd5-20020a1709069b8500b006dbab807924mr1176856ejc.160.1648055741706;
        Wed, 23 Mar 2022 10:15:41 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:5c66:3b6a:a041:aaaa? ([2a02:578:8593:1200:5c66:3b6a:a041:aaaa])
        by smtp.gmail.com with ESMTPSA id c11-20020a056402120b00b004196059efd1sm217358edw.75.2022.03.23.10.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:15:41 -0700 (PDT)
Message-ID: <2ec04b6b-9943-db88-469f-94bbd8a14903@tessares.net>
Date: Wed, 23 Mar 2022 18:15:40 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 mptcp-next 2/3] mptcp: reset the packet scheduler on
 incoming MP_PRIO.
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
References: <53b59c780c15855fb57ec41e187a19272747c9d8.1647960598.git.pabeni@redhat.com>
 <ed967b995918548f6abf8f2625b29bca770f132a.1647960598.git.pabeni@redhat.com>
 <664e844-1d26-d3e3-fdd-5cb343645@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <664e844-1d26-d3e3-fdd-5cb343645@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat, Davide,

On 22/03/2022 17:54, Mat Martineau wrote:
> On Tue, 22 Mar 2022, Paolo Abeni wrote:
> 
>> When an incoming MP_PRIO option changes the backup
>> status of any subflow, we need to reset the packet
>> scheduler status, or the next send could keep using
>> the previously selected subflow, without taking in account
>> the new priorities.
>>
>> Reported-by: Davide Caratti <dcaratti@redhat.com>
>> Fixes: 40453a5c61f4 ("mptcp: add the incoming MP_PRIO support")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v1 -> v2:
>> - fix backup comparison - Mat
> 
> Thanks for the v2, series is ready for the export branch:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patches, reviews, reports and suggestions!

These patches are now in our tree (feat. for net-next) with Mat's RvB tags.

New patches for t/upstream:
- 9d336ad77b77: mptcp: optimize release_cb for the common case
- fadfdaea5a2f: mptcp: reset the packet scheduler on incoming MP_PRIO
- b9854c166093: mptcp: reset the packet scheduler on PRIO change
- Results: 73b94fb27a8c..ff138f44bccd (export)

Builds and tests are now in progress:
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220323T171227
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export



@Davide/Paolo: I didn't merge the new packetdrill tests because there
were still some opened questions. May you have a look if you don't mind? :)

https://github.com/multipath-tcp/packetdrill/pull/82


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
