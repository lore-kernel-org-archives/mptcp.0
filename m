Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C9221FC6
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860924; cv=pass; b=IEQHcNlFhm5l8vr+X1oXk3yZrFHhgIUyLmRNnagK9yeBjdzgtUF33+HlGmXNO8UB17vTkas/RpWJsv5qpwp7yXuAfARZLcWY+CzpVp+8RQt5ZNENniiGKcj7thI9/PtYCBAFtO1pUrJEzPgdRPfdDm9j3KkDDuCST9vAEE+xO2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860924; c=relaxed/simple;
	bh=hXgVm2y4ccbFw3UpQbCGgU7iu416H9DXJTbFn7H5pu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLKiV1dJQH7AFtAvdy6eXsS6o0yEF0/RxHFuykdxZH871QGqpfyOG7vgHr5KHEH/QQYH2xicvpX1XqfhyjSJwDzuzuk8DHcHAIn74oBmGgk4ZsnR96f48/vOJTE/z1zkINSToOJ9/N+HlqcTtm0WplKzXFh40p3tme1dLVGWT2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJaMZESr; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJaMZESr"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-485462d9290so3312192b6e.1
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 22:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779860922; cv=none;
        d=google.com; s=arc-20240605;
        b=OY1RIOHKz/8vsHI9hqAebPRo9M05NqkLCJq1c1svsrqcI2YnjiXZrNtvGi9xP21d5Q
         4ypHgyxy0ZfyYWJwVaz4eT+MKoYBHQEWqwsmt5Y4KERmqeYDR4AXlW8LUuJwTPatrRD6
         ctW8W0Rx9cV8+5NjAJWiWwGBe61Ofqg47fiTw7qPOVbCbcSa4Fbhui5Y1MVKXakC9CeN
         9BvCHxJKv0rYWYocUHm2ntBQe7cV+7TsQLoN0yPEQKVk2RuODnCFqP+QCdshRWXED4Bz
         iyYyL///7nm3AZW9z1FW0SPwl83+ULBk0EXIdYVcMqOMZ2JxSvG+y/Jx+4CYRlcXuVvp
         JmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CeL/PDZNi4rQ/JgP6XAgwtLvM1wDv+urK/AANRNM/CY=;
        fh=uOgxwBv/G00xChfAXgYBX18fjEAiKqASTCSINK036KA=;
        b=dQVh4hXpM4nGufmCgO/ELQv/Enu6E3Pxm24voX7xX63mdoSn66yxFgpHRS2NYUxGCW
         1bKlHMA3YX2/AKUMyyDmh2iVLbQj0NWK48SFBtx8i1b/NaOpgG9jzLC64LGFGC1kEVRV
         86ZSnzz3KjxkN3zvcEFmx1WMPOpZ7S57n5ONgSySBJ3JiL1B6+XIlO8I2Kl5qfoIu5hP
         tGCRTBxYCgBe+KprWAn5sjtmYjmNH2Jc/9Ci91uE8YXNY65XHDZyc2srGuwk6G1XGPtc
         QnuI/vIiqE5DOcuLCyUReC2GJECYortIQvwmC1TjQDzijthXmiXPtzdi41lAgr4emSFu
         21Mg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779860922; x=1780465722; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeL/PDZNi4rQ/JgP6XAgwtLvM1wDv+urK/AANRNM/CY=;
        b=oJaMZESr7vCx1pxIaHwCJkKmjOCFHSWSBKhgfhiBgrDSS7B+e5z5+EvcCQa9xARXKc
         RyNh2BgaHts/5sPsh9Mgp6GtDVgsqB6F49rMzl0wDSVxCee/QKpi69dV9VFFtdd9sBGJ
         dI1ZiRDxGhcxfKakIh8O0dzp27Y0J/KPCLLs6V7ZtLLe24AQGjxZfjDhHPTKOmvQwt91
         TtZRpGZ9O9KrU037IVZGyOZFIOiWSSr/1UqrQ4hCop/5LA/VaYrr3lmhIw6uMSW/FURU
         wKJEWQ2rIzyBU4Y6r6rmc/aQK/uAcjkYHuZ5N5a3insNXYpODJ3b5Jr4JQcO9dxt5hzU
         RBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779860922; x=1780465722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CeL/PDZNi4rQ/JgP6XAgwtLvM1wDv+urK/AANRNM/CY=;
        b=IlM0lr+PsoaTdcyl+VSMxpxslBrhXWmVOcEfMpSFPvSGdKAiqHq++r/oYEbV4owNk8
         CVV5kyfhWgt71DD+0Bg3ye3gxqaqlh5qMRVAaQ0fxJf0/zKMIVzTwKku/r389s4l0OEv
         VQyYUR7K03vlNLyOYqMNyqluVn2BsMnGs8DbsVvn2STjMZacSntyA7JGkPTH+9+QDRNF
         AnHzQ4zE+xfC5fGROxCGd5L94+4lpXXFsf+dwfhcDWcLBV71GF26Gf2YMwhDepXzoLvQ
         38yj+4Ar1+f3zcHTuZIx2J/ebSoiAVYqREaHV/SPoS7zjZbks1AtDAxiXy1s1FYiQu4Y
         fCBQ==
