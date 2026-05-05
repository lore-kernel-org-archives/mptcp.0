Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B39481FDF
	for <mptcp@lists.linux.dev>; Tue,  5 May 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996640; cv=none; b=F8Ai+fBODXeuxHcyZjRaGK9Nz2e6Y1nK+bgws1KX1wP2xpsgB+TPj+6hbX/VhB3Yr5bPC1sshCOt7ZGBozxt7b5u/R6WAu33o5FNmUMkvFaE0BUYqnxvWHEPysW5jLaU9zqM0jdhXfDvj/bVMiYeTwgaHr6gyRjAMr70SGzMUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996640; c=relaxed/simple;
	bh=4tbkQD3qjzUNZYoGCbMdfdMn6j1OXzy+/hjj4tI7cOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZrMUZWgN+1T56jvtPP+PJpgDtoR4yJTw+1WeRdFEUCEl5eW4JdfX2MytWQQadTKTHt885BFfU9btlP7fDkPdC26l/V9WFkRS/9eEtmiulgADuQBiHdLjDWOOSGCHPOisrONR+BJIdTeD/xOSFDhcSJ2gjuDYMXZbv93nDXw+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgt0Soj0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgt0Soj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777996638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gbhNN4Y+U0874ckf/A+Q+33B/TiI+pxihIO3dt2UI8=;
	b=dgt0Soj0nyO/rc1BtmzmZxHbr4LtbFrmUnY+nprdnUYOzAZq51hx0ZgNm35cjUvdjwJfzW
	M5CXat2LZFNpeg7qNhJPwPXedIikspQr3KQcf4r1ODNbgAFpqNFxA6fnxG/ju0uE1GH7ZI
	DmUZrbWTj/wbVc8hnVhng0Sdfel9mA0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-qbSIJpGgOfaFnZ1h09dV9w-1; Tue, 05 May 2026 11:57:16 -0400
X-MC-Unique: qbSIJpGgOfaFnZ1h09dV9w-1
X-Mimecast-MFC-AGG-ID: qbSIJpGgOfaFnZ1h09dV9w_1777996635
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so1967616f8f.2
        for <mptcp@lists.linux.dev>; Tue, 05 May 2026 08:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996635; x=1778601435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gbhNN4Y+U0874ckf/A+Q+33B/TiI+pxihIO3dt2UI8=;
        b=e5bw4pqI8h6nmRljguAQo/5XX/wxkL8ull8iBEPvwcdLWZMvNKKB/dqHmJ24ImK0KH
         ugkTl/Mk76LdmaT7PHyFZGiSZeYbsYLcFuWSox7RLfBqSBNCYLgeYg7e5PjZmVof4gC6
         icwscRAKLfLzLJ9Kr+p66l+Mmxe6ZpJBADNsWT6DZrDL869jRzQ6Kso7YzApjX31bh4+
         wgWA6JK+tt33nKD6gY5K9fBCqHtdo/X2NBEQ8Lw2ItfORQrdzQd8sW/SqLmoLvmKm5Bk
         Y5l0d+hSvY/nsBrO94O2XMeZivOH8b0wbIqPo0IHZC+icZBe3PKk1ljpV7qEmSblh+Zr
         M7/w==
X-Forwarded-Encrypted: i=1; AFNElJ8N1q2pym1xXZCTibBMH5w+mUysjAwTpBrgZE3ZJCNVyZzEHq6DuJwXwaaetW+kXJz6pLN2pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO0zQH8YEkVZdjSOb+v0TBo3gfBC/kxlvBOjoNvuh/TNB4Ny0O
	9WKkH9UJxx4Q4OsdMn4s1gQ3Ko7+DU1EKeWydJdcmCIlWAN1R7kWxl/We1dd+g5/uO83F4BwGhr
	jwtH5hRHJDwThu4t+Hp6AqunGhl6O9ygW7APl4lIEfcmENCrnWpBmmKNn
