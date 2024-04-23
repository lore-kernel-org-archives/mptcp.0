Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B4168DE
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838520; cv=none; b=cmt4LxvQ+amooRxWP97CmXnLQfRZfrZnJxHXIhED7OVTX9dNo946Bi2zn9q7BjD0nDEgogSnAIhrj1NyXMnYXIzfAASjUn9Nfs9F2RrFfQDE96LoeiLAYqkcrp7AzQtmeD1a7Z/cpUhkhGrlIbQAljrIYH88r4VanMBIW+oPhUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838520; c=relaxed/simple;
	bh=GuYXJcFYNRLFxboJdCmbLjGSwgY45IyHwUaLxLSfj2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meTrLbT07aMvnaSl1HMClE0uhcW28tiE66vN+Y9OdbdI5A8G9W5P7he7vrDik/PZySG7IE+HuO2us4SAWkOu1EMH+o47qRcqB6PAeSUWDPe2m9u3Y9fLBRe4UkhXLiRuugWzOHGwItW6s3FHB8mDyBIo4iaMHGYi20qyT65sK3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3qfsoCN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3qfsoCN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5878caeb9eso42291366b.1
        for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 19:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713838517; x=1714443317; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3o8Gg1Q80DB5SQLoW+dy2JUtrw4tmu4mL6vo9DJdVo=;
        b=H3qfsoCNUYNCnfY2zJ9zZORpQjlBsEz3CRNK7KOTbFX6CW6LOLE+jMTEYIEq0dd5nR
         A/9RIMDT+FyzzKyipMAv7c0iSskd0UVeh1BgeRyRn5JfNsR6IERil84U5vRFTc9ik6ee
         jpp27hgr30nb3fOBKIqtbRGl4xUrAMzY+N0xyJvnQ/47yv2pAZnV4QqGnRt9LVa4zGOe
         gsZJQI2lfmq4lPGx/HbEqOTnt2nckCXVTDY9Lx2u+r/dGFCv8AnLajFq9hUXQ3aYrcZc
         c4+XJrLVUCMKmgiu+RaLIh0tQVhDolQxGXJIB3/j5Xqk5IVxMmmF/asriqmlNyNA4Xh+
         zKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713838517; x=1714443317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3o8Gg1Q80DB5SQLoW+dy2JUtrw4tmu4mL6vo9DJdVo=;
        b=St8DgTO82ocO9M1lUgMTyDILQmhUM/4SGG2HXP1ad7wu94FXvU/4KKrSGGyKiefYmF
         mrrvv98OOndEUCZdjsErmW/F0ZrBkVKMsLcHMNu0DuvT8BUgxysg5s3YqmBttzgDSbb1
         boQ6FtjMkWMDrRl73CQnbuw+pgdwg8qzaPJ5E7dtlT6ckrHcVTVVfe6FKN7RgfUHW37/
         Jl9XqRs8F3PA0mNVv6FEztcA1aXLMwq+s3fcA2BBlsZjOTtc1y1gUICpewCkalNJJ+qd
         hn92hERQZrADjnjgENGhlFsRxUWIUWcNQzQLaJoC6LE/FLSpaWhmcuGIMO5OS7kJ1OPG
         VoHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB0gmFpY26SwaIsByho1UziJ9S7I4HEbcXSQVw6BL8Jk9ZJktV5NpOCXqN+QR96blissWWtTCUtaYtoIU74gFDS+IUTSE=
X-Gm-Message-State: AOJu0YyCGkB1Ai4KX1GClBhgSHaUA1/9Nj22NNUBZTq3yr77QhzxSfu2
	bBUxDKoG2XwkRS4zshpFGrTgQFpjPK5HAv2sp1Nv1BWwnEIBsaIr3yj5NVk2U/P6TPnSAayw+s7
	NAPyEB0q2/TU5rMkqpBacBpy6ciA=
X-Google-Smtp-Source: AGHT+IEd/Bc/4e7Z9aJEomVzHjZQOX75mT5jm5Rrv5h9ArpasEnG2N7f8PckvsdGtNymaWGo4SGqrgGWC8NxoqopVhk=
X-Received: by 2002:a17:906:f901:b0:a55:5620:675c with SMTP id
 lc1-20020a170906f90100b00a555620675cmr7438444ejb.34.1713838516875; Mon, 22
 Apr 2024 19:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
 <20240422030109.12891-2-kerneljasonxing@gmail.com> <20240422182755.GD42092@kernel.org>
In-Reply-To: <20240422182755.GD42092@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Apr 2024 10:14:40 +0800
Message-ID: <CAL+tcoBKF0Koy37eakaYaafKgoJjeMMwkLBdJXTc_86EQnjOSw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Apr 23, 2024 at 2:28=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Apr 22, 2024 at 11:01:03AM +0800, Jason Xing wrote:
>
> ...
>
> > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
>
> ...
>
> > +/**
> > + * There are three parts in order:
> > + * 1) reset reason in MPTCP: only for MPTCP use
> > + * 2) skb drop reason: relying on drop reasons for such as passive res=
et
> > + * 3) independent reset reason: such as active reset reasons
> > + */
>
> Hi Jason,
>
> A minor nit from my side.
>
> '/**' denotes the beginning of a Kernel doc,
> but other than that, this comment is not a Kernel doc.
>
> FWIIW, I would suggest providing a proper Kernel doc for enum sk_rst_reas=
on.
> But another option would be to simply make this a normal comment,
> starting with "/* There are"

Thanks Simon. I'm trying to use the kdoc way to make it right :)

How about this one:
/**
 * enum sk_rst_reason - the reasons of socket reset
 *
 * The reason of skb drop, which is used in DCCP/TCP/MPTCP protocols.
 *
 * There are three parts in order:
 * 1) skb drop reasons: relying on drop reasons for such as passive
reset
 * 2) independent reset reasons: such as active reset reasons
 * 3) reset reasons in MPTCP: only for MPTCP use
 */
?

I chose to mimic what enum skb_drop_reason does in the
include/net/dropreason-core.h file.

> +enum sk_rst_reason {
> +       /**
> +        * Copy from include/uapi/linux/mptcp.h.
> +        * These reset fields will not be changed since they adhere to
> +        * RFC 8684. So do not touch them. I'm going to list each definit=
ion
> +        * of them respectively.
> +        */

Thanks to you, I found another similar point where I smell something
wrong as in the above code. I'm going to replace '/**' with '/*' since
it's only a comment, not a kdoc.

Thanks,
Jason
