Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F5D30648A
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835974; cv=none; b=FK8A5Rgrk115vg52zSbF1+L9FVgu0eG1ip3wC34p4QOOuUmndD9Fg8rRKGV7oNn1L/Dt45jiiqIyR2MMxx04UxPuAlA5fzy9yuS9ku+jb6+sxzOKYhcn/WL86/uE2Y8b0Dp9ZBkYRYpyV3ttG9uCoapJlZ41SBThiMPwvjdP5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835974; c=relaxed/simple;
	bh=qOm5dfJliA8gLeYORN5zG/a5qiPuUT8GxiwjVBugB5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIydHT+Sj4TfzCJ5T0fZTG4/ni8VhMj8QdKybskAYhqq6NOpRybz0Bw8igizXddKi1kRHFJx9yzd0kp8u3WlEHY0A1jwvGSgqBrAYuLqHh623vn1BpMJyNu2ssHhJwob8j2BMksp0hyQqyKJqv3yGhFIrIY/oXCjjlu1Gh0wbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjhAjLAx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjhAjLAx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778835971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vN2g2JL7fiItleBDBKW3Nse+vFTgpyomesBRy1HX8Ok=;
	b=WjhAjLAxnEB2SBUTg6ZdoVwpy8IEHyHNfcrhuPKWaugRhQkVJl2BqpJLH+RC/HcBxQ7LDW
	pOuJgce/ar1bh3zvw4/zSDOg3+6oEWUNVZZK8/ZhYSBLDEigtE+3vQmMpZ/pt8yF5aMnY1
	KPjRfHWqqpbSHSoHXzWAc0g0u9e4AY0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-h4rHCJdWPBqe-ezrAz2V9A-1; Fri, 15 May 2026 05:06:10 -0400
X-MC-Unique: h4rHCJdWPBqe-ezrAz2V9A-1
X-Mimecast-MFC-AGG-ID: h4rHCJdWPBqe-ezrAz2V9A_1778835968
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fd3449e6dso13751475e9.3
        for <mptcp@lists.linux.dev>; Fri, 15 May 2026 02:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835967; x=1779440767;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vN2g2JL7fiItleBDBKW3Nse+vFTgpyomesBRy1HX8Ok=;
        b=XABzzPHtgKBjyJPuSCY2fyC61IOSIbgM7gX/xVxuydf4zhdl+cEOAap1y9MtKQ3fkF
         s9cRv8DXvUUyM2uJA08fEhVWnJfeCTR3/09OSMNgjfINCAkOW3YmFsmjidB2rcPVPeHR
         NRZnvieC5SMruZkLUUB3xhuRJ39keibGtZ5cc3tXI230pHgOU9ZL4sTqD4oOuP4SLgNG
         +LSvY5bqj8HrhYRzQpctA761phFJT0OsZr5VVNO7InFjvlr1AYz+1zGiaaeFgg+mkpem
         er88jux0ozWmr5HioIIJEFaxVkqT2ZcPcY/xTX8mczCXFBt9pHLG2eV5hGZalpYnOfw/
         UZzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0cC4XINCn94lcCoowGF4Ha/ddJeMK0wCUvDwVsbid5uQVo1zgKk5Bp3msDaLws7LNJvFQZg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxanx0m5gbQsjcofrUSzEVeWET02UgQmtavLmrOPvmk1kTCn1Wv
	IdK1bO8Fwr2kbt110/uPsn6GLaioDemaON0+dtn59CPMpx2Bnar6puYw4b//oE3QEspYy3Sfosh
	KxqvbfMNOQpVYtWSA7qxE5RaS/iVwD0ARnKP1ZyQJVwvhkzPGlMHmE4Ys
X-Gm-Gg: Acq92OGitsRaC2JJ2GhodXAdn735zC39psdSzvb+DFZojjy+8fas+02bN0sHrfFwPYC
	cSBKBQ/e+CuX7En+u/upcIflPzR/1T38YY69MJpcsf55kOf5O4Gl2sMFatBbAZUsQq8986RIDjN
	FJSb6Cv9Ghe3Ob/lSl/0zRnOfzCl4nOhqJOBmCvbv20c2oZnvHaxj8N88AvW0PpMplGLr0Jxj8W
	DYKDlbJMNlHUJlIQPZeIUDSbWnVQ348l5FphdrnHkSzWDz7jIjenvPR10Er/3aUgUy12hBEdXUz
	kO5dNU8TBjX3876hjRmqILsrShUdbGkIj+H3Xc7k6XaqfPtmbRI+6GLRp2nzT7o2QDqxgo52uTh
	rcVLvWLybhnXqxMZe8AQP/6lVqnzESiY8PSRsLqFONfQDdCNCrsq7kYmVWA==
