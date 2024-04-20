Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4A5CB5
	for <mptcp@lists.linux.dev>; Sat, 20 Apr 2024 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713583393; cv=none; b=fAdWtFXYzg/yKWsfVVnBB6NPaPp5ndZBDofiwxqzFeEyd/6Z/V2oZx8WRv4H56OBLrYo+p40xYfq+gv+wKhcTkdvPLFnTHS9eHst7H99bwVktfiaHI8sT/ZG3K9IqwKwaPmlWf6f0E1XoxqAiP0X/NXEFKlnXCGNljMqYdyNEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713583393; c=relaxed/simple;
	bh=efxe3LWT1F4DBpCl6IYwsNI5Ug5mdMiWXefSbL916ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3GG/P9CJRueRltrirxg1TK8l7k+8xb9ljmXeekjWYp/YW25pZrw3UBnUCv3rbhGY1LRftcy6KJk1El7RucLL9H4x6OlyH+u8CrgOHDXHqtj6C4bbuSUlMrP4SgZMBN8wVvn3qKpI0SaD1ofeN6CxX7c5EtuIsaZmHsfFQAjuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5sf6p18; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5sf6p18"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5200afe39eso282104466b.1
        for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 20:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713583390; x=1714188190; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpLu6IVjSlqb5TSshPffMpA3zpsaR9HFuHO2G5ymDPM=;
        b=R5sf6p18ru40W7ltlWMtwJaN8okOf4EOcCOunHv1So37I+qjZskRLh4TlBfvpQNBey
         fbzRvEE2bAkXD6rvIgTnMJwyCBDNbcos3pX6ZJW8eO2HUGBTURUwgPRml1a7AvuCufEt
         LpaDXO3l44SVOhdhzVo4iifWMJBjqqm5yzcjRu6fVDCAO4pI/Up1oBVPe9nU9kebro9j
         vYOBuW+jfgyoO31SdQaTeeXeVvIoEYrV7Hq8+ca6TH+1BeZBJUaOWoRDD+XsQ7dEeM4m
         ytXuRgsnXI/WasUjPSMF5g+iyByo+/rM9BZCXo8tu0gBEf1qtSseb0bok9I1DqmPzpJZ
         sE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713583390; x=1714188190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpLu6IVjSlqb5TSshPffMpA3zpsaR9HFuHO2G5ymDPM=;
        b=otTw2JQobL4NFpF6ap+KOP2eaz1ML5MnD8Sm0plGBjLxwNyjs6W4iIf0LCZIa7Z108
         7FKxO5D3/2Rh4+sIvD/Ps4x5dFmRD3k8qaFG7W5Kx4sUMJWxk0PVkZds/AKBJLbSR7WB
         79t6A8mi52zwl0SDX3q2l3RoRVzw3xgD5aPvTFAY7Zwrw2OWKp63D8ieMSTsNfNoC/rt
         kIYewVjEjoMqcsVPMEnr2rqWPTm9cNMJQ+zNrGX+sjCBv5zG0qDpdOVXol0oXVYBJBve
         PcQHZejl/CzXacb97EcSBq/axVpKDCgwYzeoegvLrGjOatCaiVXblLqgrTYl6nolqNI7
         z81w==
X-Forwarded-Encrypted: i=1; AJvYcCVrB1gPMU8CSC5hvqGq9jVy8ssEfeQSFGOiRqI5TfgW4WOnt5yRJ/5bm64tgQhgg+0ggkMcoswJ0HY7vceiOLtrkx+Lg3s=
X-Gm-Message-State: AOJu0Yx1a39AWvfBFJU1XbLOja5J2w/lbak+Dtvy1QxojU78mGnB2u9h
	sSx/gr4+NdiA8+iyes+IDZJYxabM2ZtfLw22/OsMPNF6jWfnvEIHJIaXJu1095/QwUY2KB5Ld79
	53F77+TCkWEAk1v7DIgop/EdhqRE=
