Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370230276A
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117868; cv=none; b=QNvq3cscxb+vXAc0nGmHv6+XhwsP3goQT4iFB3QbwXvV3EZ6vJlq804wlk4r4E+1Qo3gc9WqYvvugwqLBxW1ZdR4jzN8S6QqgenQRxLR6YHRe1aOUYpRqxklyb1dXkqHqo1EilfuS0Aw76pfFd8LvRKBi/kOghqFRtSbg78H2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117868; c=relaxed/simple;
	bh=BTGDQj1HOGwGLKQsNgFU05o6rGCswci5CY3UOPqnr6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=cW82GjLnEZ4MYrS8DYyIti15hqU1jWI35xVH6aeJIgt06uOFUW/CQffhY8jrujNpg4Sy0MRw77iK3idf7i9v20GF2hBWPjtoAUTO4XFpOZg2v+6FtTiqM+H9f3L1KLr+wICrWPopnMY2UwW6GwbCEVaB0UquLfC28DV25WKyJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKk9nykB; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKk9nykB"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c5b3d8eab1so24662eec.1
        for <mptcp@lists.linux.dev>; Thu, 02 Apr 2026 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775117867; x=1775722667; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7L8rbQyNTaW4ZHHtZMCpL+IbrCTcvvmdv3N6ZQijMo=;
        b=tKk9nykBCDV78xlP3/9HdYB7/rP0zINM2TDyl2h8EvN6GfmDnANCzNvkqAC1L1IDkI
         zlxl7lriIQngTBsaiS8VN/XnzuErV1oJudbf4cazPaUcPFw8MPfhobQaRGLy2wRV9MmI
         MfzYGOK4AQlYVkJnrkutFR3rLFyhrrnHii+5ZddT2QQ//Oux3vjZoh3ciCl+TANRGqNg
         wom5rKlVvrOgAuqF5o8mUMLvjW9abIW9OP3KdL8YJsl6p85VrMufjlKZBCliUFOGjNXQ
         yutS4wVvynHHNzfZE30jlih/6nmGMWvG1qsx+TVCtSAM0Mlz0Uh+0/F4DZ9lhbf8Ho8f
         kb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117867; x=1775722667;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7L8rbQyNTaW4ZHHtZMCpL+IbrCTcvvmdv3N6ZQijMo=;
        b=hMSh25SiVW0DdgxH/Uh2Q/ucc7n/7DecfHRluSxIwl+JPcpjpW5kvSZBK5y57dHczt
         AQ1e/Yw6ztbN7yhSEY/6ePdAcvpSkQsK2ETMUMiHVoI7K0VZ8dMmliXm7v8dhV+S+VDR
         /6CYh6akEskhHS804PZy0FomLTEJtdvR/0aWi7o2iZjxhnGjfKYzzbCO7EwEnCCdbPe/
         zw6W69akH+84OP2u53dj6YXyqphxYiZaB/DoTP3kY4QyPnNiPZwWv5X/gv9UpKkQWBHh
         FZfpEp2BR4g/5H2JhV10D4184Z2rZUWvWSrLc+84ldkXl7bRK5cT88mSqc4SogTz0MiS
         t2Jg==
X-Gm-Message-State: AOJu0YxTSLlZiYeeelnywvsDWCRXM+JbVQH26XwCqHvAQUfNUyxi/qCw
	ZLQLv/fMpmLQxTKw7m6xqynnvOWWPNxgz9C+uc2XNlThNnQ9a1Xt39cIedXC
X-Gm-Gg: ATEYQzx97rz6Cjgz16rcetT3rpNAJlWsYR1ejHT8+FsHnO63x6Mj5LKforGJLvnQSzX
	5XAbH5hBgEphh63+O9lE/5T++ye0rE1xFdLWSiY/ll4u7yNcsoGFoZUIOHlvMf/FPLuNQ6sRv33
	UcaGcqaNq8MyABUAx725bdwRsrcHAZY6MFjMRXJLwIIQjh3oybrlt0o/4cTdKkfYvTzipe6OE5+
	E6Ag4oga9BVXqcGApU8tC7D1hfuozUR7UNgY6L3LUO9Vxr7CztrH78Di/X9N19pw/sP9J0Wnq6i
	Gj2KFeU3LCgfv5ilbgHERVdSxaWWJe2x8r4GLGLRwhDu1L9C9aiSRaS/CboQwVvIiV/pc2lPvnl
	tMD6EXv00CPfp8Xu6hLc1DiuFDUIZ77CCS4S/JYcNCLYa2fqV9uc9ieH9Um7dWkCsWjTiTsIs6O
	ovDyJ4pSIEYNzmX56nxIdAuqcROr484NGG9C6TL3gbghkD4HE=
X-Received: by 2002:a05:7301:1298:b0:2c4:ab8f:1da2 with SMTP id 5a478bee46e88-2c9323bb002mr3624008eec.21.1775117866749;
        Thu, 02 Apr 2026 01:17:46 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.62.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3c11sm1894696eec.4.2026.04.02.01.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:17:46 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1775115102.git.tanggeliang@kylinos.cn>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v12 00/15] MPTCP KTLS support
Message-ID: <0a9f16f7-6991-8e13-7e2e-80f361579e33@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Apr 2026 08:17:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/23890722509

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/88=
f07fcab32d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1076267

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
