Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5014291E
	for <mptcp@lists.linux.dev>; Fri,  5 Apr 2024 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303934; cv=none; b=kzaNQuF6w7t8dbjTJmej+QzdZ1VUnE2nNQOcaSxc3v6r4ql+ebeK0u3naq+vsiPR0kY6Vi0StX/YjVKMcOUZVURcNcSm+HcqP3AK8VyJsCts63740MGSkkUtJWgrW4Sb7dbYw6bcxSVv+faqAVoZz5ySe38tXhshC4iYyO4U4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303934; c=relaxed/simple;
	bh=8h0LF290BNLlM/vHBnVhqXt+ajZXc03kBGpM0QpctDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnXlwnPfvDEuKbw9LdHkGtFe1YreP8rqfhreMWGh7MqqWG5khutOKzqpsoUz72pMkI9NoK7kXdjQDIqOm1eMD+jXcJ4pFEwgovs73pPEeRTBQKnz2X6zfIOJ37B4XBSQLuO/DODigwrotBw5dHMG9vZo/47TLhPfVnGq5Ixiw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zrl9Dkjf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zrl9Dkjf"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51a7d4466bso27799466b.2
        for <mptcp@lists.linux.dev>; Fri, 05 Apr 2024 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712303931; x=1712908731; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h0LF290BNLlM/vHBnVhqXt+ajZXc03kBGpM0QpctDY=;
        b=Zrl9DkjfyoYVQ8kK2aXRZgvraOzlfGOZ5Ok9znQtFHA2zoOsChFLnI5EmS3+zv6GF6
         A0iKbtp+COWK+qPepvVRCNhNzV8AELYH8RPXUs0bQG7gPwgqZuh+PjlyM1dMv+5VSlTo
         BHNvh0eINJQXSN1iCaqN9ZyhdBxtisUsYJfBRyJHo+d2lUHmmrBtE4Ymulc9+/noigLJ
         CF+mKOw8NemL0WUiRQMF0+t8BPbt4Sy0ejK9MT7SxBmZw5aqqM5V3P/n3pdkqp9LfMet
         CA+K0RZHOfFxxqj+Up6pqPlxq+Ec1wPyM49iAs83l4M7Ii4FhnVjuBW7JlCj1OZbDewt
         F6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712303931; x=1712908731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h0LF290BNLlM/vHBnVhqXt+ajZXc03kBGpM0QpctDY=;
        b=n6Aiw4cwckfYJv0dXnuwFvZb2razyJ4AAqlr1QOBWqWKBP1kv7jFDAPmyjRmg1XSuu
         UOzzBHM7g4Z2hJGnZ0mk500HFQbDFEJxOPY10U+7NWs7WOmo+UzG8lIvjBzB4hT9u4HQ
         On6VwSXTvsK4kywnoDSxEgt8w50XANw1P1wZQLvO9da6Y88MAQVUyaOrPlvuFtcTjou5
         F5D37jljXK0jKOpUMTYEERioNo+LuKmDtOGS2Tkc+Suya54Fg64GDi/BPGcwAD6CM6Rx
         BFDuXjbPA8X+eG4BVPbdfMolk22EMw3Z+TAyHSqw512ElPN50VU01CBuqdug6CQNIVZI
         qGzg==
X-Forwarded-Encrypted: i=1; AJvYcCWF5yocLXqrrXQy7DunT6w1/+ssBVuj/ufj8T8S9wEFr0n2H6Z9zztNJsUHzXAX82M7SbluDj8xZd0O02v5tIxRHSMlKHY=
X-Gm-Message-State: AOJu0YzC+Jh1dxqFPOs5jq5qLac7PGI4i+zNvMYfsc/Tp48050TL1+QB
	Sz5dIvzNkn/SheEvBb5ucLjihlIq0c52n+1m8xQyHxBfQHs8kkL67pWOblQ+vuD/ZLSc5bT4e1Y
	YTjk7FYRWX+65VJ7k9pREoKYd2wg=
X-Google-Smtp-Source: AGHT+IFlgSGUCoSNpI6/sL6qIdfGOBZm6KSwh9vJ/RBw+3NQXkumQUgnJ0ic8zrXoo5FghWTYvxMogW31UHSZh8JY+s=
X-Received: by 2002:a17:907:7792:b0:a47:20c3:7c51 with SMTP id
 ky18-20020a170907779200b00a4720c37c51mr419089ejc.71.1712303931066; Fri, 05
 Apr 2024 00:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
 <20240405023914.54872-2-kerneljasonxing@gmail.com> <a0e75cbda948d9911425d8464ea47c92ab2eee3b.camel@redhat.com>
In-Reply-To: <a0e75cbda948d9911425d8464ea47c92ab2eee3b.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 15:58:14 +0800
Message-ID: <CAL+tcoBEkK-ncB6zdJrq7kkd3MEdyT7_ONOyB=0cVVR_oj-4yA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mptcp: don't need to check SKB_EXT_MPTCP in mptcp_reset_option()
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Paolo,

On Fri, Apr 5, 2024 at 3:47=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Fri, 2024-04-05 at 10:39 +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Before this, what mptcp_reset_option() checks is totally the same as
> > mptcp_get_ext() does, so we could skip it.
>
> Note that the somewhat duplicate test is (a possibly not great)
> optimization to avoid jumping in the mptcp code (possible icache
> misses) for plain TCP sockets.
>
> I guess we want to maintain it.

Okay, I just read code and found the duplication but may I ask why it
has something to do with icache misses?

Thanks,
Jason

>
> Cheers,
>
> Paolo
>