X-Google-Smtp-Source: AGHT+IHPmY1syujhBD4xStYQPROXKUhZWyW6X0fVqqUaltqcDWT552yWFmDdwt+9n9NNErHbE+ctL8JdG2V4VRpEbdM=
X-Received: by 2002:a17:906:5856:b0:a55:5fb4:824f with SMTP id
 h22-20020a170906585600b00a555fb4824fmr3525634ejs.45.1713583389615; Fri, 19
 Apr 2024 20:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
 <CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com>
 <CAL+tcoAEN-OQeqn3m3zLGUiPZEaoTjz0WHaNL-xm702aot_m-g@mail.gmail.com>
 <CANn89iL9OzD5+Y56F_8Jqyxwa5eDQPaPjhX9Y-Y_b9+bcQE08Q@mail.gmail.com>
 <CAL+tcoBn8RHm8AbwMBJ6FM6PMLLotCwTxSgPS1ABd-_D7uBSxw@mail.gmail.com>
 <CANn89iJ4a5VE-_AV-wVrh9Zpu0yS=jtwJaR_s2cBX7pP_QGQXQ@mail.gmail.com>
 <CAL+tcoA_eU98hMoWA2UM2LD_fNp=geY0uUfc+4pDnbUCKK6=Ew@mail.gmail.com> <20240419223553.49cb0628@rorschach.local.home>
In-Reply-To: <20240419223553.49cb0628@rorschach.local.home>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 20 Apr 2024 11:22:32 +0800
Message-ID: <CAL+tcoBS1pAp-1sKE8V9CHEXqwme2-eRvwJtL150mGqmD+7hpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	pabeni@redhat.com, davem@davemloft.net, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Steven,

On Sat, Apr 20, 2024 at 10:36=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Fri, 19 Apr 2024 16:00:20 +0800
> Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> > If other experts see this thread, please help me. I would appreciate
> > it. I have strong interests and feel strong responsibility to
> > implement something like this patch series. It can be very useful!!
>
> I'm not a networking expert, but as I'm Cc'd and this is about tracing,
> I'll jump in to see if I can help. Honestly, reading the thread, it
> appears that you and Eric are talking past each other.
>
> I believe Eric is concerned about losing the value of the enum. Enums
> are types, and if you typecast them to another type, they lose the
> previous type, and all the safety that goes with it.

Ah, I see. Possible lost value in another enum could cause a problem.

>
> Now, I do not really understand the problem trying to be solved here. I
> understand how TCP works but I never looked into the implementation of
> MPTCP.
>
> You added this:
>
> +static inline enum sk_rst_reason convert_mptcp_reason(u32 reason)
> +{
> +       return reason +=3D RST_REASON_START;
> +}
>
> And used it for places like this:
>
> @@ -309,8 +309,13 @@ static struct dst_entry *subflow_v4_route_req(const =
struct sock *sk,
>                 return dst;
>
>         dst_release(dst);
> -       if (!req->syncookie)
> -               tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NO=
T_SPECIFIED);
> +       if (!req->syncookie) {
> +               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> +               enum sk_rst_reason reason;
> +
> +               reason =3D convert_mptcp_reason(mpext->reset_reason);
> +               tcp_request_sock_ops.send_reset(sk, skb, reason);
> +       }
>         return NULL;
>  }
>
> As I don't know this code or how MPTCP works, I do not understand the
> above. It use to pass to send_reset() SK_RST_REASON_NOT_SPECIFIED. But
> now it takes a "reset_reason" calls the "convert_mptcp_reason()" to get
> back a enum value.
>
> If you are mapping the reset_reason to enum sk_rst_reason, why not do
> it via a real conversion instead of this fragile arithmetic between the t=
wo
> values?
>
> static inline enum sk_rst_reason convert_mptcp_reason(u32 reason)
> {
>         switch(reason) {
>         case 0: return SK_RST_REASON_MPTCP_RST_EUNSPEC;
>         case 1: return SK_RST_REASON_MPTCP_RST_EMPTCP;
>         case 2: return SK_RST_REASON_MPTCP_RST_ERESOURCE;
>         [..]
>         default: return SK_RST_REASON_MAX; // or some other error value
>         ]
> }

This code snippet looks much better than mine.

>
> I'm not sure if this is any better, but it's not doing any casting and
> it's easier to understand. It's a simple mapping between the reason and
> the enum and there's no inherit dependency between the values. Could
> possibly create enums for the reason numbers and replace the hard coded
> values with them.

Right.

I also need to handle many drop reasons cases like what you do. Due to
too many of them, I will try the key-value map instead of switch-case
and then see if it works.

>
> That way that helper function is at least doing a real conversion of
> one type to another.
>
> But like I said from the beginning. I don't understand the details here
> and have not spent the time to dig deeper. I just read the thread and I
> agree with Eric that the arithmetic conversion of reason to an enum
> looks fragile at best and buggy at worst.

Thanks so much for your help, which I didn't even imagine.

Sure, after one night of investigation, I figured it out. I will drop
enum casts without any doubt as Eric and you suggested. But I believe
a new enum is needed, grouping various reasons together which help
ftrace print the valid string to userspace.

Thanks,
Jason

>
> -- Steve
