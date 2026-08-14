Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF24192EF
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694569; cv=none; b=bit++3RfVXcWThrJvKM6Uv7g2GQXt0JHVgP5lN6j3c1WecPeObZsW9DMEa8y9MME5POZJYG+Bz3PcIE2uh9ejagX7gU3EeCf6sp1L6L5XpivU30+peqMfDEXJtnVPt7kVa/iw32iCMOcxndV+Fiy0VwYLEK+gjBrvXSnTPMX21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694569; c=relaxed/simple;
	bh=L8KCXFXuLdsozsNqKqCpOIh895yoHYeyMGAl9+gzScI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8iOqYemeYaunWDqMoj2/MJdx2AxAZuuh+v3OiWeRK/LbCmWujR4QLWihgYfYlSeYSEZdHlZY94DrS8vkvzE2uk1s4W7JrNdt5HLogUAxqfeZxX4ZS24frATRxfWie5GBir1f8Lm2cINdqTVgItu6OQimcNBaTVaULs58voy8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSkK9xJ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSkK9xJ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLpMGj0pQGhJ1cyaYBf6c5UqVZN5Sm2Ptah1UzyzRUE=;
	b=BSkK9xJ0v35TIFknAi7dQiXZz7uplBbce8uXJeS5H25xT2blY+aDw+OeuzCTgCNUH8Vyaw
	COxv6uog8WPP6mIvev9F8oVU6LdgU/iLrEDUzHtTIQTvooOx0LmvEc8CBt+GPDHIrOdgrF
	kRXDbuucHQ3zJlxSVfpkT7ZchH6cktE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-D0L8eT-zMPa1wU77Pk8RKQ-1; Fri, 14 Aug 2026 04:02:43 -0400
X-MC-Unique: D0L8eT-zMPa1wU77Pk8RKQ-1
X-Mimecast-MFC-AGG-ID: D0L8eT-zMPa1wU77Pk8RKQ_1786694562
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767b782so5536425e9.2
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 01:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694562; x=1787299362;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLpMGj0pQGhJ1cyaYBf6c5UqVZN5Sm2Ptah1UzyzRUE=;
        b=jM7zrd0TBg6CKSXNvEXFNvcbE9UU4F6JN+32r1LRTZ9cK6uC3k7fMHU+a5bnColHnZ
         B3ws0GODE6PcJkJAv3Jegg8vHtfyNnlsissYqs21w1A7H87G9TT27GnhPpzhVCG5ca6u
         0wyCmhTJsANiRoQQnTGTvElEt1EQHlBl8B4TZ5tbFtE7dP0d6BaDa2hkwfVoSIP0sujz
         1gKVF1ikF5TuwwPL8iahPBBuetHYuW1VcYogU7M2zC3o8hhCjdYNuQa3hiFmZoZYhO0I
         6sbC/4cpU344VcWZyHnKVCiNm9vrx0sARzS3az02nwh6A6etMVFUXk2+ywW8Nbo16LuN
         +TzQ==
X-Forwarded-Encrypted: i=1; AHgh+RouWaRljhgREB/vzd03cXNo+2sLP2jQO3jk9EE/wTyt2r2/XWSsvdvcDb7DHVMwwPJiDdcTpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj1ZT2Hc5UJU4kitnfQJkpMTScTMO3KeJJlEfXUFls0X0ci/T/
	C6Q1GYDHOUGchBVOvIwQE6I+bQquX/Q6rUIHktGF9QeEO4D8FaXcmnCh7C0Hb1cSnYj1qaKOh7I
	DnKrkIYJBGxxZqVUf9uy1EjBtNA9Nxiw71X6IpDTeYS1SNe/ruGRiRhQF
