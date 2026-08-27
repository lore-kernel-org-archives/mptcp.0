Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554E328243
	for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807711; cv=none; b=uz6AkXhWByU2NAzcAMImA2n6DwWcXKN5QkCYQfzGxoDyZN+6mhCfYt9wJo9+9g9DdSEqG/sHY1AN1FwWnXM5R8hG8FZlJFpE8usgrqYDzS/CBLxzj7qUipIxepZ5axfrX0fLyZXDII/hvrFMKc165dq7VzPAp2/c/UJ7F0T2mOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807711; c=relaxed/simple;
	bh=E5+H6V+3XXZMBHSJKSx+D0MX8zkwluL0GQUvRGnWlNY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=DQP+IPhSIUGuvP5G6TYFPhEm7r02sh5aX8twZbxUlhfXy1GGOEFzCoLY53nFJDPRF1XpasiMiSkZrjUF5lV+HdVpAy1VvNUIlSo68V7l816omHjsICB+UqaTdRhchQqbp5lMkhfc7c3j2HBzCLkv84gEjP0zZBrZcDTD+n+dSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkeqXxkf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkeqXxkf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caea3f742bso5381395ad.0
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 22:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787807710; x=1788412510; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fCUVHxDnDXTR2PrfrMmsY7WMP/v8hs6PsX9U7iXoVa4=;
        b=rkeqXxkf6yJT8lQMymGIbxp6tHtNpdWxxTfKp2hyrwx/WgWWhe4J/Fkt5iN90zsS0W
         5Ic6pYt+ipNrk75I4XF+xTwvcZJplG15t3eXHp1b3CjNRa1frmMMKWprcQiLz8Pzpt+0
         nxu34qXXuDG6jLJqC44JByYet+682WSoM/I0n4fsJOeSln5cOD4is72L4+SGMISIwtKM
         xGp9o5PgW81HiUNUaAUSLHa7C9VgiC5i2+zfK5TK/Lvss31ucry3LnLxa64h7fxKAAz9
         4d9JKdJ53QRj0hIQr6pm+Kkm5MzJTesIRwMXl8KLtUBSYY9FFxD4kmEUVvvb0Z/JoC62
         eMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787807710; x=1788412510;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fCUVHxDnDXTR2PrfrMmsY7WMP/v8hs6PsX9U7iXoVa4=;
        b=Zm1+vPAG8j9NZXxHnJ/rgvqCOeyhRpFu0kU8kiU2YUg+mSbWaIqtAGuOMWhGcG+ITF
         o7t3NWstlHDf0CEZJh1+6jQkLhTZ3JMYatHxx0Ds9xavW+gKOeJO2UD2TfvrMpDfzxdI
         PccpIt76PcqjEVQtZElaKmVacgDLzTGJYnxuT6hrDyTfl5J91SwtjdQZaWwQhPvtnXhI
         BKhk2gzV5cYADa9EYqIs3j/LtJO5RS5jekj1wt4hXg3DtvcQq3Z1pJTLkfxlQUZCnNqD
         jp2ay43V/kaxSjwpbJXIY+iTs0F+iTXglwg1dw0BD3eUo3E6caVCk2Da0kmNwCC9fMhL
         ubVQ==
X-Gm-Message-State: AFuF++l0XjsZ4jJ0GeOxsxfFf+i4Z+3zt3zHCLLRsmSW1NGzFo2R1Qsi
	bWuZvTegPNXowSoG+NQ9mqRjayO5NrNp5MHunl06DIg1WSK9Ve5DO84=
X-Gm-Gg: AR+sD114ISbEibmJEzh0v6/jLu9KWsSL7315c+16rigS44xehcsSmcTJdW85YyHmXmT
	21VayzM/ATo6sY65eM5NR5XGstR/R7EzhEwH3BZYOUn1ygYB7K/RmdKWq8chZrWNZ1Cp4syjOTD
	dHADPpyJN14yDI/wMToqMFeAPL59rj0N3Og5NRmc0X9ZXdzIY5DLSSUkPlcoxDyOlEyHRjC65BR
	l+z3e0zhrxO/+hv27tiGvHRi68V5uKJK3+eDk7h+XxTZ4AbQkiIMG3tU4L6C/ysz50cWkuBlx0Y
	aBxQH4QLeT4yXtzP37Kpqk6USj5ppe4YPTJ9inGL2rOOI7qIDjTZTuQZcwwJpXxVb4ea6PFaTH2
	S9n8VvmAA3YDPgZpXfuCr3xxd/8KI8cDGiN/nN+RXLWnqDEE7e7f0YWIknGQoHcMRHlA0wL8A6E
	hLzQgyFaFLTNRG6GPR0umys/NaIJPiT9FnDtMjzAQR/O5FW/FPJGIPRu5EKfLjpwTpntlHj3Z1
X-Received: by 2002:a17:902:e54f:b0:2d6:e9f3:9305 with SMTP id d9443c01a7336-2d707a40c28mr213999485ad.5.1787807709722;
        Wed, 26 Aug 2026 22:15:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8bc3d2sm16063596eec.21.2026.08.26.22.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:15:09 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260827041058.2833707-1-kalpan.jani@mpiricsoftware.com>
References: <20260827041058.2833707-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next v2] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <624ffecf-61ba-28da-d8c5-dc45fc3edf02@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 05:15:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/330394=
01339

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/842add44df40
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1152387


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
