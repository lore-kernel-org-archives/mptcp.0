Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA365190
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426314; cv=none; b=ec5OMCDS2mpBgHhSzTLntKAkgHf1skiM2Piz/0s/RLnnwlnEtR+w0It+Gn+amujpuJF6ALI15di1x65cgpaHuyJdYTc1jpDwq5iUN44zGE+8VKx1TOsGD7pAOlr3spfrPJi9tiP/viVtKLvdbvj2QBFhOM3rdbGE5o//wOPHq5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426314; c=relaxed/simple;
	bh=Vl909QG+hMOxwX71Nmw8cHZkcQJTne7P9P6vZ9/H92I=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UcR89wyAe7eXTdqUVcuDGO00nkyqB4mwTvDPSntXq0RACGDRxEXSQeoIuxKyk59RgcbdJ0X5Dch+87WoJEfGc80CqYltQ5bM7OY4cDJXhJj2G7FrNUo3kLPCVpWNK6YUAtewXiq7HIkQKuDJ/ahgyQqHjYJN+oTyxUwn4ehWvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX5wQNcR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX5wQNcR"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7877468beacso46109585a.1
        for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 02:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708426311; x=1709031111; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF2DQlC+yvtm1+orCxVwKv9nA4N0hVEkQRKoCLl02To=;
        b=iX5wQNcRyBEF08qcypIE+PUuL+0bWZeOUDeBaO3dvK+YPv1/2K+cj6pL7W0b1mcq26
         j5EWHlglQhhcLWXy5/Mpo3cpVE4XSZ9yQyK2IwI3NwKdLL8pCXMkkylL1fe7juRWJ9FM
         Lp3UAgeBKcitoCArjdBrpIUH3fj5ftkaFasRJbWzZys/HL+WUVrxKC0RyTcjtPEvxYbR
         HBbqbAfc8m4iV3jOyI3Gwuy9xB30NMTNQCuFH8dcItvudmyZwsJqonY37iRJN8jkXO6W
         p6OZe0SBeh5juiCOSPFpQ3WIeCdRrHYfd3T6DZZdAL5ERQoDP2qYj657mB4RChIfrx5U
         0xQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426311; x=1709031111;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LF2DQlC+yvtm1+orCxVwKv9nA4N0hVEkQRKoCLl02To=;
        b=vOSxUA8D/PVnXwQ1Ljw1DhJwCYoY7OSp1GO5xc4eLKOOBvy97oU5KV+EM6q7CzQm9a
         Z0E19MViCbeNHB6j14jg4sLQIOYZrOvCKl/TgE68f4+PT9k82vn8K+dDWdZHWl6P7CvS
         crqLQsk9eYkosF8gbrk6vgdSUpBaaU2BsPDUF77GDmt+xrcgvE9kEHkAupFwjH0lV99x
         lf9FP2NQvqjGJaWUoTuYUNxvqprj7HiZsmV7QlDmJnuBDH4M3iVU9NPqLU3mJCBvZrgs
         cMfB3thH4L+3TsEbSNXGfVrUC94uDBbbOtVJb44/F7Ajn6q0bog70DIrGQ8EtboYcA0D
         TR/w==
X-Gm-Message-State: AOJu0YyeTIZmA5zaRNNVZ+jfeKr3F6DvMnh0KFqhNBVJmJaekTZ0xfbg
	0FQ88o9mePwpwYlYyqo7g1pK/YH9zHyXIeQtr6Xlmz91xH+nfcdNOXGkNqCQWg==
X-Google-Smtp-Source: AGHT+IGn/1I8rodi7qkG/sxhGDOTOyqvVjf+IPyQ+7NMzkambWVDd8x6lsADz8jTOdA6cc2E60r7aQ==
X-Received: by 2002:a05:620a:e10:b0:787:6b47:6a75 with SMTP id y16-20020a05620a0e1000b007876b476a75mr4093999qkm.24.1708426311278;
        Tue, 20 Feb 2024 02:51:51 -0800 (PST)
Received: from [127.0.0.1] ([20.109.60.243])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a004500b007876fd0b878sm1144543qkt.53.2024.02.20.02.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:51:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1217349b8d341c11964bb2869d141565c4d355c6.1708422758.git.tanggeliang@kylinos.cn>
References:
 <1217349b8d341c11964bb2869d141565c4d355c6.1708422758.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <a8c89430-6ce5-3b74-0c93-3ae11aa88fb6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Feb 2024 10:51:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7971809022

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/31704c65829c


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
