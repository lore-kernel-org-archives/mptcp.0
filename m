Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D17139589
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254677; cv=none; b=rxyCRnA9+5huGuE7KHkXXyHSqItpOTwXTPzbrlNGyuIereFKYxNENc1OZnU8TDQf5efkvPT7a7QN3RUCDklLVeHHDvezM/S29HrEiBsdISkY3DhQAIqqltv17VQgJOO/cySpKdTOpQyciANKFgNhN4sRYUBQUQzSkG+4P77CvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254677; c=relaxed/simple;
	bh=Z10em1iqwhs/aajTedwFR+rSb1HWbJyQ2h1ztSq73jU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgLB3qEJq8gZ0y60bh37n4RJwrTzzTu/nOgBdwh1G5Y+rOHmYA/h+LRGoO8bdDZGggZ+9r+eIpmcKR76rS/6U3S9ss3d3M77WhOOuQyBIuhcdyrCIY8xg87pMgxA7ObaRj72ZrgWxwncohFqeONjmMoY3/xfHpKM4BexCMMEj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZTQxQP5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZTQxQP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713254675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lz4kwBo+nbvfN5+RBXA9li8P06Hha4is8np7tT3uH9Q=;
	b=bZTQxQP5yUAEpMQ6crKB5C36VVYalxP7YjzgJAbaMcVB1IpybO6yl/7XyMi6VXytvo3SEE
	O87cg/gPx1ky2NFRtFvj6P22OxBkzIoAv7Kla1IUYn8uKIHyc77OANB/tuRZfdvZtxJVpA
	dqCpJXTJS5MGpcWQbAOyPmgVT7IWHwk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-G5TCBntXP-GOjOcvl6t-Zg-1; Tue, 16 Apr 2024 04:04:33 -0400
X-MC-Unique: G5TCBntXP-GOjOcvl6t-Zg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57021782d67so209717a12.0
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 01:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713254672; x=1713859472;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZcXIuEw53uD9NLYCNih5BQiC3vmAN86am6lbUrPRC8=;
        b=poWlm5xEiCfO7LBbJJjkrbekoyHybFFkM8eMMvj0iuOtXkhCuL8+co2s3zjy6NVafy
         XRKd75qUuiiaKxDbaaqgXk/loSml//yBnmDwYj9yMKaekc7aGUhaX51olE+6D858SsRt
         aEqIo3cpAUnxyBdm4qWVhbGOhtSbpjn7//Zq5vDvz4eWQGgCez871q4e6qQ2XHwJ8P3U
         K3EGkycSrOw1FI4Lx82OuvcPCm7qaWDqtGqMJtm/jHgXzKH31RGiBWXGCCJVvowWNtZ7
         HluRcoYs6MGuPjvZxM1sAroo6W5w5f9CmQ66AyQz6j08DkzME8w96Unw5nS91pgToBUr
         /bCw==
X-Gm-Message-State: AOJu0YxPldSQk+cnG2HdNi2vvIsEvRKH7nagbbkXu/rHLnl7sxR7s9gu
	iepyRZZDNjtfTI+kxeu6XLXHcpctU/zz/Qt1PSirvBQnr01qfVHznvpvOP0f3RfVW4w8j3oRSoU
	EAS2du0m3/J93S6JNBFe+yAnMY/BT+aR7rYXHy/cenRQRHG9oEuRU
X-Received: by 2002:a50:9ec5:0:b0:56f:e715:d1c3 with SMTP id a63-20020a509ec5000000b0056fe715d1c3mr8267639edf.1.1713254672725;
        Tue, 16 Apr 2024 01:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvT+edfU/HSvtt/P822LXfQeP2tkNAjcODhLuuIB68XkMut6cZxQ4cXbt0L/OMQTS/kdjqzw==
X-Received: by 2002:a50:9ec5:0:b0:56f:e715:d1c3 with SMTP id a63-20020a509ec5000000b0056fe715d1c3mr8267622edf.1.1713254672331;
        Tue, 16 Apr 2024 01:04:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-31.dyn.eolo.it. [146.241.231.31])
        by smtp.gmail.com with ESMTPSA id s24-20020a056402037800b0056e44b681a6sm5797370edw.57.2024.04.16.01.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 01:04:31 -0700 (PDT)
Message-ID: <3b53762fbdfb7df1b3e79ea5138fabb714449d28.camel@redhat.com>
Subject: Re: [PATCH net-next v4 5/6] mptcp: support rstreason for passive
 reset
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com, 
 dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org,  kuba@kernel.org, davem@davemloft.net,
 rostedt@goodmis.org, mhiramat@kernel.org,  mathieu.desnoyers@efficios.com,
 atenart@kernel.org
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org, Jason Xing
	 <kernelxing@tencent.com>
Date: Tue, 16 Apr 2024 10:04:30 +0200
In-Reply-To: <20240411115630.38420-6-kerneljasonxing@gmail.com>
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
	 <20240411115630.38420-6-kerneljasonxing@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-04-11 at 19:56 +0800, Jason Xing wrote:
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ba0a252c113f..25eaad94cb79 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -308,8 +308,12 @@ static struct dst_entry *subflow_v4_route_req(const =
struct sock *sk,
>  =09=09return dst;
> =20
>  =09dst_release(dst);
> -=09if (!req->syncookie)
> -=09=09tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFI=
ED);
> +=09if (!req->syncookie) {
> +=09=09struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> +=09=09enum sk_rst_reason reason =3D convert_mptcp_reason(mpext->reset_re=
ason);

Since you already have to repost, very minor nit: even the above
strictly speaking does not respect the reverse xmass tree.

=09=09enum sk_rst_reason reason;

=09=09reason =3D convert_mptcp_reason(mpext->reset_reason);
> +=09=09tcp_request_sock_ops.send_reset(sk, skb, reason);

Cheers,

Paolo

