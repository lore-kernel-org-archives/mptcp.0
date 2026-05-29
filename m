Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB993A3E78
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040922; cv=none; b=b8BHzwW93B9t3Nfa9WE3q+k5yyAxUwZlhZciABtFhabgrukSWuNkg98SkJY03CUncrsSheDZzy2ScRfJVfBgLslCePyYqs8Rmbk/j6QvI6UTOh0CLjiqXHwa+4NPghSasH9742snG2PuSqmiSsVYN5ozCVTgWtQfqkR1eAgSjLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040922; c=relaxed/simple;
	bh=Pgira/dOJJyW+OEPp0YfW1Gh/nbcnT2SaSyEVzIED5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEd2QyEz64SYBdDEQGY3z6fup06nNonn0cp4dcslH2ImpfoYnJtoNP65Np+5igRW2Hv4cq1Whcp6XCifO4Jm27qqAABebq2g2bYKMO7GJo9lTus57qzrRO/XJe+PTb8kwHuUJw0IvDuJ6DHpBgpS8awjlXL7U8EcV2C98FlsVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EA/hKdEC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA/hKdEC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780040919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGHs+BhRQHi+UbJNdkHHmOXBdA8bHEqdWedHPan3gVY=;
	b=EA/hKdECYnfBgVy6jiDTZs3zB7Wg4weB4bwKBWocgzjfX9B0RvBGTrBQMfCA5Q54jJ1VYj
	y5LTsseZzmmTUaDeaw7Ywi/Fv4uKQSkfo5KfaJmSVsPq+pyZE/nIWxXXWUAQ5cCj8iyUs0
	ibCAd6bTJeJ3+XJgtFrrzs7M9ymFQck=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-ie2yu4Y8POC10pk02GIh-w-1; Fri, 29 May 2026 03:48:37 -0400
X-MC-Unique: ie2yu4Y8POC10pk02GIh-w-1
X-Mimecast-MFC-AGG-ID: ie2yu4Y8POC10pk02GIh-w_1780040916
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49050c44bcdso76856085e9.3
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 00:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780040916; x=1780645716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGHs+BhRQHi+UbJNdkHHmOXBdA8bHEqdWedHPan3gVY=;
        b=Qfrx+iLfOXBzys/ZvSCnxiCQeWFgU0Fz5vf3Rm1OHQZOY8l8IcDoNbhw76q8u7xHoF
         1/DhgTB4U2Rqj17JAruQ2a9pgtOK9c1rfBIAHTWmvM/x/wm26vI/AjQoSbmWi8jCIoes
         wCFCCTD+3yzBgp4FHnf+MPfj/MOr/6etLbg46AGI/Lk9SK1jZcb4p46KUZybHvscmgqK
         GWSwzhDsmdxx7bAzQdXM5GbkCEVOonluArR7+ArIk+9IkdTP/5FjU7Gfg/98UN4yWC8g
         42CkHyK3rNnKcyRKb9uVJ92w5Wb6rGP4JAIG2TcguUEBfCjjnohvMwLcijoE6P1Rgso+
         8O7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+53gSYpPq5VBw3bzkl5TIhbKZMC7WlXlsz2lBIzq+nP67MRzG6GnAUjU7Rp0Cf7neYoGFTcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfqiN1MHe13fXuhd3vju/eI9FxiVBMlnMCGmiMuqG2Om81jgIu
	lgw9NXVl/a0olv406dNXRLK+NXj4w6pFkk7DwVs21HjFxqNsJasvLHQ+R2k9dNbBw97xBMbuaRt
	1DyijCQ/Ei86ffaca5DaKMvexnTAgl8EJXT9zmqPBr2dgg53hw8BFpMsY
X-Gm-Gg: Acq92OGOmmN0dLkcPnUigD3A5rK0DKClyg7cvFtMyYHw3YqHpTVyrdJXEbcKzyJ9QbJ
	+K1ArmIpsOsVMYorjFm0Kr1TVhZRt1OHLapNGFoanDA4BLlgP3cNBnlCUzOnJIDHjW/QkQwqupW
	Lk7vgij+q0T3SMQ2RWbiRyN6v/cKQI2dBDfAh/Gy2RIpg5EVd2Z43d2T0X6hh2XrXdP3lvSNWTh
	PlyFx5E+xBbgkdHYKWi+ptDdwfScfdJLkhXQ9bHDk/IjSsSUmgzWDcJLhCA/BbV8UsHyBNf23R8
	MrjQMmfkoRfBk+rGKolLqyK2mTdbQ9lmDfpFsEsLKYSWFkUU/kynaF70vmby0gbI0UMhGMSHC3U
	fjOMsH5bXi0CxqUCoobP2P+2VJHQxQjo4sj3TiH+y/cui+4WCM8bhExUCZEhdBA6ldD4=
X-Received: by 2002:a05:600c:4ba8:b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-4909c092130mr17023835e9.3.1780040916357;
        Fri, 29 May 2026 00:48:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4ba8:b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-4909c092130mr17023595e9.3.1780040915947;
        Fri, 29 May 2026 00:48:35 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c1035ebsm11391635e9.5.2026.05.29.00.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 00:48:34 -0700 (PDT)
Message-ID: <452a83a2-f715-4f22-906e-0d2cc0dd1240@redhat.com>
Date: Fri, 29 May 2026 09:48:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in
 mptcp_established_options
To: Matthieu Baerts <matttbe@kernel.org>, kuniyu@google.com
Cc: syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
References: <69f8e352.170a0220.bb392.0005.GAE@google.com>
 <2a9bde65-d2de-44cc-9192-e7aa8a0935a7@kernel.org>
 <672f5b7d-6fa0-41c5-a950-2890028c8572@redhat.com>
 <ba9aa82d-efd6-48c8-8e90-8820a21c5402@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ba9aa82d-efd6-48c8-8e90-8820a21c5402@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q0BQZVlW-ej8l0a73jrHFVz9jENjwHvcymDZrl_fuAM_1780040916
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/26 4:41 AM, Matthieu Baerts wrote:
> On 08/05/2026 19:27, Paolo Abeni wrote:
>> On 5/7/26 9:44 AM, Matthieu Baerts wrote:
>>> Hi Paolo, Kuniyuki,
>>>
>>> On 04/05/2026 20:20, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>>>> KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt
>>>
>>> It looks like the issue is different now:
> 
> (...)
> 
>>> Plus I'm not exactly sure to understand the issue here: mp_opt is
>>> defined and used only in mptcp_incoming_options(), and I don't see
>>> anything using it after the end of this function. Or did I miss something?
>>
>> I also had hard time understanding the backtrace, I think some frames
>> are omitted/missing (it happens sometime, IDK why), specifically the one
>> related to mptcp_options_received() - which would be useful to
>> understand the issue.
> 
> Because the other issue spot by syzbot seems to unrelated, do you plan
> to send your patch upstream? Or do you prefer if someone else does it?

I'm sorry /me is losing track of multiple items. I can send a formal
patch to the mptcp ML for:

https://lore.kernel.org/all/5841afcc-13ea-4bee-8645-634a02e76c4f@redhat.com/#t

/P

