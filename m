Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104E402BA9
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981374; cv=none; b=G8OgnohsZms+oOZCIJ+iaxDSshkQDDW4HwfeajyPkS5l9/aHfYZ4NJ3dk0/h0gMuZCALUdd3io1efNLpfO/gRUxce9ZVbuXOUE0jcKVFWpmsOTaCQN6ynznxxSOP4FdsIFBZ3baUfWfIAt5vQBWljlshR9yjEDcjIgdNeGTPVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981374; c=relaxed/simple;
	bh=Zsx058F91r/vCz2OecmadAV9QyYcp7tnlq18zrmfcYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/EcxEdbByxsApCKNuBv+XpteEgPJ7Q7EaKwm0slT6n6eTZiwhucTTf1eLGJq9Q5H5JzDhuCINdNzYJmqzE20OIwiiv1/S8Qo3KkSNEzh/Os7OpCOannztG6/auVob51HaGR/SVYpWQnIylNu2uhJcUyAgD/iQdSIR1Hw0ohhsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJT3ybpB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJT3ybpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779981372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMA/Oxy96y6hMPjQK5FgU2BjjauAYJmB4PaoF3MH9w8=;
	b=UJT3ybpBBPg4u0aysOqeplONmIngCgQTtBRfI3oEXgMBV4IM19gik5h50sYZcgDS2tsH5W
	XW9K+ce/kenBrHHgBxCgD4CTmAkOAdh5BX7NPF8u+XP49xRWfGS9pHp072zMM3Py0BV4Nj
	OYaXgzkVY24pN2JkISW1fUJ1voPb8m8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-yF6Fd_X5PFCtAEGyKoi0oA-1; Thu, 28 May 2026 11:16:10 -0400
X-MC-Unique: yF6Fd_X5PFCtAEGyKoi0oA-1
X-Mimecast-MFC-AGG-ID: yF6Fd_X5PFCtAEGyKoi0oA_1779981369
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45eef10d5ebso68876f8f.0
        for <mptcp@lists.linux.dev>; Thu, 28 May 2026 08:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779981369; x=1780586169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMA/Oxy96y6hMPjQK5FgU2BjjauAYJmB4PaoF3MH9w8=;
        b=hrh0Rkl2IoQ9OfzstyZOnLAH6GCF+mPVVm35d04LHWvsOY28Lvx1Ar0kAUzGkiQ3TI
         sDQGJk2hybsjlHVCDD09kUr6tkRv/N3UULII1QKzMtl1WYRrd55T/k9wqLcGaVvvnmna
         RnsBXbwPB/jQDtcWx5LgdnTbQTtl2C02oEuWELjIuPfNA9zWXlyj+KPM0IDSbSlKgyKp
         bJlTAOXuhPAUPtISaiSz6bwJ2hhQ/Qb7My6MrWXj2J0gH71UCfjUNHGYWynJpAVEn46i
         PfhmM/bVN1MmGOTxXXexoJ8td/eHjLwTZhVRiKl8BTcwo21Ttjjvxb8n55vrJwUXE0+5
         CP7A==
X-Gm-Message-State: AOJu0Yw0catuWLlOOp4ngA93upo96hh9h5YXZX4So9IgKN7zYwgYS7vZ
	qos7j6DuHgaz9AcgTGnbUwnkg8MA2uFLZNDktAycgsdRw+Iao/NV5foO5dU//f+kSmIFKDAZ9e2
	1R/UbWUVJX95lQtcyOcUks5YCSrGWfOcybfxZR2CdHUuIhlurka41IVlmrywBNCsP
X-Gm-Gg: Acq92OF+6EEXYXsuFl2DUfbrv2M7i82+/QB68ogwMf3VsAT5d5a97H1627lBm+sHUy5
	QDnLLMOJ+49C19nL0VpDGFWxsDrMQCj6h30EG4Pse51+ttyv2wJykPVbV/217dBAN6MoASCo/Dz
	tpsQukMjcHt6O6i7LA8wylJ8YEoVZmVjepjlBFixNduvB8h0R5MkM90Lw6H2GPEnxF9+9oevkNB
	7EEkgpKHpo+PXkqYzM5XoYvQ0C3+ZUs7dWJgF/jhj829eCs+apl7r+6qlh4q6J4urvQ7moZyQ6K
	BhWyuHueF1q/exGbIZ/D4a6MpRiScYA9z8EXis83Yzsjps5kO/DVXEQJpbWpks29kv5sxRMtnMx
	iZiS5iIXs8JhC1+p741cZ+mlRP/MdY8Yx66BrbhUIKAn9wG6u9ZXs64tfvb8b8nG5HA==
X-Received: by 2002:a05:6000:98f:b0:43f:e990:2f5d with SMTP id ffacd0b85a97d-45eb39fa487mr45409112f8f.35.1779981369284;
        Thu, 28 May 2026 08:16:09 -0700 (PDT)
X-Received: by 2002:a05:6000:98f:b0:43f:e990:2f5d with SMTP id ffacd0b85a97d-45eb39fa487mr45409032f8f.35.1779981368703;
        Thu, 28 May 2026 08:16:08 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb557679sm24951123f8f.10.2026.05.28.08.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 08:16:08 -0700 (PDT)
Message-ID: <b5244dd4-205d-4abd-8ea5-fd879a97038f@redhat.com>
Date: Thu, 28 May 2026 17:16:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mptcp-next 2/6] mptcp: explicitly drop over memory
 limits
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1779876523.git.pabeni@redhat.com>
 <6ccf1a553f1e5a3ae63b5a5608f774623d71c9da.1779876523.git.pabeni@redhat.com>
 <eed92bb8-8b77-44e4-9f1f-242db72177b9@kernel.org>
 <c45eb641-3f97-4206-bb7a-60fc208b732a@redhat.com>
 <8ac26189-453c-49e4-b1fc-a51c1818c468@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8ac26189-453c-49e4-b1fc-a51c1818c468@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: plJU6UbG2P9Uw2OPPlqM_ZAC6Tq8D-fmMo2U3AigFJA_1779981369
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/26 10:32 AM, Matthieu Baerts wrote:
> On 28/05/2026 18:26, Paolo Abeni wrote:
>> I guess:
>>
>> 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
>>
>> could be added here, but still the caller will do __kfree_skb instead of
>> using a proper drop reason.
>
> Or a new MPTCP specific one. Or abusing MPTCP_MIB_RCVPRUNED?

The dropped skb is not pruned (removed from a queue were it was already
sitting). In theory we could add a MPTCPRCVQDROP MIB, but technically
the skb is dropped before reaching the _tcp_ receive queue, so I think
LINUX_MIB_TCPRCVQDROP could make sense.

>> I think/guess an eventual follow-up patch could do?
> 
> Of course. It can also be a "Squash-to" patch if preferred.

/P

