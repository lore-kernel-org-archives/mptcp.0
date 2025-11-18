Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01847285CA4
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440662; cv=none; b=AdZYqs32y/YsBSiLwAaybVowubN6NiBuAE1D2+tNbzLjPsfl7Ap+J4TI04kjrE+u7VK+VAMfxv/qrMaXVdM8zQJWR6gyeyzKTg4UfFxj1lRBLEw6zv0ZHTMgSKVT2AyDdOnuizWq1UXbMezW+1TxIDodslh637ktwIGhsSWB5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440662; c=relaxed/simple;
	bh=nzSYnu2yFpz1A07+YglaCaBaZJlIowwsrD6g4qJlYJY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=JcR6TzWqlodwvHQSS5aVGIlWqTt2I1XfL6zisBSajHfwm7+eo9cMs/sqH9R1OjZstcfsvw6xJg5fHTU0AepEaczg3KRaUuOyBy0Eg75plaOwVm7m/m4BDQKe1s9CwmfS+NoyJp24v0AzzjMw7pqzN6VSqsziGEG8OnsaHKPG9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctIWlHID; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctIWlHID"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2dcdde698so357566885a.3
        for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 20:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763440660; x=1764045460; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJm1K9oFU2aDLN6sAEH9KNGFJZlXF1UjtpbZUHW63No=;
        b=ctIWlHID7+hCsbQ5tvkiReRJXk0oAfD08lA/+tJQUvQoIMpd2YAIOgnorW7ERL2wap
         rH4Tq+ItjbkWE+3ckbEd/yjIiRlWSzyHctdT00DtE41ZJaKxp/79E8jobflhY9XZyw0F
         K1+wIH2HiGxqXSVdYlIMJFpeIMKUIGLgYoay5oxau90DwHSLoLWnbHgK+1Eyror2Tp04
         pIFYkArhr6jlKY7Y6xakN890d8oCrhqlfRxiX9mq3peoYO0PR9hxSbQ3uYPp0hhhmygC
         FuNrd2CFFsOW/nl3y6oJNPwggE6gLmfOToY8wF7ThBxDuycH5/TgsCUSlIzi2oqUV1aC
         kjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763440660; x=1764045460;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJm1K9oFU2aDLN6sAEH9KNGFJZlXF1UjtpbZUHW63No=;
        b=tvxQQ6kZtU4x3FANjQ5prQGcCOAZT1mQXT2GzNAt+i8kQoxvDNLD443MG3d8R+cZiw
         jq17TvIb8xR1zGB85EQwVVrAG1X0vEuEFRysEZkz+x2QZ6LzKJkjLve5lJh1mupBJX0Z
         9jDDvjOEhWQj3XYcDZ5pmwvlYB72ZmlrOExcNZ36IVtUvQ4rjREey0ZrY8FLaEo1HeQY
         WkmHv0/CQMB9F0A/ttu3lDzsBy1tRAE0v18/0bavs7kJOpDnl4rctGk5nU4WHVmRpbyu
         Wx75d3JPXolPzDVEgIGfpz7sVbkk4MjyeKdQOHSEdUrjEeyU1WX75PYuehr7L6y5Ok4F
         pYeA==
X-Gm-Message-State: AOJu0Ywm6YzSfUDbCIao8NyKzVVKb3Jm6LghY2+3qYZwnQYiR4ySZzSl
	2WgxzxfHUEYTUYPq0YYMVrmtz6ArzuQIGT4MyCRXyd876UDI/OHUiRhEwrqu
X-Gm-Gg: ASbGnctIjRW6D8lkrROq7I9ggD750J/DY6mlUcvvlbo9xoqPbjVADr3YtbQ67aNszRs
	Mc0qlTzGJBWNTGMVGfK5HVxxK8+3cIzcPeEUva3JW3gJzF9KCxydAJ0fI3mx2ogBWJM372kX2e8
	PGJHS+az2uFcPgteEbmbQiwMExSl1BiI4DYaea0rWgueVPLB5ZIQNo8kZUDbOyuHAdC9keF5FWB
	/RyeBDN6gZkN11GcX9kE1YIb+xaqmetEUWSyyJB1ib/bxxgXWxD5sNi3S0X9Ph9nVOgHAqRMHcN
	PyYdMMKAMgI7PEuEZhOOG9InJ4/wOlCFMEBe0/2ZDAHa0IfZ/pAKL9QBYouH4mIt0qyRFCM3IGw
	KyNnvRAaNgFUEevtR1gPbgGWE62GtGzpICYRRZZK7zeR1OUNJuRQ8KsEZyp0as7uqoWky+C0KGl
	1ReUY1NgPLjOmo7cu09dYuDpU0NR3yobNlMVbc
X-Google-Smtp-Source: AGHT+IHhKiug+FMoFSciCe2xjq+zLDV0FJ0Uyu9sFmmlnkoICrm5CZYk9KOT0C/KCttyhky+wguWjA==
X-Received: by 2002:a05:620a:1a1c:b0:892:9838:b16a with SMTP id af79cd13be357-8b2c31c927emr2076555685a.59.1763440659820;
        Mon, 17 Nov 2025 20:37:39 -0800 (PST)
Received: from [127.0.0.1] ([172.178.117.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2db481f57sm708747285a.4.2025.11.17.20.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 20:37:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next 00/10] MPTCP KTLS support
Message-ID: <ce80b0a2-7b23-1a07-41a3-468b4dfe3880@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Nov 2025 04:37:38 +0000
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
net-next/actions/runs/19453856367

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b3=
7b703d4e0a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1024635

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
