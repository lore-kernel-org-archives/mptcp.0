Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FC15B135
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753732; cv=none; b=SojHAd58q9p3FJVPGnlVELG2HlX+ex4Jo447zuGXiGzwYwxvhQ973azT7tjou+O56kIO4Ziecu9cT6ks+kG7Bvk5whWOqZK7UB26w+Iatqpdq8Oe2NmOR/LX71FTr4N5dhP/uLJjqRIb7Zijs97bMq+k1VuZ2DNecrNc5f9EMg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753732; c=relaxed/simple;
	bh=u75iZbm7Pfh67KXT9acAaihcf6va24NSr1ILm59Pdek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAc/S3DZj2fswM0GNVoWOMH9Wzyxu6z6lF1rEsjv69+25a2obCMZr25VOhSPMyTfZngZ8Sd2bNO9njP0nOyJzIvXPVciYc/ANZhS3VEsPIMCmTapkX0UdL37lV1euRmCp9u3bV60notl2Dr5CuzxiA/qqKP6eidi/WQJ6hcTIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHXxMrg2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHXxMrg2"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44f2d894b7so758032266b.1
        for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712753729; x=1713358529; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1tBPyZzIM9HvWCWytDTb+G73q44vzb5qtNl+V3kOlM=;
        b=OHXxMrg2bG447uMN0gKref2PyyesWblls+3/lMlmowG+za59swZ2ENOVRyovNgclYV
         Daw8j7iV9IyuZOjbs7L4xlsz+9aR9IAVI02N7UEL0leVnFmxEZiwjSxHwfxYUsjpr6w2
         HUD8BKjDzEXxJ9YrUfg0s89yRHRsFM5eZT9EVZmGQovz7I3dXK2a+VkzHHcxSH8Vq5lF
         85IA3sQgseGXUKyZ9TwnURgihUNHksIf9/rSxXrAHeNgaWDCM4L0UHaEP5YTokrXIdKf
         ZIWGRDCoOOygImDXTvIzAQ3h1DTQeiSLHM5Le8kh72lHOonQtCupifKl0fMpY/Rk28Bo
         YvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753729; x=1713358529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1tBPyZzIM9HvWCWytDTb+G73q44vzb5qtNl+V3kOlM=;
        b=VxSU/1BVkg9UPwNVdwrfqBpoww2yJIYueqbY4aN/zWwLVp4qDsWaaTOZwCukpsaDHd
         +mKpGzRo+ABHHCVNYPoiuGly+RiyVQku7lWliEwnkECjrs8acIoi54RriR4czqY7i6v1
         mPGjsM34SsSDq+ACwOAQ/p2+Q7GNEbbuuME0ObL5DsJUY4w5sbGClNuOBzn5hYGPg71E
         C0o3Bgk28wImECERqY5ooFE6SXIOmHWEjqnUShzHc92yP7pcYmiCrfrxbpPiPEM3zFIC
         fm8a8A/4igRmaQgwPbpWgJJUdFjBTsCpGeVAKKOi69jtHVtezeGqeYAygoUkOOFay9EK
         3xaA==
X-Forwarded-Encrypted: i=1; AJvYcCVHBJAiTZU3ieQmr53r2z8jLLLaIhEFKv5pzyfp7RGwdLcQa3OwDCOSvQ4S4IHGC6LhNz/j6FV35m5jNHd62TEOIAMd4z8=
X-Gm-Message-State: AOJu0YxT2nyuzLBmlqZ6CTwrZ85XfjGDpgP9A+vM0nCkurIhDjOMPC66
	ThNd/pKrCEAu29+ktbOs08x2/TaDxOUJTPZXI40wCFlHoYZE6m30iF4+GwsxulTuNjZL2hWw+on
	gA24A0Pwhv1gOPzYEXRTRMa2ri0pS9mWfcEk=
X-Google-Smtp-Source: AGHT+IEFGpK8dqlN0pLAXdaZjXeCc2d/m+u1J6Gp1y5AFwBfa42NzVG00TVcLeHTO9U1W0RhT00vHwjKoItzUtjvEQk=
X-Received: by 2002:a17:907:60cb:b0:a51:ce36:1534 with SMTP id
 hv11-20020a17090760cb00b00a51ce361534mr2440092ejc.48.1712753728518; Wed, 10
 Apr 2024 05:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
 <20240409100934.37725-3-kerneljasonxing@gmail.com> <171275126085.4303.2994301700079496197@kwain>
In-Reply-To: <171275126085.4303.2994301700079496197@kwain>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 10 Apr 2024 20:54:51 +0800
Message-ID: <CAL+tcoCk_RTp6EBiRQ96nrdN7cuY1z+zxzxepyar4nXEJkAB9A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] rstreason: prepare for passive reset
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	geliang@kernel.org, kuba@kernel.org, martineau@kernel.org, 
	mathieu.desnoyers@efficios.com, matttbe@kernel.org, mhiramat@kernel.org, 
	pabeni@redhat.com, rostedt@goodmis.org, mptcp@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antoine,

On Wed, Apr 10, 2024 at 8:14=E2=80=AFPM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> Quoting Jason Xing (2024-04-09 12:09:30)
> >         void            (*send_reset)(const struct sock *sk,
> > -                                     struct sk_buff *skb);
> > +                                     struct sk_buff *skb,
> > +                                     int reason);
>
> I get that 'int' is used instead of 'enum sk_rst_reason' to allow
> passing drop reasons too without casting, but that makes understanding

Yes!

> what should be 'reason' harder. Eg. when looking at the code or when
> using BTF (to then install debugging probes with BPF) this is not
> obvious.

Only one number if we want to extract the reason with BPF, right? I
haven't tried it.

>
> A similar approach could be done as the one used for drop reasons: enum
> skb_drop_reason is used for parameters (eg. kfree_skb_reason) but other
> valid values (subsystem drop reasons) can be used too if casted (to
> u32). We could use 'enum sk_rst_reason' and cast the other values. WDYT?

I have been haunted by this 'issue' for a long time...

Are you suggesting doing so as below for readability:
1) replace the reason parameter in all the related functions (like
.send_reset(), tcp_v4_send_reset(), etc) by using 'enum sk_rst_reason'
type?
2) in patch [4/6], when it needs to pass the specific reason in those
functions, we can cast it to 'enum sk_rst_reason'?

One modification I just made based on this patchset if I understand correct=
ly:
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4889fccbf754..e0419b8496b5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -725,7 +725,7 @@ static bool tcp_v4_ao_sign_reset(const struct sock
*sk, struct sk_buff *skb,
  */

 static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
-                             int reason)
+                             enum sk_rst_reason reason)
 {
        const struct tcphdr *th =3D tcp_hdr(skb);
        struct {
@@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *sk=
b)
        return 0;

 reset:
-       tcp_v4_send_reset(rsk, skb, reason);
+       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
 discard:
        kfree_skb_reason(skb, reason);
        /* Be careful here. If this function gets more complicated and

It, indeed, looks better (clean and clear) :)

So I also ought to adjust the trace_tcp_send_reset part...

Thanks,
Jason
