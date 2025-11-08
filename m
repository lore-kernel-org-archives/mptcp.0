Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD72B9B9
	for <mptcp@lists.linux.dev>; Sat,  8 Nov 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762612663; cv=none; b=kAwRwND3INmTRJf/DLgJFzCDb1cCWHU8sf78oaN82xBlt1Vp9k3ghFCYHBF1pr84N2LuY6LXuMf7CQ/2549AtIbFA5DpbWXmfMiWDcI6lixA8/TRWmfNcnPvDqFycZnrvrsTN4ZCD/LMLCXRSV6RXwv3rbbLgc2UL+o2ibn7RdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762612663; c=relaxed/simple;
	bh=p4WC5vUJAA9iLqBva4+07vXkh4xWMIYEhBWEYwhQgVA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LO5+hDNQvbKAcQPu6Na9dkK1QdkVfXP/5bJ+kjfhm4dI64oU+CUDKXZKkkU7SxtFMPCkE/FajzGTyStkpySlpmiDHnPS9Au4ekHhcvBNXkVLabCCGJAYxR1ibMisS4pM6Za47udRItmojWH9rpdHlLCgelnhULten8F0V51HI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2T2fw0C; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2T2fw0C"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-940d25b807bso56786739f.1
        for <mptcp@lists.linux.dev>; Sat, 08 Nov 2025 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762612661; x=1763217461; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4EWl8M5IgwqqsCxrQ0/gn3Q0TOu7w3vG85TIHTPnDk=;
        b=Q2T2fw0C4p35l1zeU3ftTBcbZT/tlIXX1wVxIX2zXIRySmRwRLr6SJXPCikHP+9oGA
         3uuEGHROonDCAsaFo5eokBRb1J+CzswrT2d+HijUFjMM9ny45h6khywofBkqvXmCiLpm
         RG05Gcf7OGr6U/jjV08y8iuuRc/27kNfWWtKd7Dr6pV7KyRkUneIqyuDSYB1JZvwl3kB
         jaccosCwcQyMNKEpgjKV1wrw+2wgulM/vjOcnBgJpVuiDhWvNyufSV+oFSMV1fceize1
         TrPOExO7h+LzHZ6ADCHTyMci68nvDJACQdajzhvmea2EjbD12Qp7f/tE0g4WvYkDDmc2
         KIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762612661; x=1763217461;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4EWl8M5IgwqqsCxrQ0/gn3Q0TOu7w3vG85TIHTPnDk=;
        b=rL/KJh8VfxZLph0qd9BVbNO3P6/21A5F4LDGHWBM7i6R92dV9ngRphMR10WA7ygNwm
         y8xNgHk1w0iymMBwcpxtf9wPPePaxd3EMUZhs1CLooPpspqENln4gO2JHnTZ1D65hW8Y
         9fWD/TvzJ6ma+icSG8WQ93SnWI2zc4DGDGNkchllfro+GZJIyT3pkcSB0hf5FZiO+A4k
         /yOref/THDcMATILsov58hff+jorAX7AgEiekz2IFBpeKXEYDiSC8IFrWB8dA7MqTAlt
         sn/3oKbLYRNHVBhLhGxBv8XNTJpIqKqfrYDbj/5yRjH3ZaD1WEI1R1dbS/T5oIzqPoiw
         qXNA==
X-Gm-Message-State: AOJu0Yxso1cA3w+qAqRX5RrHck/QTLXOUkoeWbKowW3SfOyXc9ZpLGOB
	sMAIYgOw1maLwPdg9awe7ORLOVut1UxeD+5h1+l/z24h/1mM9PR2JGQL6YUH
X-Gm-Gg: ASbGncvnQAjwyLiCHnMxJiZ2ZVe0JuIbUdEIkZ3qOkOdlE5a2Jrkxd/91sn5hHAdIX2
	44CGBaCFP8QBXTjzYeMz+scrQ3ZGKovFu79JNJwN7V1HpXwlBVE6TgfDxOc/KDOLjKM3+VRuqaq
	IDnrWniSxZMbQi8TFopO7HZT1UZEaOEW2V6de4ASvNc850L6JpUebxuUVidzQ2XQbHhfg4ege93
	z1EX5YCDFJT6oxDYWWzfa1MFBXmcu33hKw2MzAJHW+3bqvFJUEDd+3dSYR4nPqZWH/ppH62OB1S
	9IjwR3CBqyjUYmGP4bLGO19ITyfj1f8q5E81mUWbdRyPkdTARQsDTI9h4cV1b/sYCpNTcymRGV7
	p+jDf5TL35vPPlpxfMCHUNjJxzWwWS6jQ2Fs8ADdox9jiHCgsL0hO3CpPRKGl4CnQLYBJVAu2yt
	2UF2QPXzmk7Hm8TLwtaDNUkNs8uhPiHT5qNQ==
X-Google-Smtp-Source: AGHT+IGMHZiQhwR46yJlb5uAEdfUoO3dXLIn/Dx+6HiOQg6UzA+7wCU9wICSFQDHkkJWrLlFEzUzLQ==
X-Received: by 2002:a05:6602:3f8d:b0:941:c4f:f44d with SMTP id ca18e2360f4ac-94895fa74a4mr424942839f.6.1762612660747;
        Sat, 08 Nov 2025 06:37:40 -0800 (PST)
Received: from [127.0.0.1] ([64.236.201.51])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7467d5a37sm3095792173.7.2025.11.08.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 06:37:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f9ee505fd5da965ab78beb4d51e6f479ad8fe4f7.1762553784.git.pabeni@redhat.com>
References:
 <f9ee505fd5da965ab78beb4d51e6f479ad8fe4f7.1762553784.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash-to?=
 =?UTF-8?Q?=3A_=22mptcp=3A_leverage_the_backlog_for?=
 =?UTF-8?Q?_RX_packet_processing=22?=
Message-ID: <2036ced0-2a0a-881d-6e42-5b63353acb37@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Nov 2025 14:37:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/19194275874

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/83be86fdeda7
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1021097

Feel free to reply to this email =
if you cannot access logs, if you need
some support to fix the error, if =
this doesn't seem to be caused by your
modifications or if the error is a =
false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu =
Baerts (NGI0 Core)