X-Gm-Gg: AeBDiettGk4pSAxNil1LawqsknoYJNGro2a26mOTUxImkZ4vDUuqWybdNYMHSX3+QXR
	mgOs5WFxALc6fptuqLYipHU5o0UxLkMyzM2G58wvKh8iJns9ih/Q7ngFZfekrhsdK7/BfmcTaCb
	vK2EsNCPbWzOOjq//AImR/nfJxNMGnQOdio2j0ppJihpf5/kBpPAU2RVL5Hfjt2DCjSHsGiv75m
	+1RHHsKoopbiiffTB1PFZrZV+O7s8OHzXidRQyPMAcU/x93tBObkorpalA3BQekMuMNWXvQl9JG
	R+4Gu/Qj/iRrqM4blOClKUSgeHP5YJ+hbBSY8mYLY9xd8rJ8BwJd60Fq8hPFbbYPPsi3a521ndE
	LKOR9QxeJpFTVNENDnymr1xQ3sjYK4am9laM5GSUc80LMje2o2jpadrgfsqgRLayxsC0=
X-Received: by 2002:a05:6000:228a:b0:43c:fd7e:72eb with SMTP id ffacd0b85a97d-44bb6ab1cb0mr23825913f8f.41.1777996635073;
        Tue, 05 May 2026 08:57:15 -0700 (PDT)
X-Received: by 2002:a05:6000:228a:b0:43c:fd7e:72eb with SMTP id ffacd0b85a97d-44bb6ab1cb0mr23825880f8f.41.1777996634677;
        Tue, 05 May 2026 08:57:14 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505285e765sm5359988f8f.10.2026.05.05.08.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 08:57:14 -0700 (PDT)
Message-ID: <1bcbd71b-8b7a-42d1-9726-c8b58e3bc3ad@redhat.com>
Date: Tue, 5 May 2026 17:57:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-next 06/10] tcp: expose the
 tcp_collapse_ofo_queue() helper to mptcp usage, too
To: Eric Dumazet <edumazet@google.com>
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev,
 mptcp@lists.linux.dev
References: <cover.1777908248.git.pabeni@redhat.com>
 <eec217c214e8db54355c7708b328c34a92c2bdcb.1777908248.git.pabeni@redhat.com>
 <0c361889-533f-4467-b908-0774dc23f08d@redhat.com>
 <CANn89iJk+0M6hAxx+L8vfLzCzo=_7E141BYty8F4CiBUM2F6hA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iJk+0M6hAxx+L8vfLzCzo=_7E141BYty8F4CiBUM2F6hA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0sWtoAMrFzxu7lZTRnkyrLkErZg8Qo-SZuYvzvukDwg_1777996635
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/4/26 9:07 PM, Eric Dumazet wrote:
> On Mon, May 4, 2026 at 9:39 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> I'd like to re-use some existing TCP helpers (tcp_collapse_ofo_queue()
>> and tcp_collapse()) in the MPTCP code, to avoid duplicating the non
>> trivial logic there.
>>
>> The idea is that the 'struct sock *' in such helpers could be either a
>> tcp_sock* or an mptcp_sock *, and the processed skbs could be sitting in
>> TCP level queues or MPTCP ones.
>>
>> That poses some hard constraints on the sk fields that the helpers can
>> access. To make them clear I'm renaming such helpers using an 'xtcp_'
>> prefix.
>>
>> The full patch touching the TCP code is below. For completeness,  the
>> whole series is available here:
>>
>> https://lore.kernel.org/mptcp/cover.1777908248.git.pabeni@redhat.com/T/#me6eda13ec2c70fbb400b6223aa2d07a4fd3bf865
>>
>> but I guess most of it is not interesting for you/from TCP perspective.
>>
>> The MPTCP bits are not yet finalized, but I'd like to know it you would
>> consider this approach doable or a complete no-go.
> 
> No concerns from my side, if we except the fact that TCP collapses are
> a high risk, we might
> remove them completely (or at least guard them under a sysctl)

I'm sorry I can't follow the above suggestion, could you please rephrase?

The patch should not add bugs to TCP collapses for TCP sockets or MPTCP
subflows (still tcp_sock). Collapses for MPTCP sockets could become
buggy if the tcp_collapse_ofo_queue()/tcp_collapse() implementation will
be modified in the future without care.

Thanks,

Paolo



