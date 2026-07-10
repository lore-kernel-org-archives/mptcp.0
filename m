Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4536BCC0
	for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703863; cv=pass; b=QpSMPJ6yf7p9gT+fC1QGPadV11wKlseHH7RTpq4t3KtrYpokn/j/DxzMhb51qQ8GAx0PRqYVyeNcWe1BrKQV1p/CbQ1t0imSh89YbMfEYZ33JofnevCvBzDdpBk+Ik4GO9NGKhig3TS1bjvrzySd0I6+m83LFemwfU2jXLIy1Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703863; c=relaxed/simple;
	bh=cloqDt+kKHjFhVMDkHMf7Pt1Uk9qilaHb1q0dagfRco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqCuDKo4Lma6umMW41tAmrZ81dk/KLSTeOuouL4Aw0nf+M0xk7xrs00wLKM7iRn/eV62jMCpoVN+IK1B23hDlSxU9FUWkMHOdronfiOSNUtw2iHvvqh9uyPaihGbu+ecEVAi1tp9ZwylvG9cVCz79dvGIhrb4tq8yAQU5fya9kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI8lD8in; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI8lD8in"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e86df8987so6820197b3.3
        for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 10:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783703860; cv=none;
        d=google.com; s=arc-20260327;
        b=T4YVD4zQfCsEm3/1CZnqW/amVhuGccF4veRwvL5KiW1PvNTt6PUlBhqB4FeZiZ9heS
         MTJtr6c98YhBXPHnKMfsTahLG0OqU9RCwD4c7Nz68drSL40ojkIT5lVwrpE1tdNOJvoN
         yYsOWegvQuZsANJHQB3IbHpPuQmeEl9zrkIbn6dAOIFv1L9LB4bO0wiK6dVmMVkGBlIJ
         xulnn21n+rFsA8L8d50PfgxOu7ec4+KRVnjfe8XxcBtkMLn50yGa8MCRP/8WXWwzQwu8
         89IhA16iqG9lVsrHIgx3BjaPubIiSZeurVprhq40g9/NMp0Nz0RMgTWbzcmIJpJ6Lb0s
         ttmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9yP31KpZ0prxpwQHwr+ymc81I89H9wJeBHrNHNNhnqc=;
        fh=FrsJj9MTb49lFuipbeB3NOcXSiMa+iQ3hQKGPcCw0qg=;
        b=L43ANjLSJEqlP0L76mZZjiWYvpn9Rrq0E6mz3IxCFMFTfbh/YmyoUpYTQPWF7P/CoJ
         Bth5dzVM5uN8VWG5UPQVjEPipAs5ZpIh4jppFsK4u0SaY7u37aQ8/jonNTr9DC5Nsing
         HxnQpO2CM8VNjeQbGMLBxV+Bpf+HcFHwK7pE1O9/13ow1EYGafagVMsKIyuCzoOtTlp7
         HMBwz0XoWTT5O7mZns3WqzkyNqdbk3c+xeOl40ULcT80LbTWiyknaIPYNpAoy02nftOb
         Wr7VkIDzCoVA89voE9iF/yDuujUgry26ekr4JcfvnaWWixSTy500PBqJ9Zw9OvmDu+rQ
         1MYQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783703860; x=1784308660; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9yP31KpZ0prxpwQHwr+ymc81I89H9wJeBHrNHNNhnqc=;
        b=GI8lD8inFMGyo6xieqBiSrpGETIKCYBfQiZZqvJv1Zdo72KupRVXp3TGGwSsOSmu7F
         X4YdTG+5KbxCdQ6Vb0Q0BpQGxzAWk1CLissrZAArOBz4Vjs7OGXvjnk65KydmGmYPV9G
         MXCEvkj7xJl0LDPIQfb9x6V30nwnffBsiJSzQnFelrfqfMd2lWh7P03OT6mQAHDT5Oq6
         brEjVOo7GHoI/2GkX7IFTpJZxjf8OdcSrew8EoNHV8nY+mVWEuE80gnfd0jsqyP6zuEl
         uQq5R2U5IZ9aYnrzHyCHirEtcBkIzhPNxpGecKBeQLZP7SYJINN2fm3WHQ0hEAADu7Do
         /xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783703860; x=1784308660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yP31KpZ0prxpwQHwr+ymc81I89H9wJeBHrNHNNhnqc=;
        b=b8GWZCLevgw5v+k5x1R7/ev5lLulIVzn/5OlnOQC+HmmN3ivo19gOwKN7CkVKUQhce
         81CCjKkRtjFJUFRqGkYW8BCWxzumpELfW2DyDSVkyPpPCxWyMv17JUEJ2ALn+x+Xc9Y8
         NHfd9GBfy06AU9x5VSzssJpIdECp1EwfkYSSS6yUU9MNcN+acO5JJ/uaEl/umj/5s/3D
         Ke6GSWRp/myRGek8xEV51rO4Gjrt5AMRPdmGVJdplp2xmlum0xlMpnT7Qj4N1FLWd0GH
         JXModrc6bHzb9S2gMyvh1W0uZp+zMbVqHN0wLI5Bv6szZ2gAdftYf0POKmhJ5gMSFJnj
         YFlg==