X-Received: by 2002:a05:600c:3f1b:b0:48a:7965:b943 with SMTP id 5b1f17b1804b1-48fe661db6dmr43359935e9.29.1778835967690;
        Fri, 15 May 2026 02:06:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3f1b:b0:48a:7965:b943 with SMTP id 5b1f17b1804b1-48fe661db6dmr43359395e9.29.1778835967216;
        Fri, 15 May 2026 02:06:07 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm11922346f8f.24.2026.05.15.02.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:06:06 -0700 (PDT)
Message-ID: <2678c535-2b51-4a04-803e-14a2e3ac348b@redhat.com>
Date: Fri, 15 May 2026 11:06:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v4 1/2] mptcp: use sockopt_lock(release)_sock in
 sockopt
To: gang.yan@linux.dev, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260509-sockopt_lock-v4-0-33f3a1c4d7a0@kylinos.cn>
 <20260509-sockopt_lock-v4-1-33f3a1c4d7a0@kylinos.cn>
 <cb257c5c1af85f1512a175730e832c7b8cc7ba14@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cb257c5c1af85f1512a175730e832c7b8cc7ba14@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G7DcrihNO7CldZIj9PImn-WWGNsjHudJM2Na4xx4VfE_1778835968
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/15/26 3:27 AM, gang.yan@linux.dev wrote:
> May 9, 2026 at 2:44 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.yan@linux.dev?to=%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:
>> From: Gang Yan <yangang@kylinos.cn>
>>
>> TCP and the core socket layer all use sockopt_lock_sock()
>> sockopt_release_sock() in their setsockopt and getsockopt handlers. It
>> is a BPF-aware wrapper that skips lock acquisition when invoked from a
>> BPF program, where the socket lock is already held.
>>
>> Using lock_sock_fast() on subflows requires extra care: the fast path
>> holds the socket spinlock with BH disabled, creating an atomic context
>> where sleeping is not allowed. Switching to lock_sock() avoids the
>> risk of accidentally introducing sleeping operations inside the
>> lock_sock_fast() critical section.
>>
>> Fixes: 24426654ed3a ("bpf: net: Avoid sk_setsockopt() taking sk lock when called from bpf")
>> Signed-off-by: Gang Yan <yangang@kylinos.cn>
>> ---
>>  net/mptcp/sockopt.c | 97 ++++++++++++++++++++++++++---------------------------
>>  1 file changed, 48 insertions(+), 49 deletions(-)
>>
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index 1cf608e7357b..57ffde0d0b87 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -72,12 +72,12 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
>>  struct mptcp_subflow_context *subflow;
>>  struct sock *sk = (struct sock *)msk;
>>  
>> - lock_sock(sk);
>> + sockopt_lock_sock(sk);
>>  sockopt_seq_inc(msk);
>>  
>>  mptcp_for_each_subflow(msk, subflow) {
>>  struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> - bool slow = lock_sock_fast(ssk);
> 
> Hi, Maintainers:
> 
> Thanks for the review of sashiko. Let me address these two points.
> 
> First, I think this patch does not introduce issues for existing MPTCP code.
> Currently there is no scenario where a BPF program invokes the MPTCP
> setsockopt/getsockopt handler — BPF helpers (bpf_setsockopt) bypass the
> protocol-specific handler via __bpf_setsockopt(), and the cgroup BPF sockopt
> filter clears the BPF context before calling ops->setsockopt(). So
> has_current_bpf_ctx() is always false when the MPTCP handler executes. The
> commit's primary purpose, as stated in the commit message, is to replace
> lock_sock_fast() with lock_sock() to avoid sleeping within the
> lock_sock_fast() critical section.
> 
> 
> The subflow locking concern is valid for future BPF support.
> 
> That said, the observation about the subflow locking gap is a valid design
> concern. As sashiko pointed out, when the MPTCP setsockopt handler is
> eventually called from BPF context, the MPTCP meta socket (msk) is already
> locked externally, but the subflow sockets (ssk) are not. The internal
> delegation via sk_setsockopt(ssk, ...) or tcp_setsockopt(ssk, ...) calls
> sockopt_lock_sock(ssk) which skips the lock due to the per-thread
> has_current_bpf_ctx() flag, leaving ssk unprotected.
> 
> However, solving this is not straightforward. In BPF context we don't have a
> good way to call lock_sock() on the subflow — as sashiko noted in first point,
> lock_sock() unconditionally calls might_sleep(), and will cause 'sleeping in
> atomic context' problems in BPF context. So properly locking the subflow in
> BPF context remains an open question that needs to be addressed when MPTCP
> BPF setsockopt support is actually introduced.

I'm sorry for the late feedback. I think such concern is actually quite
relevant. Note that replacing

	bool slow = lock_sock_fast(ssk);

with:

	lock_sock(ssk);

does not change much WRT the sleeping issue.

I *think* the only viable path in the short term is making the sockopt
requiring subflow-level lock fail when called by BPF.

In a possible long term alternative could be delegating the
subflow-level changes to a workqueue, but that really looks invasive and
I would really like to avoid such option.

/P

