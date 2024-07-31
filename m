Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D41AC43B
	for <mptcp@lists.linux.dev>; Wed, 31 Jul 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419967; cv=none; b=n19VRXTiqgYwgFc4VO5Cvxa8tqIr0YaT9YluZRM3UnexzJXXaeBCLoAg9NAtefhFG+OkyxbQ/QO2yIynap0QyJGp4OqfVGzazI75sv+SnblvCs1Ki9vQXPfRyx6tpU/11PG20DlfrLSREXaqkYJmsa1K8CBUBsCorPUcwauGHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419967; c=relaxed/simple;
	bh=4R4xX4AJXVbL/lVltFFMgiURfppUNJpanFd+OFoaQnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BVzfoXGp07g5bsB5sHSSOt43gG/DO+rcLWcWozmjbcvlyEmGTzfZ/V9DneNu0ggifSYc9Rh4bQgYHG+/sSpQ0h2IzSxdjn0gHAHzMYvW2XcklEsp//012U7+obPZ3rBuBWi5ce+mxs01dbQkdvZLq6XBter5iqPzk5jRFjX85RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0dndCZh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0dndCZh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722419964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fK1g098iq4JAFSZ1OwoLqHTRasnFeG8nDHsMGLN1u3s=;
	b=b0dndCZhjHz3xCqutvi5L98aoDXrI5ShS/yzVj1vHg0MJfrjrBIcVu2c5N2SePbUsV/Ol3
	4XvZhxth3AZVkm5VMoyH0B7vRR1FvUaB6rCbf4svmcww0Twvzq7ziBEMqvpDK969yGXGr1
	Cdx4xO85cRJN3lhr6rNDyO/1E2xav44=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-7VJyDM-rNuyFnzRZBGLN9Q-1; Wed, 31 Jul 2024 05:59:18 -0400
X-MC-Unique: 7VJyDM-rNuyFnzRZBGLN9Q-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee88b1c3e9so3699051fa.0
        for <mptcp@lists.linux.dev>; Wed, 31 Jul 2024 02:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419956; x=1723024756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK1g098iq4JAFSZ1OwoLqHTRasnFeG8nDHsMGLN1u3s=;
        b=jj2WGbkTmKxnPbpnvMJqVUrQD1MPGyonn8wMfG8J9c5NbhfVP87llX0jQqd8t+1Ufg
         2zj6/W6JcgLhlC4IEb2wIK9Lyz4Nre71LtWT5sLCEUvm+LJdBc8GiROoa2gNJ0Je83tq
         wSG5bLbQhscbXhD//cqKg8s4o0DcH7zhhETuu6o6ToH/olwiQ6lAK3XzbWj4cLcj18FJ
         EcQ4nOhCrfPXxBCo6gvvAtzW4hELsSwo81TaCUb0DdT/cPqyqnX8u7KCVzKLcwuW9rMV
         uWuvR2IJC9J9830tV6DUCUE2L8+hwOUAFyzYXXUj5bM/jIKEPAhKkCnHBUiNSVA4FPj8
         yB2g==
X-Forwarded-Encrypted: i=1; AJvYcCWGxSE86pp1dOGa5HT+3vesMOfMFMfkXZHdHK+0OaYsPZHcH883lKxAdlgxZO9BrR+8cQOS+Cp6JPuNSttHsdecJTfkmrg=
X-Gm-Message-State: AOJu0YwK4yhD24iRwZ5tkOJN+s5VQg6ZQ93h2psLLGPnf9xAr8LO5Tes
	lzRYOFgH6Petj+2TH5HxB9pjhGAcTlDpvmmuHCIpDTPNn6o+NyBOt4Ms37UFgwQpoDYjoFpccvn
	Aq6w36vZM4dzjRcrmZ0BA+t+Bd1WkOExxcVJwOqKPJE6Cwtxnvx7q
X-Received: by 2002:a2e:7d0c:0:b0:2ef:80:a68c with SMTP id 38308e7fff4ca-2f03c7dc6b7mr69798421fa.8.1722419956325;
        Wed, 31 Jul 2024 02:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF17aCAzJBAn3plIADOp9HDwljSF8JNrYjS9kMfR+jYggbEfORU+MY3qApdGsfOXL1i/8ZbFw==
X-Received: by 2002:a2e:7d0c:0:b0:2ef:80:a68c with SMTP id 38308e7fff4ca-2f03c7dc6b7mr69798301fa.8.1722419955717;
        Wed, 31 Jul 2024 02:59:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e49bdsm16719478f8f.44.2024.07.31.02.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 02:59:15 -0700 (PDT)
Message-ID: <b1c0717f-2eff-4e97-a84f-3f25a697e48d@redhat.com>
Date: Wed, 31 Jul 2024 11:59:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una
To: syzbot <syzbot+5b3e7c7a0b77f0c03b0d@syzkaller.appspotmail.com>,
 cpaasch@apple.com, davem@davemloft.net, edumazet@google.com,
 geliang.tang@linux.dev, geliang@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000dce735061e8173dc@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <000000000000dce735061e8173dc@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 04:00, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit fb7a0d334894206ae35f023a82cad5a290fd7386
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Mon Apr 29 18:00:31 2024 +0000
> 
>      mptcp: ensure snd_nxt is properly initialized on connect
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c8bdbd980000
> start commit:   4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=5b3e7c7a0b77f0c03b0d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fc9c8a180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d0cc1c180000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: mptcp: ensure snd_nxt is properly initialized on connect
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: mptcp: ensure snd_nxt is properly initialized on connect

oops, I forgot to do the required communication/accounting here, sorry!

Paolo

