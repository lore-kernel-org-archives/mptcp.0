Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94442C80
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 17:08:23 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id w1so14236864edc.6
        for <mptcp@lists.linux.dev>; Fri, 03 Dec 2021 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y+uoeN+DznTV3/Yb1Mq3oB4O/GDbGk/2PA6rVzxInq4=;
        b=QEzpLMkGIuG3k9bVtgAL4LxF0r01buiKEaVuiIO1Mr0wC4Tk9zreFL/OJ4ry6XqdSo
         nKbrKOP0BR32SouaM2NjfpLTTT5TbleVK9YpxVA3QkD8NGFZw+vbA4HUsdGeFrBqgW8E
         IDgIz9A5xDP3RbfGe9U+zeX9ru6mtqYCQqmenF2WXccYyYotN+vaydqzSh2VUmovkJzi
         RueaKO6+i6UamJGEVbC/o4FulOY9zHe6YgMrqCEXMk3mHxnnii/ZCuuRXeK0BVy/66LH
         H4htdJsgfIe4VEwRyJIyoChB1L8HpuibW49RH0v6HaYDzsg57Ul4Kj5ZN4A2XhUi6qys
         ApjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y+uoeN+DznTV3/Yb1Mq3oB4O/GDbGk/2PA6rVzxInq4=;
        b=wrQFk/bGdpgk/NGIG2IHAu8UMq2HWrqibGzQoxh8hc4M0FajGRXYh6tVv6UrYIDj25
         FRUdzdKoMQIPgFpedGkRQLhCs3t6Gxsj1NZWlYWQBb5ZK2myUTNxET+PbS/z4ld0PfBS
         C8YzYREF2dqilOb1Rbx0YaWOtg/jTRCqjepfzJXmXIZZAjrtO8JvUMEuFDrdu6Voc6dV
         dxuWmZ8uCYYauhwSv6Wx3Ao79gKJIaHIFPKPhW7R/6eAP3xnVVxam4buUUh2M+nXOjbx
         i8d2N6pW/+QfZ5zsm6vN0nuEUEorQFpoUM5AuHoWkTNXULlq+YfCctKkrZipixlTpN7B
         cajw==
X-Gm-Message-State: AOAM533HgXBY2Y8a9RQsR75FXNhOeMJuLszy4GYhFf60Bep8UXa2zskS
	k6/myCM99evv7sxnPJHFDqRU8TeXNTIOnkvTQBI=
X-Google-Smtp-Source: ABdhPJxFeJL5WarH33sAIj8Hp3By6O9zgehvlkT4hrFCNDpnZhZQuGxZkU0o6jIm29euGu6uBS5lFQ==
X-Received: by 2002:a05:6402:5146:: with SMTP id n6mr28171308edd.126.1638551297325;
        Fri, 03 Dec 2021 09:08:17 -0800 (PST)
Received: from [192.168.178.33] ([213.211.142.51])
        by smtp.gmail.com with ESMTPSA id b7sm1162364edj.24.2021.12.03.09.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 09:08:16 -0800 (PST)
Message-ID: <f2ae3156-b247-683c-440b-999cd5f251a4@tessares.net>
Date: Fri, 3 Dec 2021 18:08:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: add inq test
 case"
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20211202173216.2982478-1-matthieu.baerts@tessares.net>
 <20211202173216.2982478-2-matthieu.baerts@tessares.net>
 <87d35f49-695f-fba-3c1f-3c993fbbbf13@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <87d35f49-695f-fba-3c1f-3c993fbbbf13@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 02/12/2021 18:52, Mat Martineau wrote:
> On Thu, 2 Dec 2021, Matthieu Baerts wrote:
> 
>> Fixing a -Wunused-result error:
>>
>>  $ make -C tools/testing/selftests/net/mptcp
>>  (...)
>>  $ gcc -Wall -Wl,--no-as-needed -O2 -g 
>> -I../../../../../usr/include     mptcp_inq.c  -o
>> tools/testing/selftests/net/mptcp/mptcp_inq
>>  mptcp_inq.c: In function 'connect_one_server':
>>  mptcp_inq.c:303:2: warning: ignoring return value of 'write',
>> declared with attribute warn_unused_result [-Wunused-result]
>>    303 |  write(fd, buf, 1);
>>        |  ^~~~~~~~~~~~~~~~~
>>
>> It seems adding "(void)" is not enough. As a workaround, we can also
>> simply the output of 'write()'.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>
>> Notes:
>>    to be squashed in "selftests: mptcp: add inq test case"
>>
> 
> Also ok to squash this one.

Thank you for the reviews!

- 17b56c543ab5: "squashed" patch 1/2 in "selftests: mptcp: check IP_TOS
in/out are the same"
- 6680d9b3e2bd: "squashed" patch 2/2 in "selftests: mptcp: add inq test
case"
- Results: 89018cadd36b..9b3f10607961

(For both patches, I removed the automatically added 'Co-dev' tags as I
guess it doesn't make sense for this kind of fix :) )

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211203T170803

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
