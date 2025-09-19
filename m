Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6525A326
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264849; cv=none; b=lIY0t9qqkV29BEf8q7rr9MoQDaSNHaIlNVk07C3UeAOJvQa9ALrVj8c5xbiZ6Yw6q0ViDhRLpIlB5llPtztil8NMrOlC/zNUaE6UCWgIN1N7yfIpaGJO00zSwM+IEN79NsvEvVpNu9Mq4jzKQLyaZet8ZL4o2i1E/IPJNCiDD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264849; c=relaxed/simple;
	bh=j5azgMkJAJtsk7PlwYvVxAiOqd/kxdIqux1d2iAYMiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MVvoWgJMYLrNxu9MTzA4gIQ1TKgqLKdfcfpgGVEmgQBWRQNBNOiwBp5oA5A7FNv6LE0E737WNeS55z9OYMXIs58b8WP8pyR88IHz6j5i8ahi6zLl+8qdZ9MPvMT7pLLedLxeF5fewzxsw24SQxj2n90bsVicUvoHxg4smgNZY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a92YvIt9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a92YvIt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758264846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJwhKtuW1Ey7JtGdReqfAX1K/Tq/7bqeF4HUcArvC1M=;
	b=a92YvIt9lRtoz8LGIq4mkynElFPSln8VyPHOMucsJrDCIIsZS9FunAtEXQ7UF+VJ+5C0iE
	gGdw2Tl1KXhsDNVAc1hzFfuVpwx0NnA2hFrcy381CBosMVIj52p5aWQsbLgPJA6KSunDaS
	dZcCal+1l3SdcVBcGgzNNAEoPPjuWVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404--MThriGrMAyHilAXT8nB1Q-1; Fri, 19 Sep 2025 02:54:04 -0400
X-MC-Unique: -MThriGrMAyHilAXT8nB1Q-1
X-Mimecast-MFC-AGG-ID: -MThriGrMAyHilAXT8nB1Q_1758264843
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3df07c967e9so904573f8f.2
        for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 23:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758264843; x=1758869643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJwhKtuW1Ey7JtGdReqfAX1K/Tq/7bqeF4HUcArvC1M=;
        b=uuu3PMgxqCDDgCh2PczXJD7WWGo6Ac5/7dndZljhdEySuTPJzOhS/RdykWJD0+op45
         GkJfxtrrz5BrvaUBRgMLZTtXhcHSzB+NHWRpmYgamsyjHpOdiv81aJXMA01a4whKaqgh
         yhuROgru9SLC4FBxVLMuwIHi/ThFIQ0wI0ExFKO6zSR4vqba05iqRFc+ge6rHTYZRBZz
         zb2mFRI7nHk4ciIdnDSXeBKkVKzpGTe7CQhEOCoS+8qHdk56H1VEUmFLIkp2kdNA0Y+8
         rmbh6v3X1cq0tc0DvDgDxzId2FRvspI6fQxW68zCAfY/T4s/xcQUW1O7aQ0kldDXLnT0
         prZg==
X-Forwarded-Encrypted: i=1; AJvYcCWjElkuto3L2/w92996zs09washElCrOn7tP64TFjKtQ8riCP/7Bx3sWWNpQE1PIcrSHhDV3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrZUQ3ztvtorMf0kz86Udegw9JMgQb54u0RD55ReJkqWOVRdpf
	HbXOwfeNkuItNowbybi2/v4ZTIrlEsidMrdjTECO1WAxzQ9iGzNKzBdfBoLgwunj4foIWNM1WKe
	vRq3WD3O2ILhm1wITR2j43iriYoApyk4WzH2jbEStnefIN80fs1WHtP2LVioLJtNw
