Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279C8AD38
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 15:09:40 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so1042180wml.0
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3eKcgZnlmRELHbIx2VxE/dJMmsiTLWRVnj/y8RLsXU=;
        b=e1vBcw54PIK6t38357mkx9z8C6qbcZu++6A7K+DDh4qEXia6QfAHmtnn5aX6/IWwk+
         PyIKU+FkaMA1EOmRXkWvV6yHk7FROwez9u431r+kYeqAH/jWngTielajxDI58yJdmsCR
         Z7DNcklWc8gv9LAAl1f6sJTFs4kypCOxR9dqoav1BvJ1/IlFYaJCkQygqpLEWzwxTlw5
         5d3IYZVDNKObDgzmywjohoEqWC3ap5gljWos5sGB7Xn30VtbwfKhX9m7V6f2N7h0YCm+
         Rksq3EnQR2hnkurZMjMI3capZlgnNrA59vVaV5im35DE+8KZNChH83+hTWFL5qv1Rmt/
         DHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3eKcgZnlmRELHbIx2VxE/dJMmsiTLWRVnj/y8RLsXU=;
        b=JddqYsWYErGhWRpop4RX+6N7eHdByrfakXC7rIxkya/foANgU0NQ5uQUbYgeLLIAcn
         YF/K404XPbcR9ZRCVGP8krn2dyf+s+EN6rGChAooT3GZTJhjyZM6Dhnj5p7FNY9v4Rdw
         cynuN4sh2QTv7JvOiegxbDDmZCuLGYWShKT6xjS7Xh242nSwkYZlvpo7Ent64qJyoURN
         uSOhxbLKGfBaJeeTLDyM5LKtVGzRPGwu2IRUKah46jcJZQEL6H3s0lh5rK0PJf2kjo4F
         g3MA485t/fKyUB+WeFWKP/5yKGA5kWXMcTHlxiS4Qo7HqsJ12T+CCCjADbzJng2iotTm
         FxPg==
X-Gm-Message-State: AFqh2koiGhTxz3clZUVzf+OPsqSnSGINj0nAeuYBqJnuUsLCEaYcKu+3
	Vrxy6VUXSy04ORo8eASFXUN35A==
X-Google-Smtp-Source: AMrXdXsATfVWeEbYIRpgyfrrIuaJwT38KVf66P5Nvx5RwRAaz8F+NnOcnpZOzrYp/oZSV7JhLTVpPQ==
X-Received: by 2002:a05:600c:4e48:b0:3cf:69f4:bfd4 with SMTP id e8-20020a05600c4e4800b003cf69f4bfd4mr35298161wmq.7.1672844978378;
        Wed, 04 Jan 2023 07:09:38 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:887e:c4c3:b863:9e41? ([2a02:578:8593:1200:887e:c4c3:b863:9e41])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d52cd000000b002425be3c9e2sm33936197wrv.60.2023.01.04.07.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 07:09:38 -0800 (PST)
Message-ID: <44d68b71-24b7-e4e9-3a9f-a5b3b519225c@tessares.net>
Date: Wed, 4 Jan 2023 16:09:37 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-iproute2] mptcp: add new listener events
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <20221226093558.599103-1-matthieu.baerts@tessares.net>
 <93761b86-6851-c1e1-1ddd-86942f71128b@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <93761b86-6851-c1e1-1ddd-86942f71128b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 04/01/2023 02:26, Mat Martineau wrote:
> On Mon, 26 Dec 2022, Matthieu Baerts wrote:
> 
>> These new events have been added in kernel commit f8c9dfbd875b ("mptcp:
>> add pm listener events") by Geliang Tang.
>>
>> Two new MPTCP Netlink event types for PM listening socket creation and
>> closure have been recently added. They will be available in the future
>> v6.2 kernel.
>>
>> They have been added because MPTCP for Linux, when not using the
>> in-kernel PM, depends on the userspace PM to create extra listening
>> sockets -- called "PM listeners" -- before announcing addresses and
>> ports. With the existing MPTCP Netlink events, a userspace PM can create
>> PM listeners at startup time, or in response to an incoming connection.
>> Creating sockets in response to connections is not optimal: ADD_ADDRs
>> can't be sent until the sockets are created and listen()ed, and if all
>> connections are closed then it may not be clear to the userspace PM
>> daemon that PM listener sockets should be cleaned up. Hence these new
>> events: PM listening sockets can be managed based on application
>> activity.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/313
>> Cc: Geliang Tang <geliang.tang@suse.com>
>> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>
>> Notes:
>>    No objection for the names?
>>
>>    We are currently limiting the name to 14 chars. If we want to have
>>    "LISTENER_xxx" instead of "LISTEN_xxx", we need to increase this
>>    limit. I'm fine with the current names or with +ER.
> 
> I have a slight preference to go with the LISTENER_* names and increase
> the fixed event length to 16.

Fine for me, I can do that in the v2.

> Also had to add "if (tb[MPTCP_ATTR_TOKEN])" before the token printf() in
> mptcp_monitor_msg() (line 502) to avoid a segfault, since the listener
> events don't have token attributes.

Oops, sorry for that, I was too quick in the testing and just realised
the selftests are not using 'ip monitor' :-/

The v2 will contain the fix that I just properly validated on my side.

> The patch only applied to iproute2, not iproute2-next. Not sure which
> git tree they expect to reply to.

I'm targeting iproute2 because Geliang's patches are in netdev's net tree.
I can probably use 'mptcp-iproute2-net' tag in the subject.

Thank you for the nice review!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