X-Gm-Message-State: AOJu0YyV7KrFgTrmJqdyejNnY31M3UWiupxePSgrhOkoeJhHg3bFUzyl
	DCtgZpMHiuP0SfBqB6FX4sHijlU3gAj+c52cZ+QzQBSdaBq0eqIeIy0g78ciE6gVhVB3mNDFKke
	ZczLdXjlpOePMxHcAgiX5DSMoqzT9cmDKBuPcHYc=
X-Gm-Gg: Acq92OGLrKqo8YopQXdAR/rppG9+OLi4B6FCXRXRO5mjDdYA0ZxjlbdVx5xBLNOfHfE
	8UhFAesdyrSW0GiImRH6nIjOiAB8XnnV3jqhIaT76vbCdpoF/gqJxDrllnDckuP2fd6jJ4tSyPg
	/buC0uqVrVPsUZ6xkYrTkuAgf3jM3WwLh2hUfDfWd75D45f5MAS6FExcaYUz4mNrSMyDcfbQu+V
	dnkISwKVMHQOuSqWg8WGwReyyYw9KH7tcc8b6es2PAPwSPia9SdQZJe16xdGxkxfurCrL4psXMu
	7e+Y1205FyfAz+QQrLZG0WYKEKqH8C7lAj2J3A==
X-Received: by 2002:a05:6808:538e:b0:485:602c:5f69 with SMTP id
 5614622812f47-485602cd5dcmr8965394b6e.0.1779860922213; Tue, 26 May 2026
 22:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260509211651.104934-1-devnexen@gmail.com> <20260509211651.104934-3-devnexen@gmail.com>
 <2390d31c-096d-43d2-8300-dea2531ce6ac@kernel.org>
In-Reply-To: <2390d31c-096d-43d2-8300-dea2531ce6ac@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 27 May 2026 06:48:31 +0100
X-Gm-Features: AVHnY4KWCSpEaM8uF-ajLIKUPjdxiEC4zgZZ9OsiNGTBaHyzjA9hE5WTPkVlaZM
Message-ID: <CA+XhMqxp42=+F19Lbt6xFbbZwtsYu7+5qmdiRROf_g7e_Q5DNQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v7 2/4] mptcp: propagate RECVERR sockopts to subflows
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27/05/2026 06:37, Matthieu Baerts wrote:
>> +#include <net/ip.h>
>> +#include <net/ipv6.h>
>
> Are these new "include" really needed?

ip_setsockopt() was already used pre-patch (transitively pulled in), so
<net/ip.h> can go. <net/ipv6.h> I need for ipv6_setsockopt() =E2=80=94 will
double-check at build time and drop if transitive too.

>> +        if (level =3D=3D SOL_IPV6 && ssk->sk_family !=3D AF_INET6)
>> +            continue;
>
> This new check looks strange: [...]

Not a fix for an existing bug =E2=80=94 pre-patch, mptcp_setsockopt_all_sf(=
)
was only called with SOL_TCP (TCP_MAXSEG), where family is irrelevant.
RECVERR is the first SOL_IPV6 caller, so the v4-subflow-on-v6-msk
case never gets exercised on this path without this patch.

For that case: an AF_INET6 listener accepts MP_JOINs from v4 peers
(subflow created with sk_family =3D=3D AF_INET), and the userspace PM can
graft v4 subflows onto a v6 msk. Calling tcp_setsockopt(SOL_IPV6, ...)
on such a subflow hits ipv6_setsockopt()'s sk_family !=3D AF_INET6 check
and returns -EAFNOSUPPORT, aborting the loop and leaving the remaining
subflows desynchronised.

Since it's only needed by the new caller, I'll keep the skip in this
patch with an inline comment + a note in the commit message.

>> +    default:
>> +        release_sock(sk);
>> +        return -EOPNOTSUPP;
>
> When lock are used, we usually try to have one exit path: could you set
> 'ret' and use a "goto" here?
>
> Also, this "default" case should never be used, right? Do we need it? Or
> use a WARN?

Right, unreachable =E2=80=94 the caller filters to the four RECVERR optname=
s.
I'll drop the default and use a single 'ret' + goto out for the success
path.

>>      if (level =3D=3D SOL_IP)
>>          return mptcp_setsockopt_v4(msk, optname, optval, optlen);
>>
>> -    if (level =3D=3D SOL_IPV6)
>> +    if (level =3D=3D SOL_IPV6) {
>> +        if (sk->sk_family !=3D AF_INET6)
>> +            return -ENOPROTOOPT;
>
> Same here: Was it required before this patch? [...]

Not needed =E2=80=94 pre-patch the v6 path would already error out with
-EAFNOSUPPORT from the v6 layer further down. This is an unrelated
behaviour change; I'll drop both hunks (setsockopt + getsockopt).

Cheers