X-Gm-Gg: ASbGnctcGGsxUZ4iW2K2BHAvex49BMGve1VXNG1P3E41YzcswiUGFneB1AG1Dj4tS9a
	8YpLvMhpCc/RTEi0FaAg//LPp7sgJaYVaNZ4+SNYDyCW21eGVfNZzehDjFdDLYCnQWouNGIOVEu
	pDNxa8cRT2LayRAgqbqxnQTZWSAhDQMG6f7f4QDhAfIQBSrw2JMNeWZwKtSPu6lJ5P5t6fjcC/x
	1EtPzwMzbbczklrmzoozeGNbgLimb7Vw7+e5XhQb69VDixu+g+ayZCfGXaCQqcBuh+kpFdgv6GQ
	WyBn7gwZmQ0GsMJoOkwgtAQpzxBdLkALS3pwz4Zcx36M2w//0mvgleN5cXXqUKOSt7qY0L0AnVp
	/is644WKjWD81
X-Received: by 2002:a05:6000:605:b0:3ea:5f76:3f7a with SMTP id ffacd0b85a97d-3ee7e0116d6mr1031626f8f.22.1758264842915;
        Thu, 18 Sep 2025 23:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiqOTWoK5NimGaF6KME4pKRAU5k5xuZQY6r3boIPFsGTnuZa8/g7owTgAXsw429V+qAQEmJA==
X-Received: by 2002:a05:6000:605:b0:3ea:5f76:3f7a with SMTP id ffacd0b85a97d-3ee7e0116d6mr1031602f8f.22.1758264842457;
        Thu, 18 Sep 2025 23:54:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407aebsm6722474f8f.14.2025.09.18.23.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 23:54:01 -0700 (PDT)
Message-ID: <7da5cd03-b5ce-4062-a23f-7bd7ecbec38c@redhat.com>
Date: Fri, 19 Sep 2025 08:54:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 00/12] mptcp: receive path improvement
To: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
References: <cover.1758214563.git.pabeni@redhat.com>
 <dd39e243-9ffe-86c0-9db7-6c108470b3b2@gmail.com>
 <0387885e84d41f14cf23914c85d2191f1cdfdae9.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0387885e84d41f14cf23914c85d2191f1cdfdae9.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oB8qy3E7BQS_nRmXWTfvEe8Q0B2AvqyGtRN6GoXVexg_1758264843
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/19/25 4:22 AM, Geliang Tang wrote:
> On Thu, 2025-09-18 at 20:33 +0000, MPTCP CI wrote:
>> Hi Paolo,
>>
>> Thank you for your modifications, that's great!
>>
>> Our CI did some validations and here is its report:
>>
>> - KVM Validation: normal: Unstable: 5 failed test(s):
>> packetdrill_mp_capable selftest_mptcp_connect
>> selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap
>> selftest_mptcp_connect_sendfile 🔴
>> - KVM Validation: debug: Unstable: 5 failed test(s):
>> packetdrill_mp_capable selftest_mptcp_connect
>> selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap
>> selftest_mptcp_connect_sendfile 🔴
>> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
>> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
>> - Task:
>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17836736262
> 
> CI reports that this series breaks the mptcp_connect.sh test:
> 
> # INFO: disconnect
> # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration 
> 1348ms) [ OK ]
> # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       main_loop_s:
> timed out
> # (duration 61185ms) [FAIL] client exit code 124, server 2
> # 
> # netns ns1-HugJD9 (listener) socket stat for 20002:
> # Netid State     Recv-Q Send-Q Local Address:Port  Peer Address:Port 
> # tcp   TIME-WAIT 0      0           10.0.1.1:20002     10.0.1.1:47722
> timer:(timewait,,0) ino:0 sk:2066
> # ^I
> # TcpActiveOpens                  2                  0.0
> # TcpPassiveOpens                 2                  0.0
> 
> I also tested it on my end and found that starting from patch 8 "mptcp:
> cleanup fallback data fin reception", the mptcp_connect.sh test has
> been failing.
> 
> I apologize for not providing this feedback during the v1 review, but I
> was too busy yesterday to complete the testing.

Thank you very much for bisecting. I did not observe the failures on v1,
but I see them on v2 (which is quite suprising, giving no big changes in
there). I submitted v2 anyway to give syzkaller/CI a chance to run more.

I think patch 1-3 should be sane and effective, we can probably merge them.

Thanks,

Paolo