X-Forwarded-Encrypted: i=1; AHgh+RqeoOzfUZhO96JWwAm+V86BIxTJppKrPOnS5kkkYAMW0cV8Wt/0MkMcMhA+MMMQtRkHMFsGhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzplQ8f9A+Gl3h4XKZTldokYhoOszbxNPUOufq53e0HVvbOOL9c
	GV44urVIWqtePEaoYJjnR0R4tQs6uWg66wTucfqySiHtX15gXMx+1XrW0taWobq8LyFBAf31Uid
	ZqZbnG/WrRoZTknlP7uT6fL0+Pa8ISJ8=
X-Gm-Gg: AfdE7clwlYqUZI1S9PzqAq1BO6fNXur3udAr5Vw/6ITQ3Q2LB9Y5O5SQryA4pNlH8rT
	N8q4LbwkdygU+hMZUFe+M8Ueth4CcJfADeC4MLcP5E45j4NtpuBqApXw0LWJ6/XLNJQ+Xs7cTtE
	yPWkt38c7w8o58JUCF3c1wvHpRW09jb3G+ci6klnxGfA5hOibiNqNQI7QawvBg0JgySBCcVp8Nt
	Mc/DUzfQoshSTLRX1+8bwBhjXQ/gJaW0AvdAeUxgThn6dOZCxvB3KKAWc3npCp4KK8DsgjfuaMH
	D9xbr71xaerjl5/eWHjqPcBNuA==
X-Received: by 2002:a05:690c:6f05:b0:81e:68a2:89d5 with SMTP id
 00721157ae682-81e68a290efmr72264847b3.55.1783703860098; Fri, 10 Jul 2026
 10:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709191925.2811195-1-michael.bommarito@gmail.com> <5bb0177a-8d42-4301-8cf1-db4630f18437@kernel.org>
In-Reply-To: <5bb0177a-8d42-4301-8cf1-db4630f18437@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 10 Jul 2026 13:17:28 -0400
X-Gm-Features: AVVi8CfKhE_3n1rmJO_w_NXuQObQrOpTY7H7ae8Vyd0BpFgvocII4BQ36A63jjg
Message-ID: <CAJJ9bXxYfCPgh6ZsMCXf6YrpEPPzKmOcDwD0L1cNcWAefBFTLg@mail.gmail.com>
Subject: Re: [PATCH net v3] mptcp: only set DATA_FIN when a mapping is present
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 12:19=E2=80=AFPM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> I tried to reproduce it on my side using packetdrill-mptcp [1], but I
> was not able to test with KMSAN: my kernel boot, but is stuck when KMSAN
> is enabled... By chance, if you can try this reproducer on your side,
> with and without your patched kernel, that would be great :)
>
> [1] https://github.com/multipath-tcp/packetdrill/pull/203

Can you try with more RAM and make sure that you have these set too?

CONFIG_CRYPTO_USER_API=3Dy
CONFIG_CRYPTO_USER_API_HASH=3Dy

I was able to get your PR #203 test to trigger after using -m 8G +
AF_ALG under vng

  BUG: KMSAN: uninit-value in mptcp_incoming_options+0x1da9
   mptcp_incoming_options
   tcp_data_queue
   tcp_rcv_established
   tcp_v4_do_rcv
   tcp_v4_rcv
   ip_protocol_deliver_rcu
   ip_local_deliver_finish
   ip_local_deliver
   ip_rcv

Thanks,
Mike
