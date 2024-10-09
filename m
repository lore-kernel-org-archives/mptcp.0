Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ABF17E012
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468328; cv=none; b=L3PNubiLxKQ/95n/XJ1ktutoknCwy8uzSNld2HnwWcUw+WC3EPwif7Rnzu7g6HB2LFzz2IxtsTSsmbw4MtkoZEyXdnlUMGfqxMNuz1FpT12xKPYYq/Yl7ZtX29SVC6+MhARvNOHUMWmsZCJUNuXuTGrRhCgtyMmwRhUZhkb1kCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468328; c=relaxed/simple;
	bh=SYZ82sprbNWKskdedXjk+tTzDMTqtq/Z64d+rtnGvRw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ltzh8ZM92ek3BmNHTRspNTJBOJc/j4DppGxHkuQlYTNWSUWtGk4WiX9Pw6aNvbOsinfi/LXWRALekbOVlLcmMER8EvsOc0jyQdWuScNTJuBpApAu4vXl0narMDWvZ6MDYHPonk3CdhFfxSk1HpSeBeEJqH3gon6llf5u3o6uIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epoCvL6B; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epoCvL6B"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dde476d3dfso53705867b3.3
        for <mptcp@lists.linux.dev>; Wed, 09 Oct 2024 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728468326; x=1729073126; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4qicWbObU8H1VrKOML3WMSa1WRf0SGn5o7FZO5HE9E=;
        b=epoCvL6BEMV2xmGrLubt8U0J6KxYUqPTsOw9Z7GER+y/rx2Jstqr5O5AhjYajxtYQq
         pi2G8LPzMoq/Lx3V5bLrlBEfpVKc0KhXjaqIFDjduxqfsql1eEtlm+37w5O/SiEE+ah0
         rjY3JwhwMcc+GLU9+2u9RGIEhu+4UdYf//Oi1BUp0GvfsunGor4JfviLXGJ+o4dSqnow
         4aAfLGBhMjWDIbKK9j6JYk1lAuqSyagM1cOQjHc7+cL7vmqiUYJ6NDJYZtahfpq63T3q
         v22IrLxZTN0x/MYkUOEJcg+cBpHYKg6WsTzHPzYH1xVkmKGVpF2ZFltUrcU57J4I2VuR
         Xn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728468326; x=1729073126;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4qicWbObU8H1VrKOML3WMSa1WRf0SGn5o7FZO5HE9E=;
        b=CC13cf/ci1A7thCmMMSb2RZmqH43dCnyOfXaDMiL3o8ge6sotpKYjLdhWU0o42dPRe
         uniBKZD9LyFguS5om4/wrgNCiEfuuL+NJ/DVunCHymCwKW1TkcAN1iSk78it66N6xJ3S
         4FaWIVDzE5s6jXaE9piH14FEH3Gwf/ZHtajtLAHtryMHJkCp3EJUTq9p6PNR+lmOLIIq
         eyMIhIBuBshCCcJdivOfVvCYshFd2hr8IHOw/8Z0eqYXWdH+Njhkx01AR3JYYc4IWTqI
         7+P8iOodkbsj115s6/r8Xk0MRdBwgAYTVUM7x65ofBiDOBDoN2pv1Pt/0T/WN4HLx0s2
         Mv7A==
X-Gm-Message-State: AOJu0Yw4qBE41jgh/WWuj6LWindUQLAjyHuuo8dMtLuRXJrKctkxQENQ
	BhzEf5mbrGPYCOL9pZrMPtoVQj4dsn6onj1PNyYUec9TV+TgcEH9FwMS
X-Google-Smtp-Source: AGHT+IGod5/iHQ2qMbjYQ4M1B+Thd6R9lxLZdi3DaD38olhlI69Bl8S316yazpdL4YeG7GW9w2JlIQ==
X-Received: by 2002:a05:690c:b82:b0:6dd:cc0f:559c with SMTP id 00721157ae682-6e32215c832mr21389287b3.22.1728468325654;
        Wed, 09 Oct 2024 03:05:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.162.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d927f2ecsm17928307b3.45.2024.10.09.03.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 03:05:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728466623.git.tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 0/7] add mptcp_subflow bpf_iter
Message-ID: <30504191-4b5f-1a69-08a3-5ae0f444c802@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Oct 2024 10:05:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/11252652867

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b0=
0f1ec86da9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D897104

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
