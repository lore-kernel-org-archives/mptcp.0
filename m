Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B71E4A4
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726354; cv=none; b=rYA/4qHI4z/glC90X8ve3UXU+KS+qEyNrqL419gJ0wd3kSMNsof7J+1bS5rGRWq1811AofbtH7jlWJsBrQ5JMxOUBO/AUZcCt2ZzJUtjs8YqUZtIzqwuywt/PtotXQxOLs57wo1RNCFDzc2tKGhf13K/0/9fQz9/RBAPJFjL+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726354; c=relaxed/simple;
	bh=+jXzEQNiD9by9O3Notb6GDtsYxspf6UL9quRXWQ3uN8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=R1hwYKuP9HQeCwmWIMrZglWa/+4LzalEDviFQ/RiqleF2McMWLgYZTi8R3xvhSy4tu9napm+a4z4naBvKzSbOMYmzHVCGcBjyR1/eTjPgvtj2i6szN/EE1v/7M9i9lsObG0n618Zx07GpjZOm5AQZFw0eR5+7R1Opx3GXNyD3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoiayAPD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoiayAPD"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4667931f14bso66504641cf.2
        for <mptcp@lists.linux.dev>; Sun, 08 Dec 2024 22:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733726351; x=1734331151; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqQ75g19/Idcb5u2q6gN8nrBsRFZdT3DC27UhD6dLrI=;
        b=FoiayAPDUxNZD3lzVDc64JNU8UhTNn1OaFlOkfAiFzjyRa2pNXxaUYlBWanftNQgLG
         by7QSkd/1h7b0/ii6l6XV2mqirc9kAkXq5CrgddVYN2yrLp9Eo2RBov00NW33hWnvUuL
         tbC5pG8C+aKDUlVohHsDz+GpomV9TWut1Dip1RKr9SPjgbrMwX5LyxNwAqsVZMsLjn2P
         nCOtbOjzPWLPY0W9hh1kfYN1PZq8XA3qusrQz9YOCbkl8Anc44TrQ1btgA1Hz9qGEQKU
         pl+xt1BDrzXF1Ka0ejFfxs94TIxMs+2gBtSgzUWjwzUdQj05V35Ce+ji5BM7dY6oq3qx
         03Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733726351; x=1734331151;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SqQ75g19/Idcb5u2q6gN8nrBsRFZdT3DC27UhD6dLrI=;
        b=LZG/sP2zH4MxWvjkfq83nKRRUj8CGL+nyGP5p1uwacQePzK3YqRHpis2VVgyIQ837J
         u4jr6OsVWB3ru9ubWnJ0du1HjY2LKBimjw0IKCIJK64YRY/oYblcTBda48wTbUB9shRy
         nynfuHwaezoqc9uFFXDhtvAxwH5O+cd0UtbJ1kmYaubpkHp24v5KEgGUjeRSaV/Q3atV
         6W0ZR2GEqw7mix3EdzjoEe39g5mJLmHZdbagmXPGyPoKxu1rKwdbYkZ6aWHTi8g+4aXx
         Wmka2NGSVjt8gZJY/OjYqlHOpzsMOKBHy9y34bAeE683F7DF+d42QLdL1LMlsS4uYVo1
         fUIQ==
X-Gm-Message-State: AOJu0Ywo4gjs1/DPBwxg+t7lkAg8wN87YPXIiyREZ8Xopyt7bJaTwQe0
	KmVHZ42ZhdTAI0nBJvEyWBs+8bhRofcdQ9KM9Nj28EYKA8iGe7e6d2ET704=
X-Gm-Gg: ASbGncuYMAsphRWiq0i/qZcXQupi8XMTCmIVvt5t++vP/9LjzQcO09rLkQB44Exvfqx
	uLV+vWxqqAjkKsg6hTQc/VGlGLdt2SmzQxqHk4AKgA+aEbrj69eOuQbTugdXAqAh1qDNO0hEaBA
	IlIYwRDj62Uk6u498op95KVTPhKnP7roRne72SxvRNy2cu6619RPL6TClna6RWy6PxkS7Susz1E
	vKFu45IUoPdgeFSXedOBNqx1MumuH/kly1ng/aBg6vWl7Xc0jLMxmz/HcoHDQ==
X-Google-Smtp-Source: AGHT+IHJyyx9bzHE1ZEo3Pv5g8Ce2d3FTm6q0bIc7dfXx0tcc9bB6KGuLeBMcw+OSSpL87P136Ma4g==
X-Received: by 2002:a05:622a:1c1a:b0:467:699f:598 with SMTP id d75a77b69052e-467699f15e3mr19447141cf.28.1733726351583;
        Sun, 08 Dec 2024 22:39:11 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4674ee720d2sm20935711cf.40.2024.12.08.22.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:39:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1733724383.git.tanggeliang@kylinos.cn>
References: <cover.1733724383.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3_0/5=5D_Squa?=
 =?UTF-8?Q?sh_to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_?=
 =?UTF-8?Q?support=22?=
Message-ID: <619b6c51-22cd-1888-e850-c1ff2fb1f6b8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Dec 2024 06:39:09 +0000
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
net-next/actions/runs/12230234363

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/c4=
20a7ab2b44
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D915780

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
