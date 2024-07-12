Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94E16F83D
	for <mptcp@lists.linux.dev>; Fri, 12 Jul 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796008; cv=none; b=fmfQtrytKUC6e6PwC01yEo3azxbkTMha9ljZGuG68dG09SYfsMme3JIkl+0LbD6xuSzdMoOe3CGRLR1DLpzrRlqCO5JrbLWUmXr2ZXiXpBMtVpln+3M3ejNbH+BFUAN9d0uY5ecZM6PA4K4mwyd6WRbUwPoXHj6xm0v1eGHoQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796008; c=relaxed/simple;
	bh=KxUiaSe9ReOfFWkk/d/LoDFP84ZRFNAPbJJG0WN0fKs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SogWIKabE28fC/GezFGWdDzR/Fs1yCUh29Eo7PNNf6EKJDwhCFpSq+2Gx1qpmxaBfZe279CBw2d7XuZN6kKL55ORWfq3aAen2iP/OOart7lIMxQwAxPVJK0LoY/2AZVK8TYYkaWB7fZb+Z5AMyY5lJBR05+La24UkcwWQCxyXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Swnee4m9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Swnee4m9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720796005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KOEjUzcDKHPMjn7wvjC/HliKTJzQk8gKFJuj/YD7krU=;
	b=Swnee4m9twxfg9HYg5zL0u0jqQY3otg9G4dVsi4vFRU72XMPiWS6uB7r57icaTm5FunFsL
	XsMyG5cFNAUIcCkM1/jn06bcuk2e6Mx577eNpRbbXghhDrL9aH9SZnzv7ylq5rpM5ap6CE
	XYcTb1USAgZl58rT+r/HiTCM4AJQYv8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-amCpvPbaNsmQfWhedc17Pg-1; Fri, 12 Jul 2024 10:53:24 -0400
X-MC-Unique: amCpvPbaNsmQfWhedc17Pg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42669213f26so4040845e9.2
        for <mptcp@lists.linux.dev>; Fri, 12 Jul 2024 07:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796002; x=1721400802;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOEjUzcDKHPMjn7wvjC/HliKTJzQk8gKFJuj/YD7krU=;
        b=p2VNBsD5YyGy1boWAoFuvQAXLxC/lv5EwJGxoXoXVxg/jKICvTVzReeXTMMflWYo9U
         2KfXDwqXOHaJpz0tp5bnB9pjPIB/RWkHzta94nR+bnEiLl9uOZh4cUYfetC4k0xUfSMp
         kKDWrGMdfRbxbSUDjUX34Rh936nXq4UIOAQFllOHj8QpJKrcOWNfO7lkzJHO8mQ2bn3H
         YY63vvKFeyuH3GpOfGralBYAtzeesqbGu4DpEI3AOP2QzfRw3BGLIqK34fGjA0+QjwbU
         LrSQ41j1czuYrGqXkLh/xIOwRn43iOxSF+MdZZ2U8LPHdrlGnws4nHxGExOnZ2FwPPr0
         /HcA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Rlm6DVrj4RoaEMBVhLVta9/3nLbjeBzIqZDRniCQGHEyrfAo0KxGuJPkj3fqUO4w7dDZQwYVJS1AMZvHu0o41TeSoGo=
X-Gm-Message-State: AOJu0YxIAjrORDAEaR9vkeTdJaiEYAnS/qfO1M0O4ove8g6ungSR5NBh
	E27vbDbnTMZ3U2Kb2CLt0O6zb9jrwGozEdfBmDDDXVkh8xOQpvMycPc59Uc+BEf6AilsjiGoE38
	Y4iSPI8Pr5VHJt6uPA1O6GmhJivrm5GR0z8+LM6ns4bLClfBzTSDo8FNptB5Nk/E=
X-Received: by 2002:a05:6000:1f81:b0:35f:1edb:4695 with SMTP id ffacd0b85a97d-367f05aa925mr3621508f8f.6.1720796002690;
        Fri, 12 Jul 2024 07:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvllgIITaMnVIBQBwilPiPF7nY7ffmRc6QMcHtOWUsrS2gKwUI8jEOy0GHZbGk7EvRgEeDXA==
X-Received: by 2002:a05:6000:1f81:b0:35f:1edb:4695 with SMTP id ffacd0b85a97d-367f05aa925mr3621497f8f.6.1720796002282;
        Fri, 12 Jul 2024 07:53:22 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde847a3sm10386187f8f.39.2024.07.12.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:53:21 -0700 (PDT)
Message-ID: <f0a2146bc7c556c5abbbfa25ce4dd9d3d7db801c.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/6] mptcp: sched: check both directions for
 backup
From: Paolo Abeni <pabeni@redhat.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 12 Jul 2024 16:53:20 +0200
In-Reply-To: <20240711-mptcp-backup-mpj-v1-1-d45506182a9e@kernel.org>
References: <20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org>
	 <20240711-mptcp-backup-mpj-v1-1-d45506182a9e@kernel.org>
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

On Thu, 2024-07-11 at 17:38 +0200, Matthieu Baerts (NGI0) wrote:
> The 'mptcp_subflow_context' structure has two items related to the
> backup flags:
>=20
>  - 'backup': the subflow has been marked as backup by the other peer
>=20
> - 'request_bkup': the backup flag has been set by the host
>=20
> Before this patch, the scheduler was only looking at the 'backup' flag.
> That can make sense in some cases, but it looks like that's not what we
> wanted for the general use, because either the path-manager was setting
> both of them when sending an MP_PRIO, or the receiver was duplicating
> the 'backup' flag in the subflow request.

According to rfc 8684 section 3.3.8, setting the B (backup) bit in the
MPJ header """indicate to its peer that this path should be treated as
a backup path to use only in the event of failure of other working
subflows (i.e., a subflow where the receiver has indicated that B=3D1
SHOULD NOT be used to send data unless there are no usable subflows
where B=3D0)."""

I read the above as the path manager should only look at the 'backup'
field?!?

Thanks,

Paolo

