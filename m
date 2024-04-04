Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F01803D
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712195910; cv=none; b=BL682bqYlCRSu+5PQRrwcor5hJmjogij/VYN3YisEB7x7HHTsxvvOtElDuYOL1ViVbcbLvjQga4ml0BhgoSbJtxfQkbPzlH/6bL3R1AJAsED99MCLMgBUSjK7BuHQ8WJ9WnDfeyx54n2dZphlH3Qwom7cqMdnsCZaKOSH8PqyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712195910; c=relaxed/simple;
	bh=ymv1KcCN3gYzCfq9KbAxjhU2YrRREjNMUnRC1R1ab18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gad+ebpvJoxgWwwq2yDC+AkKrLNQhbPGLlltCq9B7tDQFD3+XcWFVXUA1B7VwTQwZSa1xGODS1IBu59+GULPDKW3bb0Gmr0ZWJ/IUHlEoU527A6/Ds5zC/BmIls17ie0hrIw59ZxnHSuY+uw1qBRoAMz8sFUmsJUbM98CCmfEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjPlliuN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjPlliuN"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56dfb52d10cso454032a12.2
        for <mptcp@lists.linux.dev>; Wed, 03 Apr 2024 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712195907; x=1712800707; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edjm4j6Dw4ZOSSQICjoznYKS8GYUsUxh5ZnKOQjsVhI=;
        b=fjPlliuNCzREi/H9ijLzL2mdceVBhrGrVOD5qn+WkWGkiToaGr2p65sjBCy6/IpgF9
         8T2TX7rhaxdlNPQHrrPGyLAGUWv39pZNSKSpLohUvifeoQ4sK1iUCXXY68tBWOZscwwG
         p42SM1IZUkH2WbCRBHtphR+6GUEoC0RoHGi8yGh8vdHpUOXx4WWVutJ5+z43zIE9u6AW
         cPo1QT0dFl57vwTSTTKfRZ1AC3wBk7zt2+x9HHVZdEzx51cUz+j7gcOM2USfohrXu3XZ
         bmbvHYYRqKZT+Y+37N2VOXHHChZEO1RE1fX3Dg5UyGxHPqqiXkvfI3D95CTphO5vjSib
         vBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712195907; x=1712800707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Edjm4j6Dw4ZOSSQICjoznYKS8GYUsUxh5ZnKOQjsVhI=;
        b=Dm96915506k3m68kp5p8sPhv40xhT7la1bcuxDwnQkvP6P8EMnPfBp7vm9TAQhJOkA
         y8aCiTelWULZTi9LHzN23m8m+hnX1AXanTGYjz2KUYRHAETYbaI+yewc2u9gb2DyL2UG
         yMOYmv0UwZomGdWXE1RuihAb13Fg2hKkgpqeO4y0eD8a8QUcr1fd2tbagCiG4ao8+o5A
         TJq3oGmwWYzenqsUDDVJHbHo2J8sS9Z1klzUJDA0J8gbm3fG+4vQ6Cq6szdOLeTmnyEO
         AOQivT2l5J0VZStwf4sCxOIgFvqTMbAC6pB58NMSSHPUV39ttT44tyKjWFc9j7uKbOTX
         4nrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8okWmv+E2QotZB722D4ly1Qpd981lMRyzfCy8aSDe4eKP8PZNfqt6Pjg63t6WEyI7JKnScuOktEuvLCwOX2lUNdAcQiY=
X-Gm-Message-State: AOJu0YwvgCYkzzehyD8wCzLm9LPg2G/KfUOhhPzhyUU8XeQ5pnFexTvh
	9DqT8sr1zHP6HuBjjmV/Zax1Qkgpjy2s2g5UXAo2Wzv6j3FT+NVaN09hBsisH/59Dd9bz1ZhCsd
	IvjG+9pC7u5vJP/LlhaecZ9Ec9jE=
X-Google-Smtp-Source: AGHT+IEK5qJlWZay2FL+Z0BWOTGdPJfiELN0iLN53ebkDnls5+3I2K0ffBrE8bSeLef9zcTtpKkqgoH9v2+TUwuLqdM=
X-Received: by 2002:a17:906:f58d:b0:a51:8b96:2931 with SMTP id
 cm13-20020a170906f58d00b00a518b962931mr41427ejd.54.1712195907242; Wed, 03 Apr
 2024 18:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240403073144.35036-1-kerneljasonxing@gmail.com> <20240403185033.47ebc6a9@kernel.org>
In-Reply-To: <20240403185033.47ebc6a9@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Apr 2024 09:57:50 +0800
Message-ID: <CAL+tcoDd=ueHVqBpe8r9R4R1vW6k0RiSfCn=vzHAaLNycb4xBA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] Implement reset reason mechanism to detect
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, pabeni@redhat.com, davem@davemloft.net, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 9:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  3 Apr 2024 15:31:38 +0800 Jason Xing wrote:
> > It's based on top of https://patchwork.kernel.org/project/netdevbpf/lis=
t/?series=3D840182
>
> Please post as RFC if there's a dependency.
> We don't maintain patch queues for people.

Got it. Thanks.

I'll wait for that patch series to get merged. I believe it will not
take too long:)

> --
> pw-bot: cr