X-Gm-Gg: AR+sD11LE9bapraOoNWoiz92M3ia/dgdzHS0aIPAjyfr149joN+9EJ+daPW9j6vQIPM
	6bPrLPuNQtUACFqg01NwUUgcqS3JGE4go+2nUBx7Mog8ifeKUImAtarI9KzBiHPYui8HOwkpBZi
	9fiSZLXOmVxo17AYXL4RiUgvW5JcLdjzZZYdqL6NLQzyj3n+aA6WeOa5Zau2XwijEFp74uUCd98
	Hp5zfFJKj3qw1N+6gHUOD2z0vLn2U7EjU7+PaKfOFJirvAzng3T/uLIQREZ3dpgKyJCzLo8VdEJ
	5VwJt06A2QbOaUDybZqLSbe9YKMeNY9Tt/VablQ2bh3M9QHeaazuHNrP81wnBQ+fVtLTDrlRH9R
	J5n1tbtqEuHfP4VVqFQuq1Hp1gqIcGH/nSppc2zYYzd1wnr3sEVOEDZ/0dfpNOlZeyy8kBdmJ0X
	c=
X-Received: by 2002:a05:600c:4003:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4998798db40mr41763655e9.16.1786694561629;
        Fri, 14 Aug 2026 01:02:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4003:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4998798db40mr41762845e9.16.1786694561180;
        Fri, 14 Aug 2026 01:02:41 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b25625sm31696485e9.13.2026.08.14.01.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 01:02:40 -0700 (PDT)
Message-ID: <e039e866-fe7e-41ef-ad41-92a76a123713@redhat.com>
Date: Fri, 14 Aug 2026 10:02:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v3] mptcp: bpf: fix NULL deref and UAF in
 bpf_mptcp_sock_from_subflow()
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev,
 Geliang Tang <geliang@kernel.org>
Cc: matttbe@kernel.org, martineau@kernel.org, shardul.b@mpiricsoftware.com,
 janak@mpiric.us, kalpanjani009@gmail.com, shardulsb08@gmail.com,
 akshit@mpiricsoftware.com
References: <20260629105020.1670781-1-kalpan.jani@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260629105020.1670781-1-kalpan.jani@mpiricsoftware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: an0slW-tnXhok3RFhgZWtv5MMYl9_QZ3U-7CkBPurQc_1786694562
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 12:50 PM, Kalpan Jani wrote:
> bpf_mptcp_sock_from_subflow() is reachable from tracing BPF programs via
> bpf_skc_to_mptcp_sock() on an arbitrary socket, without the subflow
> socket lock held. It assumes sk_is_mptcp(sk) implies a valid subflow
> context whose ->conn points to a live parent mptcp_sock. That invariant
> does not hold in several windows:
> 
> - Fallback: subflow_ulp_fallback() clears icsk_ulp_data before clearing
>   tcp_sk(sk)->is_mptcp, so a reader can observe is_mptcp == 1 with a NULL
>   context and dereference mptcp_subflow_ctx(sk)->conn through NULL.
> 
> - Init: subflow_ulp_init() sets is_mptcp = 1 while ->conn is still NULL;
>   on CONFIG_DEBUG_NET, mptcp_sk() dereferences its argument in a
>   WARN_ON(), so mptcp_sk(NULL) faults.
> 
> - Publish: the passive MPC path in subflow_syn_recv_sock() stored the
>   freshly cloned parent into ->conn with a plain assignment, on a child
>   that is already hashed and globally visible. A lockless reader could
>   observe a non-NULL ->conn before the stores initialising the new
>   mptcp_sock were visible.
> 
> - Teardown: subflow_ulp_release() and mptcp_subflow_drop_ctx() dropped
>   the subflow-owned parent reference with sock_put() without clearing
>   ->conn, and the established parent msk was not SOCK_RCU_FREE, so a
>   lockless reader could dereference a freed parent: a use-after-free.

I think we should expose to tracing program arbitrary socket state
locklessly.

@Geliang: what about just removing such possibily? Something alike the 
following (completely untested).

If a tracing bpf program needs to access the msk, it should do just:

	mptcp_sk(sk)

on the main socket, via a new, to be defined/implemented helper, and
_non_ starting form a subflow.

AFAICS all the other accessors using from tracing are simple casts,
like the above, and do not traverse the rather risky ulp layer.

/P
---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 75495a5c3507..ad4b8d04b190 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1745,8 +1745,6 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_skc_to_udp6_sock_proto;
 	case BPF_FUNC_skc_to_unix_sock:
 		return &bpf_skc_to_unix_sock_proto;
-	case BPF_FUNC_skc_to_mptcp_sock:
-		return &bpf_skc_to_mptcp_sock_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_tracing_proto;
 	case BPF_FUNC_sk_storage_delete:


